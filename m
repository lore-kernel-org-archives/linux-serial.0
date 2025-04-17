Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D491547C0;
	Thu, 17 Apr 2025 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744878640; cv=none; b=t2zSP+W5SCN4GzIQE0QSFGk8+HfX1ICinAsXTugNf+qjw4V6GGi9K74IvolbwDWjqoCR+HFS57KKuaYoKvbLtF6temq1//x8wopRs4lJ8UsD6GgpQC5EJ+u2UOLn8qyWswsbQGvsKxbbsmYao3gXGsU3ENs6aJqx1v6cXyCU3cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744878640; c=relaxed/simple;
	bh=Hn6sMpUGDk+JUipbQWheHD+NmGTDLgQNE42Wjv/lnIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daRA9aWd2gZcO2izm0gPRd5aAzMvxhUO3szQ1XrUoQaNi858q/ow68UutrSJa2MLadCUWKGj5VG2aMTMD5C6rVe6kc4ylJR7yJXf+bCLSdQZEV5E7b3dOP+UjNPTMr5LtFJVzJFsenQ/Mz9Z7BczTqxu64yXMNbYuEeBTOhU41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3YvJumz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3YvJumz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744878639; x=1776414639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hn6sMpUGDk+JUipbQWheHD+NmGTDLgQNE42Wjv/lnIw=;
  b=d3YvJumzvdgSRWuWHoGJTsn+efztldvDYTihqx4Xm5IMh3FGJWUbGSQr
   v12IsTx8ovnZffjQZCB3iGtllZnO/ntownOFK/yVVTKZ/8MP2J15hbxka
   3JGVvqCsODr/eAawqb4Z1DDdAGqJn0GnmICiXzvJeUcU+KIeLmpCL5MS0
   +rSfoyG+hGzGnWj9fXAS5BqX6oFD6X4wlg54PO/uDyycy+XCGtzKA10Sw
   ouvOh42/AWrykDoBa19s0Sk/tXOGI7PJENeazwF5N6Jnk7dHzzakrrRrT
   xTpCjWScVZit3pUhJdLQ3kEL3gpIpuyrP+JOgdUvY+m5nXBJFmRJgE2PT
   g==;
X-CSE-ConnectionGUID: On5q+0CTQtyn/FFNKvidpg==
X-CSE-MsgGUID: ivBNmqHARFOjjdo8A6B9IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="49150281"
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="49150281"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 01:30:38 -0700
X-CSE-ConnectionGUID: 8uaoSk4OT9aCn4gd9CKUHQ==
X-CSE-MsgGUID: OYbjFTdNSI+C10E72WFhSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="135706576"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 17 Apr 2025 01:30:36 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u5Kdl-000LzE-2D;
	Thu, 17 Apr 2025 08:30:33 +0000
Date: Thu, 17 Apr 2025 16:30:18 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolas Pitre <nico@fluxnic.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Nicolas Pitre <npitre@baylibre.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/13] vt: use new tables in ucs.c
Message-ID: <202504171646.NDaNfFql-lkp@intel.com>
References: <20250415192212.33949-7-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415192212.33949-7-nico@fluxnic.net>

Hi Nicolas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-linus]
[also build test WARNING on linus/master v6.15-rc2]
[cannot apply to tty/tty-testing tty/tty-next next-20250416]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolas-Pitre/vt-minor-cleanup-to-vc_translate_unicode/20250416-142136
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-linus
patch link:    https://lore.kernel.org/r/20250415192212.33949-7-nico%40fluxnic.net
patch subject: [PATCH v2 06/13] vt: use new tables in ucs.c
config: arc-randconfig-002-20250417 (https://download.01.org/0day-ci/archive/20250417/202504171646.NDaNfFql-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250417/202504171646.NDaNfFql-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504171646.NDaNfFql-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/vt/ucs.c:43: warning: Function parameter or struct member 'cp' not described in 'ucs_is_zero_width'
>> drivers/tty/vt/ucs.c:43: warning: expecting prototype for Determine if a Unicode code point is zero(). Prototype was for ucs_is_zero_width() instead
   drivers/tty/vt/ucs.c:55: warning: Function parameter or struct member 'cp' not described in 'ucs_is_double_width'
   drivers/tty/vt/ucs.c:55: warning: expecting prototype for Determine if a Unicode code point is double(). Prototype was for ucs_is_double_width() instead


vim +43 drivers/tty/vt/ucs.c

    35	
    36	/**
    37	 * Determine if a Unicode code point is zero-width.
    38	 *
    39	 * @param cp: Unicode code point (UCS-4)
    40	 * Return: true if the character is zero-width, false otherwise
    41	 */
    42	bool ucs_is_zero_width(u32 cp)
  > 43	{
    44		return cp_in_range(cp, ucs_zero_width_ranges,
    45				   ARRAY_SIZE(ucs_zero_width_ranges));
    46	}
    47	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
