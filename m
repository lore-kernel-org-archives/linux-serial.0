Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795322251;
	b=inRaBe6neTZuBp5Uro/txjnojBOD+/a3qQv1MJDjJdLhwARE/I5IRVF9YcLUqAISik2j
	 Vd4ruHMZOLEaDJGBiOjKoYG4BkVhLLJAMN7e5svX5JbzKyUe4K0Ih8ZnDpOkjheH6cqBL
	 36CZzLXlkTg5zkQqDLpPKmZXWgt5zUcl7d3jcHP5VZvLPn7WWzoh5TSAvzcvz7Jnz4mCz
	 3s4RHod/F+i/Pkpp4PtpZRKYhhE+26rrmii8bqTigjPZg/OVKSDPMpynb6Qm3jYfxGRAQ
	 eWyLBK7BTQkdLk5nB0sHUAg4DyfhpiTKBHg5cg82MJKZzEc95iTQ2kLfuZSwTs1BUXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795322251;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=TlzTHi+0VW6cnxsXzK9vRsLG/RZrcMxe7NzlbmPXEJ8=;
	b=YCcIkL9z8Hwz9H4knExB01jXLZp67wWtxtAFzDG2hY+cGJxccB0YuCe+SwCNR+GoDgpS
	 6+dQ9ASEcHWzWO1jc0FrMDFdVBcsIQA2sFuHjltX28ru+ES+g4+HJ9pt7SPsfqxwUd1nR
	 tKR2yZeP5YX20hMYg955bJ/UToDgZy8HgURhCYU+YPlgEx+LjQoi0GSJ2BFjBz25WCFJJ
	 9vuhkPPKcY9/9KZESMbY6Fe5+AgX2O3YKCPJBNi7InTcapaSXmww7idFuaue2gJCdaqRW
	 Z4yPt10cXPERwf7MIH7TghrBb657uKKXa7zE8vPGsC6JfrIoD15yy8SIdOKjQL0RM8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GrXwk0hc;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C70606A32A;
	Sun, 22 Nov 2026 04:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57C70606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GrXwk0hc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795322250; x=1826858250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i/xRwtOnx0DXbMOqe/jKs//Rhfd679HI7L90EJzaxac=;
  b=GrXwk0hcUNTMU8yFRYdIVRTGSMaVonul88sIjoiDu/qn66ZhMdPWkw2P
   ZTzXA4hxxVe1M8NPtV3Xy0MFpLkwFEJZmOeS71xSImU4Lzfi/KUz1sEob
   +8sl6VCVpTjDXz162ePodCmlGaxWKrl2uvDJkx7yuvIiruDcbyNomCzki
   yM0CbIbXBh/FDoh25QKTW+SEtIJGit4di1ydccsOYhP2GZER2qPFioOu6
   aH5bej4wi+l7jaFEOmfBzua3jo/aa9ji/fk6Me+eFGrmlA3yORTeIgV7p
   7Eh5w8wG3+3Ygaf6B5ShE/ReamrV9eOOsQkBlvlSgqzBqxAXGtrRXUntU
   w==;
X-CSE-ConnectionGUID: abdrMbCpS9uy6yAK1cbpwQ==
X-CSE-MsgGUID: xBy796Y3QhOGyIp7rSar6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11973"; a="4154136"
X-IronPort-AV: E=Sophos;i="6.27,226,1787036400"; 
   d="scan'208";a="4154136"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2026 20:37:29 -0800
X-CSE-ConnectionGUID: gJT9oT1vTu6oBOV4lefT4g==
X-CSE-MsgGUID: 86FdmE9XSYeQpVd3VxZ3Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,226,1787036400"; 
   d="scan'208";a="11342485"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 21 Nov 2026 20:37:27 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xUzKO-00000001L1b-1IfX;
	Sun, 22 Nov 2026 04:37:24 +0000
Date: Sun, 22 Nov 2026 12:37:08 +0800
From: kernel test robot <lkp@intel.com>
To: Bramuel Barack <bramwelbarack89@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, Alim Akhtar <alim.akhtar@samsung.com>,
	linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bramuel Barack <bramwelbarack89@gmail.com>
Subject: Re: [PATCH] tty: serial: samsung_tty: fix -Wformat-overflow warnings
 for clk_name
Message-ID: <202611221200.BFeU1ULS-lkp@intel.com>
References: <20261121192158.44872-1-bramwelbarack89@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121192158.44872-1-bramwelbarack89@gmail.com>

