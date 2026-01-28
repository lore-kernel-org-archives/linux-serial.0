Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9F525D527;
	Wed, 28 Jan 2026 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609414; cv=fail; b=Pa0j3eE2mkBze0/HPoVp5am0jzqegPU3NWoNytHvbEzZsGdDBmtdPL28LEhX9ghhdn3wsQ4gFVsYmW1BkfY5RSDyEkG3u7SvfRhZNJHjC8pAgRlGuz+xFFhRTF6F/myMUyNFuKmQwBuQ8SnIpQIH7rxApt+yFIqz9eXnYq2FP1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609414; c=relaxed/simple;
	bh=ZjKSXn5dj7scqY7ubLSkYVEsAaKimIqF64GA8EA+xrA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=IiL8lDN66fzr7CUq+CNOaTvK7BwBM6fBq6PB+9ZZNyAHjd7fo21zpBC0ratCsXWVJbsgkJ0nl0eAMuXftOyI0DgJ5NQqpkp94MjpW0z9B1dsOdjd6ejhNOVPff8CGRjG+QZhFQgDKUb+0R/y0R5NhnI7OtmJwLH96nhl70CO9s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OCC8URap; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCC8URap"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769609412; x=1801145412;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZjKSXn5dj7scqY7ubLSkYVEsAaKimIqF64GA8EA+xrA=;
  b=OCC8URap7yeNt611ycEKoEWk0ocjkf0Ffdr9ALMNwh6HpmxqsRZArLx/
   z8NtS4oHO81qks5pV+KvWJXU7l+HB1rbKXyod76l6POOhMzerrTeM4J/V
   Wlz2/fooyOWUJMzVKYsojOrQbRSNSNV73Ql3TsYwvToEr2/VvKCwUN4nE
   VanbyXsFSI0AKcHA4geV/iRVlT9rrDikPGq+omPfMZHe72Bk5fvVtsZeB
   qe3fsNdnflItjA8f4ef5hQNJoo13SnKNo+y4OawPKe2YfBYrwrgdhgecO
   bwuUrLSUlmCa4p4i9Hy3FWJw1TGZyW3MVQanKKNst5ewwn/wTDsKhDeU7
   w==;
