Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0812941C62;
	Mon, 16 Sep 2024 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481364; cv=none; b=qNihKhwtvYG2o4tfa9HuRIe5aep4OkZmH6UKA8lHUFY/ma3txg/+z9ToaQeah1zq5UyR+SycVCw8hBkJj6eodful7Ocy224Z7/VvKl3JvxMaeRuOBL4YBvb6bN0JJzakypkEZ+xprt7ReX5ZkideYNrg7IxdsvPml2zVjsBL0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481364; c=relaxed/simple;
	bh=x9frWFSiwZgea4dLj22yFxrd3OqYmZIUfJKbAW/nCQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYMSC60Hst3Jmxw53MstQCDY0ZKCdXD1Up4CdZN0tpiu56YlvamEU87FvV8rnGDO8N3uYyWZd5pTkpz760tk7eH+2T2g4GKs8p1vQVi+lGPeOITD0IqQpVlqP9P5KelvEY8wqAHkI2Ta+PS8CoX4mF9g+nPMZpynMUcooS4VCKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+8xNY/0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+8xNY/0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726481363; x=1758017363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x9frWFSiwZgea4dLj22yFxrd3OqYmZIUfJKbAW/nCQ8=;
  b=G+8xNY/0SH+nDTY8ury6pb3Aufw2gL9kYQSYF2m2pQzFDkC/qDigEc0m
   UnnkVqsI75vCdzJnXjVCu02sptNx4o9wlEBojXw0PRDzIpzWCxCnSpFDw
   tcb6G28CfP3CzcHf94/YhOQ97+405ySzYJYlTfAjM0uZ3ljSz77hXtCVM
   35rFQNX33vlM1kv5kLekgFDd/SeP55HiH+AURy4sIEvgBs4MNYhYLk+2u
   WoOzU/+EjgxGsNew6fpvefwUCoF9awaBbunYwxGcVNGMaiCcBfTb0t1Ke
   vBj60bppSqP8VAU6yFvKT8tRT/IfbX9Oz9koxK3IiXHEJbo7mCEbMBjRn
   A==;
X-CSE-ConnectionGUID: kmVdLYOFR2OjU/DnE7b/RQ==
X-CSE-MsgGUID: tyFalaaHSmq+MJM0JOSFWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="25130568"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="25130568"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 03:09:22 -0700
X-CSE-ConnectionGUID: ul9sjz7vRR69TRfNEl1Kvw==
X-CSE-MsgGUID: 79dV34vtR3eONo0b0PwkYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="69133419"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 03:09:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sq8fU-00000009Pv1-1JXL;
	Mon, 16 Sep 2024 13:09:16 +0300
Date: Mon, 16 Sep 2024 13:09:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: Parker Newman <parker@finest.io>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 4/6] serial: 8250_exar: Replace custom EEPROM read
 with eeprom_93cx6
Message-ID: <ZugDzBHmTCdMagWR@smile.fi.intel.com>
References: <78dead78311ea619e0be99cc32ee0df1610a480d.1726237379.git.pnewman@connecttech.com>
 <202409142138.yCOHBlL1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202409142138.yCOHBlL1-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Sep 14, 2024 at 09:26:27PM +0800, kernel test robot wrote:
> Hi Parker,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 5ed771f174726ae879945d4f148a9005ac909cb7]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Parker-Newman/misc-eeprom-eeprom_93cx6-Add-quirk-for-extra-read-clock-cycle/20240913-230345
> base:   5ed771f174726ae879945d4f148a9005ac909cb7
> patch link:    https://lore.kernel.org/r/78dead78311ea619e0be99cc32ee0df1610a480d.1726237379.git.pnewman%40connecttech.com
> patch subject: [PATCH v1 4/6] serial: 8250_exar: Replace custom EEPROM read with eeprom_93cx6
> config: x86_64-randconfig-122-20240914 (https://download.01.org/0day-ci/archive/20240914/202409142138.yCOHBlL1-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409142138.yCOHBlL1-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409142138.yCOHBlL1-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/tty/serial/8250/8250_exar.c:739:13: sparse: sparse: restricted __le32 degrades to integer

Yes, and this should gone if Parker follows my suggestion on how to handle this.

-- 
With Best Regards,
Andy Shevchenko


