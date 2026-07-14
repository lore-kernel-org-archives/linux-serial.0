Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9425341D640;
	Tue, 14 Jul 2026 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072559; cv=none; b=Ha8q8+GY1l/id4ud69B7dzb6imJWDMQRGsFtkPK59wNFCRQ4a/dY7JCSbFKBCucL6Fry2Rz7O/eOc08lWbJXFY43nTxX1rZ5n+Mg5FpfSoSVGwOCcAcccZI9qBaJ6ZYi5RWrLvJ9sBRSBdO18lxRU2XmpvKqrEzPb69GOEKkjPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072559; c=relaxed/simple;
	bh=9ffNt6u/OagZq7WylhHPBVWHAD/IqzxUJ/Erh2Pk4jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNtHzTB1mKKhS8IzZ5EKrhCD25EP5KuJieW9TLViWyylcIv5o4qmgqT6JM1WaJluTYuxJJgo0X86w/kKov7lRST6DEcaEBBFM/YntEp4pnAL2oumTfNWJx87fky1WQGfkr7enobN/d+xq4E9ZQ0RzLsNZ6VC1q47gyo9aCGQMhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KxgVwg2p; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KxgVwg2p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784072558; x=1815608558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9ffNt6u/OagZq7WylhHPBVWHAD/IqzxUJ/Erh2Pk4jo=;
  b=KxgVwg2pzmjWMk5Avo6ibuPG4lzTavVNVcIUhIArhwrKM+2MmODuh3Wj
   dSbbJSK31LL3NESiB1pHhRuVzT1SUcu0/uFJkSdez/mW6R1ppI0OsJYD9
   b8UO4o3hRcwzXx8Ac07GvT3yfFSa0Oa0/TEdnSm4xOyHp/wb2Nq+ynEqW
   C9phlbMqR46Q6aGmUdcnOGZJfWzbBQtUKZVkAZ83npP/zajBHdIAwDB8E
   z8lrWZbZPwWJ31sCOaIuCr0q2kZhYt8070wnXqsVzm4MDFKBQFFCEd54A
   qM0Ji6XmybRyO6tLI7xtLRwRh2J3ycLWhFkxyL/bnwdkc45K5Ehk4esDT
   A==;
X-CSE-ConnectionGUID: C/T02BXGTXmPChuUAYb7CA==
X-CSE-MsgGUID: Tsr/54Y2R1aFTArQCE60WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="107499467"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="107499467"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 16:42:37 -0700
X-CSE-ConnectionGUID: N2MZxde3Qna93127rh97KQ==
X-CSE-MsgGUID: 6u7XFaF0QYW5S4kuuQjiFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="254873510"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 14 Jul 2026 16:42:35 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wjmlk-00000000N7n-2ERa;
	Tue, 14 Jul 2026 23:42:32 +0000
Date: Wed, 15 Jul 2026 07:42:00 +0800
From: kernel test robot <lkp@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: oe-kbuild-all@lists.linux.dev, hugo@hugovil.com,
	kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_hub6: add missing include for
 hub6_match_port()
Message-ID: <202607150717.2YxVdWpX-lkp@intel.com>
References: <20260714012610.576746-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714012610.576746-1-hugo@hugovil.com>

Hi Hugo,

kernel test robot noticed the following build errors:

[auto build test ERROR on c1d4ce2d9eaeccd7e8aef7ec1109df49eaf4f503]

url:    https://github.com/intel-lab-lkp/linux/commits/Hugo-Villeneuve/serial-8250_hub6-add-missing-include-for-hub6_match_port/20260714-092814
base:   c1d4ce2d9eaeccd7e8aef7ec1109df49eaf4f503
patch link:    https://lore.kernel.org/r/20260714012610.576746-1-hugo%40hugovil.com
patch subject: [PATCH] serial: 8250_hub6: add missing include for hub6_match_port()
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20260715/202607150717.2YxVdWpX-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260715/202607150717.2YxVdWpX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607150717.2YxVdWpX-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_hub6.c:46:6: error: redefinition of 'hub6_match_port'
      46 | bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
         |      ^~~~~~~~~~~~~~~
   In file included from drivers/tty/serial/8250/8250_hub6.c:10:
   drivers/tty/serial/8250/8250.h:340:20: note: previous definition of 'hub6_match_port' with type 'bool(const struct uart_port *, const struct uart_port *)' {aka '_Bool(const struct uart_port *, const struct uart_port *)'}
     340 | static inline bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
         |                    ^~~~~~~~~~~~~~~


vim +/hub6_match_port +46 drivers/tty/serial/8250/8250_hub6.c

ec9f47cd6a14ca drivers/serial/8250_hub6.c          Russell King    2005-06-27  45  
3d406299d88297 drivers/tty/serial/8250/8250_hub6.c Hugo Villeneuve 2026-05-21 @46  bool hub6_match_port(const struct uart_port *port1, const struct uart_port *port2)
3d406299d88297 drivers/tty/serial/8250/8250_hub6.c Hugo Villeneuve 2026-05-21  47  {
3d406299d88297 drivers/tty/serial/8250/8250_hub6.c Hugo Villeneuve 2026-05-21  48  	return port1->iobase == port2->iobase && port1->hub6 == port2->hub6;
3d406299d88297 drivers/tty/serial/8250/8250_hub6.c Hugo Villeneuve 2026-05-21  49  }
3d406299d88297 drivers/tty/serial/8250/8250_hub6.c Hugo Villeneuve 2026-05-21  50  EXPORT_SYMBOL_GPL(hub6_match_port);
3d406299d88297 drivers/tty/serial/8250/8250_hub6.c Hugo Villeneuve 2026-05-21  51  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
