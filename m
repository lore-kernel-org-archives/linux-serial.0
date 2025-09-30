Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E3B224AEF;
	Tue, 30 Sep 2025 06:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759213896; cv=fail; b=DwTJR57L7hfXuHk/2/iK8uWs/p6PW1rCQYQurnuXTMhRaflkJhWK80ops8JgDHKCdoEuVTxpv37d6OEkZeI2z17a78/2x9NgL9s12c7d3zntm9E1hWNDkPNQLppTeH91f8CWozb+ntwfu4wTpgm31R6MBBNCk7yHWR2VjHJ3uj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759213896; c=relaxed/simple;
	bh=SqTbUgH9Ji13Bjkk1RwEpFMsI7ttVI04AdElSXjpyQ4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lR2YjazF9otbvvwx7KpmhvZJwYAUj2UO8WdlaaqyAC+f+mYtBbpV69+AGrOJbfE89oaUh532OaSZ63nTjCcNpyY8iwwflYV0WHXJAcvBft0eoqOs6OkPn+JMA64TL1eOrN7Z2/9lhxRlHc6Zt4H01De/f5xLoTyCeCjrGfaaxSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=anIjt2zL; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="anIjt2zL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759213894; x=1790749894;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=SqTbUgH9Ji13Bjkk1RwEpFMsI7ttVI04AdElSXjpyQ4=;
  b=anIjt2zLEKLegpbfCdI4vYk/gOSLMm1IvUfHHb2v8hhXENCtmnC0hv35
   OaG9U1+l8Z/Y8QzMA7Xz6fkfk7/htFQUiTl/z5dyGKkRXyYbSU0w20c8y
   cRa/2Iv+M40UdWwlfQRDgajKZlrROYhV74Mm9RDoZES4IotPu0C22jhjR
   2pzpzYvflgXJtpldwmXaI3fwu9uRsJJsbWAQrEKTuSRn4TwiZ2AJ9oCkO
   jbFh5GQu80yw5IfVS0ruONXhXxwOwL3mNrgmJS2kfQA1p3Uev4OftNazU
   N5BxnA8A5PnDEzT7IP53+lR6luIuT4h4c/+NPTI0EzeDN0a39JFVa7M+4
   g==;
X-CSE-ConnectionGUID: NcdRvWavRQu6RVk+F5mfXQ==
X-CSE-MsgGUID: l3a0HurOSFSVBU1S9ua9aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="84078096"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="84078096"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 23:31:33 -0700
X-CSE-ConnectionGUID: J4Zw0ocIQ86eGAMtBUszbg==
X-CSE-MsgGUID: 2xwNIPAAQhCoqW7pegGyKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="178234787"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 23:31:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 23:31:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 23:31:32 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 23:31:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIzfExBuGE3CrbTxvbIxf9ZmK7CGRMiSAsS/VXpbITbDyhBnuV9QhLAPlhpmeW1U7Pbse7QkwfqickZuIrKv/XYHAAa2UeQbO1Hb+vzz99H1M6aAXIn2aU9A/Gr1OPrBo5n+7Y6hAWaT7yLl4buhSgyj4jjqRCovMmOA3zOmmQOamRRCQS9/QVEjjO5yXU0qpdRNzTNMrMbw1xXv+KGlCUnKxB8O6DVFglWC6p8HzWVDz8Fxlb6R6HF5itKhkeMAbxPkZiuoc4Mqbu7Pfxwskw4IIKfyZJnNUq18l8pnhY9HrpjXIjLGwB8p8VCMdg4NX4X7W9NmYWr01sUItRZGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOm1Cc3UOpJ3MWlwcwvYacCRt213IGmxphyf6EH7nAY=;
 b=AQhFUQDM5TsjD1BS+AfbqbBPppQvWIu1uMwNCKkfgk4ORWDPlkVHiP6acM0bxBvdrzkMoWQJDg7426COiEeeZTwmHLjcIE+J0R/vd7A7BOeprc6nGvOS30LONCiIUMwG64FrfvoxacAYuhiGP5T6U67ZTnxklj0+Pu+KjhUXB0JSqKQsY8GSlf0ntCnc/+/SLJY9oSvOccKeFVScUakNyUzo4/Xdkujf5kTS20jMUCfrO3ZMlqslNWSSZvZlmdOy5ljW5IyCRezL2hbmDHWKdPtfVvlUHp0zMjGTXPR2rhIK5ry2c7DlwSJQS1SA/0JW+N3qND5xVaKSpw82N6mZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB5127.namprd11.prod.outlook.com (2603:10b6:510:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Tue, 30 Sep
 2025 06:31:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 06:31:30 +0000
Date: Tue, 30 Sep 2025 14:31:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: pengyu <pengyu@kylinos.cn>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <legion@kernel.org>, <mingo@kernel.org>,
	<myrrhperiwinkle@qtmlabs.xyz>, <tglx@linutronix.de>,
	<dmitry.torokhov@gmail.com>, <changlianzhi@uniontech.com>, pengyu
	<pengyu@kylinos.cn>, <syzbot+79c403850e6816dc39cf@syzkaller.appspotmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] tty/vt: Fix possible deadlock in input_inject_event
