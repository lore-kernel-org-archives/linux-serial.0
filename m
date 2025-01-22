Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606A97B3E1
	for <linux-serial@vger.kernel.org>; Wed, 22 Jan 2025 02:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737512947; cv=fail; b=FDXyaquxzV7P2rBsAvba75/JOkKwqR6yn9+dRYy7xc0nxeHMmnJCnfJos1KKqBn5UN30sj87S6Hofy+8GRWScZa5W7ZNB7zk5S5V2RgBwGWCXK6j28aOQFZIwhpSBa6rA1/mmr7AvMukgfEs3n99X4qqCAIeZrokYgsQsc7jy/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737512947; c=relaxed/simple;
	bh=5ZtQtxZAuz0e+22ZhH0xxT1zahZ7RlfDUgL2jS5HRHk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=L0K8MVCio0w8aQkFPGFrHBcrbmp+zvdNNC9gcJ9n+vnd/3Ev1xfEIrULEoxbZZa4gdzgq97GaBl62BbaDEB2W+44Ssn1rBMPRL/H4WXw/nTsJUAnqzqQ2Rp/kN7yn9cktypQRTiOEMxfDR7dQEquo2CgL18OgzCs/JOuUrAToro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HAZUodY1; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HAZUodY1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737512945; x=1769048945;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5ZtQtxZAuz0e+22ZhH0xxT1zahZ7RlfDUgL2jS5HRHk=;
  b=HAZUodY1ICyYDPP+qo6/PBStfsSMFum4RHVIKdNv3+XeWGKcEFaa6M7w
   dyuKhv/YF+RDIeTFObqDBRWx0odoIWgnMs7i0IpGEn+5A2SxmY3LS7aXG
   CmGR45NudfTgt/IEo9WhUtRVNOTwXQYCTM1SQa2OU5+ySwF9ZJPrxV7SA
   fOBuJNBJsTM9Z6JEukmEsKd2BQj2PIntEdc4OM8BbXCNmQsMZWXP3tYYF
   FVRLQDS/z9HrHoB6Esesd5qkHLZoOTXEDCHSXbqCCsWbeQy6mWAbRUtGe
   J+70LspoabPwT1hV+cEYHcCTPpu2uoP5+3u22zqMJqvCM/WtF+sKqfMJu
   g==;
X-CSE-ConnectionGUID: 9Zi/nG6zS2KPG0iLpcSYZw==
X-CSE-MsgGUID: lF4JSqd3TJey16a3yPdTSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="41628711"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="41628711"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 18:29:05 -0800
X-CSE-ConnectionGUID: YdUzfNy2RKSw6OP1WBZNYQ==
X-CSE-MsgGUID: 2thpyStwQ/ShG7XYNFhX+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="106908126"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jan 2025 18:29:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 18:29:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 18:29:03 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 18:29:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnNaMpxYq4dxa3ZhcpttmlWaASFFIDflqWs0Ay/bup4dpHws5JHXvUz80ZnfEuAlSqBxW2xZ+U/lY9jOY4rJHybmmUVEQT7A0WHFWUC5AphTRxgjSvM0pBkWwsE6vjblIEBF+ULVLQz5O3DNwYuMNyY4La2HQou7YgsR8OR/tmRREaYkJlrB0pWQ8h1+wF445bBcWnoj23Dl/FnRNnAfSMXLgOuqR/gWNm520yMe1YkIjdBKiuKXd5f9y4iBs43fDmKBjRhX3yD1Z0uDPQVAkKDyM+j+K6FATMXUFKYcd5j9Ev9WeFEx31SORmKEGDtdWDDVDw7YKCfpLiPjMCxdKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1zDvhhLQKpgbugZR+AWUTsYguVRJSx7hAw4wAvvCZ8=;
 b=dbyyrkVY//JdiDFL1s/O5Wgarpr1P0mgQh8oEzLzg7Q7+jX1p1sIbZd8achCMMJCI2nGFtgAQ1wMFlbpgn5zlqtBFHPMokf4gwIuJV1NwgR84M2yRSNJymEAz/8lwi3jxUcpLvK8k513WIfOY8pyxTnfCz6qO1iutnc09YFMOZGVRICHW1OTpjXj1DvM7T/7Lbe+Yh6DaKUDdmhksydEWC3k5/Fb1DoHC45Pe8zrwGXmqRXj28hcbQLSDmi2cbj+Yu6nzjkMBVrx5U3WWO0L00qSl3HAMa2FyawpO35zmoWHvg/FwGMOVGue+XG18VZ0A0Lcanaw9ATdbISdEIfnUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV2PR11MB6023.namprd11.prod.outlook.com (2603:10b6:408:17b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 02:29:01 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 02:29:01 +0000
