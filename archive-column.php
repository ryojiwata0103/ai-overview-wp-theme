<?php
/**
 * The template for displaying column archive pages
 *
 * @package AI_Overview_LP
 */

get_header(); ?>

<section class="column-archive-section">
    <div class="container">
        <header class="archive-header">
            <h1 class="archive-title">コラム</h1>
            <p class="archive-description">AI Overview対策とSEOに関する最新情報をお届けします</p>
        </header>
        
        <?php
        $categories = get_terms(array(
            'taxonomy' => 'column_category',
            'hide_empty' => true,
        ));
        
        if ($categories && !is_wp_error($categories)) : ?>
            <div class="category-filter">
                <ul class="category-list">
                    <li><a href="<?php echo get_post_type_archive_link('column'); ?>" class="category-item <?php echo !is_tax() ? 'active' : ''; ?>">すべて</a></li>
                    <?php foreach ($categories as $category) : ?>
                        <li>
                            <a href="<?php echo get_term_link($category); ?>" 
                               class="category-item <?php echo is_tax('column_category', $category->term_id) ? 'active' : ''; ?>">
                                <?php echo esc_html($category->name); ?>
                            </a>
                        </li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>
        
        <?php if (have_posts()) : ?>
            <div class="columns-grid grid grid-3">
                <?php while (have_posts()) : the_post(); ?>
                    <article class="column-card card">
                        <?php if (has_post_thumbnail()) : ?>
                            <div class="column-thumbnail">
                                <a href="<?php the_permalink(); ?>">
                                    <?php the_post_thumbnail('medium', array('class' => 'column-image')); ?>
                                </a>
                            </div>
                        <?php endif; ?>
                        
                        <div class="column-content">
                            <?php
                            $terms = get_the_terms(get_the_ID(), 'column_category');
                            if ($terms && !is_wp_error($terms)) : ?>
                                <div class="column-categories">
                                    <?php foreach ($terms as $term) : ?>
                                        <span class="badge"><?php echo esc_html($term->name); ?></span>
                                    <?php endforeach; ?>
                                </div>
                            <?php endif; ?>
                            
                            <h2 class="column-title">
                                <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
                            </h2>
                            
                            <div class="column-meta">
                                <time datetime="<?php echo get_the_date('c'); ?>">
                                    <?php echo get_the_date(); ?>
                                </time>
                            </div>
                            
                            <div class="column-excerpt">
                                <?php the_excerpt(); ?>
                            </div>
                            
                            <a href="<?php the_permalink(); ?>" class="read-more-link">
                                続きを読む →
                            </a>
                        </div>
                    </article>
                <?php endwhile; ?>
            </div>
            
            <?php ai_overview_pagination(); ?>
            
        <?php else : ?>
            <div class="no-columns">
                <p>まだコラムが投稿されていません。</p>
            </div>
        <?php endif; ?>
    </div>
</section>

<?php get_footer(); ?>