Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EC0368D4E
	for <linux-serial@vger.kernel.org>; Tue, 12 May 2026 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778615648; cv=none; b=W1ahJoWq358ZOxiTpNQLdxs7BpRKf7QDwza1ET1wPvT9t8Yc4u5nGBCVwcmvCa1KT4iy8URaSjgLb9pgIFLxZWExiSzmlAaz+ihDTVIWdFT4g9ZmOAatDUzitA+IXmxWpz5/PyjM/HGLyfyqGvNMwjMC4GDdG1MeMV6TxN0o/9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778615648; c=relaxed/simple;
	bh=+l9GhiBIM+peatuuDig73wLTqrNcJy8F4KnbLQ6Ai+k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JkGzdtdXIoIsphXfnivlvQu9X9FdltfhzGnF77A4IBN7IgrJN5D2brQLPYNcc1VL6PfPtyMqUVkC5GNYFs8AggeZBSbln/W3wdu+2wZcbTTJh9EuDIKLTU5JcnXZ1rzku52iyAz6we9eANiB/rpReTu3uVjnwFXpa8DvDiWKpd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9uXxngG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9uXxngG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778615647; x=1810151647;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+l9GhiBIM+peatuuDig73wLTqrNcJy8F4KnbLQ6Ai+k=;
  b=H9uXxngG3zzxw2klJiTvlnJ5G8es7vJ4xGxEGyQDKRvRONG54nnesnwk
   8dN3aCAd0O2OFFidXFz5xgOU6QPk/z5+h240CIPRPd2VDp1sRiW0/olwC
   19qmZf6ktUWbYunJD6z8O0AXOD3ku6S+dWP/H4d/e9zL4rPYCZfQdhJPY
   1q9M1A60JFbNvqr/q8+hNugSO2K/Muybw0Ll+vXyryfBEYUHCadVV3B2a
   Yc519/VmZZu31w61PJgFPKhT7kwRzgbYzeLDBnGR9oUGi9Ou0WRTAdjCR
   PnOy+ClaBYXOEZBLxSsuQbZM+06EnqzKzgG1sFR8JaJ3Zq9rA4DpZgR8j
   A==;
X-CSE-ConnectionGUID: AqSXMyYeS/qUGbV3rmLfLw==
X-CSE-MsgGUID: SJfxXnMuSbCMiHfPyhhyZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79518412"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79518412"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:54:04 -0700
X-CSE-ConnectionGUID: l+CZiU36RAiq9E0k25Rzlw==
X-CSE-MsgGUID: DlCJ0TcsSU+9X0lKbe8GCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="236883764"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 12 May 2026 12:54:02 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMtB0-000000002iZ-4BNJ;
	Tue, 12 May 2026 19:53:59 +0000
Date: Wed, 13 May 2026 03:53:00 +0800
From: kernel test robot <lkp@intel.com>
To: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: [tty:tty-next 28/31] drivers/tty/serial/max310x.c:1507:20:
 warning: 'max310x_regmap_name' defined but not used
Message-ID: <202605130334.e6V1YDQN-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Hugo,

