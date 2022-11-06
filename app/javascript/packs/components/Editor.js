import React, {Component} from 'react'
import { Editor } from 'react-draft-wysiwyg';
import { EditorState, ContentState, convertToRaw } from 'draft-js';
import htmlToDraft from 'html-to-draftjs';
import draftToHtml from 'draftjs-to-html';

class ContentEditor extends Component {

  constructor (props) {
    super(props);
    let editorState
    if (this.props.value) {
      const blocksFromHtml = htmlToDraft(this.props.value);
      const { contentBlocks, entityMap } = blocksFromHtml;
      const contentState = ContentState.createFromBlockArray(contentBlocks, entityMap);
      editorState = EditorState.createWithContent(contentState);
    } else {
      editorState = EditorState.createEmpty()
    }

    this.state = {
      editorState: editorState
    }
  }

  onChange = (editorState) => {
    this.setState({editorState});
    const rawContentState = convertToRaw(editorState.getCurrentContent());
    const markup = draftToHtml(rawContentState);
    this.props.onChange(markup);
  };

  render () {
    const {value} = this.props;
    const { editorState } = this.state;

    return (
      <Editor
        editorState={editorState}
        onEditorStateChange={this.onChange}
        wrapperClassName="wrapper-class"
        editorClassName="editor-class"
        toolbarClassName="toolbar-class"
        toolbar={this.props.toolbar || {
          options: ['inline', 'blockType', 'link', 'remove', 'textAlign', 'history'],
          blockType: {
            inDropdown: true,
            options: ['Normal', 'H1', 'H2', 'H3', 'H4'],
          },
          inline: {
            options: ['bold', 'italic']
          },
          textAlign: {
            inDropdown: false,
            options: ['left', 'center', 'right', 'justify'],
          },
          list: { inDropdown: true },
          link: { inDropdown: true },
          history: { inDropdown: true },
        }}
      />
    )
  }
}

export default ContentEditor;