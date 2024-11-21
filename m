Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5DC1CBE81;
	Thu, 21 Nov 2024 22:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732228626; cv=none; b=altGW6yQGR+T1LAuBBTcRnCYxMUHKZZDVo5pifgsB2H/QcXU3WZ4vgjFQFXCEZQ1wm9KhM091jt7yKqKvVcP1mJ2JeiibvFWzgInIdma/YiXnXbi+dLmReRndR4bdUyYzJ9JLIEVMsaWzy5TvBbq0EH9IFE1jkBqtifva/m4ZMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732228626; c=relaxed/simple;
	bh=MUGLVwS75jQUSL12uOeu0NQbPRYbChsHCYEPGyBY20A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVKv86E4DAXSd9RVoX7XHsf/3HCZ+RTAxcYYcwfP1b7f0DQrO0VfHeN/ynNybSvDy59smEGZws2gTgmHyBUBZxO/diSLL8OkZz/FTpF9007VZsgKrDqg8YYRhQP3p4UK6ZkLj4uOVo7RkUMmqN4JmL03B5QUbzCE2S6LHv7R1ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jVKzZhxO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVKzZhxO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732228625; x=1763764625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MUGLVwS75jQUSL12uOeu0NQbPRYbChsHCYEPGyBY20A=;
  b=jVKzZhxOfnSlhdcN3BiOmzxPAyohDCSnZIYmGzYYVomBL7a+LH6H3++7
   RXjlMT7BMYPJC9Wzn0ep2K3ikDcKk4WNstjUOuJ4lrMGSTuKJL8SbbJP5
   qMRMzIHYNm7fPDLE9XKkJyZoIpGNlJgZXH5YGfWISBe1CmOxwcX5JSWaa
   TBGYy6JEjYqmfavS0QLgSDRQuHk8l1jqHxI1LdD6TDAyTkYVbKhhipfM5
   kIoX3Ur6bQTIJ4Aewb18xUjxDRRejv71gS6ddjgW1yva/ErCSY3Ked4gp
   N0fV7RoPhJ5OTrq+RbNxX55IzIzE1L7dR5WtbmVvN+XBY9LrpRS8beZ8f
   w==;
X-CSE-ConnectionGUID: Z2O2Dn8WQ1KzzJdbibXsvg==
X-CSE-MsgGUID: RTm4L1kIQaKZ/kaqBOFAeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="49889254"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="49889254"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 14:37:04 -0800
X-CSE-ConnectionGUID: u4lzi55QQtuEqcueIDQ7aA==
X-CSE-MsgGUID: HC93Hgp/RFyhgB78eC/uvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="94480413"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 21 Nov 2024 14:37:00 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEFnG-0003QJ-0N;
	Thu, 21 Nov 2024 22:36:58 +0000
Date: Fri, 22 Nov 2024 06:36:14 +0800
From: kernel test robot <lkp@intel.com>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chester Lin <chester62515@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, NXP S32 Linux <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: Re: [PATCH v5 2/2] serial: fsl_linflexuart: add clock management
Message-ID: <202411220621.UfubUV0X-lkp@intel.com>
References: <20241118154449.3895692-3-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118154449.3895692-3-ciprianmarian.costea@oss.nxp.com>

