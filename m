Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D89312E63
	for <linux-serial@vger.kernel.org>; Wed,  7 Feb 2024 04:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707279818; cv=none; b=kH6iJs4O16ypgHoWSNEL3kHR4KObBmoA5dYCzpkPz5iDeSPBiky0hz+CZQjDr/u28Cp9HPClfqBxclMfyurORmrB2M5IR+PntFzdS/CqLYr4SHLhSwufqfwGv+hvK5HeJN5WSr+Aumfu7KdjGjLknHK9QuFKFrynfREdXxavrVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707279818; c=relaxed/simple;
	bh=eYRXl/UxPoHLCIohZWJYP3Tc7X8XZG5CHXVF3pHZ/Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XSdqQoLaqbidtVKG0YRptGBjuzv+IiJsDeqNA3XY7vHXGVgI06Uk6ZAwPRJ94UEiYVhGclDsk+N6Q0TIcuw1yhOj1Y3bNeWxofCLMGCnsFNLDkCSp0rns1xke7CnG3DCHuXL8oqLScUmCqlfbVYifCi30xI3sfZR94XwVi4o8yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlC70ZLm; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlC70ZLm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707279817; x=1738815817;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eYRXl/UxPoHLCIohZWJYP3Tc7X8XZG5CHXVF3pHZ/Ds=;
  b=TlC70ZLm8GrYoi+2iBQSyE6OlqFmY3mlIZCW8kdThBQfVvj06qlUBKdz
   WM4SucZF73MxTPdtAJqfdA0uWSAvib5YNiw2xaluxOWShzF9MDJ9k1tih
   kC2TpkSQdAkK1Zor7iT5DXCgsCxGFXaxBqrLTZwn33UDxtSUWQXcxKLeI
   qjIkLFzR0D+MxPZeqOneZ+0hKiybTe7hPCRqiKbLR1dxHnbc8gRc/bvf7
   Ql4HGmWd7EUXANjwWX/Pj0I/eykqMZfC+cfpmb92BhtP8IqDse/zr4rga
   YbpSmf1Xh4z3NrH7QvifgoGb2TVCwb3dJkOzVb6TaGCNtHKkJByDQOXJC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="11644559"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="11644559"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 20:23:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="1220202"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 06 Feb 2024 20:23:34 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXZT9-00027A-1R;
	Wed, 07 Feb 2024 04:23:31 +0000
Date: Wed, 7 Feb 2024 12:22:40 +0800
From: kernel test robot <lkp@intel.com>
To: Sreenath Vijayan <sreenath.vijayan@sony.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>,
	John Ogness <john.ogness@linutronix.de>
Subject: [tty:tty-testing 28/29] include/linux/printk.h:275:13: error: unused
 function 'dump_printk_buffer'
Message-ID: <202402071252.Zj78sTXN-lkp@intel.com>
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
config: i386-buildonly-randconfig-006-20240207 (https://download.01.org/0day-ci/archive/20240207/202402071252.Zj78sTXN-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240207/202402071252.Zj78sTXN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402071252.Zj78sTXN-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from lib/test_bitops.c:9:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
   In file included from arch/x86/include/asm/timex.h:5:
   In file included from arch/x86/include/asm/processor.h:23:
   In file included from arch/x86/include/asm/msr.h:11:
   In file included from arch/x86/include/asm/cpumask.h:5:
   In file included from include/linux/cpumask.h:10:
   In file included from include/linux/kernel.h:31:
>> include/linux/printk.h:275:13: error: unused function 'dump_printk_buffer' [-Werror,-Wunused-function]
     275 | static void dump_printk_buffer(void)
         |             ^~~~~~~~~~~~~~~~~~
   1 error generated.


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
