Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792843229;
	b=5OA1kF2wLTXZKddIl8hYI6t+mqL/YNd17udaHEkyo67adWNUs+ujw/Eb8RRGk4sZRMU/
	 X1+lQQcZ0hgZtMl4SbE076O1IcamuEPzEk4zNrsdNMW4E25TvbwXDcyASUMOgRV/BeCUh
	 1rQHg8kiv1Xlmts3p3io+Cf9SwshQg5VGrexmY1FsxP8tcXrW/bD2LXV+qgZeKvw0JE5W
	 0B4utYE2vsnEZ3Sxx3nEt/qesR/4c7ln7LWGTGTE6sJUlDG3xRxeXPtqU8NdT07o7rvfe
	 aL3hwrGWkxnkMWLTNF8mS0L8EAnhbIMwABF9KDSiwbctIkyLmHY9ZfQViTxpDWmKpaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792843229;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=iAawE0i7d2dZx6OsfH1v0hH9YdKLVGJsQThzURgrqPc=;
	b=xSiOezh/C2Nl/+KDLAREq/7aVkpPqk7aU4W4OmCXxTi8I5p9UJQ26Q109dRwRSNdzpUg
	 AMNXAnY1Es9RGDj/7STY/wcPPb/7MXx3VfB8NxIlqWhW6erSfPv+MHD+O2e8WdHp3Dux+
	 9ScCsHaBNWm+CcuzmQ3eY73UtqgU2LP5JcasIZffJ/HLahgRvytK4aYGkmtTNWsKhtjRx
	 VTwGal1+eT0JXRg+8VbNMeGC5ntE6aLzh29tlaPUJ5HzJ3sJoD11DsGN8tYUAttfDrulo
	 v+LKgQoawJS2cIombhzwJj9CdhNk7rgomesIAIH319nsbp+LrFxY0kGPfEcVN1h2gCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QX4dc8Ag;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A21606A31E;
	Sat, 24 Oct 2026 12:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4A21606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QX4dc8Ag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792843226; x=1824379226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R2AGPdWUdD6phrB+/se1ceN07sH0CgPftRU5IJSao78=;
  b=QX4dc8AgsG8wCnfioyJuJHsik2y1k960vckHRrMmQxRl5Uam4Ijnt0Vp
   vFq87PZN0YA1oRysnCi6IUrFzMnf7WkZvHtTIyAkgy0U6Jyc7c1mSSF0D
   tPEmRcqW2fYPZCjvB0/a6FTD8jGK1gj9xFpF1Uc0+9ycbc3Mvru9F7evd
   zBkzZthIFET1zym+GkqGeiuuiQ6HYfYl+J6fGkCOX+O0mYp4OYnP6UBOE
   VZ3S4CfmNH/H+d4qbKuLyfrt16V0d8UsmC8aPn5wlSvB2Q9D2SNTBtJKG
   KTPzbqJ1fueWtwOdjqIXEO0m2RKj7ShEFsV1fRsEW1tAPekw3c7fT7ADO
   w==;
X-CSE-ConnectionGUID: BMCDpgpBRcm/qZG08dfAZQ==
X-CSE-MsgGUID: nEmUYUYvRVqIp/QtG7p1DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1568018"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1568018"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 05:00:26 -0700
X-CSE-ConnectionGUID: SevpA2GZRF2+GiK0R8HMUA==
X-CSE-MsgGUID: mlfvgZumRlGFpZl/s2XhdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="5706325"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 24 Oct 2026 05:00:22 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xKaQ6-00000000TqI-3nH2;
	Sat, 24 Oct 2026 12:00:18 +0000
Date: Sat, 24 Oct 2026 19:59:52 +0800
From: kernel test robot <lkp@intel.com>
To: ChunAn Wu <an.wu@canonical.com>, linux-serial@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	markus.probst@posteo.de, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com, mpearson-lenovo@squebb.ca,
	derekjohn.clark@gmail.com
Subject: Re: [PATCH v4] platform/x86: dell-uart-backlight: Bind through
 normal serdev matching
Message-ID: <202610241920.GJiRENj2-lkp@intel.com>
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
[also build test ERROR on driver-core/driver-core-next driver-core/driver-core-linus linus/master v7.3 next-20261022]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ChunAn-Wu/platform-x86-dell-uart-backlight-Bind-through-normal-serdev-matching/20261024-102929
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20261024022930.2704030-3-an.wu%40canonical.com
patch subject: [PATCH v4] platform/x86: dell-uart-backlight: Bind through normal serdev matching
config: i386-randconfig-1007-20261024 (https://download.01.org/0day-ci/archive/20261024/202610241920.GJiRENj2-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261024/202610241920.GJiRENj2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610241920.GJiRENj2-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/platform/x86/dell/dell-uart-backlight.c:328:38: error: array type has incomplete element type 'struct serdev_device_id'
     328 | static const struct serdev_device_id dell_uart_bl_serdev_id[] = {
         |                                      ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/platform/x86/dell/dell-uart-backlight.c:338:10: error: 'struct serdev_device_driver' has no member named 'id_table'
     338 |         .id_table = dell_uart_bl_serdev_id,
         |          ^~~~~~~~
   drivers/platform/x86/dell/dell-uart-backlight.c: In function 'dell_uart_bl_pdev_probe':
>> drivers/platform/x86/dell/dell-uart-backlight.c:363:15: error: too many arguments to function 'serdev_device_add'
     363 |         ret = serdev_device_add(serdev, KBUILD_MODNAME);
         |               ^~~~~~~~~~~~~~~~~
   In file included from drivers/platform/x86/dell/dell-uart-backlight.c:19:
   include/linux/serdev.h:161:5: note: declared here
     161 | int serdev_device_add(struct serdev_device *);
         |     ^~~~~~~~~~~~~~~~~
   drivers/platform/x86/dell/dell-uart-backlight.c: At top level:
>> drivers/platform/x86/dell/dell-uart-backlight.c:328:38: warning: 'dell_uart_bl_serdev_id' defined but not used [-Wunused-variable]
     328 | static const struct serdev_device_id dell_uart_bl_serdev_id[] = {
         |                                      ^~~~~~~~~~~~~~~~~~~~~~


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
 > 338		.id_table = dell_uart_bl_serdev_id,
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
