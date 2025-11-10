Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8AE2F657C;
	Mon, 10 Nov 2025 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774241; cv=none; b=jjxLXDns8zdKDl5jkhpAe2uZt7Bpa3a68s2qQPC/DP7qeNUM9Rc5ouBS0QimLVWhQUIvR9KADRiU74rResL0zr3XIGaF7c4SRR8PwGagjlQEx0KogElK3SpztO3Puv/QfQC0OrT72eTgIwLPuVcwZUMN9lX58bA6LTmGBqnSqhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774241; c=relaxed/simple;
	bh=RxfqoO+yHS7u10hkcKNl7hz+iD8IaI6bqSG+tV23NGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2WcezhE9r0jwbXl62YX9D9+Dda2ht9CDSGT2ayByl8Vx2NVadxnZ9HtCYO1loUBEAIO2D7BKERfALrFVia4ZcIPbMVAPet3Tb/j508Nwy6sd/XHIxycQ0To3+yZVuvIkW5Uk8my/Qorx1s925+9J8mclWfeIZEWMzXvqor8EhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+L0gK5Q; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+L0gK5Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762774238; x=1794310238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RxfqoO+yHS7u10hkcKNl7hz+iD8IaI6bqSG+tV23NGM=;
  b=W+L0gK5QuH5DtLuKE4/HMopDdQxcnNNdyeu6cypQCh21WyCKA2uw7/tR
   hOdj7lx9OGRcbc8hZhUckBQSh1+3iW7DLQwJjKnZtY7WSEVh6x75aygi5
   xeKF4jFiPW10+/3XmokOX0wbHH7QS3kFCwR4TXaAVzCBytNwzc2Y6VxvZ
   PPsUaA8ZcU9wqFbCNyjvLuQKwFQWUJtLp6b97y9guXzCCOT/U2o9nb9u7
   QOoglFPhHOqc9/AUslZtct0gImLXqyaR8Dr6VJEa8JuLycviK/xbvmqDf
   x962Qr9USTtjyII+NfZ+491rzFpaOipfpJa5ZREsmaOrDaD+KA0AwOvcD
   g==;
X-CSE-ConnectionGUID: 7d64s8Y7ROqcRpGgLv0btw==
X-CSE-MsgGUID: HeW4apFDTXWqtKfJ3erGFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64522245"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="64522245"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:30:38 -0800
X-CSE-ConnectionGUID: CpyNSRr8R8+L7o4h4wO8uA==
X-CSE-MsgGUID: eNsO4S4xQoaPjpnkFF2swQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="193661718"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 10 Nov 2025 03:30:34 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIQ6S-0000LH-0z;
	Mon, 10 Nov 2025 11:30:32 +0000
Date: Mon, 10 Nov 2025 19:29:58 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, jfalempe@redhat.com,
	javierm@redhat.com, simona@ffwll.ch, airlied@gmail.com,
	mripard@kernel.org, maarten.lankhorst@linux.intel.com,
	gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/3] drm/client: Support emergency restore via sysrq for
 all clients
