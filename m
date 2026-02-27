Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725A1336EC2
	for <linux-serial@vger.kernel.org>; Fri, 27 Feb 2026 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772179092; cv=fail; b=GrGKgwqD+7xQOYJsw3OUfd4qLXX1vbWcqTLTjLrM/NwztwR1xt37uEXqpoSxQn08QRHGMp2cGHwDVpZL2MZxTraJdEMLuH6S6YH1DdOZFZVE2ZPceyudQhiAhUdiBl93l6VI9LeOBrIWe7ZT3wYJlDA2YTdzqVfKpMVwKFhXTBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772179092; c=relaxed/simple;
	bh=B7slnmXmkFVQpp9+rwiLAI5ZC4NKC4PC6qP+Sns5VIs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=QtgidxiY6i+GBb11nlASblTkVrmob+s1PP0ZrK7A2SHvMCgU/iRGCMwgpF/4YWgORzNiB3xRvUoPnD5cr6Y9hoLiq4WK4vw7AHzfCxG4Rm/5mwejRvnyNjeaFwBFq7VyQsDxH/lJKKn8HxdH6cvxJif5cy3QTDyqtHuBsVeAr3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=THa85pNa; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="THa85pNa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772179090; x=1803715090;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B7slnmXmkFVQpp9+rwiLAI5ZC4NKC4PC6qP+Sns5VIs=;
  b=THa85pNatJlvFDnm47h2MWtwfd9Buo0fgcWfWl3d+JrLI9xcnwvkiCCN
   Afy97lwez9LHCT/bVZXldP5FDN3SA0P+VBWRNA6wwnds0e4mtnGPONgIO
   umJ/Ba1DpwHDjFHKaIeUydGZ+qQtXZDGBUiqmxDxhYFYMNfwJlmvlHUpc
   nlXODdDxH5iIkJ1dq52yOBtmQ2VXtCkQw/EwxEetP1hiv4zx1H+w0zMyW
   44Ezifb66TH7ogns9ZjV5YmKZTJX0Lis+2b2Hao2f3QbSEcak9TT8xqeg
   gZ9t1sZO8nyGVj1KgYr5ArTvX9ykMftJGOVSVept8kzqJHRA/d+CF67rC
   A==;
