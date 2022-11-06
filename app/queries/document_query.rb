class DocumentQuery < ApplicationQuery
  def call
    scope = Document.includes(:category, :file)
    scope = scope.where('title ILIKE ?', "%#{filter[:query]}%") if filter[:query].present?
    if category = Category.find_by(id: filter[:category_id])
      scope = scope.where(category_id: category.subtree_ids)
    end
    scope.page(page).per(per_page).order(id: :desc)
  end
end