Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4733137B036;
	Mon, 11 May 2026 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778504104; cv=none; b=eGF6g10IIKl8tNGivYr4I2yTC9Ua+AuR15cDEC/1lxmb5OVuU56IBXCDkg9jjERDs+h+RYI0qLTvBIRTP4R+1OZQ+WhSG/3A64prLj+WdFFf2LYhTJdOGIWPRHbElYNc91mhSwy4PQP0Sc9XttBesyEC9JscdOrouWly5vW9/ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778504104; c=relaxed/simple;
	bh=5n7lTpy63mOyE1afSibKO8kjel4xtgAxRtlNfLPvj2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUJfB1zf2SkrgelcPdtO+iADqLqodo5/eycyF17LiMuyXdlabpZsrYos36ucM73suT0FJ+p7ljnEl546iUkHcwQFFS4wr695Ht6DXg4sNHZszWppbp6h//m9WJL9FPA1VZqbj0yQmfRjIXr5ypf1cf3POTKAAcUJY6zeqlQjeA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hv56tKdK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hv56tKdK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778504103; x=1810040103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5n7lTpy63mOyE1afSibKO8kjel4xtgAxRtlNfLPvj2Q=;
  b=Hv56tKdKCidIHUu7zc/GDijy3r4Pd+2oH/JnmBSztQ4/Aoxp3q8SHISx
   ylueUwhcAhad958Ww7MwbNuAkeLGenWsqtLcZEvh0p0GYUa6xXg/kV66a
   MNJlFiZ3li0IfXZpJHdwE2BBRSxgBWbc5jEEUWLSYPYyGrye3lAtQuqeX
   YkqhTDaQJB8Lci5rrEo+Vd2MGxs9pDDUjd+sxGJzrJdLadOgXEtFG6gNc
   zS/e3qmnuQk5c2xAv67Ma1bBS/65UPCQoeLhHZa9vtZt8XuFhIK+Jmvrw
   SJ81ov3m5PCmMe+mgm0FmxRFbSF5VfCf5TuxsvnFSgLWSI9HneBMNtlT+
   A==;
X-CSE-ConnectionGUID: dWnhloziQXSWVPaSgqd+Ww==
X-CSE-MsgGUID: cfJEoT+iT4mAqFQKTGKOvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="89972869"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="89972869"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 05:55:02 -0700
X-CSE-ConnectionGUID: mHJcfbe4QpukErAPBgh9SA==
X-CSE-MsgGUID: tQ1ImuS1RvqpoJnLZ7i5Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="241419790"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 11 May 2026 05:54:59 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMQ9x-000000000ab-28PE;
	Mon, 11 May 2026 12:54:57 +0000
Date: Mon, 11 May 2026 20:54:12 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_fsl: Export fsl8250_handle_irq()
 conditionally
