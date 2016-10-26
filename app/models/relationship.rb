class Relationship < ActiveRecord::Base
  #外部キーの名前に依存する
  belongs_to :followed, class_name: "User"
  belongs_to :follower, class_name: "User"
end
