<template>
  <div class="max-w-sm m-auto my-8">
    <div class="form-container">

      <h3 class="form-title">Sign Up</h3>

      <form @submit.prevent="signup">
        <div class="error-text" v-if="error">{{ error }}</div>

        <div class="mb-6">
          <label for="email" class="input-label">Email Address</label>
          <input type="email" v-model="email" class="input-box" id="email" placeholder="email@example.com">
        </div>

        <div class="mb-6">
          <label for="password" class="input-label">Password</label>
          <input type="password" v-model="password" class="input-box" id="password" placeholder="password">
        </div>

        <div class="mb-6">
          <label for="password" class="input-label">Password Confirmation</label>
          <input type="password" v-model="password_confirmation" class="input-box" id="password_confirmation" placeholder="password confirmation">
        </div>

        <button type="submit" class="submit-button">Sign Up</button>

        <div class="my-4"><router-link to="/" class="link-grey">Sign In</router-link></div>
      </form>

    </div>
  </div>
</template>s

<script>
export default {
  name: 'Signup',
  data () {
    return {
      email: '',
      password: '',
      password_confirmation: '',
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
      this.$http.plain.post('/signup', { email: this.email, password: this.password, password_confirmation: this.password_confirmation })
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
      this.error = (error.response && error.response.data && error.response.data.error) || 'Error - Something went wrong!'
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