Date: Wed, 22 Jan 2025 10:28:52 +0800
From: kernel test robot <oliver.sang@intel.com>
To: John Ogness <john.ogness@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>,
	<linux-serial@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [serial]  b63e6f60ea:
 BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]
Message-ID: <202501221029.fb0d574d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV2PR11MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df10ba6-b08b-4d2d-8f1d-08dd3a8c8844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IDExScpHYJXhcmOHa49C/S5+UBsqeO9U0wCqWSQtXxMq8gx8JQ6gi1DiTObw?=
 =?us-ascii?Q?9ATr4lKIIyxQtQTFH5SCn+4nICnAI83cGlnWCV7KnCgrtjApeesMcJprsvd6?=
 =?us-ascii?Q?/Xej5POXteQZAazabJhr7MdOHffuOViLvc441t0AXa1r6FboojBIO6YlJAdc?=
 =?us-ascii?Q?xX+f6MRmgbu83V0Igs+PmMVAypFPb1ItDuc7QsgnAA/wXnlF1YMuqK1erCqC?=
 =?us-ascii?Q?a2Y73pXl0lIYNH4KoMOogoLDESdsIcQWZ67BrjzuwB3n2lqyNL06jbceJlBC?=
 =?us-ascii?Q?baWAAF6LSWMZ7brw+UVH8DxNPzkIu4ya5P3xfFlQCNRy38zVm4hi+UmhBJuq?=
 =?us-ascii?Q?LOiGrGMBj5cV/3pSZvKKfuLqQcoaIbH3tPJ8BXJKpoBA8/9I5GZhsQrUCyUs?=
 =?us-ascii?Q?07bxhrAwbihLqn5TZNDPyVD/257tJtO1Lg52DgXGcrUBU5lYcwq0xTiQKLL5?=
 =?us-ascii?Q?D7etm85wbVrwvXInG9JcMzSqDDB+aOHYyKFaqXORHq61xTitvV9ylv647HC5?=
 =?us-ascii?Q?GYhmuEqjFuHrBirLh/AJl91huxv9wHep0chtCqKsDmSSjMWGJW3OlpQ+yjr/?=
 =?us-ascii?Q?DML2rZnjDBp5yN8UyciD2GMzOKM06sJOic2ypD20mAMRXiz7GKbSyZRtNqnn?=
 =?us-ascii?Q?LQ4el81oJoqSsj/hdN8K9cmoSH/vksOhXLTbw/dIsyogtqyYVdZaqlxEeVxI?=
 =?us-ascii?Q?k2tAvIuo3STM8mMtpmq03mbiV8NEaJZzS1/xqkI9+SaiUqzCHeJkoKvkUEgH?=
 =?us-ascii?Q?uDy0fmi9xury5pV97jYBa3MraRvM3oYoEXYZ7MnymL0qgdl/5tlw1Sl07Z0V?=
 =?us-ascii?Q?Nlr1scysu8fkfjTmnqaSkGU2MnrX+J9uj/kWQ2ZGuCjj5bkxyxWHLuQXPvTh?=
 =?us-ascii?Q?QDdrFU6JU5qMBOfrCzn0FRsFE6r/ho8e7bu8l8XVipPwiXVW1pGi9XLM+jKW?=
 =?us-ascii?Q?VL+pwoex5yZ0LEzaW9q6dYoUqZOwwxBAOx3457PiSIZxDwf5a8s4kys7KPIy?=
 =?us-ascii?Q?g060fdPRmf/3VQkpY7OyKSxoDX+4QMT4SYMXQfrT1g72vvL4oUjzZuKROX9M?=
 =?us-ascii?Q?wkztaaIqwSSGeUXjsTC9AGQiu5Z/NmzpJVkfOxC8objWV6XgT9sczC50q2h/?=
 =?us-ascii?Q?aSUAXfLCEtLRGx1y2tPGFVhHM83dgH3Y/FhkjAXxTZnnr3trQEKHVU9J+pY7?=
 =?us-ascii?Q?inQHQJOhRbFAIZDoLO6n9g8M8V8Go3rkDxBdwUvMXA2uVHrFGskCEE37ygno?=
 =?us-ascii?Q?Q5Pdclj4XmVLpSyNfflePImELRXgyKADUXj2FG/9rQt7Msvj9WV4jw2clSf8?=
 =?us-ascii?Q?nlnIbhKBaA7PRovX5e3insHDw9HLLDGp/Qi4yp+WSPMVMA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eYrMvp2FX5SwPYr3LGnOr5I/l+dI5/MZ07WtliDEZ7MuRCjCdvQ2kHG2Q88c?=
 =?us-ascii?Q?IYqZo7wiaNge77l8npXVuqrf/OaPZquWLP6WcflucCMP/15MGM6JQ0DIdPdS?=
 =?us-ascii?Q?I2e6Sp9k0+jUnqKWlTlWiZy73oEgGW2xieX4pZSY57hK6SVdW+UTJe+SFmKx?=
 =?us-ascii?Q?Lpsa9mKFgwTrG9vpcEKePYtdiD8HWtr+sQqUQu0r00VSBZRCKgMa4GEc9bWM?=
 =?us-ascii?Q?TdXkbfjprRR9zcraxXXYKXrfcOBjOkkdnr9tPQffLlXVcQXDcID04OU75hqx?=
 =?us-ascii?Q?uHPAvZ+XmNRHrs5VtaGeVgzHmeuLx+ksOPNtSEqF41r/E7l+w0cDkmhuRs7w?=
 =?us-ascii?Q?yaYuxgvjjfi/5D3lQKjIC+pPha+7dbPcJhn12xF5YMyi0kaXHI/TAN6xFC8b?=
 =?us-ascii?Q?7+wYGIZiOIKK9TDAe9m7catfMF5y6TlmRXmlZVEbRQlqkLZP3U9KpbCiTatj?=
 =?us-ascii?Q?YU8pG3o1JeIjB9WI9thGC84epx2evV2xyggsOcNP3Buz6714oYVpl0XHLPxs?=
 =?us-ascii?Q?aFiNAVv0AfaSShWCbP0ReGDGEltEmo7dk1+w/h5RQ1jr+CwAkMLhOO8QuDvn?=
 =?us-ascii?Q?BlQex+6zsup3H+Q4RPZ++mwOUo9CcQ0VLzm/UPvVHIQPrSu5Eh8LvHZKXW0h?=
 =?us-ascii?Q?hewA2iioRt6iQsnUrZqGniVeD2OmxJUt79w3ARfF9RB0RKkTqtHgRtfKN3Xa?=
 =?us-ascii?Q?ulBX3ELibCN4cWhSN/h6U0XkKMsvUm98RVhAIwbfii+JG21CvxXBL4wmdJlv?=
 =?us-ascii?Q?zH/gaHkl8QII9yxg+LZt9F0QACqbH6rcMAX2t/tOljM4KBXAu+j++2RLvxoU?=
 =?us-ascii?Q?qm7CCkGw/bPK1kAl0LhzjU0wXWnTg3LGMA8OUZyrLGS/0eqlEQheDJ3X90eB?=
 =?us-ascii?Q?4trzxLUnxdnHetSxw9s0SBFkzOxc2r6H8tSsPXq0O+aqhNYbOSiwPOUqywUs?=
 =?us-ascii?Q?OA5ZAWjUVjDWCCVWHytc0RSfcJTkvsnCb4QFZNtHFW0JsrNM2trIj2HVyib7?=
 =?us-ascii?Q?+BCADEiu2sJEONgy23SbbAuc9J38FQP4WHCD+rbbWlHohJetjEeYlvysjan4?=
 =?us-ascii?Q?BK2J15L5wWZ4oGnRn36x+I8aWS8VfhsnSUkS5iAoX4tLv/8KLQbAFwCGIafs?=
 =?us-ascii?Q?UUFHesQtU/4Xv1CkNc2n4xDjV0q24DDheIjqgIFH0tCXNkXwqh0pgO431E7S?=
 =?us-ascii?Q?ApAq7qLshCceTbpg/zYvhAqJMusGxZVDFyHllPIS7ZopmcQIWdPubroS5Fhr?=
 =?us-ascii?Q?IuLba+lGNd63j9BXgku8E6ntebOpsYvGygN+bn0DEgXYbp4ZHRSw3nIVKJJG?=
 =?us-ascii?Q?8wkwBIg/BZ+fXMzOhUrC8BJ+tyg/5iMXgYXB+r1cxAvxZUaADL6WL6/W9wJM?=
 =?us-ascii?Q?KsEdKsy9a6+zXQXaav2KSOG8fUs4H7xuTEYyDYfEiNOJ+DClZZBDumzt9RiZ?=
 =?us-ascii?Q?GFqQAKARbL+mE6Bq90MwbDlizuO5JXF8EUoYVZSt1iG0G61XDA5ZBIpP7qx0?=
 =?us-ascii?Q?IXWg553dpi8KTPJ6HGlkrYorvOOsfiXiQVVgbH587IMJ/QkTkpVg14zS5qCK?=
 =?us-ascii?Q?Ip35TB1LivWqM4AOEfiM8ZEoml/I1fDa0r78KpgDVto3lD2LFOtpRPm0a9Lw?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df10ba6-b08b-4d2d-8f1d-08dd3a8c8844
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 02:29:01.3418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0bY6aSyePXwZqfmMYY34vvYU9eVFUs6hBLnX6PcA5E6wePhcDO8hpE/axWUna7N/7N4ZN88fMuAtssI6OjMig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6023
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]" on:

