class Document::Import < ApplicationInteraction
  object :file, class: ActionDispatch::Http::UploadedFile

  def execute
    sheet = Roo::Excelx.new(file.tempfile.to_path.to_s)
    rows = sheet.map {|row| row}
    columns = rows[0]
    rows = rows[1..rows.size]
    data_rows = rows.map do |data|
      answer = {}
      columns.each_with_index do |column_name, index|
        answer[column_name.to_sym] = data[index]
      end
      process_attrs(answer)
    end

    data_rows.each do |row|
      if (document = Document.find_by(id: row.delete(:id)))
        document.update(row)
      else
        Document.create(row)
      end
    end
  end

  private

  def process_attrs(row)
    category_slug = row.delete(:category)
    row[:category_id] = Category.find_by(slug: category_slug)&.id
    row
  end
end