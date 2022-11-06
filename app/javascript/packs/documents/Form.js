import React, { useState } from "react";
import { useFormik } from "formik";
import API from "../utils/api";
import Errors from "../components/Errors";
import CategorySearch from "../components/CategorySearch";
import FileUpload from "../components/FileUpload";
import FilePreview from "../components/FilePreview";
import Editor from "../components/Editor";

const Form = () => {
  const [errors, setErrors] = useState({});

  const initialValues = {
    id: null,
    title: null,
    slug: null,
    description: null,
    seo_title: null,
    seo_description: null,
    file_url: null,
    file_id: null,
    file_name: null,
    html: null,
    category_id: null,
    ...gon.document
  };

  const formik = useFormik({
    initialValues,
    onSubmit: values => {
      const apiFunc = values.id ? API.documents.update : API.documents.create;
      apiFunc(values).then(res => {
        window.location = "/admin/documents";
      }, errors => {
        console.error(errors);
        setErrors(errors);
      })
    }
  });

  const onChangeCategory = (value) => {
    formik.setFieldValue("category_id", value);
  };

  const onChangeFile = (value) => {
    formik.setFieldValue("file_id", value.id);
    formik.setFieldValue("file_url", value.url);
    formik.setFieldValue("file_name", value.name);
    formik.setFieldValue("html", value.html);
  };

  const onChangeHtml = (value) => {
    formik.setFieldValue("html", value);
  };

  const onSubmit = () => {
    formik.submitForm();
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
                value={formik.getFieldProps("category_id").value}
                onChange={onChangeCategory} />
            </div>
            <div className="form-group">
              <label htmlFor="title">Название</label>
              <input className="form-control" {...formik.getFieldProps("title")} />
            </div>
            {
              initialValues.slug && <div className="form-group">
                <label htmlFor="title">Slug</label>
                <input className="form-control" {...formik.getFieldProps("slug")} />
              </div>
            }
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
            <button type="button" className="btn btn-success" onClick={onSubmit}>Сохранить</button>
          </div>
          <div className="col-md-6">
            <FileUpload onChange={onChangeFile}/>
            { formik.getFieldProps("file_id").value && <a className="text-info" href={formik.getFieldProps("file_url").value}>
                <p>
                  {formik.getFieldProps("file_name").value}
                </p>
              </a>
            }
            {
              formik.getFieldProps("html").value &&
              <Editor value={formik.getFieldProps("html").value} onChange={onChangeHtml} />
            }
          </div>
        </div>
      </form>
    </div>
  )
};

export default Form;