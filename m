Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB6118DB04;
	Thu,  6 Mar 2025 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245659; cv=none; b=tlDULXnv9hpvTl9UtUiC/neMBRcaqC5EPF3x5fqpuGx9wt65jcZMyGdzBNjnH3WNT6B2bWbM1Mu8YOrGDeoEiP+Xi0L1nA/kW8C2jnyD5fQXAqmYeR1w74aQo8tk/6WhhUxKG/6r3VQsnUrBSOA21RjCMsBUwMPy4PrcrsR5PYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245659; c=relaxed/simple;
	bh=viywW8Wo5al4JNCgIcpW82I98bhli2aFf+i7vZPMZ5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sin4W/rJ7G0CjiXVCem+ex2z6awuIPFtxuhqGcbQAdViEwT911D9r6gQY6oOsCnsrC7kBpzyE8FkDekXyU2+1TILlYQLRCnmmLu6vrlcwKcwiAJQzN4fKdt+4vEFz6ZZdCZ3O1JHSc5XL7Xt4pN3UmvcY/gxzEgAJNFBf5tXUEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHHhlJVe; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHHhlJVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741245658; x=1772781658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=viywW8Wo5al4JNCgIcpW82I98bhli2aFf+i7vZPMZ5I=;
  b=HHHhlJVeMR8a408kLrhdFp6Xv12qKDEaUiBjF6vBwSA7bR+oG2ikPsjX
   cirQClsA+eWTs5p/fkVFaEtGFiek+9NRcwJEdQOKcCSAEJ/MzEOiD1NK7
   Sm5+zaOf1Wawn3PmOVMlQ0OeoANvaYKtW3DGhc+RCKvexI0KMAe4RAEMx
   BJAdC/IbYYAKTEuiSRblZYPcmaayaANuTdXmLox/1y8U3w9rArDUKJTdt
   Sqrcyf9wV18Jy1sjUXFO053w0aiIGk2wrC1V9N7J6n3ew6lg0jSfxJujn
   SkjLgbH0ICd1hvErZh5EWna49hKnz1HlElaU5zeh0398/FfCO8PfD1Bfe
   g==;
X-CSE-ConnectionGUID: JU6rAyPQQOWDtL1viji0dQ==
X-CSE-MsgGUID: BEAXTlkjR2qr8LE0YFm/2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53226056"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="53226056"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 23:20:58 -0800
X-CSE-ConnectionGUID: kE678XV/QHOHGv7r6C2NgQ==
X-CSE-MsgGUID: fpWHKwkfRHiwo2nVkBnzvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123089173"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 05 Mar 2025 23:20:42 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tq5X6-000MhW-16;
	Thu, 06 Mar 2025 07:20:40 +0000
Date: Thu, 6 Mar 2025 15:20:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Yury V. Zaytsev" <yury@shurup.com>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, "Yury V. Zaytsev" <yury@shurup.com>
Subject: Re: [PATCH RESEND] tty: vt: make defkeymap for shifted F-keys
 consistent with kbd
Message-ID: <202503061554.ZQPrGM8H-lkp@intel.com>
References: <20250301132108.62761-1-yury@shurup.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301132108.62761-1-yury@shurup.com>

Hi Yury,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on linus/master v6.14-rc5 next-20250305]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yury-V-Zaytsev/tty-vt-make-defkeymap-for-shifted-F-keys-consistent-with-kbd/20250301-214942
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20250301132108.62761-1-yury%40shurup.com
patch subject: [PATCH RESEND] tty: vt: make defkeymap for shifted F-keys consistent with kbd
config: csky-randconfig-r111-20250305 (https://download.01.org/0day-ci/archive/20250306/202503061554.ZQPrGM8H-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250306/202503061554.ZQPrGM8H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503061554.ZQPrGM8H-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/tty/vt/defkeymap.c:254:42: sparse: sparse: Using plain integer as NULL pointer
   drivers/tty/vt/defkeymap.c:255:35: sparse: sparse: Using plain integer as NULL pointer
   drivers/tty/vt/defkeymap.c:255:38: sparse: sparse: Using plain integer as NULL pointer
   drivers/tty/vt/defkeymap.c:256:18: sparse: sparse: Using plain integer as NULL pointer
   drivers/tty/vt/defkeymap.c:256:21: sparse: sparse: Using plain integer as NULL pointer
   drivers/tty/vt/defkeymap.c:256:24: sparse: sparse: Using plain integer as NULL pointer
   drivers/tty/vt/defkeymap.c:257:25: sparse: sparse: Using plain integer as NULL pointer
   drivers/tty/vt/defkeymap.c:260:14: sparse: sparse: symbol 'keymap_count' was not declared. Should it be static?
   drivers/tty/vt/defkeymap.c:268:6: sparse: sparse: symbol 'func_buf' was not declared. Should it be static?
   drivers/tty/vt/defkeymap.c:303:6: sparse: sparse: symbol 'funcbufptr' was not declared. Should it be static?
   drivers/tty/vt/defkeymap.c:304:5: sparse: sparse: symbol 'funcbufsize' was not declared. Should it be static?
   drivers/tty/vt/defkeymap.c:305:5: sparse: sparse: symbol 'funcbufleft' was not declared. Should it be static?
   drivers/tty/vt/defkeymap.c:335:9: sparse: sparse: Using plain integer as NULL pointer
   drivers/tty/vt/defkeymap.c:336:9: sparse: sparse: Using plain integer as NULL pointer
   drivers/tty/vt/defkeymap.c:342:9: sparse: sparse: Using plain integer as NULL pointer
   drivers/tty/vt/defkeymap.c:307:6: sparse: sparse: symbol 'func_table' was not declared. Should it be static?
   drivers/tty/vt/defkeymap.c:345:18: sparse: sparse: symbol 'accent_table' was not declared. Should it be static?
   drivers/tty/vt/defkeymap.c:382:14: sparse: sparse: symbol 'accent_table_size' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
