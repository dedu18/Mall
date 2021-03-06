import {getAllNavigationPictureList} from '../api/category';
import {getGoodsNavByCategoryId, getGoodsListByCategoryId, getGoodsBySpuId, getRecommendGoods, getGoodsListByKeyword} from '../api/goods';
import {getSeckillInfoList, getSpecialByType} from '../api/market';
import {getUserDeliverAddress, loginUser, addUserDeliverAddress} from '../api/user';
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
export const loadGoodsInfo = ({commit}, data) => {
  commit('SET_LOAD_STATUS', true);
  getGoodsBySpuId(data).then(response => {
    commit('SET_GOODS_INFO', response);
    commit('SET_LOAD_STATUS', false);
  });
};

// 获取商品筛选规格列表
export const loadGoodsNavInfoByCategoryId = ({commit}, data) => {
  getGoodsNavByCategoryId(data).then(response => {
    commit('SET_GOODS_NAVINFO', response);
  });
};

// 获取商品列表
export const loadGoodsListByCategoryId = ({commit}, data) => {
  commit('SET_LOAD_STATUS', true);
  getGoodsListByCategoryId(data).then(response => {
    commit('SET_GOODS_LIST', response);
    commit('SET_LOAD_STATUS', false);
  });
};

// 获取搜索商品列表
export const loadGoodsListByKeyword = ({commit}, data) => {
  commit('SET_LOAD_STATUS', true);
  getGoodsListByKeyword(data).then(response => {
    commit('SET_GOODS_LIST', response);
  });
  commit('SET_LOAD_STATUS', false);
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

export const loadAddress = ({commit}, data) => {
  getUserDeliverAddress({sessionId: data}).then(response => {
    const address = response;
    commit('SET_USER_ADDRESS', address);
  });
};

/**
 * 新增用户收货地址
 * @param commit
 * @param data
 */
export const addAddress = ({commit}, data) => {
  addUserDeliverAddress(data).then(response => {
  });
};


/**
 * 加载购物车
 * @param commit
 * @returns {Promise<any>}
 */
export const loadShoppingCart = ({commit}) => {
  getUserShopCartByUserId()
    .then(response => {
    commit('SET_SHOPPING_CART', response);
  })
    .catch(error => {
      console.log(error)
    })
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
      if (response && response.login) {
        localStorage.setItem('loginInfo', JSON.stringify(response));
        commit('SET_USER_LOGIN_INFO', response);
        console.log(response)
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
