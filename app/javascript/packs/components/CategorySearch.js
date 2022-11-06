import React from 'react';
import Select from 'react-select';

export default ({ onChange, categoryId, value }) => {
  const delimeter = " -> ";
  const options = gon.categories.filter(c => !c.parent_ids.includes(categoryId)).map(c => {
    const parents = gon.categories
      .filter(cc => c.parent_ids.includes(cc.id)).map(cc => cc.title).join(delimeter);
    const label = parents.length ? [parents, c.title].join(delimeter) : c.title;
    return {
      label: label,
      value: c.id
    }
  });

  const defaultValue = options.find(option => option.value == value);

  const changeHanlder = (option) => {
    onChange(option ? option.value : null);
  };

  return (
    <Select
      options={options}
      onChange={changeHanlder}
      placeholder={""}
      isClearable={true}
      value={defaultValue} />
  )
}