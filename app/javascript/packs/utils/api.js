const jsonify = (data) => {
  return {
    data: JSON.stringify(data),
    dataType: 'json',
    contentType: 'application/json'
  }
};


const filefy = (file) => {
  const formData = new FormData();
  formData.append('file', file);
  return {
    data: formData,
    dataType: 'json',
    cache: false,
    contentType: false,
    processData: false,
  }
}

const parseErrors = (response) => {
  if (response.status == 422) {
    return response.responseJSON.errors;
  } else {
    return { base: ["Server Error"] };
  }
};

const request = (url, data, options = {}) => {
  return new Promise((resolve, reject) => {
    $.ajax(url, {
      ...data,
      ...options,
      success: resolve,
      error: (response) => {
        reject(parseErrors(response));
      }
    })
  })
}

const api = {
  categories: {
    create: (params) => {
      return request(`/api/categories/`, jsonify({category: params}), { method: 'POST' });
    },
    update: (params) => {
      return request(`/api/categories/${params.id}`, jsonify({category: params}), { method: 'PUT' });
    }
  },
  documents: {
    create: (params) => {
      return request(`/api/documents/`, jsonify({document: params}), { method: 'POST' });
    },
    update: (params) => {
      return request(`/api/documents/${params.id}`, jsonify({document: params}), { method: 'PUT' });
    }
  },
  files: {
    create: (file) => {
      return request(`/api/files`, filefy(file), { method: 'POST' });
    }
  },
  pages: {
    create: (params) => {
      return request(`/api/pages/`, jsonify({page: params}), {method: 'POST'});
    },
    update: (params) => {
      return request(`/api/pages/${params.id}`, jsonify({page: params}), {method: 'PUT'});
    }
  }
};



export default api;