Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E2D372666;
	Mon, 16 Mar 2026 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773699656; cv=none; b=YHrBOJbDDl2PIqlHGQZmp4f6fqgI+wdUQn1rN2ll7emUgKZmdsIT27hcu8yKYFqkRTdl22WvR/by16wRdYdggi0mEjWIbmRJuqag17b5CJ4lJ8UQLxeUiPaQgnGOpiGfCncM+DrFUHnOIl4k2dEi/TGHDKo6fwGVYdi0/NMo+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773699656; c=relaxed/simple;
	bh=+Sz+Brr7tbQWKUIQKSBZksMsdfRpXtvVoKbNC9XzoME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TspSsxuItRy5yi0bCunTmUiLeF5lVXHYc4A28BmIZineIBwgvqfUd602ap5n46qvt5aF4BP68op1Qhx2e0fWPTxx02s5BvzmE/UFxcvi++fAK1Pk0lgJtkWKjeLTlhmJHhODztWG07w6G2/3HDDfrNn0PL4p8avHG28hmfMg3fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XuvWNESE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XuvWNESE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773699654; x=1805235654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Sz+Brr7tbQWKUIQKSBZksMsdfRpXtvVoKbNC9XzoME=;
  b=XuvWNESEZxjXacfDGBIHYezV0XmRlRDHSJ8AlCjBjVEzG4lJgsR8Ni2g
   Qg3BG/VZ0zom802QNV0S3EKh2B/I3Ge8fX/pv95lIhDf7yXbiOW4ccSW8
   htl/jmANILREHQYjeWtyhOgTD8KupRc/iokC+etiW4ddK3XwQ+i3o7AvX
   EDSnsZc/z7E1TLMgsJ1JIm95wp5UNtBVxuQAwK4t8W+NXftvqrY8Td3o1
   +KG8zaKCRoJJcnHTurKpVHswzsMT3c0J/QCjmAVEuxq77Ff7c5zizAmlD
   BkrfmQIfh19xVryhZnnNSGPH1tz0g7TcMd1N3IlY8au3lMi0t4wUfAtxZ
   Q==;
X-CSE-ConnectionGUID: odmkrGMPQuGYiRZ4BHjXmg==
X-CSE-MsgGUID: 87hSFmnhTBeachLDPmFLAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74616448"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74616448"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 15:20:53 -0700
X-CSE-ConnectionGUID: j8tB4O6uR/CCxiMjTcujAA==
X-CSE-MsgGUID: xSp5ygjoQhukk1pTyCHElw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="259949405"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa001.jf.intel.com with ESMTP; 16 Mar 2026 15:20:49 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w2GIo-000000004IH-2w6p;
	Mon, 16 Mar 2026 22:20:46 +0000
Date: Mon, 16 Mar 2026 23:20:00 +0100
From: kernel test robot <lkp@intel.com>
To: Ziyu Zhang <ziyuzhang201@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	baijiaju1990@gmail.com, r33s3n6@gmail.com, gality369@gmail.com,
	zhenghaoran154@gmail.com, hanguidong02@gmail.com,
	zzzccc427@gmail.com, Ziyu Zhang <ziyuzhang201@gmail.com>
Subject: Re: [PATCH] tty: n_tty: annotate lockless read of ldata->icanon in
 input_available_p()
Message-ID: <202603162328.vY9JOJWL-lkp@intel.com>
References: <20260316132827.17855-1-ziyuzhang201@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316132827.17855-1-ziyuzhang201@gmail.com>

Hi Ziyu,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus linus/master v6.16-rc1 next-20260316]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ziyu-Zhang/tty-n_tty-annotate-lockless-read-of-ldata-icanon-in-input_available_p/20260316-224221
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20260316132827.17855-1-ziyuzhang201%40gmail.com
patch subject: [PATCH] tty: n_tty: annotate lockless read of ldata->icanon in input_available_p()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260316/202603162328.vY9JOJWL-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260316/202603162328.vY9JOJWL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603162328.vY9JOJWL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/tty/n_tty.c:1913:6: error: cannot pass bit-field as __auto_type initializer in C
    1913 |         if (data_race(ldata->icanon) && !L_EXTPROC(tty))
         |             ^
   include/linux/compiler.h:194:13: note: expanded from macro 'data_race'
     194 |         auto __v = (expr);                                              \
         |                    ^
   1 error generated.


vim +1913 drivers/tty/n_tty.c

  1906	
  1907	static inline int input_available_p(const struct tty_struct *tty, int poll)
  1908	{
  1909		const struct n_tty_data *ldata = tty->disc_data;
  1910		int amt = poll && !TIME_CHAR(tty) && MIN_CHAR(tty) ? MIN_CHAR(tty) : 1;
  1911	
  1912		/* data_race: benign race, poll readiness is best-effort */
> 1913		if (data_race(ldata->icanon) && !L_EXTPROC(tty))
  1914			return ldata->canon_head != ldata->read_tail;
  1915		else
  1916			return ldata->commit_head - ldata->read_tail >= amt;
  1917	}
  1918	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