commit: b63e6f60eab45b16a1bf734fef9035a4c4187cd5 ("serial: 8250: Switch to nbcon console")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 0907e7fb35756464aa34c35d6abb02998418164b]

in testcase: kunit
version: 
with following parameters:

	group: group-01



config: x86_64-rhel-9.4-kunit
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501221029.fb0d574d-lkp@intel.com


[  231.759560][    C3] watchdog: BUG: soft lockup - CPU#3 stuck for 26s! [modprobe:3860]
[  231.759572][    C3] Modules linked in: test_rslib(+) reed_solomon ipmi_devintf ipmi_msghandler intel_rapl_msr intel_rapl_common btrfs snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp blake2b_generic coretemp xor raid6_pq libcrc32c kvm_intel snd_hda_codec_realtek snd_hda_codec_generic platform_profile i915 kvm snd_hda_scodec_component snd_hda_intel sd_mod snd_intel_dspcfg dell_wmi crc32_generic snd_intel_sdw_acpi sg crct10dif_pclmul cec crc32_pclmul dell_smbios snd_hda_codec intel_gtt crc32c_intel dell_wmi_descriptor ghash_clmulni_intel sparse_keymap snd_hda_core ttm snd_hwdep ahci rapl rfkill drm_display_helper snd_pcm mei_wdt libahci intel_cstate dcdbas snd_timer mei_me libata intel_uncore drm_kms_helper snd pcspkr drm_buddy mei soundcore video wmi binfmt_misc drm fuse loop dm_mod ip_tables poly1305_generic chacha_generic [last unloaded: test_fpu]
[  231.759681][    C3] CPU: 3 UID: 0 PID: 3860 Comm: modprobe Tainted: G S  B            N 6.13.0-rc3-00034-gb63e6f60eab4 #1
[  231.759690][    C3] Tainted: [S]=CPU_OUT_OF_SPEC, [B]=BAD_PAGE, [N]=TEST
[  231.759694][    C3] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
[ 231.759699][ C3] RIP: 0010:encode_rs16 (lib/reed_solomon/encode_rs.c:33) reed_solomon 
[ 231.759708][ C3] Code: 87 68 83 00 00 89 da d3 fa 41 0f b6 4d 00 41 38 cc 7c 08 84 c9 0f 85 64 02 00 00 8b 75 04 21 f3 01 d3 39 de 7e c0 48 8b 3c 24 <48> 63 db 48 8d 1c 5f 48 89 d9 48 c1 e9 03 42 0f b6 34 39 48 89 d9
All code
========
   0:	87 68 83             	xchg   %ebp,-0x7d(%rax)
   3:	00 00                	add    %al,(%rax)
   5:	89 da                	mov    %ebx,%edx
   7:	d3 fa                	sar    %cl,%edx
   9:	41 0f b6 4d 00       	movzbl 0x0(%r13),%ecx
   e:	41 38 cc             	cmp    %cl,%r12b
  11:	7c 08                	jl     0x1b
  13:	84 c9                	test   %cl,%cl
  15:	0f 85 64 02 00 00    	jne    0x27f
  1b:	8b 75 04             	mov    0x4(%rbp),%esi
  1e:	21 f3                	and    %esi,%ebx
  20:	01 d3                	add    %edx,%ebx
  22:	39 de                	cmp    %ebx,%esi
  24:	7e c0                	jle    0xffffffffffffffe6
  26:	48 8b 3c 24          	mov    (%rsp),%rdi
  2a:*	48 63 db             	movslq %ebx,%rbx		<-- trapping instruction
  2d:	48 8d 1c 5f          	lea    (%rdi,%rbx,2),%rbx
  31:	48 89 d9             	mov    %rbx,%rcx
  34:	48 c1 e9 03          	shr    $0x3,%rcx
  38:	42 0f b6 34 39       	movzbl (%rcx,%r15,1),%esi
  3d:	48 89 d9             	mov    %rbx,%rcx

