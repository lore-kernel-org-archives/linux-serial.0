Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AEC1E7C07;
	Fri, 11 Apr 2025 03:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744343245; cv=none; b=ZU3sKcySg4wP8RMfrBWeDhNID+vD65RBxB+OtB+ccEFK9gXHC+Ay0+c+yiWrnP8YODTYNDZJZZ2TAoavpT+YeRljrXC+WHl/jVvKDJ4pQEhmcDpSReBfZi6TC7J6gzhulbDqRCX4M8yV3dmKx3u+AWTOgwG57BiQnEsKqyZ+xdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744343245; c=relaxed/simple;
	bh=VRpaDPeddYKoPCJkNZD93So02dw0UKpgz41AvSL+wns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rW9W+hosigElqP6EJJUAit3wEmlEuXzA6a5K7djNyAuUWsbVIK0bDBzBO+taEv88Dp7GdtfGLm6eSM6KUrhMTThxXzJQgmU0jRADshqtiYovsh4/avpJvIXLhioPWtmMo0J0ssHEcP7jht9kB4YWnoImcK3mYUc2azjqhXnmEmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jKj7Mpg0; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jKj7Mpg0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744343243; x=1775879243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VRpaDPeddYKoPCJkNZD93So02dw0UKpgz41AvSL+wns=;
  b=jKj7Mpg0U55MQRwIlYMPR2cP6Bl4DquWIxijQVB+UFeznw85ZdwhNtmy
   GsPtCpLzvOnxoxx3tltGkD1BI59uuB9+1sct7ABtLEiSCECYWjoA7x3BQ
   LizPmqbtfmjSMV4X/MyPfIlgMaioDR62zO0p0rWDGC71tGlFTfnJXbFEI
   NvD2BVQQ7lyNqh/s491ky0xAAHBGCxVDZiYus1aAUbZBlTqFFI7g56yzl
   EJVR6I5EpyfTJvOVFytogOfSKNzTN+l+BAAiR185DrrWHGRjf4t19ND7Q
   8UXiHN+NQ6KOIVhNLD7zs4eikF/KEMalKeO0AC9g+a+HEH42sVy4mjGZz
   g==;
X-CSE-ConnectionGUID: 0aNCJT/mTPCb9yBEOio6qQ==
X-CSE-MsgGUID: FxlXGMDES1W+nyNrMqqzSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="57267543"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="57267543"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 20:47:22 -0700
X-CSE-ConnectionGUID: Tif5TBgzTjyoB3N3tyIcvg==
X-CSE-MsgGUID: KgZ2Tod7TQy/msqFuOQ11Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="129026885"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 10 Apr 2025 20:47:19 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u35ML-000Amd-1P;
	Fri, 11 Apr 2025 03:47:17 +0000
Date: Fri, 11 Apr 2025 11:47:01 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolas Pitre <nico@fluxnic.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Nicolas Pitre <npitre@baylibre.com>,
	Dave Mielke <Dave@mielke.cc>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] vt: update ucs_width.c using gen_ucs_width.py
Message-ID: <202504111036.YH1iEqBR-lkp@intel.com>
References: <20250410011839.64418-6-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410011839.64418-6-nico@fluxnic.net>

Hi Nicolas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus linus/master v6.15-rc1 next-20250410]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolas-Pitre/vt-minor-cleanup-to-vc_translate_unicode/20250410-092318
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20250410011839.64418-6-nico%40fluxnic.net
patch subject: [PATCH 05/11] vt: update ucs_width.c using gen_ucs_width.py
config: csky-randconfig-001-20250411 (https://download.01.org/0day-ci/archive/20250411/202504111036.YH1iEqBR-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250411/202504111036.YH1iEqBR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504111036.YH1iEqBR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/vt/ucs_width.c:485: warning: Function parameter or struct member 'cp' not described in 'ucs_is_zero_width'
>> drivers/tty/vt/ucs_width.c:485: warning: expecting prototype for Determine if a Unicode code point is zero(). Prototype was for ucs_is_zero_width() instead
>> drivers/tty/vt/ucs_width.c:496: warning: Function parameter or struct member 'cp' not described in 'ucs_is_double_width'
>> drivers/tty/vt/ucs_width.c:496: warning: expecting prototype for Determine if a Unicode code point is double(). Prototype was for ucs_is_double_width() instead


vim +485 drivers/tty/vt/ucs_width.c

   477	
   478	/**
   479	 * Determine if a Unicode code point is zero-width.
   480	 *
   481	 * @param ucs: Unicode code point (UCS-4)
   482	 * Return: true if the character is zero-width, false otherwise
   483	 */
   484	bool ucs_is_zero_width(uint32_t cp)
 > 485	{
   486		return is_in_interval(cp, zero_width_ranges, ARRAY_SIZE(zero_width_ranges));
   487	}
   488	
   489	/**
   490	 * Determine if a Unicode code point is double-width.
   491	 *
   492	 * @param ucs: Unicode code point (UCS-4)
   493	 * Return: true if the character is double-width, false otherwise
   494	 */
   495	bool ucs_is_double_width(uint32_t cp)
 > 496	{

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
