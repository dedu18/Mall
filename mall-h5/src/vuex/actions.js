import {getAllNavigationPictureList} from '../api/category';
import {getGoodsListByCategoryId, getGoodsById, getRecommendGoods} from '../api/goods';
import {getSeckillInfoList, getSpecialByType} from '../api/market';
import {getUserDeliverAddress, loginUser} from '../api/user';
import {getUserShopCartByUserId} from '../api/cart';
import {addGoodsToShopCart} from '../api/cart';

// 获取轮播(营销)图片
export const loadCarouselItems = ({commit}) => {
  return new Promise((resolve, reject) => {
    const data = {
      carouselItems: [],
      activity: []
    };
    getAllNavigationPictureList(null).then(response => {
      data.carouselItems = response.carouselItems;
      data.activity = response.activity;
      commit('SET_CAROUSELITEMS_INFO', data);
    });
  });
};

// 获取秒杀数据
export const loadSeckillsInfo = ({commit}) => {
  return new Promise((resolve, reject) => {
    getSeckillInfoList(null).then(response => {
      const data = response.info;
      // 距离开始秒杀时间
      const deadline = {
        hours: response.hours,
        minute: response.minute,
        seconds: response.seconds
      };
      commit('SET_SECKILLS_INFO', [data, deadline]);
    });
  });
};


// 加载电脑专栏数据
export const loadComputer = ({commit}) => {
  return new Promise((resolve, reject) => {
    getSpecialByType(1).then(response => {
      const computer = response;
      commit('SET_COMPUTER_INFO', computer);
    });
  });
};

// 加载爱吃专栏数据
export const loadEat = ({commit}) => {
  return new Promise((resolve, reject) => {
    getSpecialByType(2).then(response => {
      const eat = response;
      commit('SET_EAT_INFO', eat);
    });
  });
};

// 请求获得商品详细信息
export const loadGoodsInfo = ({commit}) => {
  commit('SET_LOAD_STATUS', true);
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      getGoodsById(1).then(response => {
        const data = response;
        commit('SET_GOODS_INFO', data);
        commit('SET_LOAD_STATUS', false);
      });
    }, 300);
  });
};

// 获取商品列表
export const loadGoodsList = ({commit}) => {
  commit('SET_LOAD_STATUS', true);
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      getGoodsListByCategoryId(2).then(response => {
        const data = response;
        commit('SET_GOODS_LIST', data);
        commit('SET_LOAD_STATUS', false);
      });
    });
  });
};

// 添加购物车
export const addShoppingCart = ({commit}, data) => {
  addGoodsToShopCart(data).then(response => {
    commit('ADD_SHOPPING_CART', data);
  });
};

// 获取用户推荐
export const loadRecommend = ({commit}) => {
  return new Promise((resolve, reject) => {
    getRecommendGoods().then(response => {
      const data = response;
      commit('SET_RECOMMEND_INFO', data);
    });
  });
};

export const loadAddress = ({commit}) => {
  getUserDeliverAddress({username: 1, password: 1}).then(response => {
    const address = response;
    commit('SET_USER_ADDRESS', address);
  });
};

/**
 * 加载购物车
 * @param commit
 * @returns {Promise<any>}
 */
export const loadShoppingCart = ({commit}, data) => {
  return new Promise((resolve, reject) => {
    getUserShopCartByUserId(data).then(response => {
      commit('SET_SHOPPING_CART', response);
    });
  });
};

// 添加注册用户
export const registerUser = ({commit}, data) => {
  return new Promise((resolve, reject) => {
    const userArr = localStorage.getItem('users');
    let users = [];
    if (userArr) {
      users = JSON.parse(userArr);
    }
    users.push(data);
    localStorage.setItem('users', JSON.stringify(users));
  });
};

// 用户登录
export const login = ({commit}, data) => {
  return new Promise((resolve, reject) => {
    loginUser({username: data.username, password: data.password}).then(response => {
      if (response && response.isLegal) {
        data.password = '';
        data.sessionId = response.sessionId;
        data.nackname = response.nackname;
        localStorage.setItem('loginInfo', JSON.stringify(data));
        commit('SET_USER_LOGIN_INFO', data);
        resolve(true);
      } else {
        resolve(false);
      }
    });
  });
};

// 退出登陆
export const signOut = ({commit}) => {
  localStorage.removeItem('loginInfo');
  commit('SET_USER_LOGIN_INFO', {});
  const resetShoppingCart = [];
  commit('SET_SHOPPING_CART', resetShoppingCart);
};

// 判断是否登陆
export const isLogin = ({commit}) => {
  const user = localStorage.getItem('loginInfo');
  if (user) {
    commit('SET_USER_LOGIN_INFO', JSON.parse(user));
  }
};
