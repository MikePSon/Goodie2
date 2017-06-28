class User
  include Mongoid::Document
  include Mongoid::Paperclip
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String
  field :deleted_at,         type: DateTime
  field :inactive_user,      type: Boolean

  ## Stripe Fields
  field :stripeid,           type: String
  field :subscribed,         type: Boolean
  field :planid,             type: String
  field :subscriptionid,     type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  ## Data
  belongs_to :organization
  has_many :request
  has_many :review
  
  field :admin,             type: Boolean, default: false
  field :goodie_support,    type: Boolean, default: false
  field :program_admin,     type: Boolean, default: false
  field :program_manager,   type: Boolean, default: false
  field :applicant,         type: Boolean, default: false



  field :first_name,        type: String, default: ""
  field :last_name,         type: String, default: ""
  field :phone,             type: String
  field :job_title,         type: String, default: ""
  field :address_1,         type: String
  field :address_2,         type: String
  field :city,              type: String
  field :state,             type: String
  field :zip,               type: String
  field :office_open,       type: String
  field :office_close,      type: String
  field :gender,            type: String
  field :race,              type: String
  field :dob,               type: Date 
  field :age,               type: Integer

  has_mongoid_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  # instead of deleting, indicate the user requested a delete & timestamp it  
  def soft_delete  
    if self.program_admin?
      organization_users = User.where(:organization_id => self.organization_id.to_s)
      
      organization_users.each do |this_user|
        this_user.update_attribute(:deleted_at, Time.current) 
        this_user.update_attribute(:inactive_user, true)
      end


    else
      update_attribute(:deleted_at, Time.current) 
      update_attribute(:inactive_user, true)
    end
  end

  # ensure user account is active  
  def active_for_authentication?  
    super && !deleted_at  
  end  

  # provide a custom message for a deleted account   
  def inactive_message   
    !deleted_at ? super : :deleted_account  
  end


end