Message-ID: <202511101914.Rt1WtmfO-lkp@intel.com>
References: <20251107142612.467817-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107142612.467817-3-tzimmermann@suse.de>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20251107]
[cannot apply to drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip linus/master v6.18-rc4 v6.18-rc3 v6.18-rc2 v6.18-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Zimmermann/drm-client-Pass-force-parameter-to-client-restore/20251107-223026
base:   next-20251107
patch link:    https://lore.kernel.org/r/20251107142612.467817-3-tzimmermann%40suse.de
patch subject: [PATCH 2/3] drm/client: Support emergency restore via sysrq for all clients
config: parisc-randconfig-002-20251110 (https://download.01.org/0day-ci/archive/20251110/202511101914.Rt1WtmfO-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251110/202511101914.Rt1WtmfO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511101914.Rt1WtmfO-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/drm_dumb_buffers.c:35:
>> drivers/gpu/drm/drm_internal.h:64:6: warning: no previous prototype for 'drm_client_sysrq_register' [-Wmissing-prototypes]
      64 | void drm_client_sysrq_register(struct drm_device *dev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/drm_internal.h:66:6: warning: no previous prototype for 'drm_client_sysrq_unregister' [-Wmissing-prototypes]
      66 | void drm_client_sysrq_unregister(struct drm_device *dev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/clients/drm_log.c:22:
>> drivers/gpu/drm/clients/../drm_internal.h:64:6: warning: no previous prototype for 'drm_client_sysrq_register' [-Wmissing-prototypes]
      64 | void drm_client_sysrq_register(struct drm_device *dev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/clients/../drm_internal.h:66:6: warning: no previous prototype for 'drm_client_sysrq_unregister' [-Wmissing-prototypes]
      66 | void drm_client_sysrq_unregister(struct drm_device *dev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   hppa-linux-ld: drivers/gpu/drm/drm_auth.o: in function `drm_client_sysrq_register':
>> (.text+0x45c): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_auth.o: in function `drm_client_sysrq_unregister':
>> (.text+0x460): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_connector.o: in function `drm_client_sysrq_register':
   (.text+0x1e90): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_connector.o: in function `drm_client_sysrq_unregister':
   (.text+0x1e94): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_crtc.o: in function `drm_client_sysrq_register':
   (.text+0xab8): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_crtc.o: in function `drm_client_sysrq_unregister':
   (.text+0xabc): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_drv.o: in function `drm_client_sysrq_register':
   (.text+0x14f4): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_drv.o: in function `drm_client_sysrq_unregister':
   (.text+0x14f8): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_dumb_buffers.o: in function `drm_client_sysrq_register':
   (.text+0x20c): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_dumb_buffers.o: in function `drm_client_sysrq_unregister':
   (.text+0x210): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_edid.o: in function `drm_client_sysrq_register':
   (.text+0x734c): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_edid.o: in function `drm_client_sysrq_unregister':
   (.text+0x7350): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_encoder.o: in function `drm_client_sysrq_register':
   (.text+0x444): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_encoder.o: in function `drm_client_sysrq_unregister':
   (.text+0x448): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_file.o: in function `drm_client_sysrq_register':
   (.text+0xf10): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_file.o: in function `drm_client_sysrq_unregister':
   (.text+0xf14): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_framebuffer.o: in function `drm_client_sysrq_register':
   (.text+0x1028): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_framebuffer.o: in function `drm_client_sysrq_unregister':
   (.text+0x102c): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_gem.o: in function `drm_client_sysrq_register':
   (.text+0x1738): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_gem.o: in function `drm_client_sysrq_unregister':
   (.text+0x173c): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_ioctl.o: in function `drm_client_sysrq_register':
   (.text+0xe10): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_ioctl.o: in function `drm_client_sysrq_unregister':
   (.text+0xe14): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_lease.o: in function `drm_client_sysrq_register':
   (.text+0x7a0): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_lease.o: in function `drm_client_sysrq_unregister':
   (.text+0x7a4): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_managed.o: in function `drm_client_sysrq_register':
   (.text+0x6b8): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_managed.o: in function `drm_client_sysrq_unregister':
   (.text+0x6bc): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_mode_config.o: in function `drm_client_sysrq_register':
   (.text+0xc34): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_mode_config.o: in function `drm_client_sysrq_unregister':
   (.text+0xc38): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_prime.o: in function `drm_client_sysrq_register':
   (.text+0xb74): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_prime.o: in function `drm_client_sysrq_unregister':
   (.text+0xb78): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_syncobj.o: in function `drm_client_sysrq_register':
   (.text+0x174c): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_syncobj.o: in function `drm_client_sysrq_unregister':
   (.text+0x1750): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_sysfs.o: in function `drm_client_sysrq_register':
   (.text+0x758): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_sysfs.o: in function `drm_client_sysrq_unregister':
   (.text+0x75c): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_vblank.o: in function `drm_client_sysrq_register':
   (.text+0x2458): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_vblank.o: in function `drm_client_sysrq_unregister':
   (.text+0x245c): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_vblank_work.o: in function `drm_client_sysrq_register':
   (.text+0x594): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_vblank_work.o: in function `drm_client_sysrq_unregister':
   (.text+0x598): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_client.o: in function `drm_client_sysrq_register':
   (.text+0x830): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_client.o: in function `drm_client_sysrq_unregister':
   (.text+0x834): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_client_event.o: in function `drm_client_sysrq_register':
   (.text+0x544): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_client_event.o: in function `drm_client_sysrq_unregister':
   (.text+0x548): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_client_modeset.o: in function `drm_client_sysrq_register':
   (.text+0x2d90): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_client_modeset.o: in function `drm_client_sysrq_unregister':
   (.text+0x2d94): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_client_sysrq.o: in function `drm_client_sysrq_register':
   (.text+0x0): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_client_sysrq.o: in function `drm_client_sysrq_unregister':
   (.text+0x4): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_debugfs.o: in function `drm_client_sysrq_register':
   (.text+0x1048): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_debugfs.o: in function `drm_client_sysrq_unregister':
   (.text+0x104c): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_debugfs_crc.o: in function `drm_client_sysrq_register':
   (.text+0x9c0): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_debugfs_crc.o: in function `drm_client_sysrq_unregister':
   (.text+0x9c4): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_gem_atomic_helper.o: in function `drm_client_sysrq_register':
   (.text+0x5c8): multiple definition of `drm_client_sysrq_register'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e18): first defined here
   hppa-linux-ld: drivers/gpu/drm/drm_gem_atomic_helper.o: in function `drm_client_sysrq_unregister':
   (.text+0x5cc): multiple definition of `drm_client_sysrq_unregister'; drivers/gpu/drm/drm_atomic.o:(.text+0x2e1c): first defined here

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for OF_GPIO
   Depends on [n]: GPIOLIB [=y] && OF [=n] && HAS_IOMEM [=y]
   Selected by [y]:
   - GPIO_TB10X [=y] && GPIOLIB [=y] && HAS_IOMEM [=y] && (ARC_PLAT_TB10X || COMPILE_TEST [=y])
   WARNING: unmet direct dependencies detected for MFD_STMFX
   Depends on [n]: HAS_IOMEM [=y] && I2C [=y] && OF [=n]
   Selected by [y]:
   - PINCTRL_STMFX [=y] && PINCTRL [=y] && I2C [=y] && OF_GPIO [=y] && HAS_IOMEM [=y]
   WARNING: unmet direct dependencies detected for I2C_K1
   Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && OF [=n]
   Selected by [y]:
   - MFD_SPACEMIT_P1 [=y] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && I2C [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
