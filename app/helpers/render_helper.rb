module RenderHelper
  def percentage(val)
    "#{(val * 100).round(0)}%"
  end

  def e(obj, attr, **options)
    handle_type(obj.class.type_for_attribute(attr), obj, attr, **options)
  end

  def f(form, tag, obj: current_user)
    has_errors = @errors && @errors[tag].present?
    raw <<~FROM_ENTRY
      <div class="form-group">
      #{form.label tag, class: 'text-muted'}
      #{form.text_field tag, class: "form-control #{'is-invalid' if has_errors}", value: obj.send(tag)}
      #{"<small><span class='text-danger'>#{@errors.full_messages_for(:unconfirmed_email).join(', ')} </span></small>" if has_errors}
      </div>
    FROM_ENTRY
  end

  private

  def handle_type(type, *params, **options)
    case type
    when ActiveModel::Type::String
      create_string_edit(*params, **options)
    else
      noop(*params)
    end
  end

  def create_string_edit(obj, attr, url: nil)
    val = obj.send(attr)
    content_tag(:span,
                val,
                class: "editable #{'empty_editable' if !val || val.empty?}",
                data: { url: url || send("#{obj.class.name.downcase}_path", obj), obj: obj.class.name.downcase, attr: attr })
  end

  def noop(obj, attr)
    obj.send(attr)
  end
end
