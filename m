Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E36B38F82;
	Tue, 11 Jun 2024 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121325; cv=none; b=CXRFxfAduX9Ub1yQzP1GvfKp6nX6xNkeMCHgMEynlDdf6uScsXX4RufMZiqbGtPYP33Vq6qOGOvYI6dZsAwa1Xh33iqsygQz8dnLFAnIQnWHM9G0Q/oXbMCMVcRxdbWmnid7Z2Rs1Edsr2fFojfPFU5wRFfG4wTnJFLqorsst0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121325; c=relaxed/simple;
	bh=I5aTgCAVxVL8odAbeMufOk8gtJT03Lg4Q5scCLrbQUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liaeNLF7rxMGRakZyKn6SA707yx1621IUQ2OHDS80npAkdozBFpyV5TbYhLePsDvZZ/W42wYaqFUNWv3srcm0aAaBz3Ksd5wgfEXUQ1xqv/9OCbVfMrjQdmxgoTnOwfxjy/ciksj+SfkJc1E19LNPCgr68slb3m1BlgIoaXTJzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyixXqAO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyixXqAO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718121323; x=1749657323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I5aTgCAVxVL8odAbeMufOk8gtJT03Lg4Q5scCLrbQUo=;
  b=eyixXqAOP4SepCnE4VS4n76djgr12eTEGuNRWX/gFWGBGrY8Diopza/q
   nB/ZJTb1VtK5hYCSBav6XkAGQQ8Y5T6XhbrmWkI1OgNQv68WB1Htd73yw
   LGFfcClKmJubsDcHEukLBppGwOV0KjHwGNcrAnV3cAOoOXLdKSpJgAzdm
   GF+t6dAWduQxUboVzbS/uWXaFym5vEY9EBGlTUshj595YOwx+/kQCQ86X
   euP6x+FLwU3oVsueQoxgjfwdnt58dU07UsNB8ICOPPawsLLQwKOnK130N
   zJoCNvWeC1eXcjRULJefqgCqu7Gnb5TVVn+kvtyQxikI0oIas9dcMojya
   g==;
X-CSE-ConnectionGUID: EZMweBwlQgiv0IBzOZehsQ==
X-CSE-MsgGUID: Od30050zTCqN6dOqZY/pAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="14641027"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="14641027"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 08:55:22 -0700
X-CSE-ConnectionGUID: FcbQqxw8QD6s5D1pjv29SQ==
X-CSE-MsgGUID: wcgAJGEBSj6EeLS57DUjww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="44378471"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 08:55:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sH3q8-0000000FaiK-39yV;
	Tue, 11 Jun 2024 18:55:16 +0300
Date: Tue, 11 Jun 2024 18:55:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>,
	Youling Tang <tangyouling@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_platform: Explicitly show we
 initialise ISA ports only once
Message-ID: <ZmhzZJdK9IgBYauE@smile.fi.intel.com>
References: <20240606184841.3102545-1-andriy.shevchenko@linux.intel.com>
 <202406072102.SGp8FYYi-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406072102.SGp8FYYi-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

+Cc: initial authors of Loongarch64 jump table implementation and people who touched that code.

On Fri, Jun 07, 2024 at 09:48:51PM +0800, kernel test robot wrote:
> Hi Andy,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on tty/tty-testing]
> [also build test WARNING on tty/tty-next next-20240607]
> [cannot apply to tty/tty-linus linus/master v6.10-rc2]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/serial-8250_platform-Explicitly-show-we-initialise-ISA-ports-only-once/20240607-025109
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
> patch link:    https://lore.kernel.org/r/20240606184841.3102545-1-andriy.shevchenko%40linux.intel.com
> patch subject: [PATCH v1 1/1] serial: 8250_platform: Explicitly show we initialise ISA ports only once
> config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20240607/202406072102.SGp8FYYi-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406072102.SGp8FYYi-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406072102.SGp8FYYi-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/tty/serial/8250/8250_platform.o: warning: objtool: __jump_table+0x0: special: can't find orig instruction
> 
> objdump-func vmlinux.o __jump_table:

Folks, can you look into it? It sounds like jump table is misimplemented for
this architecture (but I'm quite unsure). Similar issue LKP reported here:
https://lore.kernel.org/all/202405290629.oaN9XxEz-lkp@intel.com/

P.S. Is it objtool issue or kernel issue? (Just thinking/questioning loudly)

-- 
With Best Regards,
Andy Shevchenko


