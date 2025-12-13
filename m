Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F5D285CAA;
	Sat, 13 Dec 2025 08:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765613119; cv=none; b=iaerH967dNnft6SuthFpBimw1/4YALRvnO2hCyikU2AuTy3dH6xOOWLtX1N4XAKoj0MF7/mNLQiud4ylWoV7N4J/okJt5AtziZPJRdUaUlOUgcVFWWV41FXHkC5r+9Rdlk/72cSRF+Iituvo0o4wrHHvDpirfGm/az6YJNEDj7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765613119; c=relaxed/simple;
	bh=JHt6KFdYF/Lyw2aJzDOMKUhj9p9Y7VTvaJ2iqurQKh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvKWpgnVRYKjgtKjxalwcsiTO1W8SPxKqt1bjG8SxAnwbzbew0RjimVKF9PqihMHlNrNX6XBEeZqUII11Ckc2j1PXQ/MPBmw6PR3kOpWkpnPl/GXgr66pl0+FcXTlI5OX0C5BYeWYRdva5MxCOY2QN/7+zD1VCDvAfI72nNDmpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVeXCo7R; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVeXCo7R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765613118; x=1797149118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JHt6KFdYF/Lyw2aJzDOMKUhj9p9Y7VTvaJ2iqurQKh4=;
  b=HVeXCo7R7umG+kmzBHd+xxB7MLXkupy5TKgAD0LXQoMdBYonbZRJd8cb
   ZAV9lyIsJ6eaB9QvM+4Mz9fN/ZdUf4/rhGHfhTD4+WaTk4W6LSTiUm0Gr
   oIeMcwS/OPgJINkDuYuyCmiDvP/u4oeuNTLCiHVLpL2z5stijq/xw85v8
   i//fcX/GIiofJrrhbRXE6DOF+hnJ9nPFJ0QPpIRtMLPVcFKu8XPMrOuAR
   C9p1H2fovDXQTckODgmoYD9WeDeKoX2vxTvJt57488NAyLFNx7sMT7HxR
   OZAEM26VdtpBtxyfJ603BNv3Sz7rJOy11yRSQ1sXuU7ecgCoy9vadUV4V
   g==;
X-CSE-ConnectionGUID: NGjsoJGvQVCc+hI1BNSwfg==
X-CSE-MsgGUID: Q4yG5BeHTOy2VrG5br6DqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="77919221"
X-IronPort-AV: E=Sophos;i="6.21,145,1763452800"; 
   d="scan'208";a="77919221"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2025 00:05:17 -0800
X-CSE-ConnectionGUID: 0AJztNN1RDml2bZ8YxYJFQ==
X-CSE-MsgGUID: vUyvmoXUT8Gdfc3tNpFDgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,145,1763452800"; 
   d="scan'208";a="201695631"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 Dec 2025 00:05:15 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vUKcq-000000007H5-3UJt;
	Sat, 13 Dec 2025 08:05:12 +0000
Date: Sat, 13 Dec 2025 16:05:01 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, simona@ffwll.ch, airlied@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/2] vt: Remove con_debug_enter/_leave from struct consw
Message-ID: <202512131551.QwAYImi0-lkp@intel.com>
References: <20251208102851.40894-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208102851.40894-3-tzimmermann@suse.de>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus linus/master v6.18 next-20251212]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Zimmermann/vt-Remove-trailing-whitespace/20251208-183541
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20251208102851.40894-3-tzimmermann%40suse.de
patch subject: [PATCH 2/2] vt: Remove con_debug_enter/_leave from struct consw
config: csky-randconfig-002-20251213 (https://download.01.org/0day-ci/archive/20251213/202512131551.QwAYImi0-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251213/202512131551.QwAYImi0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512131551.QwAYImi0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/video/fbdev/core/fbcon.c:3176:10: error: 'const struct consw' has no member named 'con_debug_enter'
    3176 |         .con_debug_enter        = fbcon_debug_enter,
         |          ^~~~~~~~~~~~~~~
>> drivers/video/fbdev/core/fbcon.c:3176:35: error: initialization of 'void (*)(struct vc_data *, const unsigned char *)' from incompatible pointer type 'void (*)(struct vc_data *)' [-Werror=incompatible-pointer-types]
    3176 |         .con_debug_enter        = fbcon_debug_enter,
         |                                   ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:3176:35: note: (near initialization for 'fb_con.con_set_palette')
   drivers/video/fbdev/core/fbcon.c:3176:35: warning: initialized field overwritten [-Woverride-init]
   drivers/video/fbdev/core/fbcon.c:3176:35: note: (near initialization for 'fb_con.con_set_palette')
>> drivers/video/fbdev/core/fbcon.c:3177:10: error: 'const struct consw' has no member named 'con_debug_leave'
    3177 |         .con_debug_leave        = fbcon_debug_leave,
         |          ^~~~~~~~~~~~~~~
>> drivers/video/fbdev/core/fbcon.c:3177:35: error: initialization of 'void (*)(struct vc_data *, int)' from incompatible pointer type 'void (*)(struct vc_data *)' [-Werror=incompatible-pointer-types]
    3177 |         .con_debug_leave        = fbcon_debug_leave,
         |                                   ^~~~~~~~~~~~~~~~~
   drivers/video/fbdev/core/fbcon.c:3177:35: note: (near initialization for 'fb_con.con_scrolldelta')
   cc1: some warnings being treated as errors


vim +3176 drivers/video/fbdev/core/fbcon.c

fe2d70d6f6ff03 drivers/video/fbdev/core/fbcon.c Simona Vetter  2019-05-28  3154  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3155  /*
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3156   *  The console `switch' structure for the frame buffer based console
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3157   */
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3158  
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3159  static const struct consw fb_con = {
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3160  	.owner			= THIS_MODULE,
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3161  	.con_startup 		= fbcon_startup,
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3162  	.con_init 		= fbcon_init,
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3163  	.con_deinit 		= fbcon_deinit,
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3164  	.con_clear 		= fbcon_clear,
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3165  	.con_putcs 		= fbcon_putcs,
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3166  	.con_cursor 		= fbcon_cursor,
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3167  	.con_scroll 		= fbcon_scroll,
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3168  	.con_switch 		= fbcon_switch,
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3169  	.con_blank 		= fbcon_blank,
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3170  	.con_font_set 		= fbcon_set_font,
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3171  	.con_font_get 		= fbcon_get_font,
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3172  	.con_font_default	= fbcon_set_def_font,
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3173  	.con_set_palette 	= fbcon_set_palette,
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3174  	.con_invert_region 	= fbcon_invert_region,
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3175  	.con_resize             = fbcon_resize,
d219adc1228a38 drivers/video/console/fbcon.c    Jesse Barnes   2010-08-02 @3176  	.con_debug_enter	= fbcon_debug_enter,
d219adc1228a38 drivers/video/console/fbcon.c    Jesse Barnes   2010-08-02 @3177  	.con_debug_leave	= fbcon_debug_leave,
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3178  };
^1da177e4c3f41 drivers/video/console/fbcon.c    Linus Torvalds 2005-04-16  3179  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
