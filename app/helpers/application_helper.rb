module ApplicationHelper
  def enum_select(model, enum)
    keys = model.public_send(enum.to_s.pluralize).public_send(:keys)
    keys.map { |k| [t(['enums', enum, k].join('.')), k]}
  end
end
