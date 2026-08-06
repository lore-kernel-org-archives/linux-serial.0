Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C3345CAE
	for <linux-serial@vger.kernel.org>; Thu,  6 Aug 2026 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005750; cv=fail; b=Dd5JlWW7nnwFfpd5fsB1WOUbIuaCbr2DHIP9uwBY/tE9isHZWKcPmGxfK4zJ4klcFAWeXwiHUxdX7OH7zicjZ1At96t0Qev8L6qVqETlmi8yusI/E5a+AImOv1HFt5LarhRgRS0jtEX4QkXXwbYEJOwsUJs9/Tqz77up01euQjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005750; c=relaxed/simple;
	bh=/pTmrk8AYfP3HvRDdHBKeJVw3RLoLqm5dQj4m7i3ytY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=K06H+NGtmydkDrYOum853T9DzbBdJ33sPWEFT7e91Uyy66iWeqDoS87OFGq1r3gNITM+790MQRPrJv/OF5Q6MLAyadORxU1nQMsnZ4teF6XpQ8HTZtuXRWQtEJCznmAPbhxVxsPdDEEbgkHgjVwkdh6kjyBWBTCZZWNwr0yv+HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cod4JDLl; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cod4JDLl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786005746; x=1817541746;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/pTmrk8AYfP3HvRDdHBKeJVw3RLoLqm5dQj4m7i3ytY=;
  b=Cod4JDLl3bOsUtF8aIGgDr8n58lEux0pWaqbDy57Xs8I1o7hzFA2fRmz
   7sFilFrVVPyXolNsRia5VocoGxhgoWG30+vfVhyenHN4939cY/f9woqjx
   HKnlyWoWsk0c5ur37LUwAPx8Ap9HKS+tatvmF9CM4I/OYtPMItQ0VM3k8
   bhC3Jue7gYhvBzMC1Trv7HzrmjSrvoatHGQYPRgsExk2ee1s5b0PhMgFW
   837gihEjtcKUMlNRxdef4NfGhFU5ZfreHsDPT9z1bHSPSXa73A+rqR5QN
   Z8hF14nIbcqkv4VYg4PucY4xmfqx/sE151nMab6Gq/YTPtUtVoA7dZSyv
   w==;
X-CSE-ConnectionGUID: 1UeWEOtPQtaSKa9CczKw4Q==
X-CSE-MsgGUID: ktGqLEtjT0OaglXOyMfYnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="97747469"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="97747469"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 01:42:24 -0700
X-CSE-ConnectionGUID: Yc4mvqi8TJGWBSBcJT4HEw==
X-CSE-MsgGUID: O5AGWOB8ShGrmLY0To57BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="258175202"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 01:42:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 01:42:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 01:42:23 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 01:42:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6RP1EhnL4iRoOeIHjpBIIOV9O+WKhrt4O7ZLahd4fTDviDjP1ZhP0edza65sXP81tzAJ9E1ioQvi78/On/nkZn3PU1m/5A42bvqBNlZ91u+1/SIqP/38v+lwXUAQQWtx4prQmxaUvt64IIv4OqzKgFZ0wxm1ZLawcCkgRZEk5F0rRuVrua2Kt9xAVhn+ohtL8QjA+ZtrESQ8w3xOvW+usAluH7Uxxm3c3Vs0sOra1BasAWTt1b3aVN2LN8uZuo9lX69W5eOKRKD6tvmdp9f9N6MCNKyLFQh9aKujM0ALP7pr3ztHYUl2Az51GdsXHpMXHT0rFKZd88J0GqARWyYww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDr4uQnZVruPks3cU+9NdmtZn7IOcq4R7o4ZA8R3W4I=;
 b=eIN4luUTEX1WlmvjKtIL5/s1t1gN8wi26NHgxzD1OFwj8mbpTvPG+coIyaxfy7ozsqffUpuE2MMNO0Ar36TgiW+pdW5RURkKnnJWwlfAz/0IpC7i4mgsNG5qq2vbT71ULOJ/5HvNq4kRwuAu4n73RvChjh9NQWO98lz8Qgo+hNnxYxb91qGxI6JUrOKDwf9JezBbYudLno/PIk/HOk8qtv+OcSxgIRRy368/esAvZBYJCreAJyZuFDXJZAAstwHrvdnEST/wpSyb9dn1gXyiv8UkeUfDv52Ecj4G6vaIXcocX6qI2oCyPYF7dxSU6KWtipgFi+yD0PMouNeM4yZEfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 08:42:19 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 08:42:19 +0000
