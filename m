Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792863755;
	b=XMud8cil9/BB8bO3drIwuW9pwd5JWs1YZz6yslck+be6YMJRk0hdW1alLetb7oKufUcm
	 E5V+nETFbKbiOXSNYSLjK9BdmXdVuf7swo8E331cGi8FEdVnudOc51+OLTA5kAAViXkkF
	 es8Xm4gGLEF0TMHSUP1BGjAjHKLhML35OLDQloEKRo5hvaZptur7cuDeyyMXMxHOT+fjS
	 wNOQMyKjPoWX7w9Pvvgyuy3z3zn2FIvoLiYRaNgH5aJQd+gnX+7o1Aj0f62CfNX9quJLG
	 Y+Kobu2VotHCWNfVoLjlg+84By7NuWusziw2+BOl3ElqocaDmFRnEq8riG3cE2ijFlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792863755;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=BuZ1t5C7X+sSlJUKEoZNCJc0nbbvghvhuZ0zbUxxORM=;
	b=JzhWeqhCTF62Q0S80bs/R0DIkMo4STV8L0FwOPfRvSLS60P9PTRbRSAmitqqbvVJ9U/E
	 3yVvVqxQDSws0mTBH7X4N6ABGKh4qT0WcOJ4XSNrGHFC0MBef4GBuQbme1c871KKyi2F/
	 HdLIMaNWpSFl7+rbjx4cxRoIHCoxOLdjtGnFhwEeiF+vsyJgMidK4seYyKjsTas7X989p
	 WPs7bQYUvXK/G+V3titc5m4jytB7t8gNol9B75M1G5Gs5mdCS8Qqyfq7RWv0SV37hshJt
	 +2OJOpZxzmfagP+kJTxEfp6Vr7KNLyuzVrGbDs+OZLCCQh0mBpLdrvD+usq/efXkIbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fyJ0Oph1;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF57606A31B;
	Sat, 24 Oct 2026 17:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AF57606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fyJ0Oph1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792863754; x=1824399754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8vNrTE29DnPOhUoUbcQAhuV/RJaOFG+RLJlehh9FQn4=;
  b=fyJ0Oph1du/s8g1KSUDFOKoY88kjZE+pJLWEL2dRto838761xsywg67B
   3twdNjPcJZe5i8gTgPICv8CO5lLrOt0Y3JHsfjLuRsqcMjX7d9HpSpZd/
   5l1pThimy5+dbiwTmHgzFT5Jg34e/9VB7C7ByBBEVRSgvWECBNw0b1NNx
   Nfm0q8ZGu7RRGN9LuQAIRnOsOOp+RRPlAywA6uE4b501aJCwEiT0XNqQz
   sVRVf4MJAUjSLnI3q7pxG6Sq2DjFdwIlaAnTsLfmA/oqchG9bouv7bsDV
   oBvskF5plW5dbFWUEhdUdWFPo9V0KmKQCskfHeX2bNyLjGWzQPRpwno16
   Q==;
X-CSE-ConnectionGUID: ystu15h1Q5WaO4CnXeNfRw==
X-CSE-MsgGUID: exDBMffOSu2tp9z3aq/oNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11945"; a="1468463"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1468463"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 10:42:34 -0700
X-CSE-ConnectionGUID: eJZY8DdJSTC/QSpw94f05w==
X-CSE-MsgGUID: 3ONycMUWSKq+6Lkg09qGPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="4013537"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 24 Oct 2026 10:42:30 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xKflD-00000000U6o-1dkn;
	Sat, 24 Oct 2026 17:42:27 +0000
Date: Sun, 25 Oct 2026 01:42:26 +0800
From: kernel test robot <lkp@intel.com>
To: ChunAn Wu <an.wu@canonical.com>, linux-serial@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, markus.probst@posteo.de,
	gregkh@linuxfoundation.org, jirislaby@kernel.org, hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com, mpearson-lenovo@squebb.ca,
	derekjohn.clark@gmail.com
Subject: Re: [PATCH v4] platform/x86: dell-uart-backlight: Bind through
 normal serdev matching