Code starting with the faulting instruction
===========================================
   0:	48 63 db             	movslq %ebx,%rbx
   3:	48 8d 1c 5f          	lea    (%rdi,%rbx,2),%rbx
   7:	48 89 d9             	mov    %rbx,%rcx
   a:	48 c1 e9 03          	shr    $0x3,%rcx
   e:	42 0f b6 34 39       	movzbl (%rcx,%r15,1),%esi
  13:	48 89 d9             	mov    %rbx,%rcx
[  231.759717][    C3] RSP: 0018:ffffc90000abf3b0 EFLAGS: 00000297
[  231.759723][    C3] RAX: ffff888102c9ff0a RBX: 00000000000000dd RCX: 0000000000000000
[  231.759728][    C3] RDX: 0000000000000000 RSI: 00000000000000ff RDI: ffff88816b6b7c00
[  231.759733][    C3] RBP: ffff88812901fb00 R08: 00000000000000c8 R09: ffff88816c8b518e
[  231.759738][    C3] R10: 1ffff11025203f60 R11: ffff88816c8b5184 R12: 0000000000000007
[  231.759743][    C3] R13: ffffed1025203f60 R14: ffffed1025203f60 R15: dffffc0000000000
[  231.759748][    C3] FS:  00007f64c760f040(0000) GS:ffff8883a7d80000(0000) knlGS:0000000000000000
[  231.759754][    C3] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  231.759759][    C3] CR2: 00007f024b693000 CR3: 00000001d4462004 CR4: 00000000001726f0
[  231.759764][    C3] DR0: ffffffff8789050c DR1: ffffffff8789050d DR2: ffffffff8789050e
[  231.759769][    C3] DR3: ffffffff8789050f DR6: 00000000fffe0ff0 DR7: 0000000000000600
[  231.759774][    C3] Call Trace:
[  231.759778][    C3]  <IRQ>
[ 231.759782][ C3] ? watchdog_timer_fn (kernel/watchdog.c:770) 
[ 231.759790][ C3] ? __pfx_watchdog_timer_fn (kernel/watchdog.c:685) 
[ 231.759796][ C3] ? __hrtimer_run_queues (kernel/time/hrtimer.c:1739 kernel/time/hrtimer.c:1803) 
[ 231.759803][ C3] ? __pfx___hrtimer_run_queues (kernel/time/hrtimer.c:1773) 
[ 231.759808][ C3] ? ktime_get_update_offsets_now (kernel/time/timekeeping.c:312 (discriminator 3) kernel/time/timekeeping.c:335 (discriminator 3) kernel/time/timekeeping.c:2457 (discriminator 3)) 
[ 231.759814][ C3] ? sched_clock (arch/x86/include/asm/preempt.h:94 arch/x86/kernel/tsc.c:286) 
[ 231.759821][ C3] ? hrtimer_interrupt (kernel/time/hrtimer.c:1868) 
[ 231.759828][ C3] ? __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:36 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1056) 
[ 231.759835][ C3] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1049 arch/x86/kernel/apic/apic.c:1049) 
[  231.759842][    C3]  </IRQ>
[  231.759845][    C3]  <TASK>
[ 231.759848][ C3] ? asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:702) 
[ 231.759857][ C3] ? encode_rs16 (lib/reed_solomon/encode_rs.c:33) reed_solomon 
[ 231.759864][ C3] get_rcw_we (lib/reed_solomon/test_rslib.c:173) test_rslib 
[ 231.759873][ C3] test_bc (lib/reed_solomon/test_rslib.c:379) test_rslib 
[ 231.759880][ C3] ? run_exercise (lib/reed_solomon/test_rslib.c:127 lib/reed_solomon/test_rslib.c:457) test_rslib 
[ 231.759886][ C3] run_exercise (lib/reed_solomon/test_rslib.c:423 lib/reed_solomon/test_rslib.c:477) test_rslib 
[ 231.759895][ C3] ? __pfx_run_exercise (lib/reed_solomon/test_rslib.c:443) test_rslib 
[ 231.759902][ C3] test_rslib_init (lib/reed_solomon/test_rslib.c:155) test_rslib 
[ 231.759909][ C3] ? __pfx_test_rslib_init (lib/reed_solomon/test_rslib.c:153) test_rslib 
[ 231.759915][ C3] do_one_initcall (init/main.c:1266) 
[ 231.759922][ C3] ? kasan_save_track (arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69) 
[ 231.759928][ C3] ? __pfx_do_one_initcall (init/main.c:1257) 
[ 231.759934][ C3] ? __kasan_slab_alloc (mm/kasan/common.c:318 mm/kasan/common.c:345) 
[ 231.759939][ C3] ? __kmalloc_cache_noprof (mm/slub.c:4119 mm/slub.c:4168 mm/slub.c:4324) 
[ 231.759945][ C3] ? kasan_unpoison (mm/kasan/shadow.c:156 mm/kasan/shadow.c:182) 
[ 231.759951][ C3] do_init_module (kernel/module/main.c:2910) 
[ 231.759958][ C3] load_module (kernel/module/main.c:3376) 
[ 231.759964][ C3] ? __pfx_load_module (kernel/module/main.c:3223) 
[ 231.759969][ C3] ? security_kernel_post_read_file (security/security.c:3363) 
[ 231.759975][ C3] ? kernel_read_file (arch/x86/include/asm/atomic.h:53 include/linux/atomic/atomic-arch-fallback.h:992 include/linux/atomic/atomic-instrumented.h:436 include/linux/fs.h:3060 fs/kernel_read_file.c:122) 
[ 231.759982][ C3] ? __pfx_kernel_read_file (fs/kernel_read_file.c:38) 
[ 231.759988][ C3] ? init_module_from_file (kernel/module/main.c:3565) 
[ 231.759993][ C3] init_module_from_file (kernel/module/main.c:3565) 
[ 231.759998][ C3] ? __pfx_init_module_from_file (kernel/module/main.c:3541) 
[ 231.760004][ C3] ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153) 
[ 231.760011][ C3] idempotent_init_module (kernel/module/main.c:3577) 
[ 231.760016][ C3] ? __pfx_idempotent_init_module (kernel/module/main.c:3569) 
[ 231.760022][ C3] ? fdget (include/linux/atomic/atomic-arch-fallback.h:479 include/linux/atomic/atomic-instrumented.h:50 fs/file.c:1145 fs/file.c:1159) 
[ 231.760028][ C3] ? security_capable (security/security.c:1142) 
[ 231.760035][ C3] __x64_sys_finit_module (include/linux/file.h:62 include/linux/file.h:83 kernel/module/main.c:3600 kernel/module/main.c:3587 kernel/module/main.c:3587) 
[ 231.760040][ C3] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 231.760046][ C3] ? do_mmap (mm/mmap.c:496) 
[ 231.760053][ C3] ? __pfx_userfaultfd_unmap_complete (fs/userfaultfd.c:838) 
[ 231.760060][ C3] ? __pfx_do_mmap (mm/mmap.c:288) 
[ 231.760065][ C3] ? down_write_killable (arch/x86/include/asm/atomic64_64.h:20 include/linux/atomic/atomic-arch-fallback.h:2629 include/linux/atomic/atomic-long.h:79 include/linux/atomic/atomic-instrumented.h:3224 kernel/locking/rwsem.c:143 kernel/locking/rwsem.c:268 kernel/locking/rwsem.c:1303 kernel/locking/rwsem.c:1318 kernel/locking/rwsem.c:1590) 
[ 231.760071][ C3] ? __pfx_down_write_killable (kernel/locking/rwsem.c:1586) 
[ 231.760077][ C3] ? vm_mmap_pgoff (mm/util.c:584) 
[ 231.760084][ C3] ? __pfx_vm_mmap_pgoff (mm/util.c:570) 
[ 231.760089][ C3] ? fget (fs/file.c:1063) 
[ 231.760095][ C3] ? fput (arch/x86/include/asm/atomic64_64.h:79 include/linux/atomic/atomic-arch-fallback.h:2913 include/linux/atomic/atomic-arch-fallback.h:3364 include/linux/atomic/atomic-long.h:698 include/linux/atomic/atomic-instrumented.h:3767 include/linux/file_ref.h:157 fs/file_table.c:501) 
[ 231.760100][ C3] ? ksys_mmap_pgoff (mm/mmap.c:547) 
[ 231.760105][ C3] ? syscall_exit_to_user_mode (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:92 include/linux/entry-common.h:232 kernel/entry/common.c:206 kernel/entry/common.c:218) 
[ 231.760111][ C3] ? syscall_exit_to_user_mode (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:92 include/linux/entry-common.h:232 kernel/entry/common.c:206 kernel/entry/common.c:218) 
[ 231.760116][ C3] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 231.760121][ C3] ? do_user_addr_fault (include/linux/rcupdate.h:882 include/linux/mm.h:741 arch/x86/mm/fault.c:1340) 
[ 231.760127][ C3] ? syscall_exit_to_user_mode (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:92 include/linux/entry-common.h:232 kernel/entry/common.c:206 kernel/entry/common.c:218) 
[ 231.760133][ C3] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 231.760137][ C3] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:92 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
[ 231.760142][ C3] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  231.760148][    C3] RIP: 0033:0x7f64c7711719
[ 231.760154][ C3] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
All code
========
   0:	08 89 e8 5b 5d c3    	or     %cl,-0x3ca2a418(%rcx)
   6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   d:	00 00 00 
  10:	90                   	nop
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06f1
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06c7
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250122/202501221029.fb0d574d-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