Date: Thu, 6 Aug 2026 16:42:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: John Ogness <john.ogness@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-serial@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [serial]  d353934702:
 BUG:kernel_reboot-without-warning_in_test_stage
Message-ID: <202608061008.48a1e76e-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: KL1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:820:d::13) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CY5PR11MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 68cf6be1-e72a-4b6f-c241-08def396a032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: Y/ArSddr+2ttoD1TSuB+DttCLZOasI8mh6q5IErUMHquaRK9zhJq3WLg6KmXi4MpH+vW5k81d2y8odHg3w30zGAaabEISF1250KrmPPdPfSwz47937WBQZ50TRRw2ElBzY8zgV4aOA78RIUJU0oU2/vIzcUVk+2bu0CIDFP3mb9Zyy/SxGn+bjYu/aAXfcBTNQZBUgTzFjm08Dl5vbB0EtjVyN350HupQv7UzeSLjN4M8pBEPsXP4QlnpV8aRR47pPtXRm/BVcSjTjoiAy3aGk6MtfQZB8diVg0hFQP+B2ujL6D3umjtyUuxT19hbBmzWL51M2voC626/I+i4VMbB7H1qphlqoLBQCEhUDihCLnONk47xbzixWG8vpUiB67xII1C24Y3TMJ6SUVHxUtqNxytPdNz8J1MnrxeS2PGOT1dKP6OTY/gCim8aXUUtOBnr0bsiqFP2cuu3zc8EFWUGmzNbPu88Bn9giUJ7pSuWDL0JrMiT08LmUfFezC+e+1rL+tx3Fyz67cWjForHtn1l4g3rBl0TB0brLfGftUf/6b765VhnJOW1wQUBKlZcj3YCLsd4ns8pNzoRBfB1QSWVYYWQRFuS0XeiH5a4Rd37cxXCifNN6rCB+QYJEtEZfx+LGvsxqmPDhW2A8ZliXFVFrFGlV2eQ7713tMtBvvdHI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5xt+uFUzuhswf0UnCyw02lITGwkW1RvvlfQ3rkDNObHQ2WLU2BvxrXHvPMU/?=
 =?us-ascii?Q?JqiQp6yj7XrHxR6h6spjV6cOpAdM05DYf/ix9quu/7s6kdXDt8czBZIN/Qxe?=
 =?us-ascii?Q?xEo44qZJTWz9SDaTuAyoG3WHey0oRjD+mNiuGnpzNNDKCSp99D/dypkyBATY?=
 =?us-ascii?Q?YAx1P/bjk8LNvS9yDdw1H5j4dy6Jg7984Ga+tH6O6K87j+hjK21DrbSBOY3W?=
 =?us-ascii?Q?syHyIlxWsLsSPpNRMLGgldtrWzpVhfLjBI+Ioj9711/AAFYsKrBINrH44mYN?=
 =?us-ascii?Q?CRhzSy4iYOyoTDJAH4OZZRMUkY/+UnjU+vQCB63BbGQKJuL3e9U1IUY+sigQ?=
 =?us-ascii?Q?NVgC6ihNXJ4hSEwgBndOHbkLs6Mqz8MWwq27CDli/fwIgmfJqu9nG0yKp9wX?=
 =?us-ascii?Q?PGmwFxK9yk89XyLa1N+P477J3AswojqPcE7QFmWTs/yWi0sIRXiTCPl/MLHq?=
 =?us-ascii?Q?cgT3AplVMvKACgLbzHJtisMeXSbFt621KRmV7LnUscb2q1fkr4FduYKTdOsI?=
 =?us-ascii?Q?5U8EYtfRCbhREeizwNj07tWp6q+EjXj1gcymzbvn0/34RHMbdRbvVIx9aWVZ?=
 =?us-ascii?Q?E3+cOC7ZYSYeg4b4FfwaaIRB5Osr7eiHBIQCRs1b4IFMdPfNgWs1L7Jb4tCJ?=
 =?us-ascii?Q?uugLN/mLuBpr626uxS5ZlEf5sL0Aut2IZ0LQTuzavl5BaIPP/HIu5BsmDVqF?=
 =?us-ascii?Q?n4YSVkyY4F20KldF8++5p7TUtDRNXISVh1cYuaCo2sV5hFQs3RU2JlTdLlys?=
 =?us-ascii?Q?bbbP2jhv4ow1Y8ETyxJrKlO66hFLL6l0Pcf0NTLyc2vrvPPLd3h2dFYPhXB1?=
 =?us-ascii?Q?kiSTanV60dkctjiK9+a6NP4nl+BHhACk3g6uki9SvqZaT/FKqt1gHUjSwgwO?=
 =?us-ascii?Q?s6gvZNIZHCXwTR+HGiklTZuqlc9gFe/9VX68ua0xR5jYXo60bkHe+TPbqegY?=
 =?us-ascii?Q?D6EJFwXGzyUBRYI1n9aA+riRAcdE3+a4WS+mBAWP/qY5G4aFGjboHk/gxFhT?=
 =?us-ascii?Q?M76c3X9ht5ePYetoOZu1Y5pQKGEHCgD1BNEHlxvUKlfvKCzbXgxMs7u6nfYv?=
 =?us-ascii?Q?bRUTyTsBuHbmobaE1VE4UCoo3/b6qW6MusEbeJVDfsaEaf1yvQRUoH2JHIxY?=
 =?us-ascii?Q?yz6j7sb+q3SnGhBc19XpBvRirGwU+5V3stNlGTiJz2Cn6Eyr4sCFY/cYWPOm?=
 =?us-ascii?Q?SKYCD79aFyoFDj2O3uXu4I7oqI1jWlBJjlU0XZdT16X/nCSriOMYyOJbQ2C4?=
 =?us-ascii?Q?Xru0NYTUnZQzUzqcR32x6qKzGMdMjPu4C7nGqvOvJXYFhsiqzsmbEM3uH4e/?=
 =?us-ascii?Q?s0ncHVPY1aCNreCfHbUp5rFetbrsBtjZQr1wCfucSy6nxdgAISxTzr9pWI+w?=
 =?us-ascii?Q?jUl7eCszpq9c/Puv5eI/AsJZyjClbEHbgmyntLn1cQXwri27Q29hf8iGMvej?=
 =?us-ascii?Q?6IiJBGuruBRXn9yZ29Ngr5QPnpxnN6Nc6y76kv4a/CQEBrE1QGYwsuzMjamV?=
 =?us-ascii?Q?SZB8qZgGLU+Jkcg1UWXVZv1qa0bX5znGY3hdXhOKUBKUhPEqWL27GNY4zYVu?=
 =?us-ascii?Q?7It71aAafx0g6kAJNSTGF7f7vVu8GuD5i1eTZrKFjwAqk4momfHR07KI4TB5?=
 =?us-ascii?Q?Ym5o0ot23xxTwh7Drfkw9qOyR3TENq3hz/xbuYDUjft5m2sMfROY89awop4C?=
 =?us-ascii?Q?VTzyZR//p4GVxYS1F4UjzKiyTzKRvmmNywLf9qchucrqy6bIYF+9gWNKCQEj?=
 =?us-ascii?Q?HJAyvQTeCg=3D=3D?=
