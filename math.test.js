const test = require("node:test");
const assert = require("node:assert/strict");
const { add, subtract, multiply } = require("./math");

test("add sums two positive numbers", () => {
  assert.strictEqual(add(2, 3), 5);
});

test("add handles a negative number", () => {
  assert.strictEqual(add(-4, 3), -1);
});

test("add handles zero", () => {
  assert.strictEqual(add(7, 0), 7);
});

test("subtract two positive numbers", () => {
  assert.strictEqual(subtract(5, 8), -3);
});

test("subtract handles a negative number", () => {
  assert.strictEqual(subtract(5, -2), 7);
});

test("subtract handles zero", () => {
  assert.strictEqual(subtract(0, 4), -4);
});

test("multiply two positive numbers", () => {
  assert.strictEqual(multiply(4, 3), 12);
});

test("multiply handles a negative number", () => {
  assert.strictEqual(multiply(-4, 3), -12);
});

test("multiply handles zero", () => {
  assert.strictEqual(multiply(7, 0), 0);
});
