Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1362BFC8F;
	Sun, 30 Aug 2026 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788113023; cv=none; b=C8XwKmR4ki2kZIx3GDR8XFai6JgR/xab3FdP70DfTbzcUs9ZrH6Tf4uVJG4Is8GEO4S2So5ACwH6wHl3yhhEJMe+R22xNLIYTwvIzeCsZOCxKi7qadPGte3GQwaXR+Z1PNkBLgBxTd5JDl+aoeqaiKUEkS4D8vTKBgKvfJlFDZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788113023; c=relaxed/simple;
	bh=lleQPyBGLLD/ZVebmz99IjY/3UMxABvMROm7L17HXI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erUPJXGSfJXi/hCW+J6IjXVrivNqzBaII/tcEhOJ3kDV7i78qhT9nYl68htgaTBdpi+yaDtyBHyUB0Uof1anPZv/UsxZ5JYnXLci/qPQnuBolBYTRdr1k5UXvTAyHn+KhsrTIz/L3kZ0Licu+ifxTu/j9d5XmwAIB8FdatD0xzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S8uDnnqS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S8uDnnqS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788113021; x=1819649021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lleQPyBGLLD/ZVebmz99IjY/3UMxABvMROm7L17HXI0=;
  b=S8uDnnqS6rcYcYLDqvZPKMfJIT262FPHh9ircYRy4S8yuC2BVarVvDEb
   BJJCWOlWSFhlb1sXOOa7LDhUYDaP++YnS+3+AaClleRDCCKjoBitsh0ew
   yd3rLI+AvPs3aNscG2i+48v6osyK+UBSnRLJXtbr0T1IWRXa0WCXcek02
   Vq3YvCkmpKKOqj3vMYIixijem5AcgheVCpsx/A/7mHrKWXdUyueae75qw
   ij7HjFt8BWVHjrWD+cg8h4yanBuoEC/aXvY3P5GvlpTGB3RnIDkYVwRhN
   TSjc4nxGf3Sfqb96BwNgluWAfp/g6b1z25rlHbwxZfGOUFBo72jFims5/
   Q==;
X-CSE-ConnectionGUID: J9f141TdRGSTvD24ixTXSQ==
X-CSE-MsgGUID: UA70eJ3mTYOnMhiyjUBXgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="91045438"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="91045438"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 11:03:40 -0700
X-CSE-ConnectionGUID: MAqk5aqaTvGy5Cmf7/lsZQ==
X-CSE-MsgGUID: ZscK/XFrTgGBgrFm2gcakg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="292109347"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 30 Aug 2026 11:03:38 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x0jsO-00000000E84-0Tez;
	Sun, 30 Aug 2026 18:03:29 +0000
Date: Mon, 31 Aug 2026 02:03:26 +0800
From: kernel test robot <lkp@intel.com>
To: Tate Whiteberg <whiteberg@arista.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Tate Whiteberg <whiteberg@arista.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_mid: wait for LSR tx empty before setting
 termios
Message-ID: <202608310138.0uIPCjfP-lkp@intel.com>
References: <20260828144617.1210599-2-whiteberg@arista.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828144617.1210599-2-whiteberg@arista.com>

Hi Tate,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master next-20260828]
[cannot apply to v7.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tate-Whiteberg/serial-8250_mid-wait-for-LSR-tx-empty-before-setting-termios/20260828-144517
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20260828144617.1210599-2-whiteberg%40arista.com
patch subject: [PATCH] serial: 8250_mid: wait for LSR tx empty before setting termios
config: powerpc64-randconfig-001-20260829 (https://download.01.org/0day-ci/archive/20260831/202608310138.0uIPCjfP-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260831/202608310138.0uIPCjfP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608310138.0uIPCjfP-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: drivers/tty/serial/8250/8250_mid.ko: module uses symbol 'serial8250_wait_for_xmitr' from namespace 'SERIAL_8250', but does not import it.

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
