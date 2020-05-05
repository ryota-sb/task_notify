class TaskSerializer < ActiveModel::Serializer
  attributes :id, :content, :is_done, :week
end
