Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3311BD51F;
	Sat, 19 Oct 2024 01:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729301362; cv=none; b=GWxfYLBV8Frat7j2cZ1Csdt+cSkHBtDYU/hxWCtaJbsRVK+rAQtg+7ri8JKiRNp3w3pKU3jgZI20dVTNLYV2/4pLoOjaK9wSxEA2wOsBInT0rttIzB1qnhTJWHfNSg4GewhlATBhrzxRxqwMF7n2VM/i3H3liT/ZPIniBzEazPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729301362; c=relaxed/simple;
	bh=5ruJRAia0ZJOhuZD+l/+ZaMAqPzgQPUVJ0vyGiY72+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXAgElnSUEBgoQMrUn67Le7fJjeJEL3Gf/piFthWZFi2QxyCOeJ0jJbifWPlw9TQansrzlGRaLGVZMgxVzL1gUUia0/CUiPM3GDLakwpiUht4v98l25ayRnDzp4y5/MKJQSiht4rD2J055+1NZmace72oZrVW/2hE8yzLuZvaEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BtiCETiZ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BtiCETiZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729301360; x=1760837360;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ruJRAia0ZJOhuZD+l/+ZaMAqPzgQPUVJ0vyGiY72+U=;
  b=BtiCETiZ7Xx5zBf1Lp9/+dO4CEwURw2s6QbuAZ+G+Sihl27UWipDKN2U
   99pYqphXOZ6cvkKYTltXu/hIScBM3GG/xF89XEK1PIzgIqXWn+TpU59xG
   rGXWz0+fqjL9dMEtwYercL+mFviswppaunzCVQSDixNJwOH8vbliAfJsa
   H/lVXQQxFAxb2iMOjnn8T3eIWtV6DfxvU8KLpDGyWZeQBCJOSXePKCjEc
   Li+NNaFDsSf6/6NR9XLpsUPHXhw1CleGomqj+gTQME2RP8u3AVF2FRlK3
   t8Ma0RDKj7jOOSZGZ0/tWIU+tuv6ER1H9sBbQ9DulhsWi/VQAQXSdl5p8
   w==;
X-CSE-ConnectionGUID: 7r0zlM3hQxCflVOph00guw==
X-CSE-MsgGUID: VfIjw1clQA6T0kWGUhpxhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="46346055"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="46346055"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 18:29:18 -0700
X-CSE-ConnectionGUID: cmrRBeX1Q7+VuDJJjqRnNw==
X-CSE-MsgGUID: egPLdJZtTNSJRPuAyL8N4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="78987586"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 18 Oct 2024 18:29:15 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1yHI-000OXK-2Z;
	Sat, 19 Oct 2024 01:29:12 +0000
Date: Sat, 19 Oct 2024 09:28:18 +0800
From: kernel test robot <lkp@intel.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 1/2] printk: Introduce LOUD_CON flag
Message-ID: <202410190915.WgFGTQdE-lkp@intel.com>
References: <20241016-printk-loud-con-v1-1-065e4dad6632@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-printk-loud-con-v1-1-065e4dad6632@suse.com>

Hi Marcos,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1d227fcc72223cbdd34d0ce13541cbaab5e0d72f]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/printk-Introduce-LOUD_CON-flag/20241017-010521
base:   1d227fcc72223cbdd34d0ce13541cbaab5e0d72f
patch link:    https://lore.kernel.org/r/20241016-printk-loud-con-v1-1-065e4dad6632%40suse.com
patch subject: [PATCH 1/2] printk: Introduce LOUD_CON flag
config: x86_64-randconfig-001-20241018 (https://download.01.org/0day-ci/archive/20241019/202410190915.WgFGTQdE-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241019/202410190915.WgFGTQdE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410190915.WgFGTQdE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: printk_loud_console_enter+0x11: call to __cant_migrate() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: printk_loud_console_exit+0x11: call to __cant_migrate() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
