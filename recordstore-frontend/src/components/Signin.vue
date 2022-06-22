<template>
  <div class="max-w-sm m-auto my-8">
    <div class="form-container">

      <h3 class="form-title">Sign In</h3>

      <form @submit.prevent="signin">
        <div class="error-text" v-if="error">{{ error }}</div>

        <div class="mb-6">
          <label for="email" class="input-label">Email Address</label>
          <input type="email" v-model="email" class="input-box" id="email" placeholder="email@example.com">
        </div>

        <div class="mb-6">
          <label for="password" class="input-label">Password</label>
          <input type="password" v-model="password" class="input-box" id="password" placeholder="password">
        </div>

        <button type="submit" class="submit-button">Sign In</button>

        <div class="my-4"><router-link to="/signup" class="link-grey">Sign up</router-link></div>
      </form>

    </div>
  </div>
</template>s

<script>
export default {
  name: 'Signin',
  data () {
    return {
      email: '',
      password: '',
      error: ''
    }
  },
  created () {
    this.checkSignedIn()
  },
  updated () {
    this.checkSignedIn()
  },
  methods: {
    signin () {
      this.$http.plain.post('/signin', { email: this.email, password: this.password })
        .then(response => this.signinSuccessful(response))
        .catch(error => this.signinFailed(error))
    },
    signinSuccessful (response) {
      if (!response.data.csrf) {
        this.signinFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      this.$router.replace('/records')
    },
    signinFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ''
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/records')
      }
    }
  }
}
</script>
