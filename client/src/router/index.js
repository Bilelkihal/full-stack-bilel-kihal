import { createRouter, createWebHistory } from 'vue-router';
import LandingPage from '../components/LandingPage.vue';
import MarketPage from '../components/MarketPage.vue';
import AllPokemons from '../components/AllPokemons.vue';


const routes = [
  {
    path: '/',
    name: 'Landing page',
    component: LandingPage
  },
  {
    path: '/market',
    name: 'Market',
    component: MarketPage
  },
  {
    path: '/pokemons',
    name: 'AllPokemons',
    component: AllPokemons
  }

];

const router = createRouter({
  history: createWebHistory(), // Use HTML5 History API for clean URLs
  routes
});

export default router;