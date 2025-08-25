/**
 * Main JavaScript for AI Overview LP Theme
 */

(function($) {
    'use strict';

    $(document).ready(function() {
        
        // Mobile Menu Toggle
        $('#navbar-toggle').on('click', function() {
            $('.navbar-menu').slideToggle();
            $(this).toggleClass('active');
        });
        
        // Smooth Scroll for Anchor Links
        $('a[href*="#"]:not([href="#"])').on('click', function() {
            if (location.pathname.replace(/^\//, '') === this.pathname.replace(/^\//, '') && location.hostname === this.hostname) {
                var target = $(this.hash);
                target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
                
                if (target.length) {
                    $('html, body').animate({
                        scrollTop: target.offset().top - 80
                    }, 800);
                    return false;
                }
            }
        });
        
        // Sticky Header Effect
        var header = $('.site-header');
        var headerHeight = header.outerHeight();
        
        $(window).on('scroll', function() {
            if ($(this).scrollTop() > headerHeight) {
                header.addClass('scrolled');
            } else {
                header.removeClass('scrolled');
            }
        });
        
        // Fade In Animation on Scroll
        var animateElements = $('.fade-in-scroll');
        
        function checkAnimation() {
            var windowHeight = $(window).height();
            var windowTop = $(window).scrollTop();
            var windowBottom = windowTop + windowHeight;
            
            $.each(animateElements, function() {
                var element = $(this);
                var elementTop = element.offset().top;
                var elementBottom = elementTop + element.outerHeight();
                
                if ((elementBottom >= windowTop) && (elementTop <= windowBottom)) {
                    element.addClass('animated');
                }
            });
        }
        
        $(window).on('scroll resize', checkAnimation);
        $(window).trigger('scroll');
        
        // Copy to Clipboard for Code Blocks
        $('pre code').each(function() {
            var $this = $(this);
            var $button = $('<button class="copy-code">Copy</button>');
            
            $this.parent().prepend($button);
            
            $button.on('click', function() {
                var text = $this.text();
                var $temp = $('<textarea>');
                $('body').append($temp);
                $temp.val(text).select();
                document.execCommand('copy');
                $temp.remove();
                
                $button.text('Copied!');
                setTimeout(function() {
                    $button.text('Copy');
                }, 2000);
            });
        });
        
        // FAQ Accordion
        $('.faq-question').on('click', function() {
            var $answer = $(this).next('.faq-answer');
            var $parent = $(this).parent('.faq-item');
            
            if ($parent.hasClass('active')) {
                $answer.slideUp();
                $parent.removeClass('active');
            } else {
                $('.faq-item').removeClass('active');
                $('.faq-answer').slideUp();
                $answer.slideDown();
                $parent.addClass('active');
            }
        });
        
        // Category Filter Active State
        $('.category-item').on('click', function(e) {
            e.preventDefault();
            $('.category-item').removeClass('active');
            $(this).addClass('active');
            
            // Here you can add AJAX loading for filtered posts
            var categoryUrl = $(this).attr('href');
            // loadPosts(categoryUrl);
        });
        
        // Lazy Loading for Images
        if ('IntersectionObserver' in window) {
            var lazyImages = document.querySelectorAll('img[data-src]');
            
            var imageObserver = new IntersectionObserver(function(entries, observer) {
                entries.forEach(function(entry) {
                    if (entry.isIntersecting) {
                        var img = entry.target;
                        img.src = img.dataset.src;
                        img.classList.add('loaded');
                        imageObserver.unobserve(img);
                    }
                });
            });
            
            lazyImages.forEach(function(img) {
                imageObserver.observe(img);
            });
        }
        
        // Progress Bar for Single Posts
        if ($('.single-column').length) {
            var progressBar = $('<div class="reading-progress"></div>');
            $('body').append(progressBar);
            
            $(window).on('scroll', function() {
                var scrollTop = $(window).scrollTop();
                var docHeight = $(document).height();
                var winHeight = $(window).height();
                var scrollPercent = scrollTop / (docHeight - winHeight);
                var scrollPercentRounded = Math.round(scrollPercent * 100);
                
                progressBar.css('width', scrollPercentRounded + '%');
            });
        }
        
        // Form Validation
        $('form').on('submit', function(e) {
            var $form = $(this);
            var isValid = true;
            
            $form.find('[required]').each(function() {
                var $field = $(this);
                if (!$field.val()) {
                    $field.addClass('error');
                    isValid = false;
                } else {
                    $field.removeClass('error');
                }
            });
            
            if (!isValid) {
                e.preventDefault();
                alert('Please fill in all required fields.');
            }
        });
        
        // Back to Top Button
        var $backToTop = $('<button class="back-to-top" aria-label="Back to top">↑</button>');
        $('body').append($backToTop);
        
        $(window).on('scroll', function() {
            if ($(this).scrollTop() > 300) {
                $backToTop.fadeIn();
            } else {
                $backToTop.fadeOut();
            }
        });
        
        $backToTop.on('click', function() {
            $('html, body').animate({
                scrollTop: 0
            }, 600);
        });
        
    });

})(jQuery);