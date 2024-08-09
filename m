Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88DB2905;
	Fri,  9 Aug 2024 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723186921; cv=none; b=rzFvYbgsSkXZDo1QlgHNAMKBUbefVdFZdBy3hvOSyRw8HJsEHT11AIAFx/06zsVOVO7cDfCDBiihz8Jwf8QIeQtpwZwt49oU2CyQrH/CL8v9o2Tk1F7pUNKixXzQBKHrpe1uM1qn0CHSP4yAtQ3PeOoXsDIGh0hfFExFZHBpIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723186921; c=relaxed/simple;
	bh=TA0O4kSV44StmXvhPbMfiwpf5ZbF8TrR1o+iGXvKaXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX/Ny+aYxCVK7vIEeIWb54o2KE/Y9V53PrZe1O58sdDV27Bx3FahOZL0IexnBihEuDOWPjxL1JRXi9KjuhuVZ1ecNl39iaGgENrkRRSKnks2A6CaepV2Ici4IgoHsDTNempeUR8ipYyRBsPJ1qgl8sYygmAs4RT8vFGQuQWuayM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i0kZDnkL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i0kZDnkL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723186920; x=1754722920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TA0O4kSV44StmXvhPbMfiwpf5ZbF8TrR1o+iGXvKaXg=;
  b=i0kZDnkLMdnjV3r56AxjuoR2JNYdXWhnTTYUvn3QuSqGxh17ZKWWPAVR
   /Ny/+gaOfLmMuG985rs2TXo6nckP/24nHxFl0+sOFEj40uZdVakinIJrW
   1mW+RBpMLW0UTUydkP2sag9Oln0h/uSMPym3WGBwGZyLmkOb66yU/0QHA
   dDGFN3xZJD7xBrg0thWYJMEwHI7hIJODTxN5F5vUo2/n48poJ46w9wBou
   BTVCVYv1OOq9aMZzBO4kT1g9luvRP2/21obNAG/pk2EmpAIQYdRaIt8+c
   VXa4Zpny5w9QsjwUjSA3q5oTpx9szrc7zpYgOe/Lubrwv24GjYSXt7lFG
   A==;
X-CSE-ConnectionGUID: 4scePCzaRba3FZeRfMGbTw==
X-CSE-MsgGUID: j2T815PzSYqoPUctVY6Vmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21160449"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="21160449"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 00:01:58 -0700
X-CSE-ConnectionGUID: DuVKJJ5CQTyckkJNOaf2MA==
X-CSE-MsgGUID: PjcgnyvjRHutAiVLuDL2sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57447822"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 09 Aug 2024 00:01:54 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scJdI-00077G-11;
	Fri, 09 Aug 2024 07:01:52 +0000
Date: Fri, 9 Aug 2024 15:01:03 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Subject: Re: [PATCH 2/2] tty: serial: samsung_tty: cast the interrupt's void
 *id just once
Message-ID: <202408091405.QtjNlf8Z-lkp@intel.com>
References: <20240806-samsung-tty-cleanup-v1-2-a68d3abf31fe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240806-samsung-tty-cleanup-v1-2-a68d3abf31fe@linaro.org>

Hi André,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1e391b34f6aa043c7afa40a2103163a0ef06d179]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Draszik/tty-serial-samsung_tty-drop-unused-argument-to-irq-handlers/20240806-234342
base:   1e391b34f6aa043c7afa40a2103163a0ef06d179
patch link:    https://lore.kernel.org/r/20240806-samsung-tty-cleanup-v1-2-a68d3abf31fe%40linaro.org
patch subject: [PATCH 2/2] tty: serial: samsung_tty: cast the interrupt's void *id just once
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240809/202408091405.QtjNlf8Z-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240809/202408091405.QtjNlf8Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408091405.QtjNlf8Z-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/tty/serial/samsung_tty.c: In function 's3c64xx_serial_handle_irq':
>> drivers/tty/serial/samsung_tty.c:948:45: warning: passing argument 1 of 's3c24xx_serial_rx_irq' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     948 |                 ret = s3c24xx_serial_rx_irq(ourport);
         |                                             ^~~~~~~
   drivers/tty/serial/samsung_tty.c:856:68: note: expected 'struct s3c24xx_uart_port *' but argument is of type 'const struct s3c24xx_uart_port *'
     856 | static irqreturn_t s3c24xx_serial_rx_irq(struct s3c24xx_uart_port *ourport)
         |                                          ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>> drivers/tty/serial/samsung_tty.c:952:45: warning: passing argument 1 of 's3c24xx_serial_tx_irq' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     952 |                 ret = s3c24xx_serial_tx_irq(ourport);
         |                                             ^~~~~~~
   drivers/tty/serial/samsung_tty.c:927:68: note: expected 'struct s3c24xx_uart_port *' but argument is of type 'const struct s3c24xx_uart_port *'
     927 | static irqreturn_t s3c24xx_serial_tx_irq(struct s3c24xx_uart_port *ourport)
         |                                          ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   drivers/tty/serial/samsung_tty.c: In function 'apple_serial_handle_irq':
   drivers/tty/serial/samsung_tty.c:969:45: warning: passing argument 1 of 's3c24xx_serial_rx_irq' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     969 |                 ret = s3c24xx_serial_rx_irq(ourport);
         |                                             ^~~~~~~
   drivers/tty/serial/samsung_tty.c:856:68: note: expected 'struct s3c24xx_uart_port *' but argument is of type 'const struct s3c24xx_uart_port *'
     856 | static irqreturn_t s3c24xx_serial_rx_irq(struct s3c24xx_uart_port *ourport)
         |                                          ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   drivers/tty/serial/samsung_tty.c:973:45: warning: passing argument 1 of 's3c24xx_serial_tx_irq' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     973 |                 ret = s3c24xx_serial_tx_irq(ourport);
         |                                             ^~~~~~~
   drivers/tty/serial/samsung_tty.c:927:68: note: expected 'struct s3c24xx_uart_port *' but argument is of type 'const struct s3c24xx_uart_port *'
     927 | static irqreturn_t s3c24xx_serial_tx_irq(struct s3c24xx_uart_port *ourport)
         |                                          ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~


vim +948 drivers/tty/serial/samsung_tty.c

   938	
   939	/* interrupt handler for s3c64xx and later SoC's.*/
   940	static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
   941	{
   942		const struct s3c24xx_uart_port *ourport = id;
   943		const struct uart_port *port = &ourport->port;
   944		u32 pend = rd_regl(port, S3C64XX_UINTP);
   945		irqreturn_t ret = IRQ_HANDLED;
   946	
   947		if (pend & S3C64XX_UINTM_RXD_MSK) {
 > 948			ret = s3c24xx_serial_rx_irq(ourport);
   949			wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_RXD_MSK);
   950		}
   951		if (pend & S3C64XX_UINTM_TXD_MSK) {
 > 952			ret = s3c24xx_serial_tx_irq(ourport);
   953			wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_TXD_MSK);
   954		}
   955		return ret;
   956	}
   957	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
