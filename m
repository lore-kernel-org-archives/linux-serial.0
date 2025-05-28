Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3561DF26B;
	Wed, 28 May 2025 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748416044; cv=fail; b=T+2dlokUo0RIX/6DgwbakbnMNZqU1LXczcDBAhqh7VYHGvGU+YJg1zcVBeWERTd854uExjuVtmieZHpqGSYy67F3sBIIS5qxaExLRUV106KwayuXSlRzAXEfsmIwQ7az6jpQ+gnY1Iz6HTir7tZ+lNrDf4JdRdOowaKcGJEQRrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748416044; c=relaxed/simple;
	bh=7az5XWpIBneMT1o/BEZFR6vNOth0aRL7ghPhN420hUM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XZBGBlFcRBnlL+3dNiy1Fu3yaJ4DuX2YVBJoJIGOHicGFUJ5y5O/wYBt4OeksURzM+pvluBK/u1jSVVcI9LIB06XJpJsFSXYdvr0RuHVyOvjSPh5tZc974KfmKIThMTiM3bHhz4uevmRZfKX51vN6zDGilAF6sL9NK0qtLau51E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2VQKLxJ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2VQKLxJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748416041; x=1779952041;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=7az5XWpIBneMT1o/BEZFR6vNOth0aRL7ghPhN420hUM=;
  b=E2VQKLxJ9UnzMA5BDoh+x6H7Gng/TNYFfCFYuGaOEhUasdi7r2UI+f4G
   +CwBhKBFI0rehi73BY2MUAXDMXEuP/Qwmgy0JbxxtecyKuj38w+4bDlKI
   a46y039nKCu2U14mYzrK6CIdZeKy5vKAmbkUQN6NByPPo9CaPQbUWlfco
   iLVTyF+LGV9lpwh2e7kFGplAThI1UzKaqRPoIFR6AX4iotFXgLrBpXAfd
   PUeEMdzVSP3P24qU/EWDhoT9s3d1YRUhoWRC1ViMJXQBge6p2yUHLq6MO
   O9s2LlA18wK2bj37sIOelS4CZbl67tK/9eD2XOTpHy5oeiQw9l+vs3+2w
   A==;
X-CSE-ConnectionGUID: BWrsZDboQOmhHfv4XWnuUA==
X-CSE-MsgGUID: Qs2vGqHrQ66jeljLZ/du8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50487631"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="50487631"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 00:07:21 -0700
X-CSE-ConnectionGUID: SLvRQBovTY2SnPRmXy2H6A==
X-CSE-MsgGUID: DKWz7p7yTaCMrnRgMdFBWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="144120948"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 00:06:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 00:06:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 00:06:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.42)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 00:06:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVgMSU1YbL2o10Qc7klEACf+BKwma3eGuA/4valVmU/2Ug6VjEB7CHgr6mvLpyR072PjjOviocQX8QpkktWadwX4gtNjpbGMyHRf10wkKn76ZgMBbRIJKt4gHAA0ncZr15iPCm4ogyuNuP3tfiOZ34IkZ+CIT5F0l4oDxbTc90Hq4MqVWxeFIgYy609yUUNmEMI1zGMINuzHacBDcJN7x/BuNoSpWpfZa+llYNRJu5Lk+T41RHijyaQHyBcZM9NIMXQzA+Zut2pE6uTyg5/ODovKMiK7OhosBkjU6XpkxINJYRHMzHbKEe0U1rxcQ3rgpafwW82Rq5ZVM2n3mAARdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6loIPM5NUGxIDrErnvk3TZmYaV2T1uVVWqZQtcmCWE=;
 b=TAa+zJ1PHdNPqyVouKd13wvkfxAUaHRpLkP6GTrUqqPbCPWM0X8Jm1WrBW6OOhuW7W6I1KIjFHWqdGNUgj9T+PW0ri8ShJuypVIBY1WPkET/kAK7EtHUNZgetsZh1E/iHeebMmJNtrKA9li32b/1dmAmu6F8rCeVwfR8lTvgSb2MQSnxn8y5JqSrBxdgr1WdeI0NRpx3Yfq81fD63ikPx8kSZIIC5hm/vxlJk80wNeAkstHqdqayBccry4CN8es+WiaG5coHpdALeoIjHky62hgxRw6Nbtn5dEKKelr78m4MD9kRUo2DvxMlqk2RR63yR04ifQ7+06wgFVIfGwelkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB4573.namprd11.prod.outlook.com (2603:10b6:806:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 28 May
 2025 07:06:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8746.030; Wed, 28 May 2025
 07:06:30 +0000
Date: Wed, 28 May 2025 15:06:19 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Max Staudt <max@enpas.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Max Staudt
	<max@enpas.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v1] tty: Register device *after* creating the cdev for a
 tty