X-CSE-ConnectionGUID: JIMrCpUASeCZ16ZBksB+mw==
X-CSE-MsgGUID: bPvXZ062SP2fVnU3hxzYWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81545202"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="81545202"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 06:10:08 -0800
X-CSE-ConnectionGUID: YCn6JBeyT/64zgTMtFi87A==
X-CSE-MsgGUID: yBLYuPfxSsu8+a/hCcZcXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="212833084"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 06:10:08 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 06:10:07 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 06:10:07 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 06:10:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmFIvDMO6IoEmCzy25Bf/mVrmGIUEFuROyuRNQGhItBrLKadYlNQQMmNKcRwTFF2adVpxbQovi+D+hySf1U5qlINbxsyo/ACh6grcgd9MWb3z+M8aj/TbCZCoOktMN5tJl5E1DvznmF+Q4KM9Yg389DYoOU4wixZIsvXblkpYjkgLYWpk7FD2XMvshE8AtlwtrNXUNBoESDvxLod5oTI26OD33Dqz/8XiL4A1vkz22rUzpfzBOOHZN5/k0PbGXhr52eKsvqw+zsctKg+FdfFObow2C9sjrokmKV00l7PKfnmey3MAMGQoudSx7cESY6yDHTvcaHrnoUFicbSMN5E8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN6mwuVPVtGAeeEetqJR8EO93r+A6MlVIKiSu41oD+A=;
 b=gvENiWhFyHGUwwFobd8SMIhezir312lkmc+XynXr5hspugzF1SWSqi2bCMSBevpSiDxQOqBvRLeNDLWBEJBt3iDLURshA3Rl14GsXVgluyjYEnZaONkhzd8JIFJvofnvd0fnHYQTGbnQ67C6JklHWOg5DSKN2sefHAmheJFLwEBo63zuez+ofP52lp683N0AHazMmz724MQGmFwmOU52jVJtUo/9DkBDu40isLWwJv/3iR9PwHeHW38pJu0WcbZn+2JWcvy5MQU+xDSAxDWaQczuF+CXxF89H8RQ5FJnUWdBt/pvO+S+Roo4etEm7F8svh8jfRJTdaXiRxrAeWGo9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA3PR11MB8920.namprd11.prod.outlook.com (2603:10b6:208:578::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 14:10:00 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 14:10:00 +0000
Date: Wed, 28 Jan 2026 22:09:48 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Xin Zhao <jackzxcui1989@163.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [tty]  d000422a46:
 sysfs:cannot_create_duplicate_filename
Message-ID: <202601282134.b947eae9-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA3PR11MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: 330259d6-3f78-4208-fa8c-08de5e76eb3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6hNrDDTp48uFk+zkveI9QsiI6sR3zkRhlgSUN2SWjUaW+SSQZN++2A245RrH?=
 =?us-ascii?Q?p7U3Ocs9G2ywNNtB2t+M6J/UL5DyBGf39rmh5tl6Sora4IjxOBnMdrK6oFO0?=
 =?us-ascii?Q?o1FK022kiXWA3SxfYMDtW1Vo4J+ob5YZ3nvBx6gQ8X0U/D4fxIG8WpZPV95/?=
 =?us-ascii?Q?a94FORGKwBuegc4HTbUQ5Vkkjui+gWG2xrVFu4Y7WPm4VTTyTeVDlyiWw9mI?=
 =?us-ascii?Q?GxykHz0/q/tNdXgAm8zHAOUbyduFG5yIMpQrgc8NGUcIlXEKTIJbNzh2jfL7?=
 =?us-ascii?Q?AfbWYs41vfkM6LXnq6kA6EmmbH7epaV8l6A2pTmVY/30eQSws5wdxK5Wrm5a?=
 =?us-ascii?Q?USpfD+ZHzszw17qiz2SpDWj+FN7mBU3jVmcOl+x6pavZ705dpz6k/H/Oy118?=
 =?us-ascii?Q?cO9kiE6szHkbIdcW0jfkel8bT+iWlb2wVBnf4fTm0oLuwhAyQ469NsxIAmQu?=
 =?us-ascii?Q?zuy9gjenoYKX9oaKB2VS6sDWldYOI4KldccxuAf+uy/TSEA2yvfhPLEPPiQA?=
 =?us-ascii?Q?XMaSM5AvsRXm8w3wGlAp9Noz0JUEJvoBc5XdxSgyelYZbjIzkkwgunxdCO7A?=
 =?us-ascii?Q?BoYCvkx/YyE5rSq/5AMwN8Rq9Up/OnUb91Yqrkdl9+UMHw6NaUoDjHd7xDj1?=
 =?us-ascii?Q?rxAocg4YRVu0ZzNHKwRurRWS+/WYA2NX6Cb2/qr7cSITuyZJSn0WXbYOWce1?=
 =?us-ascii?Q?BX4tKfrcJmkA1fXzNnpKMGIhjcbGlQtQ6iLE+i0Z822yOzBHGCQjflml5ePV?=
 =?us-ascii?Q?L5KL1hZ4CA3UKgJUcbmKoGNUN6dJj7khxVmXQ45Q0OU19AU+Y3yJtSSjkkZS?=
 =?us-ascii?Q?S594Ih6XNrZStGE96bleEVaWkKN+cMppQlpAJa9mczJhYT45DHOJoWbZVGu7?=
 =?us-ascii?Q?m4GzU46aUaNtQulbYWvX6TcYb0b1sgtDTD0bRBXcNsPOYgS4XO16nvL7lO8Z?=
 =?us-ascii?Q?TSpluXzvDadaODcAjDNADNa47R9qPQZqcxVWRb9bGvAiCEv6yW0944dhmV6b?=
 =?us-ascii?Q?hD9HPJ6tsEyygihZ+7oOvGmXAtc6dZCoiqCmB4cm42z2hcwaA5T1vl8KTkCd?=
 =?us-ascii?Q?wtpypuOYrX+iFvp/vpGvx6f9m136iKB24Qj5GLI8Mn5BlyV9sR2FCx+F/0ka?=
 =?us-ascii?Q?FKErkqVqpHamtKgTXtW2M8betqN74TakWnWK7003oBfjjHlNDxNzdKPVFX49?=
 =?us-ascii?Q?nogqB9cOq2KA1JxSssYS/dow7PYzGWxZx7a0H+h+gp2+rKjVCtr+aqzh8iMs?=
 =?us-ascii?Q?WHXidhWwXGBVzfJavC5DeI9yG1BYTb7ne0lLQBHVFI2l4lVhB/JKQXkdL615?=
 =?us-ascii?Q?33A7P51mj/trd/w9AeePa4Wn8AkDQjQRNTNwtHBMT2H/f25FdI99I/NTYnz+?=
 =?us-ascii?Q?NIDYfY8KxMpINhTcBqYFXZb74gu3wA4zNnRBF4/BSj9y7OLk1xZWuC4UTR4P?=
 =?us-ascii?Q?fUG380ICeWaHFmROHt8XurQtNFxpIA47nUoYaMsfECVh5oj5QK7xpY8Kr0dR?=
 =?us-ascii?Q?o6EuVyTHVWuqKvPEhOxeWVWg/Y+PKaSaQWgr2vR304yF0a8u+urGsQCbuUc0?=
 =?us-ascii?Q?smiLGaPzaWCQ+OHzHudWHYVQ/fuVSc6CCxSB+o48?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dnB18KRWlBSqSDqR87BShtyXmQDHEormsKLO8nLJs9iC4SXm7GfL4IGWEYaD?=
 =?us-ascii?Q?0lw4FqWIVGqBTHLZqjpU+ky53R8EH/Yr4kIjz9Okt7mA31TSy+XrXWzxZknC?=
 =?us-ascii?Q?GHRqyXwQLrhcdOw8GLNeJ6NIInYY5vMDIyoHgO9w/5NMMhXiWO6N0xDe7xv9?=
 =?us-ascii?Q?2IZlcjNcb/tV93NddsWNloT52cNThdQUrd5WrNnmhvUBoWGuKKrbBWvPdzoI?=
 =?us-ascii?Q?cuib0razpUf7sy/8RqfTtSe6QvPscuLSYGJJwY2DlK05sQzi8QtWfZdNVDYd?=
 =?us-ascii?Q?8yoM3rA7G3AeNxJtb2RlVPmo6u4MoWAxxriEC0cUftWzGKiUlmrED5Sz9pmT?=
 =?us-ascii?Q?brcZ8pDi097Uk4myuhbJzEO8VuHOfLjKU9unudwqhtCs1vk/F8C2gkb/uYyR?=
 =?us-ascii?Q?iQPjQbFbnTFtqKRTEiY5tkzG/Y50sCNo8nTdiUT8IRof42ARhPPIsZXh7MD1?=
 =?us-ascii?Q?oJ99QpM9LpO7Nz7KyKOOafNiqlCvc+GybS7DXYXUq6fjc4YpU4Z0xEfoQzmb?=
 =?us-ascii?Q?Knu9LIcUhtg79nVlaYBDkBX3tiIZFugTeqkjtKsJEg++XbSHUn+tlKgwjW2u?=
 =?us-ascii?Q?HNQG0lJYW7sYE3dKcQ1egdosnkvM4rQ8lz7S68GrAzFR5WNhoDQxwJzfHaxT?=
 =?us-ascii?Q?oHZB3DNYaJpnpa+eEDj0i6gkBPmpBLszRMrR4UgRV6bnAw9vD1BmG39nf768?=
 =?us-ascii?Q?fDwgueTdfuWKc0M7enYiQsiBl1qLFkF3oyJuQ9XkCoJDgaGdo/dh77wMRwLK?=
 =?us-ascii?Q?9aEQMw/uZD2nrEIX0OIDUdVXV4gOpfe/XLx2Si8UM5f1/PqD8xp3WXHOWOLB?=
 =?us-ascii?Q?t6lVjBem2CSTsRC8QPFCm/B1ktSXX3frdwDcoNcDwHKitWPfaDM2hOdS9jvv?=
 =?us-ascii?Q?8VdSikIKDM3E4yUKJjFn1vArZ46e0KQarUnV/6nyEekMgNyK7JwkkNW4AdmM?=
 =?us-ascii?Q?Y/X47+cO6Ns8qaTcpHULkmDiO++zjcHYYUafzBpUpvH79cRRQo+Fe+Vj83IJ?=
 =?us-ascii?Q?29WlGYoIcAOTSeOj6hYd3ulczZF+1F9zZuy87awO/gHmS3wpertTh48Y6FyO?=
 =?us-ascii?Q?kBvbMlaY0m/BKOrPU6Da06ssx+q1+FgMyNXLiMv2/kp32w+Fs+oIbFkN3WpS?=
 =?us-ascii?Q?jCmDAzx8vQx3YQ2yjI7N6ugQy1mxrAlSZvdqt5w3qPHPZbbb+q5KSTmzyQVL?=
 =?us-ascii?Q?111kEvFdRz0UgEOw6NbnKMs0zqBz9dOy0hjIJYRrHA85dh/J//P0h1Vs0bC5?=
 =?us-ascii?Q?xKoxhzJ8Z+2v436y4u29lchvA39c8SdWPk3tlg5Shgda1TWChMfrCPzlCDuP?=
 =?us-ascii?Q?a3MZve+MFkTVVeTqFRrRf9wm9TYJ+FRA3y3CaHAZexqvuV6n6TVE4enW5UsP?=
 =?us-ascii?Q?q6l2iTcJbe8jc8RJj0zGlfXtd0bZclL/OXkLgrSDuNwWVnVzTq2jaCL0vZhW?=
 =?us-ascii?Q?KZG6HwS6+BPIUTxt3yh0P1WXxw1K6/fgJ9M15B6cQ7hZ+3UCviVla+DTfz7L?=
 =?us-ascii?Q?i0ravsBNXzF2k3aAsT3zr9aTumpvKHoWqOpNGT/df5NM5mw9C/J7YOFZy/TM?=
 =?us-ascii?Q?IUjO5Fn20k5gLLT9H5RhcqUvbfvDf0pIIzIPhs7NY2hCDTfKiVzpyrufErEU?=
 =?us-ascii?Q?/D/iNyli1iR8zHXKXV+Pfea7pZO2L74jbMcIK61iEhWOfBdJIKuv5s2Z4GoG?=
 =?us-ascii?Q?NlwFMVljWdTqEfuhpFlVd8FNxN7d9Z5sworJJ+NXIvcA6I15yFWdy0W44Nrr?=
 =?us-ascii?Q?wz058EgpIA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 330259d6-3f78-4208-fa8c-08de5e76eb3f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:10:00.0733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62HWKZ0CrCgLAFzI659v3BXZj9tKKzqVTJ2ulORS56MWjXvT+FV0ENfIiH+YodwvVyM2J+m9dDQ4CGguSF8T0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8920
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "sysfs:cannot_create_duplicate_filename" on:

commit: d000422a46aad32217cf1be747eb61d641baae2f ("tty: tty_port: add workqueue to flip TTY buffer")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 615aad0f61e0c7a898184a394dc895c610100d4f]

in testcase: boot

config: x86_64-randconfig-003-20260127
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202601282134.b947eae9-lkp@intel.com



[   90.273010][    T1] gpio_winbond: not an our chip
[   90.276100][    T1] ledtrig-cpu: registered to indicate activity on CPUs
[   90.315441][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[   90.322749][    T1] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[   90.330210][    T1] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[   90.348052][    T1] sysfs: cannot create duplicate filename '/devices/virtual/workqueue/ttyS-flip-wq'
[   90.352197][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.19.0-rc3-00049-gd000422a46aa #1 VOLUNTARY  96515dc2651f95070d1b72690dc313e8c588745e
[   90.352235][    T1] Call Trace:
[   90.352248][    T1]  <TASK>
[   90.352300][    T1]  __dump_stack (kbuild/src/consumer/lib/dump_stack.c:95)
[   90.352413][    T1]  dump_stack_lvl (kbuild/src/consumer/lib/dump_stack.c:123 (discriminator 1))
[   90.352430][    T1]  dump_stack (kbuild/src/consumer/lib/dump_stack.c:130)
[   90.352440][    T1]  sysfs_warn_dup (kbuild/src/consumer/fs/sysfs/dir.c:32)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260128/202601282134.b947eae9-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

