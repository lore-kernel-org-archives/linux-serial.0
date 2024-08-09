Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29AA170A02;
	Fri,  9 Aug 2024 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188135; cv=none; b=HC9rdV4oQRV3rd6EIXp/yGlLahJAAYyImwR+4rLUmxaE3i+jcMoKKLR2PnkSuPCGlbgnD7yZ0IFx4ymLk17KG/cXaZ6KEbPtuxdEQmcvYb++2txV9vjISCKS3ICeosQrHB9x6pxq59TBJi9LWs5LwqQRJ//pnlu8Y9aTfL/7G+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188135; c=relaxed/simple;
	bh=d5FxnMHUMv2rC7ppbxaCgzn622SWNQ8X1+UVYqUlvS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obSfiy4Bmfz02Iy9WJHy6zlCA4lMRE3w2UKe7fB2HUPh8gcU1693asBI7q+B4lnxU4IqOvon5WerGsxLUbIsWBq6vE40zXLotqYTmudNNNjEbSYeOm8ObWYs2Ffuwk4YDVQ8J77rI+8NVDBp+bnHp9NBWiXPsfhTskev8OX21yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lgbVLzbO; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lgbVLzbO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723188133; x=1754724133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=d5FxnMHUMv2rC7ppbxaCgzn622SWNQ8X1+UVYqUlvS4=;
  b=lgbVLzbO9fNqW9iki5yFb565NfjbUQ2v3oLmc30JhkmsdlmX9UGG0BaR
   EcvEQ93ucMM3WtkmCLPuOWoLw6VrQFXCCTagjPISrMiV9dvVCOSHMoZLC
   jo6Ub50Is4P3vAe17bulzMPGolKxupfj2dM9B8jGbapkIhdecWu5tB6ju
   5dr89zb4Yo7a6bESbPo4xS0VoPdwm7gGxSUCzIA6UG3E9KMBWthHo/L3m
   uJwr/fRoI6npdcWWWATMKhZAdXen9kfCj6V/G/XyaN+gM6SYS69eGy8x1
   80Vk625PK0LoQ6KecWmhMmJkQ3PQt9TvCEcE66gZgw/WoSmi4EVzXBlDW
   g==;
X-CSE-ConnectionGUID: pJxtKXNkTVqAbfwFmNLySg==
X-CSE-MsgGUID: M9aBksxrQwOnjg2NZBJO+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="12929699"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="12929699"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 00:22:13 -0700
X-CSE-ConnectionGUID: +BsZKSnbSxu+0vMS++pG3g==
X-CSE-MsgGUID: 4zKBcZwESw+ROgNMgEBBIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="61603129"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 09 Aug 2024 00:22:09 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scJwt-0007Db-1T;
	Fri, 09 Aug 2024 07:22:07 +0000
Date: Fri, 9 Aug 2024 15:21:32 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Subject: Re: [PATCH 2/2] tty: serial: samsung_tty: cast the interrupt's void
 *id just once
Message-ID: <202408091530.vvvqEiPv-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on 1e391b34f6aa043c7afa40a2103163a0ef06d179]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Draszik/tty-serial-samsung_tty-drop-unused-argument-to-irq-handlers/20240806-234342
base:   1e391b34f6aa043c7afa40a2103163a0ef06d179
patch link:    https://lore.kernel.org/r/20240806-samsung-tty-cleanup-v1-2-a68d3abf31fe%40linaro.org
patch subject: [PATCH 2/2] tty: serial: samsung_tty: cast the interrupt's void *id just once
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240809/202408091530.vvvqEiPv-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240809/202408091530.vvvqEiPv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408091530.vvvqEiPv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/tty/serial/samsung_tty.c:948:31: error: passing 'const struct s3c24xx_uart_port *' to parameter of type 'struct s3c24xx_uart_port *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     948 |                 ret = s3c24xx_serial_rx_irq(ourport);
         |                                             ^~~~~~~
   drivers/tty/serial/samsung_tty.c:856:68: note: passing argument to parameter 'ourport' here
     856 | static irqreturn_t s3c24xx_serial_rx_irq(struct s3c24xx_uart_port *ourport)
         |                                                                    ^
   drivers/tty/serial/samsung_tty.c:952:31: error: passing 'const struct s3c24xx_uart_port *' to parameter of type 'struct s3c24xx_uart_port *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     952 |                 ret = s3c24xx_serial_tx_irq(ourport);
         |                                             ^~~~~~~
   drivers/tty/serial/samsung_tty.c:927:68: note: passing argument to parameter 'ourport' here
     927 | static irqreturn_t s3c24xx_serial_tx_irq(struct s3c24xx_uart_port *ourport)
         |                                                                    ^
   drivers/tty/serial/samsung_tty.c:969:31: error: passing 'const struct s3c24xx_uart_port *' to parameter of type 'struct s3c24xx_uart_port *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     969 |                 ret = s3c24xx_serial_rx_irq(ourport);
         |                                             ^~~~~~~
   drivers/tty/serial/samsung_tty.c:856:68: note: passing argument to parameter 'ourport' here
     856 | static irqreturn_t s3c24xx_serial_rx_irq(struct s3c24xx_uart_port *ourport)
         |                                                                    ^
   drivers/tty/serial/samsung_tty.c:973:31: error: passing 'const struct s3c24xx_uart_port *' to parameter of type 'struct s3c24xx_uart_port *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     973 |                 ret = s3c24xx_serial_tx_irq(ourport);
         |                                             ^~~~~~~
   drivers/tty/serial/samsung_tty.c:927:68: note: passing argument to parameter 'ourport' here
     927 | static irqreturn_t s3c24xx_serial_tx_irq(struct s3c24xx_uart_port *ourport)
         |                                                                    ^
   4 errors generated.


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
   952			ret = s3c24xx_serial_tx_irq(ourport);
   953			wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_TXD_MSK);
   954		}
   955		return ret;
   956	}
   957	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