Message-ID: <202610250118.t0UAW41j-lkp@intel.com>
References: <20261024022930.2704030-3-an.wu@canonical.com>
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
In-Reply-To: <20261024022930.2704030-3-an.wu@canonical.com>

Hi ChunAn,

kernel test robot noticed the following build errors:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on driver-core/driver-core-next driver-core/driver-core-linus linus/master v7.3 next-20261023]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ChunAn-Wu/platform-x86-dell-uart-backlight-Bind-through-normal-serdev-matching/20261024-102929
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20261024022930.2704030-3-an.wu%40canonical.com
patch subject: [PATCH v4] platform/x86: dell-uart-backlight: Bind through normal serdev matching
config: x86_64-randconfig-1014-20261024 (https://download.01.org/0day-ci/archive/20261025/202610250118.t0UAW41j-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261025/202610250118.t0UAW41j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610250118.t0UAW41j-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/platform/x86/dell/dell-uart-backlight.c:328:60: error: array has incomplete element type 'const struct serdev_device_id'
     328 | static const struct serdev_device_id dell_uart_bl_serdev_id[] = {
         |                                                            ^
   drivers/platform/x86/dell/dell-uart-backlight.c:328:21: note: forward declaration of 'struct serdev_device_id'
     328 | static const struct serdev_device_id dell_uart_bl_serdev_id[] = {
         |                     ^
>> drivers/platform/x86/dell/dell-uart-backlight.c:363:34: error: too many arguments to function call, expected 1, have 2
     363 |         ret = serdev_device_add(serdev, KBUILD_MODNAME);
         |               ~~~~~~~~~~~~~~~~~         ^~~~~~~~~~~~~~
   <command line>:8:24: note: expanded from macro 'KBUILD_MODNAME'
       8 | #define KBUILD_MODNAME "dell_uart_backlight"
         |                        ^~~~~~~~~~~~~~~~~~~~~
   include/linux/serdev.h:161:5: note: 'serdev_device_add' declared here
     161 | int serdev_device_add(struct serdev_device *);
         |     ^                 ~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +328 drivers/platform/x86/dell/dell-uart-backlight.c

   327	
 > 328	static const struct serdev_device_id dell_uart_bl_serdev_id[] = {
   329		{ KBUILD_MODNAME },
   330		{ }
   331	};
   332	
   333	static struct serdev_device_driver dell_uart_bl_serdev_driver = {
   334		.probe = dell_uart_bl_serdev_probe,
   335		.driver = {
   336			.name = KBUILD_MODNAME,
   337		},
   338		.id_table = dell_uart_bl_serdev_id,
   339	};
   340	
   341	static int dell_uart_bl_pdev_probe(struct platform_device *pdev)
   342	{
   343		enum acpi_backlight_type bl_type;
   344		struct serdev_device *serdev;
   345		struct device *ctrl_dev;
   346		int ret;
   347	
   348		bl_type = acpi_video_get_backlight_type();
   349		if (bl_type != acpi_backlight_dell_uart) {
   350			dev_dbg(&pdev->dev, "Not loading (ACPI backlight type = %d)\n", bl_type);
   351			return -ENODEV;
   352		}
   353	
   354		ctrl_dev = get_serdev_controller("DELL0501", NULL, 0, "serial0");
   355		if (IS_ERR(ctrl_dev))
   356			return PTR_ERR(ctrl_dev);
   357	
   358		serdev = serdev_device_alloc(to_serdev_controller(ctrl_dev));
   359		put_device(ctrl_dev);
   360		if (!serdev)
   361			return -ENOMEM;
   362	
 > 363		ret = serdev_device_add(serdev, KBUILD_MODNAME);
   364		if (ret) {
   365			dev_err(&pdev->dev, "error %d adding serdev\n", ret);
   366			serdev_device_put(serdev);
   367			return ret;
   368		}
   369	
   370		ret = serdev_device_driver_register(&dell_uart_bl_serdev_driver);
   371		if (ret)
   372			goto err_remove_serdev;
   373	
   374		/* So that dell_uart_bl_pdev_remove() can remove the serdev */
   375		platform_set_drvdata(pdev, serdev);
   376		return 0;
   377	
   378	err_remove_serdev:
   379		serdev_device_remove(serdev);
   380		return ret;
   381	}
   382	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
