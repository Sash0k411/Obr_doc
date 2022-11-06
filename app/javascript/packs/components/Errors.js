import React from 'react';

export default ({errors}) => {

  if (!errors || !Object.keys(errors).length) {
    return <></>
  }

  return (
    <div className="alert alert-danger">
      { Object.keys(errors).map(key => (
          <p key={key}>{key} - {JSON.stringify(errors[key])}</p>
        )
      )}
    </div>
  )
}