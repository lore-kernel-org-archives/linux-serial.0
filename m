Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A9A1A4F1F;
	Sun, 12 Jan 2025 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736679318; cv=none; b=O1a51jgpXkbSjFFcSjUSsNwtp8DYG9Q6UsWzEHrPdU5mw9xmNNXwjIln+jUDV6oW3K3Gy9WZrnJCkNk9/RlpFK6Hd7Ey7tmmX2ph2wdEURCM0+/wryxWfZrgdxJQFG5lCQcZMVU3W7fptrvQD0rOlC++IheZa0EV7Uj8YaM53tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736679318; c=relaxed/simple;
	bh=dwkiCijo7AdyEXM0b+EMYP3GyUuMRqeeGvU7ZNbOHXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsdr9PGowbX6OHVmbT68fZb/NVsMoLdy8xSVDJE1Fh+wCO72cFIl8rCKpcWaS7ztdGOutC3o7G1iZEWz6oxpOnU2hSqwR5oYk4wjJyN2mbvefQ+r18NI4RJNsrDInrBsqsDBqLNAVw8rujXWXJjjU8gPSldAcCR2GmiwUrTSLaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGpfw4Mn; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGpfw4Mn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736679317; x=1768215317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dwkiCijo7AdyEXM0b+EMYP3GyUuMRqeeGvU7ZNbOHXA=;
  b=GGpfw4MnZDhkbHUrVU5idEzXp352DZDSLcAqIMARfgFmqRrJdSPXxzPz
   8vtpToi+4J3OyWbtw8kiq4KG2o+SKcR7/sxHCWiicPNBRR5I8BftLwpE0
   5OMOOoISTqA6uU+NUq7i45aVEV3jikiLamwMOwWrw/nJF3c7MCZP0WDsD
   G/l73CD7i2HnqKfDj+dI3uxAeeNXthLLYrwE2GJCwBM4uQ3rDhC4du//d
   WTZ/CrP8jEB01AGDpZMYT/T0xWqBTSYPZ9iBykm83Z2eW3YFZjb2sYefX
   7MzshfSgHstBJ9yl5eErOwk+zNWx5pQSbinDNUfQHUwh4SG6SOSYz00GW
   A==;
X-CSE-ConnectionGUID: bVcGUHzWRU2es12eyauzKQ==
X-CSE-MsgGUID: wt/AuoX0Sj2ilV5Sav1h7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11312"; a="37078260"
X-IronPort-AV: E=Sophos;i="6.12,309,1728975600"; 
   d="scan'208";a="37078260"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 02:55:16 -0800
X-CSE-ConnectionGUID: GUGhOun5Sliw4gJc52abuQ==
X-CSE-MsgGUID: WmjKLMeJSj2fDKyQD+I/Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,309,1728975600"; 
   d="scan'208";a="134981474"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 12 Jan 2025 02:55:14 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWvcd-000Lol-2p;
	Sun, 12 Jan 2025 10:55:11 +0000
Date: Sun, 12 Jan 2025 18:54:48 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Larsson <benjamin.larsson@genexis.eu>,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ansuelsmth@gmail.com, lorenzo@kernel.org,
	krzk@kernel.org, gregkh@linuxfoundation.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>
Subject: Re: [PATCH 2/2] serial: Airoha SoC UART and HSUART support
Message-ID: <202501121822.HT0uHM1g-lkp@intel.com>
References: <20250111132250.3642694-3-benjamin.larsson@genexis.eu>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111132250.3642694-3-benjamin.larsson@genexis.eu>

Hi Benjamin,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus linus/master v6.13-rc6 next-20250110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Larsson/dt-bindings-serial-8250-Add-Airoha-compatibles/20250111-212544
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20250111132250.3642694-3-benjamin.larsson%40genexis.eu
patch subject: [PATCH 2/2] serial: Airoha SoC UART and HSUART support
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250112/202501121822.HT0uHM1g-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250112/202501121822.HT0uHM1g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501121822.HT0uHM1g-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_airoha.c:55:6: error: redefinition of 'airoha8250_set_baud_rate'
      55 | void airoha8250_set_baud_rate(struct uart_port *port,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/tty/serial/8250/8250_airoha.c:10:
   drivers/tty/serial/8250/8250.h:328:20: note: previous definition of 'airoha8250_set_baud_rate' with type 'void(struct uart_port *, unsigned int,  unsigned int)'
     328 | static inline void airoha8250_set_baud_rate(struct uart_port *port,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/airoha8250_set_baud_rate +55 drivers/tty/serial/8250/8250_airoha.c

    46	
    47	/**
    48	 * airoha8250_set_baud_rate() baud rate calculation routine
    49	 * @port: uart port
    50	 * @baud: requested uart baud rate
    51	 * @hs: uart type selector, 0 for regular uart and 1 for high-speed uart
    52	 *
    53	 */
    54	
  > 55	void airoha8250_set_baud_rate(struct uart_port *port,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
