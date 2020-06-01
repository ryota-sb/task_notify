class TaskSerializer < ActiveModel::Serializer
  attributes :id, :content, :is_done, :week, :notification_time, :user_id
end