Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3682FCC0F;
	Mon, 10 Nov 2025 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776764; cv=none; b=aDXU+8QXA3cznCzUttdgll6F+n057C+Qh/3qJCGcK3OGpK4Rn6Ot4xKR+RQieD1VeJ1v8rYJLxeeb90CWLtn3cWteu0Zb5RXp+4WzL3Lqnsk7OpgoM0tE/DRRO5aDxA09ersk9+RpzuxI7BJwgTRgJ/bDR1wARKRG/Qw+iv1v0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776764; c=relaxed/simple;
	bh=yzGSD1deVr4Tn78N15H/ci6TxRT1XXPF04nElnFf1xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aT6lS+1e0Qin5ioCgNDtu3EaPdyB84HjmrFa1APb/Svh8AtPcrrRkWaOBZCUX3xJyJ5ZJaI6J6ZLXAo95+2CdqNWWCcDP/d9kzfershoYqNmV0jAu2UdpoEW5Urlh8Yq/QrrVp62NYGndaFU66Ru4cuYM8Llymh4yYA5vpSrtrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STAxsVxM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STAxsVxM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762776762; x=1794312762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yzGSD1deVr4Tn78N15H/ci6TxRT1XXPF04nElnFf1xY=;
  b=STAxsVxMsMI1ob2TaPgyKz+P0rtMiMeJvFysP0tpNekrewQX4WzD/+cs
   WCwAewWBrtlmAzCxDPHpucMxDWuHQ5GHXhAfZJPEm/p03B0BQqOgiKJLa
   XM2TAatksT/l7dBgBcgg3C/i/3/cHiuT/mZEfeCDOh7yDsKQejvqOURxE
   ddLCyvhHC8AnCvnGGyGvh1ZdwGAZNzEkVYzswV88TGvpK1dKGb+Kx8Jna
   9m5rsdNjVmJhAnCMgVOib1dLCD8Ux5o+OjPF2N8VXyCqK0T9RfhDVBtm1
   DkvIKWSIwGvPVdYvBJoHiSKHlFdxCwYAHoRLm47L9msiNVPAoBEA0pT67
   w==;
X-CSE-ConnectionGUID: rct8Aw6rQ7u592oPz68lvg==
X-CSE-MsgGUID: QCHI4xBhS32GnmmWX6LH3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64753475"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64753475"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:12:42 -0800
X-CSE-ConnectionGUID: 8+TWTtMwSYW5Hzc880c7CA==
X-CSE-MsgGUID: 4XqcJeUdQIC5ubqAW2QpFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="188496676"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 10 Nov 2025 04:12:39 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIQlA-0000Op-2P;
	Mon, 10 Nov 2025 12:12:36 +0000
Date: Mon, 10 Nov 2025 20:12:27 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, jfalempe@redhat.com,
	javierm@redhat.com, simona@ffwll.ch, airlied@gmail.com,
	mripard@kernel.org, maarten.lankhorst@linux.intel.com,
	gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/3] drm/client: Support emergency restore via sysrq for
 all clients
Message-ID: <202511101950.bIUDG3LX-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20251107]
[cannot apply to drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip linus/master v6.18-rc4 v6.18-rc3 v6.18-rc2 v6.18-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Zimmermann/drm-client-Pass-force-parameter-to-client-restore/20251107-223026
base:   next-20251107
patch link:    https://lore.kernel.org/r/20251107142612.467817-3-tzimmermann%40suse.de
patch subject: [PATCH 2/3] drm/client: Support emergency restore via sysrq for all clients
config: powerpc64-randconfig-001-20251110 (https://download.01.org/0day-ci/archive/20251110/202511101950.bIUDG3LX-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 0d786b9a207aa0e6d88dde7fd9ffe0b364db69a4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251110/202511101950.bIUDG3LX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511101950.bIUDG3LX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/drm_debugfs_crc.c:41:
>> drivers/gpu/drm/drm_internal.h:64:6: warning: no previous prototype for function 'drm_client_sysrq_register' [-Wmissing-prototypes]
      64 | void drm_client_sysrq_register(struct drm_device *dev)
         |      ^
   drivers/gpu/drm/drm_internal.h:64:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      64 | void drm_client_sysrq_register(struct drm_device *dev)
         | ^
         | static 
>> drivers/gpu/drm/drm_internal.h:66:6: warning: no previous prototype for function 'drm_client_sysrq_unregister' [-Wmissing-prototypes]
      66 | void drm_client_sysrq_unregister(struct drm_device *dev)
         |      ^
   drivers/gpu/drm/drm_internal.h:66:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      66 | void drm_client_sysrq_unregister(struct drm_device *dev)
         | ^
         | static 
   2 warnings generated.


vim +/drm_client_sysrq_register +64 drivers/gpu/drm/drm_internal.h

    58	
    59	/* drm_client_sysrq.c */
    60	#if defined(CONFIG_DRM_CLIENT) && defined(CONFIG_MAGIC_SYSRQ)
    61	void drm_client_sysrq_register(struct drm_device *dev);
    62	void drm_client_sysrq_unregister(struct drm_device *dev);
    63	#else
  > 64	void drm_client_sysrq_register(struct drm_device *dev)
    65	{ }
  > 66	void drm_client_sysrq_unregister(struct drm_device *dev)
    67	{ }
    68	#endif
    69	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