Message-ID: <202605112003.uLqRrYzE-lkp@intel.com>
References: <20260504151259.483924-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260504151259.483924-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/serial-8250_fsl-Export-fsl8250_handle_irq-conditionally/20260511-115924
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20260504151259.483924-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] serial: 8250_fsl: Export fsl8250_handle_irq() conditionally
config: microblaze-defconfig (https://download.01.org/0day-ci/archive/20260511/202605112003.uLqRrYzE-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260511/202605112003.uLqRrYzE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605112003.uLqRrYzE-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tty/serial/8250/8250_of.c: In function 'of_platform_serial_setup':
>> drivers/tty/serial/8250/8250_of.c:187:36: error: 'fsl8250_handle_irq' undeclared (first use in this function); did you mean 'serial8250_handle_irq'?
     187 |                 port->handle_irq = fsl8250_handle_irq;
         |                                    ^~~~~~~~~~~~~~~~~~
         |                                    serial8250_handle_irq
   drivers/tty/serial/8250/8250_of.c:187:36: note: each undeclared identifier is reported only once for each function it appears in


vim +187 drivers/tty/serial/8250/8250_of.c

32f6ec282fb0ddb drivers/tty/serial/8250/8250_of.c Bastien Curutchet    2024-04-05   83  
8d38a5b2fab1397 drivers/serial/of_serial.c        Arnd Bergmann        2007-02-13   84  /*
8d38a5b2fab1397 drivers/serial/of_serial.c        Arnd Bergmann        2007-02-13   85   * Fill a struct uart_port for a given device node
8d38a5b2fab1397 drivers/serial/of_serial.c        Arnd Bergmann        2007-02-13   86   */
9671f09921d93e7 drivers/tty/serial/of_serial.c    Bill Pemberton       2012-11-19   87  static int of_platform_serial_setup(struct platform_device *ofdev,
058bc104f7ca5c8 drivers/tty/serial/8250/8250_of.c Lukas Wunner         2020-02-28   88  			int type, struct uart_8250_port *up,
0bbeb3c3e84bc96 drivers/tty/serial/of_serial.c    Murali Karicheri     2012-10-22   89  			struct of_serial_info *info)
8d38a5b2fab1397 drivers/serial/of_serial.c        Arnd Bergmann        2007-02-13   90  {
8d38a5b2fab1397 drivers/serial/of_serial.c        Arnd Bergmann        2007-02-13   91  	struct resource resource;
4678de73932f8f3 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2023-09-12   92  	struct device *dev = &ofdev->dev;
4678de73932f8f3 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2023-09-12   93  	struct device_node *np = dev->of_node;
058bc104f7ca5c8 drivers/tty/serial/8250/8250_of.c Lukas Wunner         2020-02-28   94  	struct uart_port *port = &up->port;
1117a6fdc7c14d6 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-03-04   95  	u32 spd;
1117a6fdc7c14d6 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-03-04   96  	int ret;
8d38a5b2fab1397 drivers/serial/of_serial.c        Arnd Bergmann        2007-02-13   97  
d3210c8e88ee413 drivers/tty/serial/8250/8250_of.c jempty.liang         2025-11-17   98  	memset(port, 0, sizeof(*port));
a2d23edaef9e022 drivers/tty/serial/8250/8250_of.c Franklin S Cooper Jr 2017-08-16   99  
a2d23edaef9e022 drivers/tty/serial/8250/8250_of.c Franklin S Cooper Jr 2017-08-16  100  	pm_runtime_enable(&ofdev->dev);
a2d23edaef9e022 drivers/tty/serial/8250/8250_of.c Franklin S Cooper Jr 2017-08-16  101  	pm_runtime_get_sync(&ofdev->dev);
a2d23edaef9e022 drivers/tty/serial/8250/8250_of.c Franklin S Cooper Jr 2017-08-16  102  
8d38a5b2fab1397 drivers/serial/of_serial.c        Arnd Bergmann        2007-02-13  103  	ret = of_address_to_resource(np, 0, &resource);
8d38a5b2fab1397 drivers/serial/of_serial.c        Arnd Bergmann        2007-02-13  104  	if (ret) {
4678de73932f8f3 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2023-09-12  105  		dev_err_probe(dev, ret, "invalid address\n");
aef6b8631f9ddf2 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2023-09-19  106  		goto err_pmruntime;
8d38a5b2fab1397 drivers/serial/of_serial.c        Arnd Bergmann        2007-02-13  107  	}
8d38a5b2fab1397 drivers/serial/of_serial.c        Arnd Bergmann        2007-02-13  108  
1117a6fdc7c14d6 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-03-04  109  	port->dev = &ofdev->dev;
1117a6fdc7c14d6 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-03-04  110  	port->flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_TYPE;
8d38a5b2fab1397 drivers/serial/of_serial.c        Arnd Bergmann        2007-02-13  111  	spin_lock_init(&port->lock);
aa95947400edb57 drivers/tty/serial/8250/8250_of.c John Garry           2018-04-27  112  
aa95947400edb57 drivers/tty/serial/8250/8250_of.c John Garry           2018-04-27  113  	if (resource_type(&resource) == IORESOURCE_IO) {
aa95947400edb57 drivers/tty/serial/8250/8250_of.c John Garry           2018-04-27  114  		port->iobase = resource.start;
aa95947400edb57 drivers/tty/serial/8250/8250_of.c John Garry           2018-04-27  115  	} else {
8d38a5b2fab1397 drivers/serial/of_serial.c        Arnd Bergmann        2007-02-13  116  		port->mapbase = resource.start;
0787691230d88af drivers/tty/serial/of_serial.c    Mans Rullgard        2015-03-08  117  		port->mapsize = resource_size(&resource);
1117a6fdc7c14d6 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-03-04  118  		port->flags |= UPF_IOREMAP;
d06b1cf28297e27 drivers/tty/serial/8250/8250_of.c Robert Hancock       2022-01-12  119  	}
d06b1cf28297e27 drivers/tty/serial/8250/8250_of.c Robert Hancock       2022-01-12  120  
1117a6fdc7c14d6 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-03-04  121  	ret = uart_read_and_validate_port_properties(port);
1117a6fdc7c14d6 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-03-04  122  	if (ret)
1117a6fdc7c14d6 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-03-04  123  		goto err_pmruntime;
b912b5e2cfb35c0 drivers/serial/of_serial.c        John Linn            2008-04-03  124  
1117a6fdc7c14d6 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-03-04  125  	/* Get clk rate through clk driver if present */
1117a6fdc7c14d6 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-03-04  126  	if (!port->uartclk) {
81e4de4ba298d73 drivers/tty/serial/8250/8250_of.c Alex Elder           2025-04-09  127  		struct clk *bus_clk;
81e4de4ba298d73 drivers/tty/serial/8250/8250_of.c Alex Elder           2025-04-09  128  
81e4de4ba298d73 drivers/tty/serial/8250/8250_of.c Alex Elder           2025-04-09  129  		bus_clk = devm_clk_get_optional_enabled(dev, "bus");
81e4de4ba298d73 drivers/tty/serial/8250/8250_of.c Alex Elder           2025-04-09  130  		if (IS_ERR(bus_clk)) {
81e4de4ba298d73 drivers/tty/serial/8250/8250_of.c Alex Elder           2025-04-09  131  			ret = dev_err_probe(dev, PTR_ERR(bus_clk), "failed to get bus clock\n");
81e4de4ba298d73 drivers/tty/serial/8250/8250_of.c Alex Elder           2025-04-09  132  			goto err_pmruntime;
81e4de4ba298d73 drivers/tty/serial/8250/8250_of.c Alex Elder           2025-04-09  133  		}
81e4de4ba298d73 drivers/tty/serial/8250/8250_of.c Alex Elder           2025-04-09  134  
81e4de4ba298d73 drivers/tty/serial/8250/8250_of.c Alex Elder           2025-04-09  135  		/* If the bus clock is required, core clock must be named */
81e4de4ba298d73 drivers/tty/serial/8250/8250_of.c Alex Elder           2025-04-09  136  		info->clk = devm_clk_get_enabled(dev, bus_clk ? "core" : NULL);
1117a6fdc7c14d6 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-03-04  137  		if (IS_ERR(info->clk)) {
1117a6fdc7c14d6 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-03-04  138  			ret = dev_err_probe(dev, PTR_ERR(info->clk), "failed to get clock\n");
aef6b8631f9ddf2 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2023-09-19  139  			goto err_pmruntime;
7423734e19e7e0a drivers/tty/serial/of_serial.c    Jamie Iles           2011-06-27  140  		}
1117a6fdc7c14d6 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-03-04  141  
926040da6064233 drivers/tty/serial/8250/8250_of.c Alex Elder           2025-04-11  142  		info->bus_clk = bus_clk;
1117a6fdc7c14d6 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-03-04  143  		port->uartclk = clk_get_rate(info->clk);
7423734e19e7e0a drivers/tty/serial/of_serial.c    Jamie Iles           2011-06-27  144  	}
1117a6fdc7c14d6 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-03-04  145  	/* If current-speed was set, then try not to change it. */
1117a6fdc7c14d6 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-03-04  146  	if (of_property_read_u32(np, "current-speed", &spd) == 0)
1117a6fdc7c14d6 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-03-04  147  		port->custom_divisor = port->uartclk / (16 * spd);
aa95947400edb57 drivers/tty/serial/8250/8250_of.c John Garry           2018-04-27  148  
f4817843e39ce78 drivers/tty/serial/8250/8250_of.c Lubomir Rintel       2019-02-24  149  	/* Compatibility with the deprecated pxa driver and 8250_pxa drivers. */
f4817843e39ce78 drivers/tty/serial/8250/8250_of.c Lubomir Rintel       2019-02-24  150  	if (of_device_is_compatible(np, "mrvl,mmp-uart"))
f4817843e39ce78 drivers/tty/serial/8250/8250_of.c Lubomir Rintel       2019-02-24  151  		port->regshift = 2;
f4817843e39ce78 drivers/tty/serial/8250/8250_of.c Lubomir Rintel       2019-02-24  152  
e2860e1f62f2e87 drivers/tty/serial/8250/8250_of.c Joel Stanley         2017-05-29  153  	info->rst = devm_reset_control_get_optional_shared(&ofdev->dev, NULL);
b9820a31691b771 drivers/tty/serial/8250/8250_of.c Masahiro Yamada      2017-12-27  154  	if (IS_ERR(info->rst)) {
b9820a31691b771 drivers/tty/serial/8250/8250_of.c Masahiro Yamada      2017-12-27  155  		ret = PTR_ERR(info->rst);
aef6b8631f9ddf2 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2023-09-19  156  		goto err_pmruntime;
b9820a31691b771 drivers/tty/serial/8250/8250_of.c Masahiro Yamada      2017-12-27  157  	}
b9820a31691b771 drivers/tty/serial/8250/8250_of.c Masahiro Yamada      2017-12-27  158  
e2860e1f62f2e87 drivers/tty/serial/8250/8250_of.c Joel Stanley         2017-05-29  159  	ret = reset_control_deassert(info->rst);
e2860e1f62f2e87 drivers/tty/serial/8250/8250_of.c Joel Stanley         2017-05-29  160  	if (ret)
aef6b8631f9ddf2 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2023-09-19  161  		goto err_pmruntime;
e2860e1f62f2e87 drivers/tty/serial/8250/8250_of.c Joel Stanley         2017-05-29  162  
8d38a5b2fab1397 drivers/serial/of_serial.c        Arnd Bergmann        2007-02-13  163  	port->type = type;
283e096ffb7077c drivers/tty/serial/8250/8250_of.c Lukas Wunner         2020-02-28  164  	port->rs485_config = serial8250_em485_config;
0139da50dc53f0c drivers/tty/serial/8250/8250_of.c Ilpo Järvinen        2022-07-04  165  	port->rs485_supported = serial8250_em485_supported;
058bc104f7ca5c8 drivers/tty/serial/8250/8250_of.c Lukas Wunner         2020-02-28  166  	up->rs485_start_tx = serial8250_em485_start_tx;
058bc104f7ca5c8 drivers/tty/serial/8250/8250_of.c Lukas Wunner         2020-02-28  167  	up->rs485_stop_tx = serial8250_em485_stop_tx;
8d38a5b2fab1397 drivers/serial/of_serial.c        Arnd Bergmann        2007-02-13  168  
9b8777e3473e31b drivers/tty/serial/of_serial.c    John Crispin         2014-10-16  169  	switch (type) {
9b8777e3473e31b drivers/tty/serial/of_serial.c    John Crispin         2014-10-16  170  	case PORT_RT2880:
b334214ea08d941 drivers/tty/serial/8250/8250_of.c Ilpo Järvinen        2023-05-11  171  		ret = rt288x_setup(port);
cd0eb354d441488 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-02-15  172  		break;
cd0eb354d441488 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-02-15  173  	case PORT_NPCM:
cd0eb354d441488 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-02-15  174  		ret = npcm_setup(port);
cd0eb354d441488 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-02-15  175  		break;
cd0eb354d441488 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-02-15  176  	default:
cd0eb354d441488 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-02-15  177  		/* Nothing to do */
cd0eb354d441488 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-02-15  178  		ret = 0;
9b8777e3473e31b drivers/tty/serial/of_serial.c    John Crispin         2014-10-16  179  		break;
9b8777e3473e31b drivers/tty/serial/of_serial.c    John Crispin         2014-10-16  180  	}
cd0eb354d441488 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-02-15  181  	if (ret)
cd0eb354d441488 drivers/tty/serial/8250/8250_of.c Andy Shevchenko      2024-02-15  182  		goto err_pmruntime;
bf03f65b7967df5 drivers/tty/serial/of_serial.c    Dan Williams         2012-04-10  183  
d9f59caf94a92f7 drivers/tty/serial/8250/8250_of.c Uwe Kleine-König     2023-06-09  184  	if (IS_REACHABLE(CONFIG_SERIAL_8250_FSL) &&
d43b54d269d27bd drivers/tty/serial/of_serial.c    Scott Wood           2015-10-07  185  	    (of_device_is_compatible(np, "fsl,ns16550") ||
d68fefdd5b5f107 drivers/tty/serial/8250/8250_of.c Dmitry Safonov       2019-12-13  186  	     of_device_is_compatible(np, "fsl,16550-FIFO64"))) {
d43b54d269d27bd drivers/tty/serial/of_serial.c    Scott Wood           2015-10-07 @187  		port->handle_irq = fsl8250_handle_irq;
d68fefdd5b5f107 drivers/tty/serial/8250/8250_of.c Dmitry Safonov       2019-12-13  188  		port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
d68fefdd5b5f107 drivers/tty/serial/8250/8250_of.c Dmitry Safonov       2019-12-13  189  	}
d43b54d269d27bd drivers/tty/serial/of_serial.c    Scott Wood           2015-10-07  190  
8d38a5b2fab1397 drivers/serial/of_serial.c        Arnd Bergmann        2007-02-13  191  	return 0;
a2d23edaef9e022 drivers/tty/serial/8250/8250_of.c Franklin S Cooper Jr 2017-08-16  192  err_pmruntime:
a2d23edaef9e022 drivers/tty/serial/8250/8250_of.c Franklin S Cooper Jr 2017-08-16  193  	pm_runtime_put_sync(&ofdev->dev);
a2d23edaef9e022 drivers/tty/serial/8250/8250_of.c Franklin S Cooper Jr 2017-08-16  194  	pm_runtime_disable(&ofdev->dev);
0bbeb3c3e84bc96 drivers/tty/serial/of_serial.c    Murali Karicheri     2012-10-22  195  	return ret;
8d38a5b2fab1397 drivers/serial/of_serial.c        Arnd Bergmann        2007-02-13  196  }
8d38a5b2fab1397 drivers/serial/of_serial.c        Arnd Bergmann        2007-02-13  197  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