Message-ID: <202505281412.8c836cb7-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250526112523.23122-1-max@enpas.org>
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: c38b976c-21ae-439b-c58a-08dd9db62b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FrfGSyJc7sS8L9xClget2ipmQTbDjpN9MpFc6034oIn8J/7x8FDpQmKNtQ6O?=
 =?us-ascii?Q?MxZVFy1zkqsBbZGCjk/m1164rgG7xu4Ljav/eAZ9lzGfw94kSIlbX0LYsR0h?=
 =?us-ascii?Q?zOySmhI19/upUU9OLqcIITszNRJv93KRmA+58bbNSqwna6n1/dllAHnwclmx?=
 =?us-ascii?Q?DKtxqYGy2fLN4Mb8feI0MDaNmQK4oukkKx/svLd5/trSh5bLDvL/rg1/0EFs?=
 =?us-ascii?Q?1Wd9y039JD3fKFfmEdz4m5rR2+M3SQu35lMTJwcJpEMezNDkj4KdOywXEuiP?=
 =?us-ascii?Q?W1RyFiBVGMwlY1L3X5C1GLRxoY4HLLNd09isGMencEvtUaoQ6BMimGr+HCwb?=
 =?us-ascii?Q?goNvhdX+eqEH6i1puurmPWqlx3PDVB5RhtYsOyk2F6OpOedwioLxZOR+BwM7?=
 =?us-ascii?Q?QW7wevaJvCHyxbXy93NEfhnNjlqGE34tDyIlI3cB6Qe6HGyNp1VI9go0K0ri?=
 =?us-ascii?Q?zZox/QCZ4PTg3ZUvkPEcbhTn2XUR6hsT7iUO8yEILX0YGwiHy/ocAopMF7pE?=
 =?us-ascii?Q?fgRHzWTfCwxlyJO6vJYPYzveoSLsuMyiK+fRpwOxQmUpnLias/2ZqKStGgTU?=
 =?us-ascii?Q?e6AnTUon/1LzuGusl6NjdiT73mec84iStKFPYI53AUkHXS6OMh24qvXLK8tP?=
 =?us-ascii?Q?KNL2rw76Rf10G/KNIelJFY0N025LsujggeR60eylPsiGi0E8DcVDjGp/NZZX?=
 =?us-ascii?Q?bi3wy0qnFL10yWPrlNaqGpRkD8+9edPhIDnWI6k3rZkvrJFuip4VTTWGL5qG?=
 =?us-ascii?Q?qAYn5LD87b9WbAc6bKjbjXVVW9gYW7i4pxfTaWLfegguftxPfAdxzIcx8iM/?=
 =?us-ascii?Q?uqOMaI+BYlUmP6Bt67iYfpCPgO3GsEpt7BK7qXSwgezEKEdeWvt0GDpNv6PA?=
 =?us-ascii?Q?ZD8mE/dcOFRbXgGHtYXLGmH18sRycpqCf6HX2SNUpD2hbI6iXISpLycQk467?=
 =?us-ascii?Q?9ycvqsGOvkrMslWAVPVPGqoFHeeWOp3izZTaHPrR3j27Qw/716jaX9yha/Qx?=
 =?us-ascii?Q?YaFrbZCAoGFXcYEF0PBAMjotH/HdovK+t/4SY3Y2u/ZX0RZFN6PeEoQggcWU?=
 =?us-ascii?Q?lqbI9FKyMXCn9QZrLjINLTqkURtg3XEirizG2ypM02hYWqUbL77BWFVH1UZG?=
 =?us-ascii?Q?Kvg1P4sseK997GHdYqFZUYBiv6p2ZTpSGni29KsmdMvDtHm4d787A5a1njN6?=
 =?us-ascii?Q?HIC60Uct4Z9MbIp4C1STMXtZEACdx6SUfhzC0z88UeVK6D039xo0uMmH/OXX?=
 =?us-ascii?Q?gEwVxGiax43jAFum2qjX+qvhK8fhCpq0+8gkJD1YAFG44lkhst9qKf3gPHkq?=
 =?us-ascii?Q?ryjDAOIs7Rz55oqby7pkknDP0338DyYIGyb9Z2HPQ5gTamm3bTOWWdajWuSH?=
 =?us-ascii?Q?/VWAlQKp6hjDfvBHGECFRfhcvDIw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lkcZfYClh1Z/5N3bgeTJ4Yr5xT/H5PASxmLjajDq44xQjHDqSnzaR9Ppwgnb?=
 =?us-ascii?Q?cROK4u82uqOkfTyLiZMCLNaE41OPyU7te+X7MnwrBmRF58NuyWf9rY40wX5s?=
 =?us-ascii?Q?DvOgZcNDRhQQ38L7fXl4AoIcAHffhyYKjNiV26uVEZRFTmxs5zHRp8Ww35JK?=
 =?us-ascii?Q?TRUcg6Q8J4x1bgQBY4UvPtrnzfR3o/2lKn+edidW1gjgkY0xHKWlYOIJPXy4?=
 =?us-ascii?Q?2jdoq2bj/EAZg8K7kdQNrfJ8s6YmvTV4S6aR03uahFKf+vIUJ167skKci0T2?=
 =?us-ascii?Q?fE4eBJ3Yk3d0NVF/2VBB14xrH0RovKB9t3dnU4xfwuVDQ7YXvwsG/5/0Qpcc?=
 =?us-ascii?Q?Aeyqe/BV4ygx7tsaFoEmtdS5hVqTR3rHeo9KWl0WMb49aLyHWJ+NuFySTtmX?=
 =?us-ascii?Q?MGzJAw8NKuywj99GhjPOEcx9RVv0A+XfGnsmf+RPwvNKv5QKGL6QLHIOiK/U?=
 =?us-ascii?Q?hWm4CSQJtbVAZUawazTO2ufuvGpzrDTLfW0lTk7uzRfJf0WM0FCS4vWmfjh3?=
 =?us-ascii?Q?2DzbWEr6ZydN9+2kvW1tgrTGEBoSqD6t73xoT9XxbZclEAQfNiY94qbmOFNE?=
 =?us-ascii?Q?tBOnhHGtg5oRxmKdsWLkH3Wn1HKfTpMWbZJ6+A03Ooq+1fPH4aUlTJHqeP2E?=
 =?us-ascii?Q?biSB4hoAOzMbVOGqLjpVghm5Ou5nUjhn32rtwtH3HNQGsVhLAcm/uB5/gvQS?=
 =?us-ascii?Q?AaAUimNGzAN9unXp6ffhDsPQJntpT01+13IuSZU/CIug0KNl7nZDqYZ7X3cK?=
 =?us-ascii?Q?5QyZ+5BVPGR7W55XC13Rl0yQfZyzN9k/XyjQnCx2ibgOSMdWf/YWqbohIirq?=
 =?us-ascii?Q?TSZsUwHSZg7qGcZiBm1Z/haGbUtePZHsgzDNyFbT1t+HOlyJc7FKN4skdZBY?=
 =?us-ascii?Q?9Bwj9nxUE2AhqojMnX33sPs7MBv5poZG50xc0/6E3ni0K+PKVBxERgMA1Ieq?=
 =?us-ascii?Q?DZhoQHODLBrRu10DHBL+4tixVf/k8wNOGD/+edrswjb7AHW2mgvnJXs4WvOX?=
 =?us-ascii?Q?N556mN5EQqgBd9FaFbxKbyGt/oFPRhZ8WiJi4WWx+rIlhfels1cJKZhKrHdw?=
 =?us-ascii?Q?TxeLXtm+RNiOrsO6NEBIxbpQWbih2034xVz9tF1QgrEIyBkutAiMI0v6VO7g?=
 =?us-ascii?Q?FyKyOE34uCPUIJvFiXQ8Ep7Dsc6OA15wn3Ab2e8rIaU1HNLXneYqsxWhtslv?=
 =?us-ascii?Q?WJHDgHyLH11k9HqwlqrpsImTctwHOvppRGxaPOUR9hOxvnuKwG9RfcaxHuMf?=
 =?us-ascii?Q?GIv2RsYMa7dQUBAltVVqtjT1E07ZA2IkxJFqbQnpX8k3xLAn5uw0lC79Er0l?=
 =?us-ascii?Q?N6xbJbdDvDaRZEtV87c81w3JS+iHzbDrpF3pAqS19RGl0+JDV35UoeV47jFy?=
 =?us-ascii?Q?RK2gbD9EughThrNZWq1o87iBBr5x8mhbhQ9RQl/mS7mg14PgREyTAGEPjkq1?=
 =?us-ascii?Q?FZqSWZ0bxwVzHU2ouH9a+kxy4SxdOksxb3H7IrygZeSN0ZTQlHlrWzD8jUre?=
 =?us-ascii?Q?xp9VPqNw2pF7AeB8IGSxv3qn8QOIZz4GlB0lVYg8Fzo9S1i56q9iMSEG1mpf?=
 =?us-ascii?Q?NH/Ii+I6FSp/zHQlEJDejlbvHVK5inFypjHHSyU/4TV/0vKDD0W39oW91dZ9?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c38b976c-21ae-439b-c58a-08dd9db62b8f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 07:06:30.0175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+VmZju+LuH5CB0vNqFuiB6k/bB7vgHWG/b3qtoVBd/rKzclOYKCU7oryRSDO/fsCMvHBcas/HI31v7juY4oYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4573
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:

commit: c8190da3d46a287a5fe76c9f92ee041564c06236 ("[PATCH v1] tty: Register device *after* creating the cdev for a tty")
url: https://github.com/intel-lab-lkp/linux/commits/Max-Staudt/tty-Register-device-after-creating-the-cdev-for-a-tty/20250526-192806
base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git tty-testing
patch link: https://lore.kernel.org/all/20250526112523.23122-1-max@enpas.org/
patch subject: [PATCH v1] tty: Register device *after* creating the cdev for a tty

in testcase: boot

config: i386-randconfig-011-20250527
compiler: gcc-12
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------------------------------------------------------------------------------------------------+------------+------------+
|                                                                                                                                                       | b495021a97 | c8190da3d4 |
+-------------------------------------------------------------------------------------------------------------------------------------------------------+------------+------------+
| WARNING:possible_circular_locking_dependency_detected                                                                                                 | 0          | 6          |
| WARNING:possible_circular_locking_dependency_detected_swapper_is_trying_to_acquire_lock:at:tty_port_open_but_task_is_already_holding_lock:at:tty_lock | 0          | 6          |
+-------------------------------------------------------------------------------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202505281412.8c836cb7-lkp@intel.com


[    6.990953][    T1] WARNING: possible circular locking dependency detected
[    6.991958][    T1] 6.15.0-rc4-00107-gc8190da3d46a #1 Tainted: G                T
[    6.993098][    T1] ------------------------------------------------------
[    6.994053][    T1] swapper/1 is trying to acquire lock:
[ 6.994811][ T1] b40b31ac (&port->mutex){+.+.}-{4:4}, at: tty_port_open (kbuild/obj/consumer/i386-randconfig-011-20250527/arch/x86/include/asm/bitops.h:206 kbuild/obj/consumer/i386-randconfig-011-20250527/arch/x86/include/asm/bitops.h:238 kbuild/obj/consumer/i386-randconfig-011-20250527/include/asm-generic/bitops/instrumented-non-atomic.h:142 kbuild/obj/consumer/i386-randconfig-011-20250527/include/linux/tty_port.h:211 kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/tty/tty_port.c:761) 
[    6.995978][    T1]
[    6.995978][    T1] but task is already holding lock:
[ 6.997087][ T1] ed9fbc48 (&tty->legacy_mutex){+.+.}-{4:4}, at: tty_lock (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/tty/tty_mutex.c:19) 
[    7.002405][    T1]
[    7.002405][    T1] which lock already depends on the new lock.
[    7.002405][    T1]
[    7.003949][    T1]
[    7.003949][    T1] the existing dependency chain (in reverse order) is:
[    7.005246][    T1]
[    7.005246][    T1] -> #2 (&tty->legacy_mutex){+.+.}-{4:4}:
[ 7.006388][ T1] __lock_acquire (kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/lockdep.c:5235) 
[ 7.007155][ T1] lock_acquire (kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/lockdep.c:472 kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/lockdep.c:5868) 
[ 7.007870][ T1] __mutex_lock (kbuild/obj/consumer/i386-randconfig-011-20250527/arch/x86/include/asm/atomic.h:23 kbuild/obj/consumer/i386-randconfig-011-20250527/include/linux/atomic/atomic-arch-fallback.h:457 kbuild/obj/consumer/i386-randconfig-011-20250527/include/linux/jump_label.h:262 kbuild/obj/consumer/i386-randconfig-011-20250527/include/trace/events/lock.h:95 kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/mutex.c:603 kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/mutex.c:746) 
[ 7.008582][ T1] mutex_lock_nested (kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/mutex.c:799) 
[ 7.009322][ T1] tty_lock (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/tty/tty_mutex.c:19) 
[ 7.010008][ T1] tty_init_dev (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/tty/tty_io.c:1295 kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/tty/tty_io.c:1407) 
[ 7.010739][ T1] tty_open (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/tty/tty_io.c:2073 kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/tty/tty_io.c:2120) 
[ 7.011435][ T1] chrdev_open (kbuild/obj/consumer/i386-randconfig-011-20250527/fs/char_dev.c:414) 
[ 7.012161][ T1] do_dentry_open (kbuild/obj/consumer/i386-randconfig-011-20250527/fs/open.c:956) 
[ 7.012939][ T1] vfs_open (kbuild/obj/consumer/i386-randconfig-011-20250527/fs/open.c:1086) 
[ 7.013641][ T1] do_open (kbuild/obj/consumer/i386-randconfig-011-20250527/fs/namei.c:3880) 
[ 7.014340][ T1] path_openat (kbuild/obj/consumer/i386-randconfig-011-20250527/fs/namei.c:4039) 
[ 7.015052][ T1] do_filp_open (kbuild/obj/consumer/i386-randconfig-011-20250527/fs/namei.c:4066) 
[ 7.015775][ T1] file_open_name (kbuild/obj/consumer/i386-randconfig-011-20250527/fs/open.c:1374) 
[ 7.016565][ T1] filp_open (kbuild/obj/consumer/i386-randconfig-011-20250527/fs/open.c:1393) 
[ 7.017247][ T1] console_on_rootfs (kbuild/obj/consumer/i386-randconfig-011-20250527/init/main.c:1528) 
[ 7.018070][ T1] kernel_init_freeable (kbuild/obj/consumer/i386-randconfig-011-20250527/init/main.c:1578) 
[ 7.018887][ T1] kernel_init (kbuild/obj/consumer/i386-randconfig-011-20250527/init/main.c:1459) 
[ 7.019589][ T1] ret_from_fork (kbuild/obj/consumer/i386-randconfig-011-20250527/arch/x86/kernel/process.c:159) 
[ 7.020334][ T1] ret_from_fork_asm (kbuild/obj/consumer/i386-randconfig-011-20250527/arch/x86/entry/entry_32.S:737) 
[ 7.021115][ T1] entry_INT80_32 (kbuild/obj/consumer/i386-randconfig-011-20250527/arch/x86/entry/entry_32.S:942) 
[    7.021884][    T1]
[    7.021884][    T1] -> #1 (tty_mutex){+.+.}-{4:4}:
[ 7.022934][ T1] __lock_acquire (kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/lockdep.c:5235) 
[ 7.023681][ T1] lock_acquire (kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/lockdep.c:472 kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/lockdep.c:5868) 
[ 7.024418][ T1] __mutex_lock (kbuild/obj/consumer/i386-randconfig-011-20250527/arch/x86/include/asm/atomic.h:23 kbuild/obj/consumer/i386-randconfig-011-20250527/include/linux/atomic/atomic-arch-fallback.h:457 kbuild/obj/consumer/i386-randconfig-011-20250527/include/linux/jump_label.h:262 kbuild/obj/consumer/i386-randconfig-011-20250527/include/trace/events/lock.h:95 kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/mutex.c:603 kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/mutex.c:746) 
[ 7.025137][ T1] mutex_lock_nested (kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/mutex.c:799) 
[ 7.025908][ T1] tty_register_device_attr (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/tty/tty_io.c:3250) 
[ 7.026751][ T1] tty_port_register_device_attr_serdev (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/tty/tty_port.c:199) 
[ 7.027724][ T1] serial_core_add_one_port (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/tty/serial/serial_core.c:3184) 
[ 7.028574][ T1] serial_core_register_port (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/tty/serial/serial_core.c:3388) 
[ 7.029416][ T1] serial_ctrl_register_port (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/tty/serial/serial_ctrl.c:42) 
[ 7.030245][ T1] uart_add_one_port (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/tty/serial/serial_port.c:144) 
[ 7.031025][ T1] serial8250_register_8250_port (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/tty/serial/8250/8250_core.c:822) 
[ 7.031940][ T1] serial_pnp_probe (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/tty/serial/8250/8250_pnp.c:480) 
[ 7.032707][ T1] pnp_device_probe (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/pnp/driver.c:111) 
[ 7.033455][ T1] really_probe (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/base/dd.c:579 kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/base/dd.c:657) 
[ 7.038357][ T1] __driver_probe_device (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/base/dd.c:799) 
[ 7.039198][ T1] driver_probe_device (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/base/dd.c:829) 
[ 7.040004][ T1] __driver_attach (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/base/dd.c:1216) 
[ 7.040773][ T1] bus_for_each_dev (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/base/bus.c:370) 
[ 7.041556][ T1] driver_attach (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/base/dd.c:1234) 
[ 7.042088][ T1] bus_add_driver (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/base/bus.c:678) 
[ 7.042585][ T1] driver_register (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/base/driver.c:249) 
[ 7.043090][ T1] pnp_register_driver (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/pnp/driver.c:281) 
[ 7.043609][ T1] serial8250_pnp_init (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/tty/serial/8250/8250_pnp.c:531) 
[ 7.044115][ T1] serial8250_init (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/tty/serial/8250/8250_platform.c:315) 
[ 7.044602][ T1] do_one_initcall (kbuild/obj/consumer/i386-randconfig-011-20250527/init/main.c:1257) 
[ 7.045089][ T1] do_initcalls (kbuild/obj/consumer/i386-randconfig-011-20250527/init/main.c:1318 kbuild/obj/consumer/i386-randconfig-011-20250527/init/main.c:1335) 
[ 7.045549][ T1] kernel_init_freeable (kbuild/obj/consumer/i386-randconfig-011-20250527/init/main.c:1569) 
[ 7.046075][ T1] kernel_init (kbuild/obj/consumer/i386-randconfig-011-20250527/init/main.c:1459) 
[ 7.046531][ T1] ret_from_fork (kbuild/obj/consumer/i386-randconfig-011-20250527/arch/x86/kernel/process.c:159) 
[ 7.047000][ T1] ret_from_fork_asm (kbuild/obj/consumer/i386-randconfig-011-20250527/arch/x86/entry/entry_32.S:737) 
[ 7.047494][ T1] entry_INT80_32 (kbuild/obj/consumer/i386-randconfig-011-20250527/arch/x86/entry/entry_32.S:942) 
[    7.047972][    T1]
[    7.047972][    T1] -> #0 (&port->mutex){+.+.}-{4:4}:
[ 7.048668][ T1] check_prev_add (kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/lockdep.c:3167) 
[ 7.049154][ T1] validate_chain (kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/lockdep.c:3286 kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/lockdep.c:3909) 
[ 7.049652][ T1] __lock_acquire (kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/lockdep.c:5235) 
[ 7.050147][ T1] lock_acquire (kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/lockdep.c:472 kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/lockdep.c:5868) 
[ 7.050609][ T1] __mutex_lock (kbuild/obj/consumer/i386-randconfig-011-20250527/arch/x86/include/asm/atomic.h:23 kbuild/obj/consumer/i386-randconfig-011-20250527/include/linux/atomic/atomic-arch-fallback.h:457 kbuild/obj/consumer/i386-randconfig-011-20250527/include/linux/jump_label.h:262 kbuild/obj/consumer/i386-randconfig-011-20250527/include/trace/events/lock.h:95 kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/mutex.c:603 kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/mutex.c:746) 
[ 7.051064][ T1] mutex_lock_nested (kbuild/obj/consumer/i386-randconfig-011-20250527/kernel/locking/mutex.c:799) 
[ 7.051547][ T1] tty_port_open (kbuild/obj/consumer/i386-randconfig-011-20250527/arch/x86/include/asm/bitops.h:206 kbuild/obj/consumer/i386-randconfig-011-20250527/arch/x86/include/asm/bitops.h:238 kbuild/obj/consumer/i386-randconfig-011-20250527/include/asm-generic/bitops/instrumented-non-atomic.h:142 kbuild/obj/consumer/i386-randconfig-011-20250527/include/linux/tty_port.h:211 kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/tty/tty_port.c:761) 
[ 7.052005][ T1] uart_open (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/tty/serial/serial_core.c:1974) 
[ 7.052433][ T1] tty_open (kbuild/obj/consumer/i386-randconfig-011-20250527/drivers/tty/tty_io.c:2137) 
[ 7.052862][ T1] chrdev_open (kbuild/obj/consumer/i386-randconfig-011-20250527/fs/char_dev.c:414) 
[ 7.053311][ T1] do_dentry_open (kbuild/obj/consumer/i386-randconfig-011-20250527/fs/open.c:956) 
[ 7.053798][ T1] vfs_open (kbuild/obj/consumer/i386-randconfig-011-20250527/fs/open.c:1086) 
[ 7.054220][ T1] do_open (kbuild/obj/consumer/i386-randconfig-011-20250527/fs/namei.c:3880) 
[ 7.054647][ T1] path_openat (kbuild/obj/consumer/i386-randconfig-011-20250527/fs/namei.c:4039) 
[ 7.055093][ T1] do_filp_open (kbuild/obj/consumer/i386-randconfig-011-20250527/fs/namei.c:4066) 
[ 7.055548][ T1] file_open_name (kbuild/obj/consumer/i386-randconfig-011-20250527/fs/open.c:1374) 
[ 7.056027][ T1] filp_open (kbuild/obj/consumer/i386-randconfig-011-20250527/fs/open.c:1393) 
[ 7.056453][ T1] console_on_rootfs (kbuild/obj/consumer/i386-randconfig-011-20250527/init/main.c:1528) 
[ 7.056933][ T1] kernel_init_freeable (kbuild/obj/consumer/i386-randconfig-011-20250527/init/main.c:1578) 
[ 7.057447][ T1] kernel_init (kbuild/obj/consumer/i386-randconfig-011-20250527/init/main.c:1459) 
[ 7.057904][ T1] ret_from_fork (kbuild/obj/consumer/i386-randconfig-011-20250527/arch/x86/kernel/process.c:159) 
[ 7.058365][ T1] ret_from_fork_asm (kbuild/obj/consumer/i386-randconfig-011-20250527/arch/x86/entry/entry_32.S:737) 
[ 7.058843][ T1] entry_INT80_32 (kbuild/obj/consumer/i386-randconfig-011-20250527/arch/x86/entry/entry_32.S:942) 
[    7.059302][    T1]
[    7.059302][    T1] other info that might help us debug this:
[    7.059302][    T1]
[    7.060225][    T1] Chain exists of:
[    7.060225][    T1]   &port->mutex --> tty_mutex --> &tty->legacy_mutex
[    7.060225][    T1]
[    7.061811][    T1]  Possible unsafe locking scenario:


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250528/202505281412.8c836cb7-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

