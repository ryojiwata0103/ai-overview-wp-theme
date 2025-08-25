<?php
/**
 * The template for displaying single column posts
 *
 * @package AI_Overview_LP
 */

get_header(); ?>

<article class="single-column">
    <?php while (have_posts()) : the_post(); ?>
        
        <header class="column-header">
            <div class="container-narrow">
                <?php
                $terms = get_the_terms(get_the_ID(), 'column_category');
                if ($terms && !is_wp_error($terms)) : ?>
                    <div class="column-categories">
                        <?php foreach ($terms as $term) : ?>
                            <a href="<?php echo get_term_link($term); ?>" class="badge">
                                <?php echo esc_html($term->name); ?>
                            </a>
                        <?php endforeach; ?>
                    </div>
                <?php endif; ?>
                
                <h1 class="column-title"><?php the_title(); ?></h1>
                
                <div class="column-meta">
                    <div class="meta-item">
                        <time datetime="<?php echo get_the_date('c'); ?>">
                            <?php echo get_the_date(); ?>
                        </time>
                    </div>
                    <div class="meta-item">
                        <span class="author">by <?php the_author(); ?></span>
                    </div>
                </div>
                
                <?php if (has_post_thumbnail()) : ?>
                    <div class="column-featured-image">
                        <?php the_post_thumbnail('large', array('class' => 'featured-image')); ?>
                    </div>
                <?php endif; ?>
            </div>
        </header>
        
        <div class="column-body">
            <div class="container-narrow">
                <div class="column-content">
                    <?php the_content(); ?>
                </div>
                
                <div class="column-tags">
                    <?php
                    $tags = get_the_tags();
                    if ($tags) : ?>
                        <div class="tags-wrapper">
                            <span class="tags-label">タグ:</span>
                            <?php foreach ($tags as $tag) : ?>
                                <a href="<?php echo get_tag_link($tag->term_id); ?>" class="tag-item">
                                    #<?php echo esc_html($tag->name); ?>
                                </a>
                            <?php endforeach; ?>
                        </div>
                    <?php endif; ?>
                </div>
                
                <div class="column-share">
                    <h3>この記事をシェア</h3>
                    <div class="share-buttons">
                        <a href="https://twitter.com/share?url=<?php echo urlencode(get_permalink()); ?>&text=<?php echo urlencode(get_the_title()); ?>" 
                           target="_blank" 
                           rel="noopener noreferrer" 
                           class="share-button share-twitter">
                            Twitter
                        </a>
                        <a href="https://www.facebook.com/sharer/sharer.php?u=<?php echo urlencode(get_permalink()); ?>" 
                           target="_blank" 
                           rel="noopener noreferrer" 
                           class="share-button share-facebook">
                            Facebook
                        </a>
                        <a href="https://www.linkedin.com/shareArticle?mini=true&url=<?php echo urlencode(get_permalink()); ?>&title=<?php echo urlencode(get_the_title()); ?>" 
                           target="_blank" 
                           rel="noopener noreferrer" 
                           class="share-button share-linkedin">
                            LinkedIn
                        </a>
                    </div>
                </div>
                
                <nav class="column-navigation">
                    <div class="nav-previous">
                        <?php previous_post_link('%link', '← %title', true, '', 'column_category'); ?>
                    </div>
                    <div class="nav-next">
                        <?php next_post_link('%link', '%title →', true, '', 'column_category'); ?>
                    </div>
                </nav>
            </div>
        </div>
        
        <section class="related-columns section-gray">
            <div class="container">
                <h2 class="section-title text-center">関連記事</h2>
                <?php
                $related_args = array(
                    'post_type' => 'column',
                    'posts_per_page' => 3,
                    'post__not_in' => array(get_the_ID()),
                    'orderby' => 'rand',
                );
                
                $terms = get_the_terms(get_the_ID(), 'column_category');
                if ($terms && !is_wp_error($terms)) {
                    $term_ids = array();
                    foreach ($terms as $term) {
                        $term_ids[] = $term->term_id;
                    }
                    $related_args['tax_query'] = array(
                        array(
                            'taxonomy' => 'column_category',
                            'field' => 'term_id',
                            'terms' => $term_ids,
                        ),
                    );
                }
                
                $related_query = new WP_Query($related_args);
                
                if ($related_query->have_posts()) : ?>
                    <div class="columns-grid grid grid-3">
                        <?php while ($related_query->have_posts()) : $related_query->the_post(); ?>
                            <article class="column-card card">
                                <?php if (has_post_thumbnail()) : ?>
                                    <div class="column-thumbnail">
                                        <a href="<?php the_permalink(); ?>">
                                            <?php the_post_thumbnail('medium', array('class' => 'column-image')); ?>
                                        </a>
                                    </div>
                                <?php endif; ?>
                                
                                <div class="column-content">
                                    <h3 class="column-title">
                                        <a href="<?php the_permalink(); ?>"><?php the_title(); ?></a>
                                    </h3>
                                    
                                    <div class="column-meta">
                                        <time datetime="<?php echo get_the_date('c'); ?>">
                                            <?php echo get_the_date(); ?>
                                        </time>
                                    </div>
                                    
                                    <a href="<?php the_permalink(); ?>" class="read-more-link">
                                        続きを読む →
                                    </a>
                                </div>
                            </article>
                        <?php endwhile; ?>
                    </div>
                <?php endif;
                wp_reset_postdata(); ?>
            </div>
        </section>
        
        <section class="column-cta">
            <div class="container-narrow">
                <div class="cta-section">
                    <h2>AIサマリ対策を今すぐ始めませんか？</h2>
                    <p>あなたの記事もAI検索に最適化して、より多くのユーザーにリーチしましょう。</p>
                    <a href="<?php echo esc_url(get_theme_mod('cta_button_url', '#demo')); ?>" class="btn btn-primary btn-large">
                        無料デモを試してみる
                    </a>
                </div>
            </div>
        </section>
        
    <?php endwhile; ?>
</article>

<?php get_footer(); ?>