X-CSE-ConnectionGUID: 2gDqeKWARHCy5ZXtYNCk8Q==
X-CSE-MsgGUID: b+MNfFOMTiOFpntE3eg6XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="84720047"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="84720047"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 23:58:09 -0800
X-CSE-ConnectionGUID: 1NaqWaViT2qxixU0Je0u5w==
X-CSE-MsgGUID: CEf+qwXJSwmgFrXRvRNSZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="216728161"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 23:58:09 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 23:58:08 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 23:58:08 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 23:58:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUkcOqnw+mXXamvRhZUuNdn4wHzttoL9qFJc4niX9KYlOM7Z1O0oH54TFbXwFant2TjmfCJ7QGrPil6iKAt2w+biuiusra0l8qsMS36bzqc5ktxw6XsGQ/66jb7H0wu4O304m3tUVlvUMe/P8UNEeRZrJ2bLMVkQ0b2gqd5qPqwuVZSMH4kJru/Q0mujLBomUSkHIaLpmlnnXZU6q4M8MHsYaJ1++CRPviB59IoCJkcwp3yQFVTiTPv0mtbCliqNm5JNR4RpL7QzMnxmOM89036blIlr3AfiJeM4qMg09TUULgXy21rkcd+yx6M6c0BnXX38CpL2+0mF/211FF+bmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxOiPuazmj+c97aIlXgyu9RziEcLwATyvfQ2BCnSMWo=;
 b=anounnZFw1UjE1Y9CxidM9wuJ7ZKjjnYJgIymhBTjr+NRhWTvGOsm1xKTZoC2Z7Hs/D6jaEyTbAWDKo9FhtrPJ+NyilEej6eZEKSeR8ECTErpMUHlnuTx1n+cRBRTFwQTDWmiYY300jwR2tj6X0BKUqhjGZ/2Z23dDNZm1gx5y6lmdVTjrLk2OFBuQemQomX4jMfx1mfg03wL5sX37FvV0l/uO/JStDYMHk2qAEc15yUbcCqz/9DV09GryuHDfIsYcwgAtwDDFrPTlA7etQMoC/eEqIrtIhCrYoTsRtGqWMNW9Nou2SeyBlB6SQ/jC9o3XLmGdInwtmuV0Nc4YfGvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB7428.namprd11.prod.outlook.com (2603:10b6:a03:4cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 07:58:06 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 07:58:06 +0000
Date: Fri, 27 Feb 2026 15:57:19 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-serial@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [rt-devel:linux-7.0.y-rt-rebase] 55eabced1d:
 BUG:kernel_reboot-without-warning_in_test_stage
Message-ID: <202602271552.c972ef9e-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: f19e21ae-2951-4779-4768-08de75d5f0e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: QUXKgob4PSSKQ+Rny8XlnYy+env1rnjY/vB4rZ+zbja4utGBul7Dx8+hMQCAxIp7y2ZGK+/JpgGiHXPsQ0jxeicftR43rOHbrSox3qMy1NLlCuJqsEJPKeWMRzKd/Nm8OU9nHe0nbQ9xZnJZ8wEgb5hBLOBpXCacFi6BE+fMKHy0zAWrdbJL3x0dOVXFUUeStuD3G+8/r1ANPQ+KVqAfYzc/n6b6+Wzwvrfp29l1j388BgU2hoDJ0dsLtbmLCj4hGkfrhmvTuIJseGgGRCeEsXPOstV7B5HXzrw/an+Qbn+RGX47fqEYkLlHpl9qGmX8rHKo//wcxwobVobTUwcPtDNsPmL1/PxMt7UC2zj3/bf8o15ZdiQsbq1YqfchpnprAHg/X5uVzoewyfD0GnGDxrPgEYq3UkxM54cxqf8R4eooMTq9Iu6aHWQZ0k2x7U46S9I0D9ovIRD14RJ+Jr3hQPbffd8Fv0M6SRo9ic/3kW+kIqqIc9qrTfjCloYP2fCr51o04TB8Mh9xsJ+u/8vbuNrOJcOxR52T7flSoXvX2jawCNYxIYN7WttP3D3U0iUf3hF1/a3jNlbDVt1CrEI8YS08nP/TdFRxE3HWLyfb9YMtvHK6KO91tu07Lo85Vi3PIG9pI6DIH+feyd2OwuwFfoM/YzKf4bGO6jJjsrZYbCtMWj5wv2FrJehBwFim1Pxd8YyRAk1xf5eZSKOScDiKFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UJ7sE3S9r4pMuXOjCsYd+3t32FBffCEoMAPFuSKYFmftTFstpsJQtoMmT96E?=
 =?us-ascii?Q?z8wy6FUVIYmfZTL1BodzKO94c935II+uObcyRygbW6FGc10Il1lwm3k6jwqf?=
 =?us-ascii?Q?5tr4OJhA83jJyP5cil5osyVWnRGM2iim/USrNpTdT9P2i9nZpBJwy2/cxvcB?=
 =?us-ascii?Q?ee6XUTvHaPV7XG2t0HKHWMA55xrbYYu0lAooqn599jhyTvF3vWzci8I+PrYC?=
 =?us-ascii?Q?fQjZoDdeYpX3D0X9ug/tuSsBxwrrDs+kPzc4mGLHc6CO2uSpwZp6zOerhLRP?=
 =?us-ascii?Q?2iXitGy33uOdUVLvHIgK1sOtOSgn0bGY8OkXqh0/awJqRHmo0DqjyZ4cnmUp?=
 =?us-ascii?Q?U85N9ENvlIyP5LKeav1bF2z7ja0uY4S8MFbymmlJrVZlW+8GZ1vS4QoWA3TC?=
 =?us-ascii?Q?eZaTxfzFZV8CLp5qlxSosQukakhIcpzOyjvRYYBDUvfzW9e9FVrZ59V7CKvy?=
 =?us-ascii?Q?Lt5GF2NB9hYhUh/LvsOPO0eXdqMuI+Pb0deogB/8QrNabi2GYHTTyrHb2qLO?=
 =?us-ascii?Q?hJYb6Hh0sAHyAscXCgqczOTOqB7YnMqfgRovY47lUFyfH8SLBBFLS5vgqPC/?=
 =?us-ascii?Q?LU3yCMli+QTSxyU6DnXp62tI+1ObbHhZOnxWxYx+cj7WsHy5EU9yOjHpZ8KB?=
 =?us-ascii?Q?YMN6Gu80w4qRJIUWr+5b7dVRifzgUBb8eyDkEcIocdF1F17C7yFXFgs7Q+Ys?=
 =?us-ascii?Q?87PkN3jBfeTBhGcph1NX3m4+O0GEuz+6Ou+i97rTp88CdmaV7QxvnG33pybL?=
 =?us-ascii?Q?anE4Vf8YcAmWFZEEvKnZ6DWPi7x9jFmZg/Osp933eJLkOP9jmT2aAWEVhPAi?=
 =?us-ascii?Q?U64nu5n73X39mOTsQwCMpyw0bt5c917g+yNu37HX7483Zy6EI5ydEu4nnHUJ?=
 =?us-ascii?Q?NN4ZUm+ByFdP4xXB2zWQZr7bfFQMYrx/GEpUIIGJDxsw+QzAN8XTgK4Xtau6?=
 =?us-ascii?Q?r1IbMTu4GfWqfPBUylbkEuRqZRJMNcDR6m8kPPtgxU08jp6WWtm20MvbFfiK?=
 =?us-ascii?Q?VpEupQ928YBrgHKJr7j2N980t3fF2AqZmIZaEYggOCjuHPlbj9B03kt+Wvyc?=
 =?us-ascii?Q?5DZ6J934tVpdL8FfmhC5UaP6IoljYENQbkSAXvXIo/D/NKoZGV6DwcXTLSAw?=
 =?us-ascii?Q?DITNFJ1koLFZyCjc6LQ3VQPbHY+/FGNBY25PX0iWRo9ZZkVnkq7HkD06ApEE?=
 =?us-ascii?Q?3WvH++SZukSmGcKqPaaIF4YFHPVb5grLT3kmcfB99cHEJuc6o8zmFU28Voc/?=
 =?us-ascii?Q?yU8zWoTlbXU14xOTm0dWnH0QyAd9ybLyRlDfYPU/BEDhwxNXyz5wBb3f1FG3?=
 =?us-ascii?Q?bFLK/of8dF39AYGqQHLiEd8qYkhLmW8hcgrEGFmYC9n257yTOVRYTMv+K2Oa?=
 =?us-ascii?Q?l4wTouzLzQNgYsBbYY5nFlaC3I6pE0RsWzsN8lem0c9vBndrrLj+tK4mOy9r?=
 =?us-ascii?Q?euoVxk25BxMOrZ9VYmrs9Kf44mzXnAApZrf72mRyV0lA2RepOhfHHkqJPiBW?=
 =?us-ascii?Q?JlMQ62haUkd+p5+ucxByJfgeSLU5hQxYTOvdvfVmKunmlOnOPlpz+k/0VYIm?=
 =?us-ascii?Q?3KLLL0UEE8+y2f+1L/1ef0c1q4vzV1qe8UxQv+M9hDZExpe3MRD/a8/Gj/4S?=
 =?us-ascii?Q?wuR19jgV70KugtTEG5Pr4cY2kLBqNeEX2C/AIjcVxcx5P8xtXhNaYuplZ6g2?=
 =?us-ascii?Q?tvJBKpHY/tNg+5hrkxaQ4lf0/LpgUiQap17sO021Bocn3hyK9zuIs+kl2NSN?=
 =?us-ascii?Q?2S490xxPRA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f19e21ae-2951-4779-4768-08de75d5f0e4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 07:58:06.4217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAOFdCith7gdfY6BeHlon2v87Fvmo7qHmGXw+HprAQYzdZYxlcYZf3w/lxUgiSYBKjVHH5ueBf9jhZt8bEmkCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7428
X-OriginatorOrg: intel.com



Hello,


patch "serial: 8250: Switch to nbcon console" was reverted by

  f79b163c42314 Revert "serial: 8250: Switch to nbcon console"

based on our previous old report
"[linux-next:master] [serial]  b63e6f60ea: BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]"
in
https://lore.kernel.org/all/202501221029.fb0d574d-lkp@intel.com/

there are some discussions which seems think the commit is not the real root
cause of the issue.

this commit 55eabced1d reapplies "serial: 8250: Switch to nbcon console", then
we notice a new "kernel_reboot-without-warning_in_test_stage" issue in a boot
test with randconfig. however, unfortunately, we cannot capture further useful
information in dmesg.

so maybe this report cannot supply enough useful information, just FYI what
we observed in our tests.


below is full report.


kernel test robot noticed "BUG:kernel_reboot-without-warning_in_test_stage" on:

commit: 55eabced1d566d2815cc215272ece998c8f2e93f ("Reapply "serial: 8250: Switch to nbcon console"")
https://git.kernel.org/cgit/linux/kernel/git/rt/linux-rt-devel.git linux-7.0.y-rt-rebase

in testcase: boot

config: x86_64-randconfig-001-20260225
compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------+----------+------------+
|                                                 | v7.0-rc1 | 55eabced1d |
+-------------------------------------------------+----------+------------+
| boot_successes                                  | 40       | 0          |
| boot_failures                                   | 0        | 6          |
| BUG:kernel_reboot-without-warning_in_test_stage | 0        | 6          |
+-------------------------------------------------+----------+------------+

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202602271552.c972ef9e-lkp@intel.com



[   16.023891][  T126] sleep started
[   16.023940][  T126]
[   17.102254][  T126] /usr/bin/wget -q --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/vm-meta-288/boot-1-quantal-x86_64-core-20190426.cgz-x86_64-randconfig-001-20260225-55eabced1d56-20260226-27605-1wm64jc-2.yaml&job_state=post_run -O /dev/null
[   17.106752][  T126]
mkdir: cannot create directory `/var/lock/lkp-bootstrap.lock': File exists
[   19.145988][  T126] kill 428 vmstat -n 1
[   19.146032][  T126]
[   19.189830][  T126] kill 419 cat /proc/kmsg
[   19.189873][  T126]
[   19.253688][  T126] kill 447 /bin/sh /lkp/lkp/src/programs/watchdog/monitor
[   19.258684][  T126]
[   19.277825][  T126] wait for background processes: 439
[   19.277867][  T126]
[   19.279442][  T126] monitor
[   19.279463][  T126]
[   24.067178][  T126] /usr/bin/wget -q --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/vm-meta-288/boot-1-quantal-x86_64-core-20190426.cgz-x86_64-randconfig-001-20260225-55eabced1d56-20260226-27605-1wm64jc-2.yaml&loadavg=0.94%200.22%200.07%201/102%20625&start_time=1772044359&end_time=1772044361&version=/lkp/lkp/.src-20260226-000921:3d999d51ba0e-dirty:bc8736f22ca0& -O /dev/null
[   24.067231][  T126]
[   25.032907][  T126] /usr/bin/wget -q --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/vm-meta-288/boot-1-quantal-x86_64-core-20190426.cgz-x86_64-randconfig-001-20260225-55eabced1d56-20260226-27605-1wm64jc-2.yaml&job_state=finished -O /dev/null
[   25.035121][  T126]
[   25.272417][    T1] init: tty4 main process (515) terminated with status 1
[   25.273235][    T1] init: tty4 main process ended, respawning
[   25.304364][    T1] init: tty5 main process (518) terminated with status 1
[   25.305147][    T1] init: tty5 main process ended, respawning
[   25.320550][    T1] init: tty2 main process (519) terminated with status 1
[   25.321322][    T1] init: tty2 main process ended, respawning
[   25.340485][    T1] init: tty3 main process (522) terminated with status 1
[   25.341245][    T1] init: tty3 main process ended, respawning
[   25.368534][    T1] init: tty6 main process (523) terminated with status 1
[   25.369377][    T1] init: tty6 main process ended, respawning
LKP: ttyS0: 103: LKP: tbox cant kexec and rebooting forcely
[   26.117689][  T126] LKP: stdout: 103: LKP: tbox cant kexec and rebooting forcely
[   26.117719][  T126]
[   26.234198][  T126] /usr/bin/wget -q --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-wtmp?tbox_name=vm-snb&tbox_state=rebooting_cant_kexec&job_file=/lkp/jobs/scheduled/vm-meta-288/boot-1-quantal-x86_64-core-20190426.cgz-x86_64-randconfig-001-20260225-55eabced1d56-20260226-27605-1wm64jc-2.yaml -O /dev/null
[   26.238678][  T126]
BUG: kernel reboot-without-warning in test stage



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260227/202602271552.c972ef9e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

