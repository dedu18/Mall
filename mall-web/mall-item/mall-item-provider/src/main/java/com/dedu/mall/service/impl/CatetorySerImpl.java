package com.dedu.mall.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dedu.mall.dao.CategoryDao;
import com.dedu.mall.model.h5.CategoryParentVo;
import com.dedu.mall.model.mysql.*;
import com.dedu.mall.service.CategoryService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CatetorySerImpl implements CategoryService {

    @Autowired
    private CategoryDao categoryDao;

    @Override
    public CategoryNavVo getCategoryNavTreeByParentCategoryId(Integer parentId) {
        String[] navTagArr = {"618活动", "惊爆降价", "跳楼甩卖", "全球购"};
        List<String> navTags = CollectionUtils.arrayToList(navTagArr);
        List<CategoryNavItem> navItems = new ArrayList<>();
        // 第二层类目
        List<CategoryPo> catPoList = getAllCategoryByParentId(parentId.longValue());
        for (CategoryPo catPo : catPoList) {
            if (null != catPo.getIsParent() && catPo.getIsParent()) {
                // 第三层类目
                List<CategoryPo> innerCategoryList = getAllCategoryByParentId(catPo.getId());
                List<CategoryNavSubItem> tags = innerCategoryList.stream()
                        .sorted(Comparator.comparing(CategoryPo::getSort))
                        .map(item -> {
                            return CategoryNavSubItem.builder()
                                    .id(item.getId())
                                    .name(item.getName())
                                    .build();
                        })
                        .limit(8)
                        .collect(Collectors.toList());
                CategoryNavItem categoryNavItem = createCategoryNavItem(catPo.getName(), tags);
                navItems.add(categoryNavItem);
            }
        }
        return CategoryNavVo.builder().navTags(navTags).navItems(navItems).build();
    }

    private CategoryNavItem createCategoryNavItem(String title, List<CategoryNavSubItem> navItemTags) {
        return CategoryNavItem.builder().title(title).tags(navItemTags).build();
    }

    @Override
    public NavPictureVo getAllNavPictureList() {
        List<String> carouselItems = new ArrayList<>();
        carouselItems.add("static/img/navigation/1.jpg");
        carouselItems.add("static/img/navigation/2.jpg");
        carouselItems.add("static/img/navigation/3.jpg");
        carouselItems.add("static/img/navigation/4.jpg");
        carouselItems.add("static/img/navigation/5.jpg");
        List<String> activity = new ArrayList<>();
        activity.add("static/img/navigation/nav_showimg1.jpg");
        activity.add("static/img/navigation/nav_showimg2.jpg");
        activity.add("static/img/navigation/nav_showimg3.jpg");
        return NavPictureVo.builder().carouselItems(carouselItems).activity(activity).build();
    }

    @Override
    public List<CategoryVo> getAllCategoryTreeByParentId(Integer parentId) {
        //查询所有顶级类目
        // 第一层类目
        List<CategoryPo> catPoList = categoryDao.list(new QueryWrapper<CategoryPo>().eq("parent_id", parentId).eq("is_delete", 0));
        List<CategoryVo> catVoList = new ArrayList<>();
        for (CategoryPo catPo :
                catPoList) {
            CategoryVo catVo = new CategoryVo();
            BeanUtils.copyProperties(catPo, catVo);
            if (null != catVo.getIsParent() && catVo.getIsParent()) {
                // 第二层类目
                List<CategoryPo> secondCategoryList = getAllCategoryByParentId(catVo.getId());
                if (!CollectionUtils.isEmpty(secondCategoryList)) {
                    List<CategoryVo> secondCatVoList = new ArrayList<>();
                    for (CategoryPo secondCatPo :
                            secondCategoryList) {
                        CategoryVo secondCatVo = new CategoryVo();
                        BeanUtils.copyProperties(secondCatPo, secondCatVo);
                        if (null != secondCatVo.getIsParent() && secondCatVo.getIsParent()) {
                            // 第三层类目
                            List<CategoryPo> thirdCategoryList = getAllCategoryByParentId(secondCatVo.getId());
                            if (!CollectionUtils.isEmpty(thirdCategoryList)) {
                                List<CategoryVo> thirdCatVoList = new ArrayList<>();
                                for (CategoryPo thirdPo :
                                        thirdCategoryList) {
                                    CategoryVo thirdCatVo = new CategoryVo();
                                    BeanUtils.copyProperties(thirdPo, thirdCatVo);
                                    thirdCatVoList.add(thirdCatVo);
                                }
                            }
                        }
                        secondCatVoList.add(secondCatVo);
                    }
                    catVo.setChildren(secondCatVoList);
                }
            }
            catVoList.add(catVo);
        }
        return catVoList;
    }

    @Override
    public List<CategorySelectorVo> getAllCategoryList() {
        List<CategorySelectorVo> result = new ArrayList<>();
        List<CategoryVo> allCategoryList = getAllCategoryTreeByParentId(0);
        collectCategorySelector(result, allCategoryList, "");
        result.add(CategorySelectorVo.builder().id(0L).name("无").build());
        return result;
    }


    @Override
    public boolean modifyInfoById(CategoryVo categoryVo) throws Exception {
        if (null == categoryVo.getId()) {
            throw new Exception("修改类目时，Id不能为空");
        }
        CategoryPo categoryPo = new CategoryPo();
        BeanUtils.copyProperties(categoryVo, categoryPo);
        return categoryDao.updateById(categoryPo);
    }

    @Override
    public boolean removeCategoryById(Long id) {
//        return this.update(CategoryPo.builder().isDelete(true).build(), new QueryWrapper<CategoryPo>().eq("id", id).eq("isDelete", false));
        return categoryDao.updateById(CategoryPo.builder().id(id).isDelete(true).build());
    }

    @Override
    public boolean addCategory(CategoryVo request) {
        CategoryPo categoryPo = new CategoryPo();
        BeanUtils.copyProperties(request, categoryPo);
        categoryPo.setId(null);
        if (null == request.getParentId()) {
            categoryPo.setParentId(0L);
        }
        categoryPo.setCreateTime(LocalDateTime.now());
        categoryPo.setUpdateTime(LocalDateTime.now());
        return categoryDao.save(categoryPo);
    }

    private List<CategoryPo> getAllCategoryByParentId(Long parentId) {
        return categoryDao.list(new QueryWrapper<CategoryPo>().eq("parent_id", parentId).eq("is_enable", "1").eq("is_delete", 0));
    }

    @Override
    public List<CategoryParentVo> getAllParentCategoryNav() {
        List<CategoryPo> parentCategoryList = getAllCategoryByParentId(0L);
        parentCategoryList.sort(Comparator.comparing(CategoryPo::getSort));
        List<CategoryParentVo> result = new ArrayList<>();
        for (CategoryPo categoryPo : parentCategoryList) {
            result.add(CategoryParentVo.builder().id(categoryPo.getId()).name(categoryPo.getName()).build());
        }
        return result;
    }

    /**
     * 递归一次收集类目
     *
     * @param result
     * @param allCategoryList
     */
    private void collectCategorySelector(List<CategorySelectorVo> result, List<CategoryVo> allCategoryList, String prefix) {
        for (CategoryVo catVo : allCategoryList) {
            result.add(CategorySelectorVo.builder().id(catVo.getId()).name(prefix + catVo.getName()).build());
            if (!CollectionUtils.isEmpty(catVo.getChildren())) {
                collectCategorySelector(result, catVo.getChildren(), catVo.getName() + "-");
            }
        }
    }
}
