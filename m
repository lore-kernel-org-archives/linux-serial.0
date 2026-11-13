Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794612890;
	b=q4RNSBi5Xy8Bgf3YJeAmFdsrkCcONQeFfWRrg/Bh6qSf46aicF5TPdQla7M6RdCWZIh9
	 U4VcguXz84tScqCO4tHHfYGHl/S9KXMSa0CzKSj/UTK9fgHpKfTOMNHb5MBIW5ahlm7Y5
	 AQz8o5eP4sZuePeGRNvSPpnvMrhMIQGTwbUlS1O0XdeMcNjluzntlT1ZzymYgntcL/tBF
	 IweCWeKmnM91b9Eo8A12ctEixFFRR2VrFBoyr2ajFEBYO1rjKChmvkRJ67uMY66jzn3s2
	 jFWaTOQcPkxR0hExvnpY8z4ltADCXcs0fg0Hmd3xmR3lRS37vJdW768iPL5lpbHLotw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794612890;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=iKPyD0fcQHjU+nZY9PhDSccu4A7Tiq9IV5sts7cPeIc=;
	b=olQ3xLDQ5fb4YYs/WevuahAVEAq3V+b/gZoZXy/S+lHjCbj+0ohC4nC6BJ+qofXZZTP2
	 2aBhAEWqHV+J3kHJL2xfNpJwzhw6fIKeIEwAJBnmnHF3IXU1Xaj3HrPXDTa3EKVcsqnV2
	 muoXkMZornv01v3aVh8XNHtVz4aQyNO/jUkDIrwxsa5ftqrilDWmHVwjYjPV8luQYNZze
	 wrEawgVDFUG7E7HXNG3H78vvBpDG4HR5OopvYJvpteP2Z3XoTtm1Td5Krh/+2kVpCj5KO
	 lbUejQ4QS9/IH24auudMGLYM/mmPcRsPZ13ZBp+c0GzXwdHU0t+yxTRV/V/qlxuqyIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I2ZgzY3t;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BDF606A89B;
	Fri, 13 Nov 2026 23:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37BDF606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I2ZgzY3t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794612889; x=1826148889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oARI0lz8E8wlq5FlviYP9LbHzAMB8U71otiLJAe+IpQ=;
  b=I2ZgzY3tFPhah1zvR6mWKt3nQMPowwdzDV3q9BSGzfTADVGs9foAWuHo
   QobUBYCf3fs6gWGveWItOlHZ/eJkhm0Kfg9+NOxfaV9ynBzxaHwuubpxK
   xXYHw06mnhrgqarpBN4JI4CljxJr4P43rWslc9zQr3OiA/E4kahbh7DY8
   vApEUBq3ILzzSGRsq5iQaF4CJoShkqIZSuTHcRjjcxcVRua+6AFb8xcIR
   Ch6ZHhzh7c8/Fajlh31O/HjvEnKguHNhU4SlxUp1qdrzqhHciheab29IE
   eXkBrpWLFBbUfhjk4a15mrKzXQZWv8zwt21qX/S95oH4beeQE8srnxH5G
   g==;
X-CSE-ConnectionGUID: lrdV4SNuQVCs23MiTEWbSA==
X-CSE-MsgGUID: FuwMKJUpQAqx6J/rmZINpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3323684"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3323684"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 15:34:48 -0800
X-CSE-ConnectionGUID: inmdYYaIS2mHAFqRoc1IIQ==
X-CSE-MsgGUID: mrkHf29aQmGNu8K7Q9mq4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="8925562"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 13 Nov 2026 15:34:47 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xS0n5-000000014Qh-2ylI;
	Fri, 13 Nov 2026 23:34:43 +0000
Date: Sat, 14 Nov 2026 07:34:40 +0800
From: kernel test robot <lkp@intel.com>
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>,
	gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, hugo@hugovil.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Subject: Re: [PATCH v2] serial: sc16is7xx: Fix clock leak on invalid clock
 frequency
