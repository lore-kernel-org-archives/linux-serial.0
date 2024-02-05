Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8BA28E09
	for <linux-serial@vger.kernel.org>; Mon,  5 Feb 2024 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143011; cv=fail; b=h/+N0JJY71DHA8HTfqvRX14b+/aeOgiLGR9cpggkI9qXq+SCpzsJwyFITxq2G6hS8ggmpRIU2Syp+rfPa2blE4x2aHAU4I72b6Kz9/nBtMwtDWwA9dkpXy2RsFZ3bSupB/Sul77cuKLLhLUybK6udOPdfwTitH9/56H1NO1fm6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143011; c=relaxed/simple;
	bh=IPLrAiDS1QrVhyL/+RUk0S0dkFc4K8xE1/ZL3G5R5hY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=sMkFBY9j8KvWNGuMy1I7Y2ZVtL0vTqisM1cgvnhKo/zqgqI7nNGCD8ir/oONBWlOPNpyv/WHQIXeUgFOX6fgMB6nuAL22kyYkFwG55nWk4Av7FaMPwv5lAVxw41ZxY9xtU2mJWz2Q/vXFTbnpRt+HwDo6991IYl/8AiTaJhXqZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V6rp4Trb; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6rp4Trb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707143008; x=1738679008;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IPLrAiDS1QrVhyL/+RUk0S0dkFc4K8xE1/ZL3G5R5hY=;
  b=V6rp4TrbikvHNYdP4TxZSrI11ZyEV4dkC/Ozul5Czd3NoiAFT/5LJV7o
   zbaBMXeyXWS5ssB3u9fhW8H5RaOk5N9vGwACkUVqQKKWFRmuMTQKpZO++
   e8Za0g7wvsHuPyQXTYaE73MmIBLzyKTBHPyB7DVgiU84LiBlYHclMzh29
   FB/f4QI5QY+UltqgHvR3g1JRLaiM2TObr+FL9nBqjirBbaQDcwnWVQaPk
   f8A93SbhGa9Fhb1SPb7p8t/DWBKZvbzi0Dk96QccHMEux5wrDU1gz4Knl
   szMQdXg95vlBtRT7Eeo3WtG6TAR0SJZUEwEWfYMi1Brg6LCb7uI8mYdj1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="682490"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="682490"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 06:23:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="1056173"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 06:23:27 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 06:23:26 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 06:23:26 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 06:23:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBLU94CnkKhGXSR/x/lL8NenpkVv7/VaJpxRpe+RMuwILivpfdyITRKE+gJSDF+NQk1ylHCXqo2DksiPCZqVw08uwV7cbI3rXf+xFZhVdWaLeGOYOFHFynx7abvT7bF/YqIL+OPzq4LKTVnzUtWXA+yzeBP7oZCmIDLIoxfdCwWLz9Cvg66iTlSAncphSV+HxSTSjZSy5Llb/OVeNCR1aG75Sjd+26woWltzinzktSHDZw4NyGHDBdqLgdJH2aYz8xGTRLv5tWBj/iUdsKC0TV5pvegs2sBGroWChyNfQ13czsqrN7bGZNx+etkJ/zqxAjJAM3nrZidiJ2JjZbBDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbqZZCHhaBrS5GXE5J4Rzq/h9NA8w/khnroVeH4eBuA=;
 b=mUmVag7NpDQqKYEdJXYbMyQuTWGgpFfNiNua6yl8H0atRDa+Cmkz1r5n/YPVQRINh0xCd9mgeHlx6WmPj1eMSPx436I76tKHAFqlQ4SudEbs2TPDZa6sJ8EiegYiVQjBBGhvOzACh+C9sxDcTgIT6s3FbaGp8+7K64dVGrUKy66u91+Tci6C6KfQbn1Oshl5w8P49m4iPWLU0Ar750yia1x8KLACkqc05R7Hlre2LpH7/rV91NDSv2HvC46xgVzZbWDgLdE96DGDtdeB555ov1lZ/s5EdFUej9p5Ei5bP3qB2enasFNsIwE1wekGWC1INNFohqXLWl0tsGzp5FIKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6976.namprd11.prod.outlook.com (2603:10b6:510:223::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 14:23:23 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 14:23:23 +0000
Date: Mon, 5 Feb 2024 22:23:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: John Ogness <john.ogness@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, <linux-serial@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [rt-devel:linux-6.8.y-rt] [serial]  0a81ac5ba5:
 Kernel_panic-not_syncing:No_working_init_found
Message-ID: <202402052207.a61afe51-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:4:7c::30) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 972383de-3a41-4e96-d095-08dc265602a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zHTgXCB+tdvn20H5tV+jok7jBPFpQB3Kr92uhqnsqxrAWsn72j9+2EiTTHOjOHNQdrbnvqcXlj/iZ+Sp82OTgkIc+QNVr25qwS8bCqhISbBELNGkY8qLToIqiqV3Af5dMw5qqjagy2eRHn9Ca7r40ZmSdWyCJoI0hYVWPKwsFk/1ry4LJW7ajvLvhVRdGdzDseqAdOZhjUlYvTcXFaRUb3xWnLrJb59Stm184WNK+V42JN39O56hjq9n16GOl+76ZPBu7NR6+WgxqZAy3NZ8XyBPurZUMCVhhkvRKr1Hmxc+pIkqLzs652i7dYA2nYnZbrxSd3YRPN0tXU2fDE2rBgMgGlshdXNSqsg3cfFRS9aDSfWszdn4CZy8/b3vl9T5h/BTXqfNynhbQp1ajrdAFFUQpQrHznx5sdoE7U6fGbQmrIrVrZ3ZgJfEKWBANgD54g4u7cUAp14luq1f6cKTr93NZFv9cDaddOWiBW1UKxqlAPV/W+bAXrNXRl5hTuxHYSVfgi5DeWwpIOGfqUL6/rLKaLCJ5QN5k+TZe0yvwNY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(346002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(66476007)(6512007)(6666004)(26005)(36756003)(82960400001)(966005)(6486002)(478600001)(38100700002)(86362001)(2616005)(83380400001)(107886003)(1076003)(66946007)(6916009)(316002)(66556008)(2906002)(41300700001)(5660300002)(4326008)(6506007)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XtOSEYMpKgKOW1wnlztyfz7U8Y9yYbfydjwfNKerF4HO1dCSMpeWR0ZHH4tg?=
 =?us-ascii?Q?P6kE6BNqyx9+EZSo/Z6o3C+gf6FiusWdxyl1q397bNG0tRSAufipdzpeHUdQ?=
 =?us-ascii?Q?Q3/Is9hCJ4YA3q9u2XtprOIJpppfFzpOh4x3xv8rEqCHL8YXsB1catIzsq2S?=
 =?us-ascii?Q?MlV01P1xvztiMchDcv8RsQN+wR5LY61c3qIW1SLMijMRrI57yt5tDwMN15m0?=
 =?us-ascii?Q?qauLDPyWkkhcS5XWc3hQ16QxLMO7PkUzX1D0x1zGCnd9D277sbIVziCXPqqS?=
 =?us-ascii?Q?HwtoYYiBUFh1p/Q0NNZv+IoVeeaw44kBqBt4tSeFlMbZ8yPkRIB+wIQdgatw?=
 =?us-ascii?Q?GcPigkPdfh33rTNsuyRKNv4DNFXn9FHs4r7zKOlbdKJH3YvtnCKs2aZr7dYL?=
 =?us-ascii?Q?XQl7SqaF61zPl5sOGJbQ8EPfFdAXhobSXEfw3cxCfYGkiSIziC8KR8Pd1yxA?=
 =?us-ascii?Q?BQmLa16vaFAppTrX7DPeOyl6fbP6CLpnF1wVKGEy9ZRTquHpr/LXsjZVbJQq?=
 =?us-ascii?Q?bPj+PFdPHoSdnaDRdBNmOk8Lh4KABrh1G9TPmJKTlmelDrNh8dZm25Su5Q2v?=
 =?us-ascii?Q?pMZFQtqx2w4uIsZr7DUdg4e2El36oW3kaNabhqBGGyYksCXXHvmblH511qFC?=
 =?us-ascii?Q?pXJIF4rd69jK5S8T+n0vZiGDiIG/K9O2l6JZGkJg+v0bo3zrn3GBIOqy0J/q?=
 =?us-ascii?Q?3sWrTruKbYWjgPpFwX0B+5QM0vmXRQZj4sIGSVMi/2Cye6OX7xjWtpmY747F?=
 =?us-ascii?Q?YPtkk7jO29K389Pu1ECYJzd4qVETotonLIBHkZvoCASIvKxol6ticlQD1dlI?=
 =?us-ascii?Q?W9B/CGem5AdeHbGUu9cALwgwK3jXerijf/oa4ouBZx/1UuweBRRbU0yJMdPl?=
 =?us-ascii?Q?JgL8Geb0mGVnmlr9BPjDZPc7fSngZQ+qAp8ZNjwr/18gkRiH5tszu9bKSp1B?=
 =?us-ascii?Q?uAm9uEIx+qIKbIEsSEJhij6wZotxXPn1kdL66v2kQzU4/KlARRRZVboEMEhp?=
 =?us-ascii?Q?yM32uPjTx5git58hg/EXmb4KQGp46IfieY0Nlhu1S9RzNSGb6so+IY+7dYkv?=
 =?us-ascii?Q?hY9r7z/5CyDjyQm/qyDqGjwpxy8olWymMV/W/o+jgmAuvCAlBtHRhiMIip/f?=
 =?us-ascii?Q?CyFRA1d6+zx+2bOQrUPMkvC3HYaCED6gekV5vCK+/EDmjviZIcSlaqJhzkox?=
 =?us-ascii?Q?tb9LcP2V0d6VbkbNvR30CEmozEJpANvBtN3i+z41HSYsbpGT/pt6mmrnNrR/?=
 =?us-ascii?Q?1BxY9gL94D0Ln1lxjjUt3qJ39x404hUrWRTq+MRaWO4fp1B5gvsocWi7U3v0?=
 =?us-ascii?Q?TgNOLOFWZcGUBhjc3DSOPMtezXSv9v/YXx18WYRZT+Er4UnNL3Lgzo8P6epy?=
 =?us-ascii?Q?15FDbBTJ/xmVZM77nlreYcsgDGhYuRcoRL/K6V47lji583C5E/AOmcxXHGK4?=
 =?us-ascii?Q?2ROaOeBGB0C1t7wMkfG8i/cQTlngvV5I7Hp91mze5yj56kijdciHb5Qi0lV/?=
 =?us-ascii?Q?gQI0wqD9cw+UyoFmkUUgwG8GlWZM0ZuBrcbN6uMfUyt2U5uPSjv+ANMTpjis?=
 =?us-ascii?Q?uhsUHeuuxVX+EBhA/p7TeMehWv2H1CyHkUSXhriL6xHKHYJGRDMtEYIjvBKn?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 972383de-3a41-4e96-d095-08dc265602a0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 14:23:23.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzN8ysMDGVwJhgw7h8JrP233MVvX/6fdkSsTU8hogEc7hHXwNi359/tHtadM5k0c3DrMDAnTUyEw4Fsjzup3yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6976
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "Kernel_panic-not_syncing:No_working_init_found" on:

commit: 0a81ac5ba5b985c0803c4f0d9272578fc7b1d361 ("serial: 8250: Switch to nbcon console")
https://git.kernel.org/cgit/linux/kernel/git/rt/linux-rt-devel.git linux-6.8.y-rt

in testcase: boot

compiler: clang-17
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


we cannot connect the issue with the code, but by more runs, the issue still
shows on this commit and keeps clean on parent.

we also noticed the issue doesn't always happen on this commit, as below,
happens 15 times out of 20 runs.

dd0b9d75b0ea983e 0a81ac5ba5b985c0803c4f0d927
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :20          75%          15:20    dmesg.Kernel_panic-not_syncing:No_working_init_found
           :20          75%          15:20    dmesg.boot_failures




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402052207.a61afe51-lkp@intel.com


[  217.891235][    T1]     LKP_SERVER=internal-lkp-server
[  217.892392][    T1]     selinux=0
[  217.893299][    T1]     prompt_ramdisk=0
[  217.894242][    T1]     vga=normal
[  217.930082][    T1] Starting init: /bin/sh exists but couldn't execute it (error -8)
[  217.931991][    T1] Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.
[  217.933840][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                TN 6.8.0-rc1-00059-g0a81ac5ba5b9 #1
[  217.935596][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  217.936883][    T1] Call Trace:
[  217.937287][    T1]  <TASK>
[ 217.937698][ T1] dump_stack_lvl (kbuild/src/consumer/lib/dump_stack.c:?) 
[ 217.938293][ T1] panic (kbuild/src/consumer/kernel/panic.c:284) 
[ 217.938820][ T1] ? rest_init (kbuild/src/consumer/init/main.c:1433) 
[ 217.939385][ T1] kernel_init (main.c:?) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240205/202402052207.a61afe51-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

