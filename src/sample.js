// Prettier検証用サンプル（意図的にフォーマット違反を含む）
import dayjs from 'dayjs';

const user = { name: 'Taro', age: 30, email: 'taro@example.com', roles: ['admin', 'editor'] };

function greet(name, greeting) {
  const message = greeting + ', ' + name + '!';
  return message;
}

const formatDate = (date) => {
  return dayjs(date).format('YYYY-MM-DD HH:mm:ss');
};

const items = [
  { id: 1, label: 'first' },
  { id: 2, label: 'second' },
];

function calculateTotalPriceWithTaxAndDiscount(
  price,
  quantity,
  taxRate,
  discountRate,
  shippingFee,
) {
  return price * quantity * (1 + taxRate) * (1 - discountRate) + shippingFee;
}

if (user.age > 20) {
  console.log(greet(user.name, 'Hello'));
} else {
  console.log('too young');
}

console.log(formatDate(new Date()));
console.log(items.map((item) => item.label).join(', '));
console.log(calculateTotalPriceWithTaxAndDiscount(1000, 2, 0.1, 0.05, 500));
console.log('Hello, Ayuko');
