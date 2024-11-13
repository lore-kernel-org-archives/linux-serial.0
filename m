Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA37620605E;
	Wed, 13 Nov 2024 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520691; cv=none; b=MlCa4rJqU+F2FTQBT8krlvond3JNZuDywl+PDVm1W4PGOpN2EmNtDCI416XGYLk0NwDLsxmsKBswcr8WFMT31ot70KOmip9rGJAX+Wem3NOLg9qKiXcz2NhRFpBQeEMH7qxJ0IWm2nD3K9OA8m9pJt22UoS5/64goS+Ha5OnKU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520691; c=relaxed/simple;
	bh=faWalIyVIG2cFG7+jPlwAYn07vjQFuWZUKaHRiRuR8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJKyMxqG0j4fSx2OjDIFGmuGN2rBAPZri74kkNyeW/qfgQoAisMelOVm7XBltCdYoEeB6EC71bgZdPGIbmVq7TSw+IKnTqVFNoJMJ9Kmyyy13n9GBM3UuDVlgrYELlF1U8p9Uq9B6ldwvwtufQTUj5TlfxbHYc7Hi49s/W6gDt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vbb4sQ7D; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vbb4sQ7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731520690; x=1763056690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=faWalIyVIG2cFG7+jPlwAYn07vjQFuWZUKaHRiRuR8E=;
  b=Vbb4sQ7D1OT9K7COTN9U6c3/wVosfVsLLu4wMky3dhHs/6LqNuBkk/dW
   ILrD/hM66bRpzsQuD12xBn0y1CVI0EX+nWy7mi5CFtGvXaIv1Ax6qROKi
   9PMn0q6QIa2vMVDH406/0wbeD8DAbp7xMvgxjlo5Qhu/g0lZLvStsGc8C
   iJ0/vAmCQz8OSieZ1o2ZPnFlPFrDU0StMT4GLI4X9Lo/+QzFYSFLCXboS
   acL9atEKNyWiU+7dgXHBYyhDhNMI0TENvrNK48EDuTEKzPBN18V6x2sbN
   RVqEax9A8TaEueslMpNAyvLIUELCo41ZPosBsIZQOqWbpSxusSrqRe7CN
   A==;
X-CSE-ConnectionGUID: RSQ0AV5SRWSDnohEE2QKow==
X-CSE-MsgGUID: BituA+NPRumxpem9ybZGLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53972258"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53972258"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 09:58:09 -0800
X-CSE-ConnectionGUID: qPvyOlvBQSy3MTCGYkYepA==
X-CSE-MsgGUID: uZHB1VCBTOSYMIkD/g4alg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="118756535"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 09:58:06 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBHcx-0000bN-1o;
	Wed, 13 Nov 2024 17:58:03 +0000
Date: Thu, 14 Nov 2024 01:57:55 +0800
From: kernel test robot <lkp@intel.com>
To: Kartik <kkartik@nvidia.com>, linux@armlinux.org.uk,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	theo.lebrun@bootlin.com, linus.walleij@linaro.org,
	ilpo.jarvinen@linux.intel.com, l.sanfilippo@kunbus.com,
	konradybcio@kernel.org, christophe.jaillet@wanadoo.fr,
	arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] serial: amba-pl011: Fix RX stall when DMA is used
Message-ID: <202411140119.QKkmNN97-lkp@intel.com>
References: <20241113051023.3125-1-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113051023.3125-1-kkartik@nvidia.com>

Hi Kartik,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus soc/for-next linus/master v6.12-rc7 next-20241113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kartik/serial-amba-pl011-Fix-RX-stall-when-DMA-is-used/20241113-131203
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20241113051023.3125-1-kkartik%40nvidia.com
patch subject: [PATCH] serial: amba-pl011: Fix RX stall when DMA is used
config: arm64-randconfig-003-20241113 (https://download.01.org/0day-ci/archive/20241114/202411140119.QKkmNN97-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241114/202411140119.QKkmNN97-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411140119.QKkmNN97-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tty/serial/amba-pl011.c: In function 'pl011_unthrottle_rx':
>> drivers/tty/serial/amba-pl011.c:1822:16: error: 'struct uart_amba_port' has no member named 'using_rx_dma'
    1822 |         if (uap->using_rx_dma) {
         |                ^~
>> drivers/tty/serial/amba-pl011.c:1823:20: error: 'struct uart_amba_port' has no member named 'dmacr'
    1823 |                 uap->dmacr |= UART011_RXDMAE;
         |                    ^~
   drivers/tty/serial/amba-pl011.c:1824:32: error: 'struct uart_amba_port' has no member named 'dmacr'
    1824 |                 pl011_write(uap->dmacr, uap, REG_DMACR);
         |                                ^~


vim +1822 drivers/tty/serial/amba-pl011.c

  1808	
  1809	static void pl011_unthrottle_rx(struct uart_port *port)
  1810	{
  1811		struct uart_amba_port *uap = container_of(port, struct uart_amba_port, port);
  1812		unsigned long flags;
  1813	
  1814		uart_port_lock_irqsave(&uap->port, &flags);
  1815	
  1816		uap->im = UART011_RTIM;
  1817		if (!pl011_dma_rx_running(uap))
  1818			uap->im |= UART011_RXIM;
  1819	
  1820		pl011_write(uap->im, uap, REG_IMSC);
  1821	
> 1822		if (uap->using_rx_dma) {
> 1823			uap->dmacr |= UART011_RXDMAE;
  1824			pl011_write(uap->dmacr, uap, REG_DMACR);
  1825		}
  1826	
  1827		uart_port_unlock_irqrestore(&uap->port, flags);
  1828	}
  1829	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
