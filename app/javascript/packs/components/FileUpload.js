import React, {useState} from 'react';
import API from '../utils/api';
import Errors from "./Errors";

export default ({onChange}) => {
  const [errors, setErrors] = useState({});
  const [loading, setLoading] = useState(false);

  const changeHandler = (e) => {
    const file = e.target.files[0];
    setLoading(true);
    setErrors({});
    API.files.create(file).then(res => {
      setLoading(false);
      onChange(res);
    }, errors => {
      setErrors(errors);
      setLoading(false);
    })
  }

  return (
    <div className="form-group">
      <Errors errors={errors} />
      <label>{loading ? 'Загружаем' : 'Документ'}</label>
      <input type="file" accept=".docx" className="form-control btn btn-info" onChange={changeHandler}/>
    </div>
  )
};