<template>
  <div class="freeback-container">
    <div class="freeback-box-border">
      <div>
        <div>
          <h1>意见反馈</h1>
          <h2>感谢你的反馈，我们会积极改善，做出更好服务的</h2>
        </div>
        <div class="freeback-content">
          <div class="freeback-form">
            <Form :model="formItem" :label-width="80">
              <FormItem label="信息标题">
                <i-input v-model="formItem.title" placeholder="请输入标题"></i-input>
              </FormItem>
              <FormItem label="反馈信息">
                <i-input v-model="formItem.content" type="textarea" :autosize="{minRows: 8,maxRows: 10}"
                         placeholder="请输入反馈信息"></i-input>
              </FormItem>
              <FormItem>
                <Button type="primary">提交</Button>
                <Button type="ghost">清空信息</Button>
              </FormItem>
            </Form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Freeback',
    data() {
      return {
        formItem: {
          title: '',
          content: ''
        }
      };
    }
  };
</script>

<style scoped>
  .freeback-container {
    margin: 15px auto;
    height: 600px;
    display: flex;
    align-items: center;
  }

  .freeback-box-border {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .freeback-content {
    margin: 15px auto;
    border: 1px #ccc dotted;
  }

  .freeback-form {
    margin: 30px auto;
    width: 90%;
  }
</style>
