Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F5224A7C1;
	Wed, 15 Jan 2025 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736970352; cv=none; b=MibXc/GjSbhfwW0fvuLQBxOBYWn7yAUsPo7EouBoURPOJ/LnTwhjCZKz3gkjGV6BZ0+iuEEJUzuuq1OxkO1U/Y9dTP6DvyoJshlRAke6yZnHtvSzrI7fwInXeDh7enRuHZcVUqkuyCbsPhtQ4GFd+bbiYLfCm347twVBzO/m/EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736970352; c=relaxed/simple;
	bh=nJNs4DtnimvoTU3qtzohKzecutGkBG66VbnYL8iKSQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAqKBKZEY9YuukDoo18AdN3zB5ev0Ts3bSVPTR2/8QHE0nEXK8SXNKFM3iFKuMIAoMXhOFL6cfFbdbSWD4jwGQMf7SbUh0fvQ5U2jgmZBr/FpNzheSFrrqBIx293YgwqmF14t0l3au9i3H14aKpPPMI4Fa82OB/4WCQJsJNdUrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fb8mGfhT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fb8mGfhT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736970350; x=1768506350;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nJNs4DtnimvoTU3qtzohKzecutGkBG66VbnYL8iKSQE=;
  b=Fb8mGfhT8T5TFzRj+8dqogr3fXqW4JHTlQbnPguJ2C+ZTW7Hi9EQqN2e
   MqLtCye5Y3tYG70jC7nPPscreHcN3WnYfOOUdo3YhixPP4iCvEnGiN0p1
   R7S/0GDtjIyQBIcwfOYmrtEpTo8PHdqxg+uZTn9lQwopllseVO7+fdpdr
   HZrSn+WvWCAPshwxD1xhilA6LMfffdWn7BeVZV0FjcghjmRhqHJTg5j1Q
   9LnKY+/CCNjssoCGKiMrJHe9pUQT7fqT8TD7AV6HDbYj/WLwV5KwTUHJj
   CTPXdd1VkMbPrXHZnVrRgoy+YCiRSwj98DvSupNu6mPCZXI15P821Sswk
   g==;
X-CSE-ConnectionGUID: pj2vV0puQ+SjG0v2PRJg7w==
X-CSE-MsgGUID: Nqtx7h8jREymWjK2Y+HHnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="41260714"
X-IronPort-AV: E=Sophos;i="6.13,207,1732608000"; 
   d="scan'208";a="41260714"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 11:45:49 -0800
X-CSE-ConnectionGUID: e8uQRh9CS4KDLGRInb65Uw==
X-CSE-MsgGUID: 5IAEEZ/CR1K3LnUoWm/L0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,207,1732608000"; 
   d="scan'208";a="110213744"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 15 Jan 2025 11:45:46 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tY9Ki-000QlT-0x;
	Wed, 15 Jan 2025 19:45:44 +0000
Date: Thu, 16 Jan 2025 03:45:33 +0800
From: kernel test robot <lkp@intel.com>
To: Yenchia Chen <yenchia.chen@mediatek.com>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: oe-kbuild-all@lists.linux.dev, yenchia.chen@mediatek.com,
	yj.chiang@mediatek.com, tbergstrom@nvidia.com, yujiaoliang@vivo.com,
	u.kleine-koenig@baylibre.com, treapking@chromium.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] serial: 8250_mtk: Add ACPI support
Message-ID: <202501160328.DUMWkTOc-lkp@intel.com>
References: <20250114033324.3533292-1-yenchia.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114033324.3533292-1-yenchia.chen@mediatek.com>

Hi Yenchia,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.13-rc7 next-20250115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yenchia-Chen/serial-8250_mtk-Add-ACPI-support/20250114-113715
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20250114033324.3533292-1-yenchia.chen%40mediatek.com
patch subject: [PATCH] serial: 8250_mtk: Add ACPI support
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20250116/202501160328.DUMWkTOc-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250116/202501160328.DUMWkTOc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501160328.DUMWkTOc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_mtk.c:662:36: warning: 'mtk8250_acpi_match' defined but not used [-Wunused-const-variable=]
     662 | static const struct acpi_device_id mtk8250_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~


vim +/mtk8250_acpi_match +662 drivers/tty/serial/8250/8250_mtk.c

   661	
 > 662	static const struct acpi_device_id mtk8250_acpi_match[] = {
   663		{ "MTKI0511", 0 },
   664		{},
   665	};
   666	MODULE_DEVICE_TABLE(acpi, mtk8250_acpi_match);
   667	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