Message-ID: <202509301323.34d956e1-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250928130819.383808-1-pengyu@kylinos.cn>
X-ClientProxiedBy: TP0P295CA0039.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::8)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB5127:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f21c211-81f3-4fc5-9630-08ddffeafd8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?67i8eXGStKBauysEbkSkSsJhIa/mofZOH9ckwR7O0gZm1SnpIIN4i+rNXCym?=
 =?us-ascii?Q?vdfldZA+64fWQRjt/0HAJQuTL4rDdK5hXzeWLDHgEVaOGgsaJw/2sOIT91OD?=
 =?us-ascii?Q?EnblecihXsEXsXDbivi1I7d9aJ6KM8Cr4Dc2F2q9qWoy+rwFRg8glp+JKkIL?=
 =?us-ascii?Q?0SE3wFm5JDgj7GfJoJiwTFtI3rGi0upF2slZ9NtmtagKknN0cdQr+nKDvk58?=
 =?us-ascii?Q?q1WRq9mZ+VlJdaXS6NaBC1LYUE0hvWZqkyNl9eAX5FY7p2bqqkfvm9H5VzZk?=
 =?us-ascii?Q?urzdzTm2IyM0n9UV5iKj2+eQe5eGqQZJVr7Sjyf71ix+KJ12Omc7NjEF78y6?=
 =?us-ascii?Q?Ce8xN7WleNQXOxE1pOJvfMhrvJB0L77vrQ5g9ky52UHO2APSm9xBB2QhtK/o?=
 =?us-ascii?Q?cTNYYGg0UvIY8vGSb9tvDKimzlvhaJkgZtRyJkoC1Tkt0D9p6h9+//ya3ab9?=
 =?us-ascii?Q?0xvqCdYKTo62UfQgJ1LOvS8knT5moN/8KOe43F2HwO0FwvUdLW3u0AsB+nPO?=
 =?us-ascii?Q?/nv/vJ+4mFxQ9NQvt4XoihkW+3Y3rny/KCV/6sITuIHC03mHmvQMugp8alV3?=
 =?us-ascii?Q?DRZ+gd2IqWQt4uzn5we7QpcTSOHNTZw+Rhz8it2JPOY94K+pEy2YcfcH13GX?=
 =?us-ascii?Q?BWz40x1+cXK9MSppSrLdJTHnT6rJ50mZupChYyj7QUrY6gmzYsHtcmYr1ms2?=
 =?us-ascii?Q?WmiLqSlqiVCNzArHSkLQ5qs0qpLqIziiu6NhAGF3kSQyj5ktKiUNYG9y2AAT?=
 =?us-ascii?Q?yKvZHFiGDaMSZ5n8H4F6TEGacyG1+4epH4HONPKPfeE/L8KO9ZU1kh4TETy1?=
 =?us-ascii?Q?VV+t4vS9MIZ+MO1AOWBPNSEg2QpmXkiN5eXpMAacdSYPcAuDIJXwRYiS0LaV?=
 =?us-ascii?Q?N0eArHNjlp8vr7KPvluOogiMViWrOlIHpPwOo0VBR/4KMo2VhpTjdZ5MqtRq?=
 =?us-ascii?Q?5XBHMKbP18w1RctPPuyRCbaRie4i0kS9aQpcla+vgMsX7AY6VilnluSMxBzg?=
 =?us-ascii?Q?QKb92nPSmqfiSVu9uuuTdLk/DBc5bkKye0Y7ZIySTKrzvCSt98hazephj2vL?=
 =?us-ascii?Q?CeSvEKO++h9fi9+oB++DlJEe4DkA/qZ+RSO0Ow7lygKyjQy/5ZKSzawwKGXo?=
 =?us-ascii?Q?y6h2Upsb88maoWwHZv/7iZ4xJGnoK9CaZEURi5AieBJBkkM5FCPxcMMLkmYh?=
 =?us-ascii?Q?6S0oqiJA2C1kv9se7efwJRwG8h1dVAvIu6+TCk58IcR1L38qY/HaWN3NnSKf?=
 =?us-ascii?Q?8BlegdIG3gz7Mv/ekgaXH59QNIP/Rh2XTmUdbI6iE052zcDEYGW1Ydargv15?=
 =?us-ascii?Q?psxvo5nJljzV/KhDu21ukUYsZPO7IFYqdtljyUAsJwakt2Shxvk1QbZeL4Yc?=
 =?us-ascii?Q?mlvPDamgRZ9LYEcCOeqnhOiba7MAhDQLG2hFGkIx5rpDFnncSYVsv9I88qbj?=
 =?us-ascii?Q?s5rAS4bqDHM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7vxeZJUf/m6ls0itVjtvhlyhLDAEVAFcC3lWBGnQny7cZlAFl0iXq7/KELYS?=
 =?us-ascii?Q?Gkkfhah5wkQJ47m/L9Rd6CjyiT8Qp9Ue7Ely/Ng0VAuZNxrscaVwX6T816G1?=
 =?us-ascii?Q?9Kbm1UiSQ2x7LEGk8VirvldNb3OzCuWDr3phiFKJMxF1A6cxhrvCqfLIT/ZO?=
 =?us-ascii?Q?gHpJ/9mKWLYla6uQmsAyXNJnZ0l3B+/91YYhP+Kdq3+xsDVjlnejIPXs07Yz?=
 =?us-ascii?Q?qZNkUl/2NQydYRFi7GB1PicOvwdGqnbxvxg99A1zgMDY193gwC3a7XrNKnk2?=
 =?us-ascii?Q?Xq+Jrm1nzNy74C7gL3HxyDT6LhTZBOEqmS7OtQ4C9UXqtKbsdkKQ1KszcYAy?=
 =?us-ascii?Q?D3p5wy+HQyN5PKeLI2tdMXBXariHBPDEuut0t9hi1oA0vqsWfrbj/20auqM2?=
 =?us-ascii?Q?acbkKq8Ta7xrVllUYEiXeyF0i/BcIrLdybiAaCYNiZu5hoy9REiYJ7uJxWnx?=
 =?us-ascii?Q?g50CQTEs+V5NGJkCPtbxVsLdk5/S672pdX8nass6lJvqhV8YWgZIc5wppzlK?=
 =?us-ascii?Q?kOQVBzxdV+r2JhLWfNYPGtqlsjnfVi0EPmHsYFS8v8cvmjlyQU1BW7rQUMUd?=
 =?us-ascii?Q?n7TT+uDGe1AeoD+IidHnD20YWq20tOE9eAMMRzfx9PZ06NHPxTH+h5qSlXCS?=
 =?us-ascii?Q?lAzD2sZVgj14+/76hC2SiaJxHQazsd4XHkDyuqHS/r0rAXlK7AGHkGmnFe48?=
 =?us-ascii?Q?X6lOpe9KvXRTsQW/SLHqoSbzAVDDq9clRrIT9+aMW52XVdk4UKK/aTE49wdO?=
 =?us-ascii?Q?VVvt5C7Q5M6UXUtVuJvIPeHBsW9EjRmqrZnudX5cACjxOAyfNiva3RIJNJc5?=
 =?us-ascii?Q?qyze01YoU6BSdU1OEGwXkruZwIGsWHwLyDEv60hieaLadh1QAt6H/CzgKh20?=
 =?us-ascii?Q?h0KahnhPFdSwIPfx93iYYKmVSbgTE7Ci/hOC06hBHPNNM7aRPRaXD15DC/xD?=
 =?us-ascii?Q?AAKdNJ6yPzzNZUeCRvr0gGu2jwvuT97lUaeTvbfTccqEJVOROW1xPDDmcqUN?=
 =?us-ascii?Q?Tphvv8eGi8CdZEoylwmuqFDlXyn2D0uEy873aT4zCrdibKQbO4Radd8JfB6k?=
 =?us-ascii?Q?ZZUXlhrdnVbZUgY48rsYymwfgu8e3je63bE0mOtKlXoFPpWeimdUvpFyJ34u?=
 =?us-ascii?Q?Df64L4op09Xxp9cIf7oH7bznUd2mi4FagprULL+oN34hhFCXHDn3XoqpYRNz?=
 =?us-ascii?Q?N9hV+Wsw3IwsEyonqdhstkMjWo4e9tT3CPGAPdudBGfd2yczEpSKhiFoJPt3?=
 =?us-ascii?Q?Q3+fI+5B28UoP0eIfTNBoAnYXhEEDSyRDaPU4iPxLhIAZj5ZusB079nJGuB7?=
 =?us-ascii?Q?Sz7mpa3RVOp21pcfDy7k1jDP1jHcbEDHH62R0AplGXbUwHhrJoZueBdaFDgJ?=
 =?us-ascii?Q?BzRtT4xPpGoNJhr7o/C8rfBmOOf9UTdNNGaJ8TMWgd3hcjHuKy2PCRPGsBVm?=
 =?us-ascii?Q?+y4S9fVsfv8iAOOjw8okVQj57U2zolKYVQWPm4aYTy9EmpygqKlUHQVzajI0?=
 =?us-ascii?Q?VY57/E71AbN16mfBk6VkgyKldQQ1VnDGn7AadDMsG/u0EXdYM2ibYUNrSSiR?=
 =?us-ascii?Q?5kdCA2ssS8UrKwfhkwPIoCwISyneZXQJ+PRUH7fLD7obDiQscZ8qwoamEOL5?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f21c211-81f3-4fc5-9630-08ddffeafd8e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 06:31:30.1913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hSLlXx25pnz4FdRmSChdoNkG8QIYzvgKxU3rgoI8x6oltE+ecRKld46o1FKp3Lk1kDv5tvNsSPyrN9iw7MQZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5127
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/workqueue.c:#enable_work" on:

commit: 81d246ffd402b46338d8a3e0cd23f474195dd236 ("[PATCH] tty/vt: Fix possible deadlock in input_inject_event")
url: https://github.com/intel-lab-lkp/linux/commits/pengyu/tty-vt-Fix-possible-deadlock-in-input_inject_event/20250928-211353
base: https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git tty-testing
patch link: https://lore.kernel.org/all/20250928130819.383808-1-pengyu@kylinos.cn/
patch subject: [PATCH] tty/vt: Fix possible deadlock in input_inject_event

in testcase: boot

config: x86_64-kexec
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------+------------+------------+
|                                            | f4abab3508 | 81d246ffd4 |
+--------------------------------------------+------------+------------+
| WARNING:at_kernel/workqueue.c:#enable_work | 0          | 12         |
| RIP:enable_work                            | 0          | 12         |
+--------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509301323.34d956e1-lkp@intel.com


[    0.877354][    T1] ------------[ cut here ]------------
[    0.878411][    T1] workqueue: work disable count underflowed
[ 0.879704][ T1] WARNING: CPU: 0 PID: 1 at kernel/workqueue.c:4326 enable_work (kernel/workqueue.c:4326) 
[    0.881213][    T1] Modules linked in:
[    0.881232][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.17.0-rc6-00045-g81d246ffd402 #1 PREEMPT(voluntary)
[    0.881232][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[ 0.881232][ T1] RIP: 0010:enable_work (kernel/workqueue.c:4326) 
[ 0.881232][ T1] Code: 5e 5d e9 0c c1 ec 00 cc 0f 0b eb 9b 31 ed 80 3d 1e e8 c6 01 00 75 a0 c6 05 15 e8 c6 01 01 48 c7 c7 cd bf 6d 82 e8 89 26 f3 ff <0f> 0b eb 89 0f 0b eb 93 e8 cc c7 eb 00 66 66 66 2e 0f 1f 84 00 00
All code
========
   0:	5e                   	pop    %rsi
   1:	5d                   	pop    %rbp
   2:	e9 0c c1 ec 00       	jmp    0xecc113
   7:	cc                   	int3
   8:	0f 0b                	ud2
   a:	eb 9b                	jmp    0xffffffffffffffa7
   c:	31 ed                	xor    %ebp,%ebp
   e:	80 3d 1e e8 c6 01 00 	cmpb   $0x0,0x1c6e81e(%rip)        # 0x1c6e833
  15:	75 a0                	jne    0xffffffffffffffb7
  17:	c6 05 15 e8 c6 01 01 	movb   $0x1,0x1c6e815(%rip)        # 0x1c6e833
  1e:	48 c7 c7 cd bf 6d 82 	mov    $0xffffffff826dbfcd,%rdi
  25:	e8 89 26 f3 ff       	call   0xfffffffffff326b3
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	eb 89                	jmp    0xffffffffffffffb7
  2e:	0f 0b                	ud2
  30:	eb 93                	jmp    0xffffffffffffffc5
  32:	e8 cc c7 eb 00       	call   0xebc803
  37:	66                   	data16
  38:	66                   	data16
  39:	66                   	data16
  3a:	2e                   	cs
  3b:	0f                   	.byte 0xf
  3c:	1f                   	(bad)
  3d:	84 00                	test   %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	eb 89                	jmp    0xffffffffffffff8d
   4:	0f 0b                	ud2
   6:	eb 93                	jmp    0xffffffffffffff9b
   8:	e8 cc c7 eb 00       	call   0xebc7d9
   d:	66                   	data16
   e:	66                   	data16
   f:	66                   	data16
  10:	2e                   	cs
  11:	0f                   	.byte 0xf
  12:	1f                   	(bad)
  13:	84 00                	test   %al,(%rax)
	...
[    0.881232][    T1] RSP: 0000:ffffc90000013b28 EFLAGS: 00010046
[    0.881232][    T1] RAX: 63593ad70bfd2600 RBX: ffffffff82ead988 RCX: 63593ad70bfd2601
[    0.881232][    T1] RDX: ffffc90000013918 RSI: 00000000ffff7fff RDI: 0000000000000001
[    0.881232][    T1] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffc90000013910
[    0.881232][    T1] R10: 00000000ffff7fff R11: 0000000000000001 R12: 0000000000000000
[    0.881232][    T1] R13: 0000000000000000 R14: 000fffffffe00001 R15: 0000000000000000
[    0.881232][    T1] FS:  0000000000000000(0000) GS:ffff8884ac411000(0000) knlGS:0000000000000000
[    0.881232][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.881232][    T1] CR2: ffff88843ffff000 CR3: 0000000002a30000 CR4: 00000000000406f0
[    0.881232][    T1] Call Trace:
[    0.881232][    T1]  <TASK>
[ 0.881232][ T1] kbd_init (include/linux/workqueue.h:730 drivers/tty/vt/keyboard.c:1666) 
[ 0.881232][ T1] vty_init (drivers/tty/vt/vt.c:3884) 
[ 0.881232][ T1] tty_init (drivers/tty/tty_io.c:3651) 
[ 0.881232][ T1] ? __pfx_chr_dev_init (drivers/char/mem.c:734) 
[ 0.881232][ T1] do_one_initcall (init/main.c:1269) 
[ 0.881232][ T1] ? __alloc_frozen_pages_noprof (mm/page_alloc.c:5148) 
[ 0.881232][ T1] ? alloc_pages_mpol (mm/mempolicy.c:2416) 
[ 0.881232][ T1] ? new_slab (mm/slub.c:560 mm/slub.c:2698 mm/slub.c:2714) 
[ 0.881232][ T1] ? __proc_create (fs/proc/generic.c:453) 
[ 0.881232][ T1] ? ida_alloc_range (include/linux/xarray.h:1437 lib/idr.c:461) 
[ 0.881232][ T1] ? parameq (kernel/params.c:90 kernel/params.c:99) 
[ 0.881232][ T1] ? __pfx_ignore_unknown_bootoption (init/main.c:1315) 
[ 0.881232][ T1] ? parse_args (kernel/params.c:153 kernel/params.c:186) 
[ 0.881232][ T1] do_initcall_level (init/main.c:1330) 
[ 0.881232][ T1] do_initcalls (init/main.c:1344) 
[ 0.881232][ T1] kernel_init_freeable (init/main.c:1583) 
[ 0.881232][ T1] ? __pfx_kernel_init (init/main.c:1461) 
[ 0.881232][ T1] kernel_init (init/main.c:1471) 
[ 0.881232][ T1] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 0.881232][ T1] ? __pfx_kernel_init (init/main.c:1461) 
[ 0.881232][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:258) 
[    0.881232][    T1]  </TASK>
[    0.881232][    T1] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250930/202509301323.34d956e1-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

