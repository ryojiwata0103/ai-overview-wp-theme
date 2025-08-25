<?php
/**
 * AI Overview LP Theme Functions
 *
 * @package AI_Overview_LP
 */

// テーマのセットアップ
function ai_overview_setup() {
    // タイトルタグのサポート
    add_theme_support('title-tag');
    
    // アイキャッチ画像のサポート
    add_theme_support('post-thumbnails');
    
    // HTML5マークアップのサポート
    add_theme_support('html5', array(
        'search-form',
        'comment-form',
        'comment-list',
        'gallery',
        'caption',
    ));
    
    // カスタムロゴのサポート
    add_theme_support('custom-logo', array(
        'height'      => 60,
        'width'       => 200,
        'flex-height' => true,
        'flex-width'  => true,
    ));
    
    // ナビゲーションメニューの登録
    register_nav_menus(array(
        'primary' => __('Primary Menu', 'ai-overview-lp'),
        'footer'  => __('Footer Menu', 'ai-overview-lp'),
    ));
}
add_action('after_setup_theme', 'ai_overview_setup');

// スタイルとスクリプトのエンキュー
function ai_overview_scripts() {
    // メインスタイルシート
    wp_enqueue_style('ai-overview-style', get_stylesheet_uri(), array(), '1.0.0');
    
    // カスタムCSS
    wp_enqueue_style('ai-overview-custom', get_template_directory_uri() . '/assets/css/custom.css', array('ai-overview-style'), '1.0.0');
    
    // メインJavaScript
    wp_enqueue_script('ai-overview-main', get_template_directory_uri() . '/assets/js/main.js', array('jquery'), '1.0.0', true);
    
    // スムーススクロール用のJS
    wp_enqueue_script('ai-overview-smooth-scroll', get_template_directory_uri() . '/assets/js/smooth-scroll.js', array(), '1.0.0', true);
}
add_action('wp_enqueue_scripts', 'ai_overview_scripts');

// カスタム投稿タイプ「コラム」の登録
function ai_overview_register_column_post_type() {
    $labels = array(
        'name'               => _x('コラム', 'post type general name', 'ai-overview-lp'),
        'singular_name'      => _x('コラム', 'post type singular name', 'ai-overview-lp'),
        'menu_name'          => _x('コラム', 'admin menu', 'ai-overview-lp'),
        'name_admin_bar'     => _x('コラム', 'add new on admin bar', 'ai-overview-lp'),
        'add_new'            => _x('新規追加', 'column', 'ai-overview-lp'),
        'add_new_item'       => __('新しいコラムを追加', 'ai-overview-lp'),
        'new_item'           => __('新しいコラム', 'ai-overview-lp'),
        'edit_item'          => __('コラムを編集', 'ai-overview-lp'),
        'view_item'          => __('コラムを表示', 'ai-overview-lp'),
        'all_items'          => __('すべてのコラム', 'ai-overview-lp'),
        'search_items'       => __('コラムを検索', 'ai-overview-lp'),
        'parent_item_colon'  => __('親コラム:', 'ai-overview-lp'),
        'not_found'          => __('コラムが見つかりません', 'ai-overview-lp'),
        'not_found_in_trash' => __('ゴミ箱にコラムが見つかりません', 'ai-overview-lp')
    );

    $args = array(
        'labels'             => $labels,
        'public'             => true,
        'publicly_queryable' => true,
        'show_ui'            => true,
        'show_in_menu'       => true,
        'query_var'          => true,
        'rewrite'            => array('slug' => 'column'),
        'capability_type'    => 'post',
        'has_archive'        => true,
        'hierarchical'       => false,
        'menu_position'      => 5,
        'menu_icon'          => 'dashicons-edit-page',
        'supports'           => array('title', 'editor', 'author', 'thumbnail', 'excerpt', 'comments'),
        'show_in_rest'       => true,
    );

    register_post_type('column', $args);
}
add_action('init', 'ai_overview_register_column_post_type');

// コラムのカテゴリー（タクソノミー）を追加
function ai_overview_register_column_taxonomy() {
    $labels = array(
        'name'              => _x('カテゴリー', 'taxonomy general name', 'ai-overview-lp'),
        'singular_name'     => _x('カテゴリー', 'taxonomy singular name', 'ai-overview-lp'),
        'search_items'      => __('カテゴリーを検索', 'ai-overview-lp'),
        'all_items'         => __('すべてのカテゴリー', 'ai-overview-lp'),
        'parent_item'       => __('親カテゴリー', 'ai-overview-lp'),
        'parent_item_colon' => __('親カテゴリー:', 'ai-overview-lp'),
        'edit_item'         => __('カテゴリーを編集', 'ai-overview-lp'),
        'update_item'       => __('カテゴリーを更新', 'ai-overview-lp'),
        'add_new_item'      => __('新しいカテゴリーを追加', 'ai-overview-lp'),
        'new_item_name'     => __('新しいカテゴリー名', 'ai-overview-lp'),
        'menu_name'         => __('カテゴリー', 'ai-overview-lp'),
    );

    $args = array(
        'hierarchical'      => true,
        'labels'            => $labels,
        'show_ui'           => true,
        'show_admin_column' => true,
        'query_var'         => true,
        'rewrite'           => array('slug' => 'column-category'),
        'show_in_rest'      => true,
    );

    register_taxonomy('column_category', array('column'), $args);
}
add_action('init', 'ai_overview_register_column_taxonomy');