First bad commit (maybe !=3D root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-=
next
head:   16e95bfb79b5d9d01dc7651d98caf3c2ace331cd
commit: 20ffe4b3330a8bde9e933e9ba2323d5e9386caa5 [28/31] serial: max310x: a=
llow driver to be built with SPI or I2C
config: powerpc64-randconfig-001-20260513 (https://download.01.org/0day-ci/=
archive/20260513/202605130334.e6V1YDQN-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive=
/20260513/202605130334.e6V1YDQN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605130334.e6V1YDQN-lkp@i=
ntel.com/

All warnings (new ones prefixed by >>):

   drivers/tty/serial/max310x.c: In function 'max310x_uart_init':
   drivers/tty/serial/max310x.c:1730:1: warning: label 'err_spi_register' d=
efined but not used [-Wunused-label]
    err_spi_register:
    ^~~~~~~~~~~~~~~~
   At top level:
>> drivers/tty/serial/max310x.c:1507:20: warning: 'max310x_regmap_name' def=
ined but not used [-Wunused-function]
    static const char *max310x_regmap_name(u8 port_id)
                       ^~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/max310x.c:1492:29: warning: 'regcfg' defined but not =
used [-Wunused-variable]
    static struct regmap_config regcfg =3D {
                                ^~~~~~
>> drivers/tty/serial/max310x.c:1464:13: warning: 'max310x_remove' defined =
but not used [-Wunused-function]
    static void max310x_remove(struct device *dev)
                ^~~~~~~~~~~~~~
>> drivers/tty/serial/max310x.c:1280:12: warning: 'max310x_probe' defined b=
ut not used [-Wunused-function]
    static int max310x_probe(struct device *dev, const struct max310x_devty=
pe *devtype,
               ^~~~~~~~~~~~~


vim +/max310x_regmap_name +1507 drivers/tty/serial/max310x.c

f65444187a66bf Alexander Shiyan 2012-08-06  1463 =20
70b4d23226c85a Uwe Kleine-K=C3=B6nig 2021-10-12 @1464  static void max310x_=
remove(struct device *dev)
f65444187a66bf Alexander Shiyan 2012-08-06  1465  {
f65444187a66bf Alexander Shiyan 2012-08-06  1466  	struct max310x_port *s =
=3D dev_get_drvdata(dev);
88d5e520aa9701 abdoulaye berthe 2014-07-12  1467  	int i;
f65444187a66bf Alexander Shiyan 2012-08-06  1468 =20
6286767ad3afc8 Alexander Shiyan 2016-06-07  1469  	for (i =3D 0; i < s->dev=
type->nr; i++) {
10d8b34a421716 Alexander Shiyan 2013-06-29  1470  		cancel_work_sync(&s->p[=
i].tx_work);
e7b8a3ceff5e5c Alexander Shiyan 2014-02-07  1471  		cancel_work_sync(&s->p[=
i].md_work);
5bdb48b501e836 Alexander Shiyan 2016-06-07  1472  		cancel_work_sync(&s->p[=
i].rs_work);
5d888f1c32e228 Hugo Villeneuve  2024-01-18  1473 =20
5d888f1c32e228 Hugo Villeneuve  2024-01-18  1474  		if (test_and_clear_bit(=
s->p[i].port.line, max310x_lines))
6286767ad3afc8 Alexander Shiyan 2016-06-07  1475  			uart_remove_one_port(&=
max310x_uart, &s->p[i].port);
5d888f1c32e228 Hugo Villeneuve  2024-01-18  1476 =20
9464833a765f66 Hugo Villeneuve  2024-01-18  1477  		max310x_power(&s->p[i].=
port, 0);
10d8b34a421716 Alexander Shiyan 2013-06-29  1478  	}
f65444187a66bf Alexander Shiyan 2012-08-06  1479 =20
d3a8a252e177cf Alexander Shiyan 2014-02-10  1480  	clk_disable_unprepare(s-=
>clk);
f65444187a66bf Alexander Shiyan 2012-08-06  1481  }
f65444187a66bf Alexander Shiyan 2012-08-06  1482 =20
58afc909772c9b Alexander Shiyan 2014-02-10  1483  static const struct of_de=
vice_id __maybe_unused max310x_dt_ids[] =3D {
58afc909772c9b Alexander Shiyan 2014-02-10  1484  	{ .compatible =3D "maxim=
,max3107",	.data =3D &max3107_devtype, },
58afc909772c9b Alexander Shiyan 2014-02-10  1485  	{ .compatible =3D "maxim=
,max3108",	.data =3D &max3108_devtype, },
58afc909772c9b Alexander Shiyan 2014-02-10  1486  	{ .compatible =3D "maxim=
,max3109",	.data =3D &max3109_devtype, },
58afc909772c9b Alexander Shiyan 2014-02-10  1487  	{ .compatible =3D "maxim=
,max14830",	.data =3D &max14830_devtype },
58afc909772c9b Alexander Shiyan 2014-02-10  1488  	{ }
58afc909772c9b Alexander Shiyan 2014-02-10  1489  };
58afc909772c9b Alexander Shiyan 2014-02-10  1490  MODULE_DEVICE_TABLE(of, m=
ax310x_dt_ids);
58afc909772c9b Alexander Shiyan 2014-02-10  1491 =20
27027a70e21f62 Alexander Shiyan 2014-02-10  1492  static struct regmap_conf=
ig regcfg =3D {
27027a70e21f62 Alexander Shiyan 2014-02-10  1493  	.reg_bits =3D 8,
27027a70e21f62 Alexander Shiyan 2014-02-10  1494  	.val_bits =3D 8,
d584b65c0ddf20 Jan Kundr=C3=A1t      2017-12-13  1495  	.write_flag_mask =
=3D MAX310X_WRITE_BIT,
c9615d34ce2619 wangkaiyuan      2024-03-18  1496  	.cache_type =3D REGCACHE=
_MAPLE,
6ef281daf02059 Cosmin Tanislav  2022-06-05  1497  	.max_register =3D MAX310=
X_REG_1F,
27027a70e21f62 Alexander Shiyan 2014-02-10  1498  	.writeable_reg =3D max31=
0x_reg_writeable,
27027a70e21f62 Alexander Shiyan 2014-02-10  1499  	.volatile_reg =3D max310=
x_reg_volatile,
27027a70e21f62 Alexander Shiyan 2014-02-10  1500  	.precious_reg =3D max310=
x_reg_precious,
3f42b142ea1171 Jan Kundr=C3=A1t      2023-04-05  1501  	.writeable_noinc_re=
g =3D max310x_reg_noinc,
3f42b142ea1171 Jan Kundr=C3=A1t      2023-04-05  1502  	.readable_noinc_reg=
 =3D max310x_reg_noinc,
3f42b142ea1171 Jan Kundr=C3=A1t      2023-04-05  1503  	.max_raw_read =3D M=
AX310X_FIFO_SIZE,
3f42b142ea1171 Jan Kundr=C3=A1t      2023-04-05  1504  	.max_raw_write =3D =
MAX310X_FIFO_SIZE,
27027a70e21f62 Alexander Shiyan 2014-02-10  1505  };
27027a70e21f62 Alexander Shiyan 2014-02-10  1506 =20
609aabb259d497 Hugo Villeneuve  2024-01-18 @1507  static const char *max310=
x_regmap_name(u8 port_id)
609aabb259d497 Hugo Villeneuve  2024-01-18  1508  {
609aabb259d497 Hugo Villeneuve  2024-01-18  1509  	switch (port_id) {
609aabb259d497 Hugo Villeneuve  2024-01-18  1510  	case 0:	return "port0";
609aabb259d497 Hugo Villeneuve  2024-01-18  1511  	case 1:	return "port1";
609aabb259d497 Hugo Villeneuve  2024-01-18  1512  	case 2:	return "port2";
609aabb259d497 Hugo Villeneuve  2024-01-18  1513  	case 3:	return "port3";
609aabb259d497 Hugo Villeneuve  2024-01-18  1514  	default:
609aabb259d497 Hugo Villeneuve  2024-01-18  1515  		WARN_ON(true);
609aabb259d497 Hugo Villeneuve  2024-01-18  1516  		return NULL;
609aabb259d497 Hugo Villeneuve  2024-01-18  1517  	}
609aabb259d497 Hugo Villeneuve  2024-01-18  1518  }
609aabb259d497 Hugo Villeneuve  2024-01-18  1519 =20

:::::: The code at line 1507 was first introduced by commit
:::::: 609aabb259d497578ffa2d66ced57c22044f821c serial: max310x: use separa=
te regmap name for each port

:::::: TO: Hugo Villeneuve <hvilleneuve@dimonoff.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
