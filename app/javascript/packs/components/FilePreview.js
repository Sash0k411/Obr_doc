import React from 'react';

export default ({content}) => {
  return (
    <div dangerouslySetInnerHTML={{ __html: content }}></div>
  )
}