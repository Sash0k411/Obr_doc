module Tree
  extend ActiveSupport::Concern

  included do
    ANCESTRY_COLUMN = "ancestry".freeze
    ANCESTRY_DELIMITER = "/".freeze

    # Scopes
    scope :by_without_parent, lambda { |_a = nil, **| where(ANCESTRY_COLUMN => nil) }
    scope :by_without_children, lambda { |_a = nil, **|
      ancestries = all.map {|node| [node.id, node.child_ancestry, node.ancestry] }
      no_child_ids = ancestries.reject { |a| ancestries.map { |a| a[2] }.include?(a[1]) }.map { |a| a[0] }
      where(id: no_child_ids)
    }

    # Callbacks
    after_update :rebuild_tree!

    # Accessors
    attr_reader :tree_changed
    alias :tree_changed? :tree_changed

    # returns parent node
    def node
      par_id = parent_ids.last
      self.class.find_by primary_key => par_id
    end
    alias :parent :node

    # returns root node
    def root
      root_id = parent_ids.first
      self.class.find_by primary_key => root_id
    end

    # return self id and parent ids
    def parent_with_self_ids
      Array(id) + parent_ids
    end

    # return parent nodes ids
    def parent_ids
      ancestry&.split(ANCESTRY_DELIMITER).to_a.map(&:to_i)
    end

    def parent_id
      parent_ids.last
    end

    def parents
      self.class.where(id: parent_ids)
    end

    # returns current node and its children
    def subtree
      self.class.where(subtree_conditions)
    end

    def subtree_ids
      subtree.ids
    end

    # returns all nested children for current node
    def descendants
     self.class.where(descendants_conditions)
    end

    # return all children nodes from one level deeper
    def children
      self.class.where(children_conditions)
    end

    # returns all parents, self and descendants (whole branch on nodes)
    def tree
      self.class.where(tree_conditions)
    end

    def tree_ids
      tree.ids
    end

    # returns depth of current node
    def depth
      parent_ids.size
    end

    # returns ancestry string for new child node
    def child_ancestry
      key = public_send(primary_key)
      if ancestry
        "#{ancestry}#{ANCESTRY_DELIMITER}#{key}"
      else
        "#{key}"
      end
    end

    # useful if node with its children was moved to another tree node
    def rebuild_tree!
      return unless saved_changes[ANCESTRY_COLUMN]

      self.class.transaction do
        old_ancestry = saved_changes[ANCESTRY_COLUMN].first
        old_child_ancestry = old_ancestry ?
          "#{old_ancestry}#{ANCESTRY_DELIMITER}#{public_send(primary_key)}"
          : "#{public_send(primary_key)}"
        childs = self.class.where(ANCESTRY_COLUMN => old_child_ancestry)
        childs.find_each { |child| child.update!(ANCESTRY_COLUMN => child_ancestry) }
      end
      @tree_changed = true
    end

    # Setters

    # node - parent node of child
    def node=(parent_node)
      write_attribute(:ancestry, parent_node&.child_ancestry) if parent_node.is_a?(self.class) || parent_node.nil?
    end
    alias :parent= :node=

    private

    def subtree_conditions
      t = arel_table
      descendants_conditions.or(t[primary_key].eq(public_send(primary_key)))
    end

    def descendants_conditions
      t = arel_table
      t[ANCESTRY_COLUMN].matches("#{child_ancestry}#{ANCESTRY_DELIMITER}%", nil, true).or(t[ANCESTRY_COLUMN].eq(child_ancestry))
    end

    def children_conditions
      arel_table[ANCESTRY_COLUMN].eq(child_ancestry)
    end

    def tree_conditions
      t = arel_table
      conditions = subtree_conditions
      parent_ids.each { |par_id| conditions = conditions.or(t[primary_key].eq(par_id.to_i)) }
      conditions
    end

    def primary_key
      self.class.primary_key
    end

    def arel_table
      self.class.arel_table
    end
  end
end