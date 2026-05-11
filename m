Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE41F3806D7;
	Mon, 11 May 2026 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502842; cv=none; b=KP4m5YRlmqWbzoVNuEm8uxpc4Ax/e7qrXDUczU4HwcIHsoOONIWo9RdrBAI1et1Mm7v6Ae/aq43oVUUE0o7M5LLgH1umzfgGghrfjLjDfvacnQEo0BliYYlKnNqbcCTqnq5Dcc5ExVUCKdGocEgcuifAsKJHZ8bnVlHmmIBXC2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502842; c=relaxed/simple;
	bh=XFp1x5W8jS4J581ntTe+UUuIu+HrW1TH83q4suDf1CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXxGMEN/PoGphlkIcG5bVFyVCrONDiHq+NB+3StK/k6jLj4KLjOqvfUSkEC664ht//5vmoY6vXfigMWokJUz0vkYCE8lYw2jZmPaK8BLKynsi/OZRRB/XsmFKbejxO6sjGKCYgfEG+7zOqjPuMshKZcsqBtIhxBtV3pUax+I+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDCPH3wo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDCPH3wo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778502840; x=1810038840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XFp1x5W8jS4J581ntTe+UUuIu+HrW1TH83q4suDf1CM=;
  b=dDCPH3wo9KRhz/6uJwHL+8t9//+CGZyfiooNmIFCxfmiklYK2ZXT5sxh
   Lv5XyBuVeNU1M1seT4Ma6PDzv+EPpYYHVBQEKQ+mBYZovLTq84Jk20ZVC
   85MFOL93ueRRuSyeRDCjusCJJFqTzMKgnNwMvm64VxkhDnYFdiHeHDc/2
   PLmeegnzNEky2+7RMj5oCrADpD1AuZUMg6A1MeTVw5Ncx5g6BVEJsS2Ea
   vJguX4SZEWhaOBWsmKVNParNWO5MHAyHLirdkPtSrOuPtUX0qn8Y6H6yB
   /H2Vf2WY/0J1ZihyjaDGBtHiaOpHjGcSceP6cw99HIWylYyW/41bkZlWA
   Q==;
X-CSE-ConnectionGUID: p0PktbQtRmeyoUlyNpswMA==
X-CSE-MsgGUID: aRkkdpywRkGionadIsVmag==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="81951564"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="81951564"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 05:33:59 -0700
X-CSE-ConnectionGUID: ZN0YOpCfQz6cloIhJGwl3A==
X-CSE-MsgGUID: /R9fPXGGRqSeEjAr/gPZ5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="241799053"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 May 2026 05:33:58 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMPpb-000000000YD-1TnS;
	Mon, 11 May 2026 12:33:55 +0000
Date: Mon, 11 May 2026 20:32:58 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_fsl: Export fsl8250_handle_irq()
 conditionally
Message-ID: <202605112047.Ie6qC0oT-lkp@intel.com>
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
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260511/202605112047.Ie6qC0oT-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260511/202605112047.Ie6qC0oT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605112047.Ie6qC0oT-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/legacy_serial.c: In function 'fixup_port_irq':
>> arch/powerpc/kernel/legacy_serial.c:514:44: error: 'fsl8250_handle_irq' undeclared (first use in this function); did you mean 'serial8250_handle_irq'?
     514 |                         port->handle_irq = fsl8250_handle_irq;
         |                                            ^~~~~~~~~~~~~~~~~~
         |                                            serial8250_handle_irq
   arch/powerpc/kernel/legacy_serial.c:514:44: note: each undeclared identifier is reported only once for each function it appears in


vim +514 arch/powerpc/kernel/legacy_serial.c

463ce0e103f419 Benjamin Herrenschmidt 2005-11-23  489  
463ce0e103f419 Benjamin Herrenschmidt 2005-11-23  490  static void __init fixup_port_irq(int index,
463ce0e103f419 Benjamin Herrenschmidt 2005-11-23  491  				  struct device_node *np,
463ce0e103f419 Benjamin Herrenschmidt 2005-11-23  492  				  struct plat_serial8250_port *port)
463ce0e103f419 Benjamin Herrenschmidt 2005-11-23  493  {
0ebfff1491ef85 Benjamin Herrenschmidt 2006-07-03  494  	unsigned int virq;
463ce0e103f419 Benjamin Herrenschmidt 2005-11-23  495  
0ebfff1491ef85 Benjamin Herrenschmidt 2006-07-03  496  	DBG("fixup_port_irq(%d)\n", index);
463ce0e103f419 Benjamin Herrenschmidt 2005-11-23  497  
0ebfff1491ef85 Benjamin Herrenschmidt 2006-07-03  498  	virq = irq_of_parse_and_map(np, 0);
ef24ba7091517d Michael Ellerman       2016-09-06  499  	if (!virq && legacy_serial_infos[index].irq_check_parent) {
463ce0e103f419 Benjamin Herrenschmidt 2005-11-23  500  		np = of_get_parent(np);
463ce0e103f419 Benjamin Herrenschmidt 2005-11-23  501  		if (np == NULL)
463ce0e103f419 Benjamin Herrenschmidt 2005-11-23  502  			return;
0ebfff1491ef85 Benjamin Herrenschmidt 2006-07-03  503  		virq = irq_of_parse_and_map(np, 0);
463ce0e103f419 Benjamin Herrenschmidt 2005-11-23  504  		of_node_put(np);
463ce0e103f419 Benjamin Herrenschmidt 2005-11-23  505  	}
ef24ba7091517d Michael Ellerman       2016-09-06  506  	if (!virq)
0ebfff1491ef85 Benjamin Herrenschmidt 2006-07-03  507  		return;
0ebfff1491ef85 Benjamin Herrenschmidt 2006-07-03  508  
0ebfff1491ef85 Benjamin Herrenschmidt 2006-07-03  509  	port->irq = virq;
9deaa53ac7fa37 Paul Gortmaker         2011-12-04  510  
66eff0ef528b6d Uwe Kleine-König       2023-06-05  511  	if (IS_ENABLED(CONFIG_SERIAL_8250) &&
66eff0ef528b6d Uwe Kleine-König       2023-06-05  512  	    of_device_is_compatible(np, "fsl,ns16550")) {
1eea99c04555e5 Uwe Kleine-König       2023-06-09  513  		if (IS_REACHABLE(CONFIG_SERIAL_8250_FSL)) {
9deaa53ac7fa37 Paul Gortmaker         2011-12-04 @514  			port->handle_irq = fsl8250_handle_irq;
d68fefdd5b5f10 Dmitry Safonov         2019-12-13  515  			port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
66eff0ef528b6d Uwe Kleine-König       2023-06-05  516  		} else {
66eff0ef528b6d Uwe Kleine-König       2023-06-05  517  			pr_warn_once("Not activating Freescale specific workaround for device %pOFP\n",
66eff0ef528b6d Uwe Kleine-König       2023-06-05  518  				     np);
66eff0ef528b6d Uwe Kleine-König       2023-06-05  519  		}
d68fefdd5b5f10 Dmitry Safonov         2019-12-13  520  	}
0ebfff1491ef85 Benjamin Herrenschmidt 2006-07-03  521  }
463ce0e103f419 Benjamin Herrenschmidt 2005-11-23  522  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