Hi Bramuel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on krzk/for-next]
[also build test WARNING on tty/tty-testing tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v7.4-rc3 next-20261120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bramuel-Barack/tty-serial-samsung_tty-fix-Wformat-overflow-warnings-for-clk_name/20261121-222158
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git for-next
patch link:    https://lore.kernel.org/r/20261121192158.44872-1-bramwelbarack89%40gmail.com
patch subject: [PATCH] tty: serial: samsung_tty: fix -Wformat-overflow warnings for clk_name
config: parisc-randconfig-1000-20261122 (https://download.01.org/0day-ci/archive/20261122/202611221200.BFeU1ULS-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261122/202611221200.BFeU1ULS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611221200.BFeU1ULS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/tty/serial/samsung_tty.c: In function 's3c24xx_serial_set_termios':
>> drivers/tty/serial/samsung_tty.c:1389:52: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size 4 [-Wformat-truncation=]
      snprintf(clkname, sizeof(clkname), "clk_uart_baud%u", cnt);
                                                       ^~
   drivers/tty/serial/samsung_tty.c:1389:38: note: directive argument in the range [0, 2147483647]
      snprintf(clkname, sizeof(clkname), "clk_uart_baud%u", cnt);
                                         ^~~~~~~~~~~~~~~~~
   drivers/tty/serial/samsung_tty.c:1389:3: note: 'snprintf' output between 15 and 24 bytes into a destination of size 17
      snprintf(clkname, sizeof(clkname), "clk_uart_baud%u", cnt);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/samsung_tty.c: In function 's3c24xx_serial_probe':
   drivers/tty/serial/samsung_tty.c:1781:54: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size 4 [-Wformat-truncation=]
      snprintf(clk_name, sizeof(clk_name), "clk_uart_baud%u", clk_num);
                                                         ^~
   drivers/tty/serial/samsung_tty.c:1781:40: note: directive argument in the range [0, 2147483647]
      snprintf(clk_name, sizeof(clk_name), "clk_uart_baud%u", clk_num);
                                           ^~~~~~~~~~~~~~~~~
   drivers/tty/serial/samsung_tty.c:1781:3: note: 'snprintf' output between 15 and 24 bytes into a destination of size 17
      snprintf(clk_name, sizeof(clk_name), "clk_uart_baud%u", clk_num);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1389 drivers/tty/serial/samsung_tty.c

  1370	
  1371	static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
  1372				unsigned int req_baud, struct clk **best_clk,
  1373				u8 *clk_num)
  1374	{
  1375		const struct s3c24xx_uart_info *info = ourport->info;
  1376		struct clk *clk;
  1377		unsigned long rate;
  1378		unsigned int baud, quot, best_quot = 0;
  1379		char clkname[MAX_CLK_NAME_LENGTH];
  1380		int calc_deviation, deviation = (1 << 30) - 1;
  1381		u8 cnt;
  1382	
  1383		for (cnt = 0; cnt < info->num_clks; cnt++) {
  1384			/* Keep selected clock if provided */
  1385			if (ourport->cfg->clk_sel &&
  1386				!(ourport->cfg->clk_sel & (1 << cnt)))
  1387				continue;
  1388	
> 1389			snprintf(clkname, sizeof(clkname), "clk_uart_baud%u", cnt);
  1390			clk = clk_get(ourport->port.dev, clkname);
  1391			if (IS_ERR(clk))
  1392				continue;
  1393	
  1394			rate = clk_get_rate(clk);
  1395			if (!rate) {
  1396				dev_err(ourport->port.dev,
  1397					"Failed to get clock rate for %s.\n", clkname);
  1398				clk_put(clk);
  1399				continue;
  1400			}
  1401	
  1402			if (ourport->info->has_divslot) {
  1403				unsigned long div = rate / req_baud;
  1404	
  1405				/* The UDIVSLOT register on the newer UARTs allows us to
  1406				 * get a divisor adjustment of 1/16th on the baud clock.
  1407				 *
  1408				 * We don't keep the UDIVSLOT value (the 16ths we
  1409				 * calculated by not multiplying the baud by 16) as it
  1410				 * is easy enough to recalculate.
  1411				 */
  1412	
  1413				quot = div / 16;
  1414				baud = rate / div;
  1415			} else {
  1416				quot = (rate + (8 * req_baud)) / (16 * req_baud);
  1417				baud = rate / (quot * 16);
  1418			}
  1419			quot--;
  1420	
  1421			calc_deviation = abs(req_baud - baud);
  1422	
  1423			if (calc_deviation < deviation) {
  1424				/*
  1425				 * If we find a better clk, release the previous one, if
  1426				 * any.
  1427				 */
  1428				if (!IS_ERR(*best_clk))
  1429					clk_put(*best_clk);
  1430				*best_clk = clk;
  1431				best_quot = quot;
  1432				*clk_num = cnt;
  1433				deviation = calc_deviation;
  1434			} else {
  1435				clk_put(clk);
  1436			}
  1437		}
  1438	
  1439		return best_quot;
  1440	}
  1441	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