// ウィジェットエリアの登録
function ai_overview_widgets_init() {
    register_sidebar(array(
        'name'          => __('サイドバー', 'ai-overview-lp'),
        'id'            => 'sidebar-1',
        'description'   => __('サイドバーウィジェットエリア', 'ai-overview-lp'),
        'before_widget' => '<div id="%1$s" class="widget %2$s">',
        'after_widget'  => '</div>',
        'before_title'  => '<h3 class="widget-title">',
        'after_title'   => '</h3>',
    ));
    
    register_sidebar(array(
        'name'          => __('フッター1', 'ai-overview-lp'),
        'id'            => 'footer-1',
        'description'   => __('フッターウィジェットエリア1', 'ai-overview-lp'),
        'before_widget' => '<div id="%1$s" class="widget %2$s">',
        'after_widget'  => '</div>',
        'before_title'  => '<h4 class="widget-title">',
        'after_title'   => '</h4>',
    ));
    
    register_sidebar(array(
        'name'          => __('フッター2', 'ai-overview-lp'),
        'id'            => 'footer-2',
        'description'   => __('フッターウィジェットエリア2', 'ai-overview-lp'),
        'before_widget' => '<div id="%1$s" class="widget %2$s">',
        'after_widget'  => '</div>',
        'before_title'  => '<h4 class="widget-title">',
        'after_title'   => '</h4>',
    ));
    
    register_sidebar(array(
        'name'          => __('フッター3', 'ai-overview-lp'),
        'id'            => 'footer-3',
        'description'   => __('フッターウィジェットエリア3', 'ai-overview-lp'),
        'before_widget' => '<div id="%1$s" class="widget %2$s">',
        'after_widget'  => '</div>',
        'before_title'  => '<h4 class="widget-title">',
        'after_title'   => '</h4>',
    ));
}
add_action('widgets_init', 'ai_overview_widgets_init');

// カスタマイザーの設定
function ai_overview_customize_register($wp_customize) {
    // CTAボタンのテキスト設定
    $wp_customize->add_section('ai_overview_cta_settings', array(
        'title'    => __('CTAボタン設定', 'ai-overview-lp'),
        'priority' => 30,
    ));
    
    $wp_customize->add_setting('cta_button_text', array(
        'default'           => '今すぐチェックしてみる',
        'sanitize_callback' => 'sanitize_text_field',
    ));
    
    $wp_customize->add_control('cta_button_text', array(
        'label'    => __('CTAボタンテキスト', 'ai-overview-lp'),
        'section'  => 'ai_overview_cta_settings',
        'type'     => 'text',
    ));
    
    $wp_customize->add_setting('cta_button_url', array(
        'default'           => '#',
        'sanitize_callback' => 'esc_url_raw',
    ));
    
    $wp_customize->add_control('cta_button_url', array(
        'label'    => __('CTAボタンURL', 'ai-overview-lp'),
        'section'  => 'ai_overview_cta_settings',
        'type'     => 'url',
    ));
}
add_action('customize_register', 'ai_overview_customize_register');

// ページネーション
function ai_overview_pagination() {
    global $wp_query;
    $big = 999999999;
    
    $pages = paginate_links(array(
        'base'      => str_replace($big, '%#%', esc_url(get_pagenum_link($big))),
        'format'    => '?paged=%#%',
        'current'   => max(1, get_query_var('paged')),
        'total'     => $wp_query->max_num_pages,
        'type'      => 'array',
        'prev_text' => '&laquo;',
        'next_text' => '&raquo;',
    ));
    
    if (is_array($pages)) {
        echo '<div class="pagination">';
        foreach ($pages as $page) {
            echo '<span class="page-item">' . $page . '</span>';
        }
        echo '</div>';
    }
}

// 抜粋の文字数を設定
function ai_overview_excerpt_length($length) {
    return 100;
}
add_filter('excerpt_length', 'ai_overview_excerpt_length');

// 抜粋の末尾を変更
function ai_overview_excerpt_more($more) {
    return '...';
}
add_filter('excerpt_more', 'ai_overview_excerpt_more');