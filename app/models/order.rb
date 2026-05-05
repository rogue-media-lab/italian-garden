class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  validates :customer_name, presence: true
  validates :phone, presence: true

  scope :ordered, -> { order(created_at: :desc) }
  scope :pending, -> { where(status: "pending") }

  STATUSES = %w[pending ready completed cancelled].freeze

  after_create_commit :broadcast_new_order
  after_update_commit :broadcast_order_update

  def status_color
    case status
    when "pending" then "bg-amber-100 text-amber-800"
    when "ready" then "bg-green-100 text-green-800"
    when "completed" then "bg-blue-100 text-blue-800"
    when "cancelled" then "bg-red-100 text-red-800"
    end
  end

  def formatted_total
    "$#{'%.2f' % total}"
  end

  private

  def broadcast_new_order
    broadcast_prepend_to "admin_orders",
      target: "orders_list",
      partial: "admin/orders/order",
      locals: { order: self }
  end

  def broadcast_order_update
    broadcast_replace_to "admin_orders",
      target: "order_#{id}",
      partial: "admin/orders/order",
      locals: { order: self }
  end
end