Message-ID: <202611140752.jrPC8oJ4-lkp@intel.com>
References: <20261113103855.2144-1-laixiangwu@cmss.chinamobile.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261113103855.2144-1-laixiangwu@cmss.chinamobile.com>

Hi Xiangwu,

kernel test robot noticed the following build errors:

[auto build test ERROR on linux-review/laixiangwu/serial-sc16is7xx-Fix-clock-leak-on-invalid-clock-frequency/20261030-165507]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiangwu-Lai/serial-sc16is7xx-Fix-clock-leak-on-invalid-clock-frequency/20261113-183854
base:   https://github.com/intel-lab-lkp/linux laixiangwu/serial-sc16is7xx-Fix-clock-leak-on-invalid-clock-frequency/20261030-165507
patch link:    https://lore.kernel.org/r/20261113103855.2144-1-laixiangwu%40cmss.chinamobile.com
patch subject: [PATCH v2] serial: sc16is7xx: Fix clock leak on invalid clock frequency
config: powerpc-randconfig-1000-20261114 (https://download.01.org/0day-ci/archive/20261114/202611140752.jrPC8oJ4-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261114/202611140752.jrPC8oJ4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611140752.jrPC8oJ4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/tty/serial/sc16is7xx.c:1622:9: error: use of undeclared label 'out_clk'
    1622 |                         goto out_clk;
         |                              ^
   1 error generated.


vim +/out_clk +1622 drivers/tty/serial/sc16is7xx.c

a5bb146502b22f Hugo Villeneuve     2025-10-27  1567  
d49216438139bc Hugo Villeneuve     2024-04-09  1568  int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
3837a0379533aa Hugo Villeneuve     2023-10-30  1569  		    struct regmap *regmaps[], int irq)
dfeae619d781de Jon Ringle          2014-04-24  1570  {
24bc6e68efa00f Andy Shevchenko     2019-03-18  1571  	unsigned long freq = 0, *pfreq = dev_get_platdata(dev);
2aa916e67db3e6 Daniel Mack         2020-05-21  1572  	unsigned int val;
24bc6e68efa00f Andy Shevchenko     2019-03-18  1573  	u32 uartclk = 0;
dfeae619d781de Jon Ringle          2014-04-24  1574  	int i, ret;
dfeae619d781de Jon Ringle          2014-04-24  1575  	struct sc16is7xx_port *s;
cf9c37530fdabc Hugo Villeneuve     2024-04-09  1576  	bool port_registered[SC16IS7XX_MAX_PORTS];
dfeae619d781de Jon Ringle          2014-04-24  1577  
3837a0379533aa Hugo Villeneuve     2023-10-30  1578  	for (i = 0; i < devtype->nr_uart; i++)
3837a0379533aa Hugo Villeneuve     2023-10-30  1579  		if (IS_ERR(regmaps[i]))
3837a0379533aa Hugo Villeneuve     2023-10-30  1580  			return PTR_ERR(regmaps[i]);
dfeae619d781de Jon Ringle          2014-04-24  1581  
2aa916e67db3e6 Daniel Mack         2020-05-21  1582  	/*
2aa916e67db3e6 Daniel Mack         2020-05-21  1583  	 * This device does not have an identification register that would
2aa916e67db3e6 Daniel Mack         2020-05-21  1584  	 * tell us if we are really connected to the correct device.
2aa916e67db3e6 Daniel Mack         2020-05-21  1585  	 * The best we can do is to check if communication is at all possible.
f6959c5217bd79 Hugo Villeneuve     2023-12-11  1586  	 *
f6959c5217bd79 Hugo Villeneuve     2023-12-11  1587  	 * Note: regmap[0] is used in the probe function to access registers
f6959c5217bd79 Hugo Villeneuve     2023-12-11  1588  	 * common to all channels/ports, as it is guaranteed to be present on
f6959c5217bd79 Hugo Villeneuve     2023-12-11  1589  	 * all variants.
2aa916e67db3e6 Daniel Mack         2020-05-21  1590  	 */
3837a0379533aa Hugo Villeneuve     2023-10-30  1591  	ret = regmap_read(regmaps[0], SC16IS7XX_LSR_REG, &val);
2aa916e67db3e6 Daniel Mack         2020-05-21  1592  	if (ret < 0)
158e800e0fde91 Annaliese McDermond 2021-03-29  1593  		return -EPROBE_DEFER;
2aa916e67db3e6 Daniel Mack         2020-05-21  1594  
dfeae619d781de Jon Ringle          2014-04-24  1595  	/* Alloc port structure */
84f1c5c0174ace Gustavo A. R. Silva 2019-01-04  1596  	s = devm_kzalloc(dev, struct_size(s, p, devtype->nr_uart), GFP_KERNEL);
e0925b4a0417d3 Hugo Villeneuve     2025-10-27  1597  	if (!s)
dfeae619d781de Jon Ringle          2014-04-24  1598  		return -ENOMEM;
dfeae619d781de Jon Ringle          2014-04-24  1599  
24bc6e68efa00f Andy Shevchenko     2019-03-18  1600  	/* Always ask for fixed clock rate from a property. */
24bc6e68efa00f Andy Shevchenko     2019-03-18  1601  	device_property_read_u32(dev, "clock-frequency", &uartclk);
24bc6e68efa00f Andy Shevchenko     2019-03-18  1602  
e8ed246ded863e Andre Werner        2025-01-21  1603  	s->polling = (irq <= 0);
104c1b9dde9d85 Andre Werner        2025-01-10  1604  	if (s->polling)
104c1b9dde9d85 Andre Werner        2025-01-10  1605  		dev_dbg(dev,
104c1b9dde9d85 Andre Werner        2025-01-10  1606  			"No interrupt pin definition, falling back to polling mode\n");
104c1b9dde9d85 Andre Werner        2025-01-10  1607  
dd515504148c43 Xiangwu Lai         2026-11-13  1608  	s->clk = devm_clk_get_optional_enabled(dev, NULL);
cb1b206cff461d Andy Shevchenko     2021-05-17  1609  	if (IS_ERR(s->clk))
cb1b206cff461d Andy Shevchenko     2021-05-17  1610  		return PTR_ERR(s->clk);
cb1b206cff461d Andy Shevchenko     2021-05-17  1611  
cb1b206cff461d Andy Shevchenko     2021-05-17  1612  	freq = clk_get_rate(s->clk);
cb1b206cff461d Andy Shevchenko     2021-05-17  1613  	if (freq == 0) {
24bc6e68efa00f Andy Shevchenko     2019-03-18  1614  		if (uartclk)
24bc6e68efa00f Andy Shevchenko     2019-03-18  1615  			freq = uartclk;
dfeae619d781de Jon Ringle          2014-04-24  1616  		if (pfreq)
dfeae619d781de Jon Ringle          2014-04-24  1617  			freq = *pfreq;
a9226b472bbffe laixiangwu          2026-10-30  1618  		if (freq) {
24bc6e68efa00f Andy Shevchenko     2019-03-18  1619  			dev_dbg(dev, "Clock frequency: %luHz\n", freq);
a9226b472bbffe laixiangwu          2026-10-30  1620  		} else {
a9226b472bbffe laixiangwu          2026-10-30  1621  			ret = -EINVAL;
a9226b472bbffe laixiangwu          2026-10-30 @1622  			goto out_clk;
a9226b472bbffe laixiangwu          2026-10-30  1623  		}
dfeae619d781de Jon Ringle          2014-04-24  1624  	}
dfeae619d781de Jon Ringle          2014-04-24  1625  
dfeae619d781de Jon Ringle          2014-04-24  1626  	s->devtype = devtype;
dfeae619d781de Jon Ringle          2014-04-24  1627  	dev_set_drvdata(dev, s);
dfeae619d781de Jon Ringle          2014-04-24  1628  
3989144f863ac5 Petr Mladek         2016-10-11  1629  	kthread_init_worker(&s->kworker);
9e6f4ca3e567d5 Jakub Kicinski      2015-05-29  1630  	s->kworker_task = kthread_run(kthread_worker_fn, &s->kworker,
9e6f4ca3e567d5 Jakub Kicinski      2015-05-29  1631  				      "sc16is7xx");
dd515504148c43 Xiangwu Lai         2026-11-13  1632  	if (IS_ERR(s->kworker_task))
dd515504148c43 Xiangwu Lai         2026-11-13  1633  		return PTR_ERR(s->kworker_task);
dd515504148c43 Xiangwu Lai         2026-11-13  1634  
28d2f209cd1620 Peter Zijlstra      2020-04-21  1635  	sched_set_fifo(s->kworker_task);
9e6f4ca3e567d5 Jakub Kicinski      2015-05-29  1636  
4fb92bdb8e84e6 Hui Wang            2024-06-18  1637  	ret = sc16is7xx_reset(dev, regmaps[0]);
4fb92bdb8e84e6 Hui Wang            2024-06-18  1638  	if (ret)
4fb92bdb8e84e6 Hui Wang            2024-06-18  1639  		goto out_kthread;
43c51bb573aab6 Florian Vallee      2016-07-19  1640  
cf9c37530fdabc Hugo Villeneuve     2024-04-09  1641  	/* Mark each port line and status as uninitialised. */
dfeae619d781de Jon Ringle          2014-04-24  1642  	for (i = 0; i < devtype->nr_uart; ++i) {
cf9c37530fdabc Hugo Villeneuve     2024-04-09  1643  		s->p[i].port.line = SC16IS7XX_MAX_DEVS;
cf9c37530fdabc Hugo Villeneuve     2024-04-09  1644  		port_registered[i] = false;
8a1060ce974919 Hugo Villeneuve     2023-12-21  1645  	}
8a1060ce974919 Hugo Villeneuve     2023-12-21  1646  
cf9c37530fdabc Hugo Villeneuve     2024-04-09  1647  	for (i = 0; i < devtype->nr_uart; ++i) {
dfeae619d781de Jon Ringle          2014-04-24  1648  		s->p[i].port.dev	= dev;
dfeae619d781de Jon Ringle          2014-04-24  1649  		s->p[i].port.irq	= irq;
dfeae619d781de Jon Ringle          2014-04-24  1650  		s->p[i].port.uartclk	= freq;
3837a0379533aa Hugo Villeneuve     2023-10-30  1651  		s->p[i].regmap		= regmaps[i];
21144bab4f1191 Tomasz Moń          2022-03-01  1652  
a5bb146502b22f Hugo Villeneuve     2025-10-27  1653  		ret = sc16is7xx_setup_channel(&s->p[i], i, &port_registered[i]);
b4a778303ea0fc Hugo Villeneuve     2023-08-07  1654  		if (ret)
b4a778303ea0fc Hugo Villeneuve     2023-08-07  1655  			goto out_ports;
dfeae619d781de Jon Ringle          2014-04-24  1656  	}
dfeae619d781de Jon Ringle          2014-04-24  1657  
1a0a2a1e57aa8d Hugo Villeneuve     2023-09-27  1658  	sc16is7xx_setup_irda_ports(s);
9eb90d57b55a0a Pascal Huerst       2020-05-29  1659  
f6959c5217bd79 Hugo Villeneuve     2023-12-11  1660  	ret = sc16is7xx_setup_mctrl_ports(s, regmaps[0]);
0499942928341d Hugo Villeneuve     2023-08-07  1661  	if (ret)
0499942928341d Hugo Villeneuve     2023-08-07  1662  		goto out_ports;
0499942928341d Hugo Villeneuve     2023-08-07  1663  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
