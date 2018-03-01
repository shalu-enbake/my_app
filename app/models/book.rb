class Book < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader 
end
