Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1972046AD
	for <linux-serial@vger.kernel.org>; Wed, 12 Feb 2025 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347696; cv=fail; b=ro9oI/lF/WuoAo1KATnc9fkH+5UGtdNVfW431yfUuPkmGZHzsN0fVCNZnmVOBtHjjBVKSCGNaqKl7kubIbr2QqFlvOz+itwl4cCl1ZQcZOFvufqc2tBXme3BKPrBH6A9wzOQRYGD9TnIxbYjxCPrLc3QvJItDi+dt3vMi4LOICQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347696; c=relaxed/simple;
	bh=MyRk1i8z9eH+TWTqfL6Op7rJKQpUNGsN9erCuYb3uQw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Oq2XMBoqp8b7YzsLmAVKjbobQ9oeItjo313/3JcdaC7YjjmE6g4aE/afK44I6ZSO4IfaJxU0bHexOsNjYd0hSWC/vtW3FaKGf4XWN/xL9AuCEA++KeqnVq7Q4Omi8O9XkgEP0hJl9hbpStD8UJPkMX88FZmpLmumHl3sGSQkKPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPjg49JX; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPjg49JX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739347695; x=1770883695;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MyRk1i8z9eH+TWTqfL6Op7rJKQpUNGsN9erCuYb3uQw=;
  b=hPjg49JXaRrwSAHchhdkRJvTq0R4f7LEtY+yTX+mXw80dzx2WIYPuCb/
   0OPvKUfBtl92wEN8ezTlWXBW4PN1eaitlsye369xn/v37m+QDOqLZGgD/
   4dRSZWilD22V0a5p5qxwi37ewMYUZXyGjHP/r4tyLhCKa+LQpIP955McB
   IPesFgzQGBGGN6vjdPSKxgOuO76N7wbcgHrWOaIaZOQu9/IOaoqINMC1r
   G+XNXWvvx3A7h4GpYMXm6U2M98LWzYDd7KGi5nSYaV8+OPVQceb2CPpIN
   lk8nS6MzCEQx2B0RzeqFqQ+HZhz3qywAYG14AwoVKa2yquNHY3CA9KGB1
   A==;
