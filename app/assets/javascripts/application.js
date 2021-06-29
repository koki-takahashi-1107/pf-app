// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//



//= require rails-ujs
//= require activestorage
//= require turbolinks

/*global $*/
  $(window).on('load',function(){
      $("#splash-logo").delay(1200).fadeOut('slow');//ロゴを1.2秒でフェードアウトする記述

      //=====ここからローディングエリア（splashエリア）を1.5秒でフェードアウトした後に動かしたいJSをまとめる
      $("#splash").delay(1500).fadeOut('slow',function(){//ローディングエリア（splashエリア）を1.5秒でフェードアウトする記述

          $('body').addClass('appear');//フェードアウト後bodyにappearクラス付与

      });
      //=====ここまでローディングエリア（splashエリア）を1.5秒でフェードアウトした後に動かしたいJSをまとめる

     //=====ここから背景が伸びた後に動かしたいJSをまとめたい場合は
      $('.splashbg').on('animationend', function() {
          //この中に動かしたいJSを記載
      });
      //=====ここまで背景が伸びた後に動かしたいJSをまとめる

  });