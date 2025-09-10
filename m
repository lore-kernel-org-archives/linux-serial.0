Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07603317717;
	Wed, 10 Sep 2025 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502371; cv=none; b=rzZVDy3DN6Sks+XQLt253rIoFPncVWB8Bs/RRqD2yN4KYxDLWBXCkNkyyiWka4YyCcPfyojXnkvpuqqxcielHEGgjy83BTP+vgXlsWP7eo0ZLxXNNNaakGUX69FXRT0kk19nb81ucYJstshYkSErD6BLugU8/5jyncPji68jzN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502371; c=relaxed/simple;
	bh=yYLZnKKLUYDcpvOnTT3Dg0STIelu5l13z6+PGs2RgzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C06hwsvwvXJZ3jHCbv4N3bOfJoCTMZwxHS0cEYVp7rpPWOOElk805By1TOJWTMK948mSz2hSV+78LL3C9fBmwR3Fomti6gdeKZEycO7gyXshuGHh/uGtiuvexfkBd9mQJwS7ABtnPrHtMXSY30gTyKMLJldy0GYaQWNX3RPLJg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jtMTPCYX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtMTPCYX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757502370; x=1789038370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yYLZnKKLUYDcpvOnTT3Dg0STIelu5l13z6+PGs2RgzQ=;
  b=jtMTPCYXtT9oNwjZTvGJEIwA6FQGK8Z3ozieYoV19gh+hidtAzqGEZGN
   ggKXhBUN4UkDfqiHJeTke3kuPwSHfPF1pOgTLO6/s0sFLzMfQuGE/lkMb
   NtK+wHDvaqbg0H/2QQiY+ljFAI2Z5StvkhDUgaGY8Q4gibFwfW6//kwtR
   efcQSJmLYjKqGadp+UE1JJfZik26uwetsOp96a2wVtOMq+egTRUT02UQQ
   AIlMW5JpQjGqYnreVHfHpIspbP7HL3je4MSfvMALxDGermWcsATHWUFPg
   OCjINL1Mo+1zLmeaz6xJCo0vywcz/s9DInZeBRCpVvkOi5m1gE1F2A3JJ
   w==;
X-CSE-ConnectionGUID: 5lqV8YRzToOXSost5d7plQ==
X-CSE-MsgGUID: lVS+arVURQuu5vsbAuPfHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59950720"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="59950720"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 04:06:09 -0700
X-CSE-ConnectionGUID: b4uroy7dQnqHmHGGxEgDwA==
X-CSE-MsgGUID: B5Vl9CKoS2iYe1JJz9g8BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="204350439"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 10 Sep 2025 04:06:05 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwIeJ-0005rV-24;
	Wed, 10 Sep 2025 11:06:03 +0000
Date: Wed, 10 Sep 2025 19:05:23 +0800
From: kernel test robot <lkp@intel.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Haowei Zheng <zhenghaowei@loongson.cn>
Cc: oe-kbuild-all@lists.linux.dev, Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev, devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 2/3] serial: 8250: Add Loongson uart driver support
Message-ID: <202509101843.2PXpHVfr-lkp@intel.com>
References: <91ae8cd4f903ac452e337e4662bbabf8a412b061.1757318368.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ae8cd4f903ac452e337e4662bbabf8a412b061.1757318368.git.zhoubinbin@loongson.cn>

Hi Binbin,

kernel test robot noticed the following build errors:

[auto build test ERROR on b601e1f41edd4667062aa7cccb4e5199814979a3]

url:    https://github.com/intel-lab-lkp/linux/commits/Binbin-Zhou/dt-bindings-serial-Add-Loongson-UART-controller/20250909-201640
base:   b601e1f41edd4667062aa7cccb4e5199814979a3
patch link:    https://lore.kernel.org/r/91ae8cd4f903ac452e337e4662bbabf8a412b061.1757318368.git.zhoubinbin%40loongson.cn
patch subject: [PATCH v4 2/3] serial: 8250: Add Loongson uart driver support
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250910/202509101843.2PXpHVfr-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250910/202509101843.2PXpHVfr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509101843.2PXpHVfr-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tty/serial/8250/8250_loongson.c: In function 'loongson_uart_probe':
>> drivers/tty/serial/8250/8250_loongson.c:102:9: error: implicit declaration of function 'device_property_read_u32' [-Wimplicit-function-declaration]
     102 |         device_property_read_u32(dev, "clock-frequency", &uart.port.uartclk);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/8250/8250_loongson.c:117:28: error: implicit declaration of function 'device_get_match_data'; did you mean 'device_match_any'? [-Wimplicit-function-declaration]
     117 |         flags = (uintptr_t)device_get_match_data(dev);
         |                            ^~~~~~~~~~~~~~~~~~~~~
         |                            device_match_any
   drivers/tty/serial/8250/8250_loongson.c: At top level:
>> drivers/tty/serial/8250/8250_loongson.c:179:34: error: array type has incomplete element type 'struct of_device_id'
     179 | static const struct of_device_id loongson_uart_of_ids[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~


vim +/device_property_read_u32 +102 drivers/tty/serial/8250/8250_loongson.c

    80	
    81	static int loongson_uart_probe(struct platform_device *pdev)
    82	{
    83		struct device *dev = &pdev->dev;
    84		struct uart_8250_port uart = {};
    85		struct loongson_uart_data *ddata;
    86		struct resource *res;
    87		unsigned int flags;
    88		int ret;
    89	
    90		ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
    91		if (!ddata)
    92			return -ENOMEM;
    93	
    94		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    95		if (!res)
    96			return -ENODEV;
    97	
    98		uart.port.irq = platform_get_irq(pdev, 0);
    99		if (uart.port.irq < 0)
   100			return -EINVAL;
   101	
 > 102		device_property_read_u32(dev, "clock-frequency", &uart.port.uartclk);
   103	
   104		spin_lock_init(&uart.port.lock);
   105		uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_IOREMAP;
   106		uart.port.iotype = UPIO_MEM;
   107		uart.port.regshift = 0;
   108		uart.port.dev = dev;
   109		uart.port.type = PORT_LOONGSON;
   110		uart.port.private_data = ddata;
   111	
   112		uart.port.mapbase = res->start;
   113		uart.port.mapsize = resource_size(res);
   114		uart.port.serial_in = loongson_serial_in;
   115		uart.port.serial_out = loongson_serial_out;
   116	
 > 117		flags = (uintptr_t)device_get_match_data(dev);
   118	
   119		if (flags & LOONGSON_UART_HAS_FRAC) {
   120			uart.port.get_divisor = loongson_frac_get_divisor;
   121			uart.port.set_divisor = loongson_frac_set_divisor;
   122		}
   123	
   124		if (flags & LOONGSON_UART_QUIRK_MCR)
   125			ddata->mcr_invert |= (UART_MCR_RTS | UART_MCR_DTR);
   126	
   127		if (flags & LOONGSON_UART_QUIRK_MSR)
   128			ddata->msr_invert |= (UART_MSR_CTS | UART_MSR_DSR);
   129	
   130		ddata->rst = devm_reset_control_get_optional_shared(dev, NULL);
   131		if (IS_ERR(ddata->rst))
   132			return PTR_ERR(ddata->rst);
   133	
   134		ret = reset_control_deassert(ddata->rst);
   135		if (ret)
   136			return ret;
   137	
   138		ret = serial8250_register_8250_port(&uart);
   139		if (ret < 0) {
   140			reset_control_assert(ddata->rst);
   141			return ret;
   142		}
   143	
   144		ddata->line = ret;
   145		platform_set_drvdata(pdev, ddata);
   146	
   147		return 0;
   148	}
   149	
   150	static void loongson_uart_remove(struct platform_device *pdev)
   151	{
   152		struct loongson_uart_data *ddata = platform_get_drvdata(pdev);
   153	
   154		serial8250_unregister_port(ddata->line);
   155		reset_control_assert(ddata->rst);
   156	}
   157	
   158	static int loongson_uart_suspend(struct device *dev)
   159	{
   160		struct loongson_uart_data *ddata = dev_get_drvdata(dev);
   161	
   162		serial8250_suspend_port(ddata->line);
   163	
   164		return 0;
   165	}
   166	
   167	static int loongson_uart_resume(struct device *dev)
   168	{
   169		struct loongson_uart_data *data = dev_get_drvdata(dev);
   170	
   171		serial8250_resume_port(data->line);
   172	
   173		return 0;
   174	}
   175	
   176	static DEFINE_SIMPLE_DEV_PM_OPS(loongson_uart_pm_ops, loongson_uart_suspend,
   177					loongson_uart_resume);
   178	
 > 179	static const struct of_device_id loongson_uart_of_ids[] = {
   180		{ .compatible = "loongson,ls2k0500-uart", .data = (void *)LS2K0500_UART_FLAG },
   181		{ .compatible = "loongson,ls2k1500-uart", .data = (void *)LS2K1500_UART_FLAG },
   182		{ /* sentinel */ },
   183	};
   184	MODULE_DEVICE_TABLE(of, loongson_uart_of_ids);
   185	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
