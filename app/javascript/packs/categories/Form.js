import React, { useState } from "react";
import { useFormik } from "formik";
import API from "../utils/api";
import Errors from "../components/Errors";
import CategorySearch from "../components/CategorySearch";

const Form = () => {
  const [errors, setErrors] = useState({});

  const initialValues = {
    id: null,
    title: null,
    slug: null,
    description: null,
    seo_title: null,
    seo_description: null,
    parent_id: null,
    ...gon.category
  };

  const formik = useFormik({
    initialValues,
    onSubmit: values => {
      setErrors({});
      const apiFunc = values.id ? API.categories.update : API.categories.create;
      apiFunc(values).then(res => {
        window.location = "/admin/categories";
      }, errors => {
        setErrors(errors);
      })
    }
  });

  const onChangeCategory = (value) => {
    formik.setFieldValue("parent_id", value);
  };

  return (
    <div className="container">
      <form onSubmit={formik.handleSubmit}>
        <Errors errors={errors} />
        <div className="row">
          <div className="col-md-6">
            <div className="form-group">
              <label htmlFor="title">Категория</label>
              <CategorySearch
                onChange={onChangeCategory}
                categoryId={initialValues.id}
                value={formik.getFieldProps("parent_id").value} />
            </div>
            <div className="form-group">
              <label htmlFor="title">Название</label>
              <input className="form-control" {...formik.getFieldProps("title")} />
            </div>
            { initialValues.slug && <div className="form-group">
              <label htmlFor="title">Slug</label>
              <input className="form-control" {...formik.getFieldProps("slug")} />
            </div> }
            <div className="form-group">
              <label htmlFor="description">Описание</label>
              <textarea className="form-control" {...formik.getFieldProps("description")} />
            </div>
            <div className="form-group">
              <label htmlFor="seo_title">SEO-заголовок</label>
              <input className="form-control" {...formik.getFieldProps("seo_title")} />
            </div>
            <div className="form-group">
              <label htmlFor="seo_description">SEO-описание</label>
              <textarea className="form-control" {...formik.getFieldProps("seo_description")} />
            </div>
            <div className="form-group">
              <label htmlFor="seo_keywords">SEO-keywords</label>
              <textarea className="form-control" {...formik.getFieldProps("seo_keywords")} />
            </div>
            <button type="button" className="btn btn-success" onClick={() => formik.submitForm()}>Сохранить</button>
          </div>
        </div>
      </form>
    </div>
  )
};

export default Form;