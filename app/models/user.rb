class User < ApplicationRecord
  after_destroy :admin_delete_prevent

  validates :name, presence: true
  validates :email, presence: true,format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, length: { minimum: 5 }
  before_validation { email.downcase! }
  has_secure_password
  has_many:tasks

  def admin_delete_prevent
    authority_count = 0
    User.all.each do |user|
      authority_count += user.authority
    end
    if authority_count<1
      raise ActiveRecord::Rollback
    end
  end
end