Hi Ciprian,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus robh/for-next linus/master v6.12 next-20241121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ciprian-Costea/dt-bindings-serial-fsl-linflexuart-add-clock-definitions/20241121-130303
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20241118154449.3895692-3-ciprianmarian.costea%40oss.nxp.com
patch subject: [PATCH v5 2/2] serial: fsl_linflexuart: add clock management
config: arm64-randconfig-001-20241122 (https://download.01.org/0day-ci/archive/20241122/202411220621.UfubUV0X-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411220621.UfubUV0X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411220621.UfubUV0X-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/platform_device.h:13,
                    from drivers/tty/serial/fsl_linflexuart.c:15:
   drivers/tty/serial/fsl_linflexuart.c: In function 'linflex_probe':
>> drivers/tty/serial/fsl_linflexuart.c:904:40: error: 'linflex_disable_clks' undeclared (first use in this function)
     904 |                                        linflex_disable_clks, lfport);
         |                                        ^~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:421:41: note: in definition of macro 'devm_add_action_or_reset'
     421 |         __devm_add_action_or_reset(dev, action, data, #action)
         |                                         ^~~~~~
   drivers/tty/serial/fsl_linflexuart.c:904:40: note: each undeclared identifier is reported only once for each function it appears in
     904 |                                        linflex_disable_clks, lfport);
         |                                        ^~~~~~~~~~~~~~~~~~~~
   include/linux/device.h:421:41: note: in definition of macro 'devm_add_action_or_reset'
     421 |         __devm_add_action_or_reset(dev, action, data, #action)
         |                                         ^~~~~~


vim +/linflex_disable_clks +904 drivers/tty/serial/fsl_linflexuart.c

   835	
   836	static int linflex_probe(struct platform_device *pdev)
   837	{
   838		struct device_node *np = pdev->dev.of_node;
   839		struct linflex_port *lfport;
   840		struct uart_port *sport;
   841		struct resource *res;
   842		int i, ret;
   843	
   844		lfport = devm_kzalloc(&pdev->dev, sizeof(*lfport), GFP_KERNEL);
   845		if (!lfport)
   846			return -ENOMEM;
   847	
   848		ret = of_alias_get_id(np, "serial");
   849		if (ret < 0) {
   850			dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
   851			return ret;
   852		}
   853		if (ret >= UART_NR) {
   854			dev_err(&pdev->dev, "driver limited to %d serial ports\n",
   855				UART_NR);
   856			return -ENOMEM;
   857		}
   858	
   859		sport = &lfport->port;
   860		sport->line = ret;
   861	
   862		lfport->devtype_data = of_device_get_match_data(&pdev->dev);
   863		if (!lfport->devtype_data)
   864			return dev_err_probe(&pdev->dev, -ENODEV,
   865					"Failed to get linflexuart driver data\n");
   866	
   867		sport->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
   868		if (IS_ERR(sport->membase))
   869			return PTR_ERR(sport->membase);
   870		sport->mapbase = res->start;
   871	
   872		ret = platform_get_irq(pdev, 0);
   873		if (ret < 0)
   874			return ret;
   875	
   876		sport->dev = &pdev->dev;
   877		sport->iotype = UPIO_MEM;
   878		sport->irq = ret;
   879		sport->ops = &linflex_pops;
   880		sport->flags = UPF_BOOT_AUTOCONF;
   881		sport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE);
   882	
   883		lfport->clks = devm_kmalloc_array(&pdev->dev, lfport->devtype_data->n_clks,
   884						  sizeof(*lfport->clks), GFP_KERNEL);
   885		if (!lfport->clks)
   886			return -ENOMEM;
   887	
   888		for (i = 0; i < lfport->devtype_data->n_clks; i++)
   889			lfport->clks[i].id = lfport->devtype_data->clks_names[i];
   890	
   891		ret = devm_clk_bulk_get_optional(&pdev->dev,
   892						 lfport->devtype_data->n_clks, lfport->clks);
   893		if (ret)
   894			return dev_err_probe(&pdev->dev, ret,
   895					"Failed to get linflexuart clocks\n");
   896	
   897		ret = clk_bulk_prepare_enable(lfport->devtype_data->n_clks,
   898					      lfport->clks);
   899		if (ret)
   900			return dev_err_probe(&pdev->dev, ret,
   901					"Failed to enable linflexuart clocks\n");
   902	
   903		ret = devm_add_action_or_reset(&pdev->dev,
 > 904					       linflex_disable_clks, lfport);
   905		if (ret)
   906			return ret;
   907	
   908		linflex_ports[sport->line] = sport;
   909		platform_set_drvdata(pdev, lfport);
   910	
   911		return uart_add_one_port(&linflex_reg, sport);
   912	}
   913	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