X-Exchange-RoutingPolicyChecked: XoO7afs/FehfGxIaSNOZfFr1E/IvdDVsyNc/qaD19XNg75Mhc+4QgeQzF1f6pHhDcB1+MRFcFqQIUPXmAdibb0V5uNlanPb18FYGslUKD/t+A+XsodhqihgtrFDW7RdtVY6jb8X5cgCk1zF/4pdxuwz1Oqnt1WSYMhEidZiK5F/HL1StCvyL3oyqlP/3IJDsOcikX5sD8vKexYHk+VE3jMt2Y7FTJc5TbNyteZHnZwEZyeB9aprGJ8eEgQauMuFi8w+FgKiE6kTlYXek6mRqJFg5zjeDoHdX8WlpFDJLtxdwmkNW47Q55jMk7SAWrPcoOoSexdQbaWZb0uaFhnU4Gw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cf6be1-e72a-4b6f-c241-08def396a032
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 08:42:19.4039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsV5NDLWaDXBE1SplNNl9nE97d+r5MpDT4h+T8mqqLdbIBdWCKWzifVqItchZE4uH367C3wZDtxT7reDHqovpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6392
X-OriginatorOrg: intel.com



Hello,

similar to
https://lore.kernel.org/all/202602271552.c972ef9e-lkp@intel.com/
we still found we have kernel_reboot-without-warning_in_test_stage by this
change in our tests.

hard for us to understand the connection, and we cannot capture more useful
information from serail. just report FYI what we observed in our tests.


kernel test robot noticed "BUG:kernel_reboot-without-warning_in_test_stage" on:

commit: d3539347022ad4eeb9dbd29c50bfca17b9d8a146 ("serial: 8250: Switch to nbcon console, take 2")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: boot

config: i386-randconfig-2006-20250825
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202608061008.48a1e76e-lkp@intel.com



[   65.107802][  T272] INFO: lkp CACHE_DIR is /tmp/cache
[   65.107809][  T272]
BUG: kernel reboot-without-warning in test stage



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260806/202608061008.48a1e76e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