X-CSE-ConnectionGUID: AZsC7cQiTmuDtjjPMHhgdQ==
X-CSE-MsgGUID: kGB+YId4QcOnduQJTzsboQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="43645488"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="43645488"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 00:08:14 -0800
X-CSE-ConnectionGUID: 3qt+myb2QTi/xVraJsDlpw==
X-CSE-MsgGUID: 8TKaCmpoTiGYv9bxQGZdEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="112965853"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2025 00:08:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 12 Feb 2025 00:08:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Feb 2025 00:08:13 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 00:08:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTVvFjv8srTHL4j81e0oW0XG1UADKyyemDXW+/HspRBjHLh8JEivMP2iV63m6J61Ki3vroWqFA3g/CurbaeK9Fm1ySHMuQd2MpjjpE6SU2UKVp+se9aTKfm0cntQn7UgxyXG1uobsqrQ7JyNhmbapHQQtcq1XArs5P4LlbFmebeIhIfqQ+UviZrv3dL4LN3F6QzJHV6s18xWg5PBFQmPCZAh/XB8YjZyDg9/r0f81rMC8nimVKjDRaqBjQvcRVOYrG673HFuOSFsbZQomtC+XJgYIrALuHaOkMsqF0R2RsUIueeLNL4k2PtAntlyjSgFSVXD7JpFZDA8cEB6mGbRRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wZsRPu/3GDC4jkWmoYjbvzTZLlPtpexVXhph4x1zR4=;
 b=GQS9bEnMP7exTAgiPR1EstjtD/I5Qe6boZuLdUVtjmI4KchWPc+XaMyhXycbedvP1C25hkGfDOv8RiRrMYCZoAcsCLrk5SYK8+I+3NdzMX8kpsp6/gYSn6uKL34/YCpIpnNo/uo8X+iG8T8Y69qwhMf455CLJnz0T5qBnvvlK52k9EEVXs2PPW+1qTkPsRN1dIqe6Wt/Hb5ZoMeQCvci/ruOS9xZjaoRVg0KEGrr3tUbLSjbbvViEOWmtXrO71PUauAJO4Psy/67A/niDl3u/GihwH5odsHAxLeR+Dxv2JARqDRVD9ohwDbvaJycjrWNAvYJcvUCY4IWLyj5DVU0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB5057.namprd11.prod.outlook.com (2603:10b6:303:6c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 08:08:09 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 08:08:09 +0000
Date: Wed, 12 Feb 2025 16:08:00 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-serial@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [serial]  bfd3d4a40f:
 KASAN:null-ptr-deref_in_range[#-#]
Message-ID: <202502121529.f7e65d49-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: 328a9dd3-0e6f-4a44-bfd9-08dd4b3c631e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NlYD24hCum56MaQFfaNXHn68MuoK19S5KimV45U3INQqM30gbkZfhVWfdyZk?=
 =?us-ascii?Q?mGp6qHqgmA+LyhojnKzrWbWlJ3FmGCJciTfz/ej/uWU/8nSXNBifL9gFk8gH?=
 =?us-ascii?Q?PeCGCBz9kPWMWKL0Q6d/vZbnYxdoXtqlJg6vncnMRoXS/a9uABMvIJx2ojGP?=
 =?us-ascii?Q?Xu5vMqSkwhHmjJ0WOtjmAjUNQuBC86bqzhFKaoCdTzxDGei3wNBweW+J4GSi?=
 =?us-ascii?Q?LFHbqh/RhiLOa0jf56CFPokiVsZxJ5OgAyw9Ou8Mea9Y1US3/lvgqhKd08jk?=
 =?us-ascii?Q?f0YVpLl6KFWTyP789RIPG0xvavEq/p4gtKLJZ9Co/bjW8XqMqfJwXpeotIPY?=
 =?us-ascii?Q?vlKaxHnliTJ4iVjOHjxmqgly+uzKuCF9KffBcxXh4lLHeXVzcae/y2uFGW9F?=
 =?us-ascii?Q?Vi7q4t6HRI3xWC9s0DUV0NRclv8e3zzDY/VFFTZwuTx/D06sv5JelRu5+uRF?=
 =?us-ascii?Q?IwXkwIKz0dRDOgAhHvhhyDAIwmc6w6v/O1jUX8/8yB2Axw5iJo3+lHA3Zl5T?=
 =?us-ascii?Q?WJ9r4dB9tsU6SuM7iFY8oBMNAXl96k822VUx6zlvYkWRhbfJiiAkB6Bv2v8B?=
 =?us-ascii?Q?HeRwkMxEC98Khyt/mCMueMgRuq9bFVaKcPOzSDchJ3NDAhz7zNVIqezSRA2m?=
 =?us-ascii?Q?thC4Uk9kxFKHa3S7FR7jxzwiQI+edeQkwbgKiZBOcyHj9vRt15kPZAn2qBOB?=
 =?us-ascii?Q?LgjyUJpHnLtkZ9IwRJZETzO3/SkEnVU+rFtXlbh24LouOdRlixHs0h1cxjzu?=
 =?us-ascii?Q?pXVkE2n5menAM/1Zmjhz+7N/vYQFthEJKSmqDmE9+ZzSoe9IKmkUC0eCg1+K?=
 =?us-ascii?Q?kCNuSdT9iC6enP6rGdnB8fGi96DhOdwA5mkNNRI/bBXrcoKtjC8CWjijTxa1?=
 =?us-ascii?Q?RMMcZcQsybbk1Rp1QxfWMyWmnyBDIk/ynEG4TJIYCQ5LD9r+PN21OMwYkO1P?=
 =?us-ascii?Q?g7D0QATKsOZTc1Dr/Mj1pMmDzWGZKmNjCj+xjqZlGkUzJAo8MrM0XCSfppNH?=
 =?us-ascii?Q?XViWW/0kt0UXHLY27vIuszK9CtyW0ytMx3vBI7ZNXhfZ5R6wlsjJ7pvnZutG?=
 =?us-ascii?Q?DDUg97mvSUSBXhDyhbXlaTpxx4zFZ1WN+515QLjjmzSW7HEbTWqXkNUtbvvc?=
 =?us-ascii?Q?vDg3OiI5y4sqEBD2liFVzHFIpNg4KZ1kA1Ud9Rabd36YUzumlPJ1PoASQS8Y?=
 =?us-ascii?Q?2JBtFmre2mZMDoPQlK9WD1fivet+DAoVWkCn6qgaXTp3ykznTwLMaL7f+W1m?=
 =?us-ascii?Q?671les7l0KdlwfO8ETMPehVMiqswL5NFCNBPvDVpL7hK4z4YNkK1JiJ+isT1?=
 =?us-ascii?Q?Xh8z5xghyVP3K2k2vFv0r7LtTznaJ3/8BxHWZVQYdm2yIQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1HMVMIrt9JA0ay5JxQBP/6+7YEFXiWYy5wxR3XGONg0A8DYlKTCNQTLmH/Ce?=
 =?us-ascii?Q?3OS8OnKVwIZC3WkQkDRdav8mrHH9qdA6TAiAruo2BcbdUP3SUy2jMslCbSG3?=
 =?us-ascii?Q?KhxVyPXV9VMEYBpjyrF3zNTgY+BuUgOcgIv6t7mPaqiBeOad+iDBjACVOyNQ?=
 =?us-ascii?Q?JIbeDDGso7pILcg+1GpD2N8BG03KjRkWHJBGmkVwVhx4XDQ7r7MmYgyv+pyS?=
 =?us-ascii?Q?GY111PNbopQcnhvgkUg+JeJxxW196IhNXONBp9oq/RI4IlPctpPGSwxYUzpc?=
 =?us-ascii?Q?mdMre465Mh4JmMnuVm7ggKo3UkPPXJ9rkJQ+BZQyrtZivsM2yrpkwRb1zwMi?=
 =?us-ascii?Q?9QCgPQuYmGdKvkDwv34ZkBY8zKOr/PfcQDn7XpfcSUFlv0lBODxVG9J5NB7m?=
 =?us-ascii?Q?qwLNqGHAVPI8/KF8tqSxzk03bp0fifLQp0Mu62elD6QLZpBMLUmkVF8a9fu/?=
 =?us-ascii?Q?k5Xp1aI1kbKdRPzEHvb3HCiLh2DPJCxWU8mYFDu5b6wazCjatA78lON30y4L?=
 =?us-ascii?Q?ANJavhxMoeGQ6673U6wZHnP/MxlgeQRYWO9hR5b4e4TsFlPRJnmWAM3rKVo1?=
 =?us-ascii?Q?NaWz1us7TIp43Zwo/JNoCDcKcgwuJreR81ckLL+v01UwdEV5nRHBk5D38scw?=
 =?us-ascii?Q?nqcJ/4EiOUcaZ3GsSPjIfIYMRwjP69n1HTkwQL4FYMRgdbdj0NzeqV0VAWhp?=
 =?us-ascii?Q?ZpXbtIrcGEolzwDARirK6WSw1nR3SqjWb2lKbtf56dToJRPb/5O736oz8Dg4?=
 =?us-ascii?Q?7P3qBdoHAa9zecxp1+mLtBze2ks9C646QNxeGqJ4fNhxjYX7UsZn8vP30sB6?=
 =?us-ascii?Q?1+1+kdfVMFbVzrpBv0EcE7oamhqWUJKN63snsweBcpQuHni2gfhFvDdJ5xuO?=
 =?us-ascii?Q?y2rsFpxAoAAL6xlh2WrB48Leb8NBMwqxKOn1EnH+kRTfBkf7ONVm3NkP/Pv9?=
 =?us-ascii?Q?WMpEF4MHKF7CNLgWtngx+lD2QegWCllchVharlJPtrJ2KoBtUJJ4CHtHn25d?=
 =?us-ascii?Q?qyud4n5Gv/N5nL9RHPz+diaSRoG7owN+LMawQRD/9GQwY0FI9kKY0iSDffMc?=
 =?us-ascii?Q?DlCoNfHiT+V4TQvWB5VRL0Bz6s6vCl3uqEKHFylcYprAH6nlQ4xbZvCz4eOD?=
 =?us-ascii?Q?QlDmrEX8OFCePjm/wWLSaQ6kSnZX5Ez9nISSzM1vYEJWEbJzhxX3+UUtjbwQ?=
 =?us-ascii?Q?IHq5rob2XevTjO8jJBdNpdzY1Cu19iKnv1acg2jwc3iXK23Nq9GyoJ4YfFAG?=
 =?us-ascii?Q?L44PhbtgLi704X4Cp4Yld8PKDOFEI05wcK3nKxPIh5XyjswnPX0CsXMggaRt?=
 =?us-ascii?Q?5xvb8aL2g4nJIm54aYUnA00C3pAJZUtvMtxCstUAzA8THyX5j4o8KwUPVNzk?=
 =?us-ascii?Q?T+R30p+zQ7Oxp6YYu8cXVp2Tr7pSOuAXWSz6BgTBO9YX+dbJQwhxD99FvzMh?=
 =?us-ascii?Q?FwYBlWjefaayeY443Bs9j0yWDOvJI2MbbfYE7GR5XdyNzjygkuCJ69YEsSly?=
 =?us-ascii?Q?PJ6SCjjEPGYTeJznYEBRxijLcQECQzYQNlngSMpfOhJ+DtzAByAhHYgfBbh1?=
 =?us-ascii?Q?hBOY5EuLz+uXYd7IhdfhKafTG9Oj2o6qcdSBywoURyyAwIQzvSLgq/MTHEz+?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 328a9dd3-0e6f-4a44-bfd9-08dd4b3c631e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 08:08:09.0505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqN7ZvP+RQJafwpJbbjVhaCfD2fH+CoZJsxVi8zA/38NJiC+kYPD2kPcd3znj1SCW3igHl4Ep5tMD7z0Vu+cHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5057
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "KASAN:null-ptr-deref_in_range[#-#]" on:

commit: bfd3d4a40f3905ec70b17dbfa9b78764e59e4b4f ("serial: 8250_dw: Drop unneeded NULL checks in dw8250_quirks()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: kernel-selftests
version: kernel-selftests-x86_64-7503345ac5f5-1_20241208
with following parameters:

	group: sgx



config: x86_64-rhel-9.4-kselftests
compiler: gcc-12
test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake-E) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502121529.f7e65d49-lkp@intel.com


[   34.377423][  T125] iTCO_wdt iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/BIOS
[   34.392689][  T357] IOAPIC[0]: Preconfigured routing entry (2-17 -> IRQ 17 Level:1 ActiveLow:1)
Mountin[   34.427657][  T357] idma64 idma64.1: Found Intel integrated DMA 64-bit
[   34.431964][  T346] ppdev: user-space parallel port driver
[   34.457700][  T357] idma64 idma64.2: Found Intel integrated DMA 64-bit
[   34.481800][  T357] KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
[   34.490095][  T357] CPU: 6 UID: 0 PID: 357 Comm: (udev-worker) Not tainted 6.14.0-rc1-00009-gbfd3d4a40f39 #1
[   34.499959][  T357] Hardware name: Intel Corporation Mehlow UP Server Platform/Moss Beach Server, BIOS CNLSE2R1.R00.X188.B13.1903250419 03/25/2019
[   34.501967][  T125] i2c i2c-0: Successfully instantiated SPD at 0x51
[ 34.513099][ T357] RIP: 0010:dw8250_probe (kbuild/src/consumer/drivers/tty/serial/8250/8250_dw.c:462 kbuild/src/consumer/drivers/tty/serial/8250/8250_dw.c:629) 
[   34.521181][  T125] i2c i2c-0: Successfully instantiated SPD at 0x53
[ 34.524691][ T357] Code: c1 ea 03 80 3c 02 00 0f 85 21 07 00 00 49 8b 8c 24 30 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 79 08 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 07
All code
========
   0:	c1 ea 03             	shr    $0x3,%edx
   3:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   7:	0f 85 21 07 00 00    	jne    0x72e
   d:	49 8b 8c 24 30 01 00 	mov    0x130(%r12),%rcx
  14:	00 
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df 
  1f:	48 8d 79 08          	lea    0x8(%rcx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx		<-- trapping instruction
  2e:	48 89 f8             	mov    %rdi,%rax
  31:	83 e0 07             	and    $0x7,%eax
  34:	83 c0 03             	add    $0x3,%eax
  37:	38 d0                	cmp    %dl,%al
  39:	7c 08                	jl     0x43
  3b:	84 d2                	test   %dl,%dl
  3d:	0f                   	.byte 0xf
  3e:	85 07                	test   %eax,(%rdi)

Code starting with the faulting instruction
===========================================
   0:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
   4:	48 89 f8             	mov    %rdi,%rax
   7:	83 e0 07             	and    $0x7,%eax
   a:	83 c0 03             	add    $0x3,%eax
   d:	38 d0                	cmp    %dl,%al
   f:	7c 08                	jl     0x19
  11:	84 d2                	test   %dl,%dl
  13:	0f                   	.byte 0xf
  14:	85 07                	test   %eax,(%rdi)
[   34.524695][  T357] RSP: 0018:ffffc9000224e858 EFLAGS: 00010202
[   34.524700][  T357] RAX: dffffc0000000000 RBX: 1ffff92000449d12 RCX: 0000000000000000
[   34.564397][  T357] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000008
[   34.572267][  T357] RBP: ffff888107cff010 R08: 0000000000000001 R09: 0000000000000001
[   34.580138][  T357] R10: ffffffff86469427 R11: ffffffff81e3d5bb R12: ffff8881db096428
[   34.588001][  T357] R13: ffffc9000224e8b0 R14: ffff8881db096558 R15: 0000000000000000
[   34.595864][  T357] FS:  00007f2e783558c0(0000) GS:ffff8887d8300000(0000) knlGS:0000000000000000
[   34.604683][  T357] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.611161][  T357] CR2: 00007f2e78141e81 CR3: 00000002105a8005 CR4: 00000000003706f0
[   34.619049][  T357] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   34.626896][  T357] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   34.634759][  T357] Call Trace:
[   34.637933][  T357]  <TASK>
[ 34.640824][ T357] ? die_addr (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:421 kbuild/src/consumer/arch/x86/kernel/dumpstack.c:460) 
[ 34.644877][ T357] ? exc_general_protection (kbuild/src/consumer/arch/x86/kernel/traps.c:751 kbuild/src/consumer/arch/x86/kernel/traps.c:693) 
[ 34.650318][ T357] ? asm_exc_general_protection (kbuild/src/consumer/arch/x86/include/asm/idtentry.h:574) 
[ 34.655938][ T357] ? __kasan_kmalloc (kbuild/src/consumer/mm/kasan/common.c:377 kbuild/src/consumer/mm/kasan/common.c:394) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250212/202502121529.f7e65d49-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

