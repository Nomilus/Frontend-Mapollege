enum SortEnum {
  createdAt('created_at'),
  updatedAt('updated_at'),
  name('name');

  const SortEnum(this.value);
  final String value;
}
