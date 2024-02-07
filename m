Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DB42032E
	for <linux-serial@vger.kernel.org>; Wed,  7 Feb 2024 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295129; cv=none; b=gLYl4wRtAFdVjOMUaXXY2vQIsAmkUWitPm4W5bKuBGVLppt59dRd2UV89U9KzFNpp6aK7af3UCKHwsK7haocT5TsFJRMOzyvev892rZNfaagBDeWn6FRVz56IwB043mslobyckJ3vDLiZxmhIWH45FiklvXCkCcKPyb71P1jG6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295129; c=relaxed/simple;
	bh=jFBlkLO+zGEktohSHqhVVqLpFHILzdE38LEOSPyY2bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t6hxcvCq8/CHFBjkIIGM5jDWOY2nrgIHk35MEmCWd5D/AfrDpKS/9MIGklMibxsO8XeYkYh6uvg9H6S6vtayxIuuQ9sPH8K45K7cSvZGjPoQFBX1LfGaiMxVEJvwRwLlu2jOkuj4xG5c8zkFoLvLkDnBg5B8UsoVc9/g1Cy3Csc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MiYEiwRX; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MiYEiwRX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707295127; x=1738831127;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jFBlkLO+zGEktohSHqhVVqLpFHILzdE38LEOSPyY2bQ=;
  b=MiYEiwRXnSrUi8xPUjnrnfc8oi4Q0nNJjTSAFUW3HsNu6xm4J3xH0Gzm
   7T/VVDvxRhIjS2COtjFWuLtNo6hP/Pk4TQdIUfh2SPBiEA5sCUBnuhK0b
   1RRL+3Ktoff6D1mXFNFoctK7eLB5Frhy64XvnblABhIPB6LPZpYm0LQf5
   EEo95PAoFPF5KGRHP/EKT3wmwkzukdlwYYChUZXKWoepZzQsZlGZNHjkH
   QbCWNogcgODJRHQ8hOR6gifDwV0aZ0IYQXCBt1aMFl64UwT+NRBTBZ9tv
   Y0Hb+plZxKZr/b8256OIE5TiprwM2BiTLd6L39/MpWrOO1Atvc2jm4pi0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="3910283"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="3910283"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 00:38:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="1510860"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 07 Feb 2024 00:38:45 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXdS6-0002Oa-2x;
	Wed, 07 Feb 2024 08:38:42 +0000
Date: Wed, 7 Feb 2024 16:37:55 +0800
From: kernel test robot <lkp@intel.com>
To: Sreenath Vijayan <sreenath.vijayan@sony.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>,
	John Ogness <john.ogness@linutronix.de>
Subject: [tty:tty-testing 28/29] include/linux/printk.h:275:13: warning:
 'dump_printk_buffer' defined but not used
Message-ID: <202402071643.DU2VnE06-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
head:   014e10bea593b963574d607faa34e7eaaad3c02b
commit: 558367b641b3802572132e7ed865f5eb887c41ea [28/29] printk: Add function to dump printk buffer directly to consoles
config: arc-randconfig-002-20240207 (https://download.01.org/0day-ci/archive/20240207/202402071643.DU2VnE06-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240207/202402071643.DU2VnE06-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402071643.DU2VnE06-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/arc/include/asm/bug.h:30,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
>> include/linux/printk.h:275:13: warning: 'dump_printk_buffer' defined but not used [-Wunused-function]
     275 | static void dump_printk_buffer(void)
         |             ^~~~~~~~~~~~~~~~~~
--
   In file included from kernel/locking/lockdep.c:62:
   kernel/locking/lockdep_internals.h:69:28: warning: 'LOCKF_USED_IN_IRQ_READ' defined but not used [-Wunused-const-variable=]
      69 | static const unsigned long LOCKF_USED_IN_IRQ_READ =
         |                            ^~~~~~~~~~~~~~~~~~~~~~
   kernel/locking/lockdep_internals.h:63:28: warning: 'LOCKF_ENABLED_IRQ_READ' defined but not used [-Wunused-const-variable=]
      63 | static const unsigned long LOCKF_ENABLED_IRQ_READ =
         |                            ^~~~~~~~~~~~~~~~~~~~~~
   kernel/locking/lockdep_internals.h:57:28: warning: 'LOCKF_USED_IN_IRQ' defined but not used [-Wunused-const-variable=]
      57 | static const unsigned long LOCKF_USED_IN_IRQ =
         |                            ^~~~~~~~~~~~~~~~~
   kernel/locking/lockdep_internals.h:51:28: warning: 'LOCKF_ENABLED_IRQ' defined but not used [-Wunused-const-variable=]
      51 | static const unsigned long LOCKF_ENABLED_IRQ =
         |                            ^~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:22,
                    from arch/arc/include/asm/bug.h:30,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:6,
                    from arch/arc/include/asm/current.h:20,
                    from include/linux/mutex.h:14,
                    from kernel/locking/lockdep.c:30:
>> include/linux/printk.h:275:13: warning: 'dump_printk_buffer' defined but not used [-Wunused-function]
     275 | static void dump_printk_buffer(void)
         |             ^~~~~~~~~~~~~~~~~~
--
   In file included from include/asm-generic/bug.h:22,
                    from arch/arc/include/asm/bug.h:30,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
>> include/linux/printk.h:275:13: warning: 'dump_printk_buffer' defined but not used [-Wunused-function]
     275 | static void dump_printk_buffer(void)
         |             ^~~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:22,
                    from arch/arc/include/asm/bug.h:30,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:6,
                    from arch/arc/include/asm/current.h:20,
                    from include/linux/sched.h:12,
                    from arch/arc/kernel/asm-offsets.c:6:
>> include/linux/printk.h:275:13: warning: 'dump_printk_buffer' defined but not used [-Wunused-function]
     275 | static void dump_printk_buffer(void)
         |             ^~~~~~~~~~~~~~~~~~


vim +/dump_printk_buffer +275 include/linux/printk.h

   268	
   269	static inline void dump_stack(void)
   270	{
   271	}
   272	static inline void printk_trigger_flush(void)
   273	{
   274	}
 > 275	static void dump_printk_buffer(void)
   276	{
   277	}
   278	#endif
   279	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
