Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2138EE49A4
	for <linux-serial@archiver.kernel.org>; Sun, 10 Sep 2023 16:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbjIJQAG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 10 Sep 2023 12:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236779AbjIJQAF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 10 Sep 2023 12:00:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68899D
        for <linux-serial@vger.kernel.org>; Sun, 10 Sep 2023 09:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694361600; x=1725897600;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s6bW2+tbnm6kfVMLZI1ILw2SoWPFqEKTwgrCuHlHCaQ=;
  b=PFillT+peTQHBZEHBlJxQ2UK0beQ116tOy7/TQq9QHJP8IajpukHkFsu
   yvQM2gA0MPjsTTz3olOWL44Rm1qIj/sPZYHPqRajlKMAaLx9WM0XZLZXI
   KAGtauF43MJTWMXkiohFELi6j1nZOahmYMhHfyABKaT163zUo2mEqnZKh
   V4io5h6g7JSHBa1sZIx5p9Fv3FNBbwC+rTvmTLtXurGIt7NLXWOzDsB9X
   7WI1lfxza5mjEW0tdpaMz0uQ+IIQDrg2GWnEr52nWdNEZdUCqYaorXNvk
   T1mCkvqwF2vmOm4smfu1ELP+3W4JusMJEzTr5VP/VkwX8GYuyN56+kf8H
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="362951722"
X-IronPort-AV: E=Sophos;i="6.02,242,1688454000"; 
   d="scan'208";a="362951722"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 08:59:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="858020957"
X-IronPort-AV: E=Sophos;i="6.02,242,1688454000"; 
   d="scan'208";a="858020957"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2023 08:59:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 10 Sep 2023 08:59:59 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 10 Sep 2023 08:59:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 10 Sep 2023 08:59:58 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 10 Sep 2023 08:59:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsFPnlCbpVJYhyAWa8aqhWikOlssIDoQwPMkYxRbpuWHCFupVFWMCyoceC0H3Np/IUUKh2709ogEZzsgypb8ZpXBYrUUK+a2MkyduvknCdNNl+LA9I3ZGSCrlC++WwihZHD8eYFv/4GIRbaAayRgmmLjhtN+2c6mLBgltYlhhK6idWR/IaWqwXFCAkY7nyFW+vcICDjiKGkCK+Z0vPb70nWy+Vh/CTKRMSpDRn+1qWXtod9zWrhPw9C+1ASL+HLYmt6d4wjPuemWQb8U88JXXTi4YQQVxfbaeNPb2kV8xuEUgVGhAmSKUU2y1XRg4z9haXZkkYeLQHP00+dXmE4U+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxXo0+culinfrhrNLFynAdp1JSy/YZHXA4HqBM92GuA=;
 b=cM21NIptus8N8NUXqwylUK/YXcNmA9wlS07mA+7hkjJswSQ8mLiJy9La6KSjLp/yMHgwdQRK606Vg9zZVcMxqaaNqU9zYI6fbLNIEyUceB7jV0ZiPJAA4/E4/Iui+Mdy0cimgEPQdIQRmQVLz0ZaxK8tZo5H3K3Z/DbmNUACIw2bBrXbKJ6m4fZMlQVPfuPKkVkuAfblwZBN9qgG1zNSNHuThXn7DLmoOhDFiaen1lgkDDaKGHgCNqwhP6wXTF2hQtr/DXJ08jbmGxuSjMcwpVhyb8E+qk+75s4ClSrPrOMVHjdQ5uzqycOfA4YgvLk5o4h0T3sowDoah2WM5midUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA1PR11MB6941.namprd11.prod.outlook.com (2603:10b6:806:2bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Sun, 10 Sep
 2023 15:59:51 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Sun, 10 Sep 2023
 15:59:51 +0000
Date:   Sun, 10 Sep 2023 23:59:40 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     John Ogness <john.ogness@linutronix.de>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <linux-serial@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [rt-devel:linux-6.5.y-rt-rebase] [serial] 2e4f53117a:
 INFO:rcu_sched_detected_stalls_on_CPUs/tasks
Message-ID: <202309102359.47ac0da8-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:4:7c::27) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA1PR11MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: db063ad2-c943-4809-12fc-08dbb216f6d0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OL9WaLNPpmtTmVEfFQvJl4M/tpWJPo2ljJMjd9fZxkKuNtAt2Q2rry4/WSYmINAXfzJfwiDonwoVKTiwyXYrp+1i4Zxt6vD/YUHnhApDRy98iz9sVSVIJc16J1hr/gOqwIvkErDZqgmkeBWYCHRtWyr9qIMn9h2y+HGikDRPzf//vWhlScii20k9pbSyrjJt/cPY/2gRPEL3RzjnPGoucqjmw/TnGNw27q8jUg4r8Kem3ouBD0o4Fhlqz1l6R34St2CrR/cJvlZUVEZrxW2LXhTLQzQWhrU2LCfSxhx/oFt9LVya2Oo+AWqu7ZaUzvv44ZVPfocBOZlEJw+6UNd9mR5ZDK4WFg8DuFNlV5M0E1ssi+lu6Y/Nm8Sl3m96M29lkPS7wb29W+g5PIPvSFEoN4Hh0Y8R1MSPGaHx/mJl0+NSJn+zH3gHrJrKBZ//zNf8+Ac9QXNgDErvBTucoj/255FKvJCDR3zAYEx3z+XIYVTi2C1HXhWzPyXQQqkM7tDUjL7azslrkgDavEJK4jRX2iwBC9HC8j0VYTpoRZAGYAfd9oZi2Et5/kMx4aoQd78mATHzuhjHNZN4E0Jmp6963A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(1800799009)(186009)(451199024)(6512007)(6666004)(6486002)(6506007)(1076003)(107886003)(2616005)(26005)(38100700002)(8676002)(4326008)(8936002)(5660300002)(86362001)(2906002)(41300700001)(82960400001)(36756003)(66476007)(66556008)(316002)(6916009)(66946007)(966005)(478600001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/awS/1lEIv6zjZvzMJk4GvaPCmTm3Zn6PkvUFs5MQp3s375eiJPCW8Znb1tA?=
 =?us-ascii?Q?1fr/8jJSczn01AUN4AUXfSABJD3X3KJO29c+lkbVIPkDBXItJiwdg3sgEzm+?=
 =?us-ascii?Q?YBTmwCveCTTytL5QsiKLVd4WcXoEtNO0k7ohVT6177pQ4v5UmR3dV1WRpv4l?=
 =?us-ascii?Q?3LGgj9QuXgvUA7Q47zQJYrSkIAMv4SuW158nVLgfwffxHiRYOaDUCbV8c9ti?=
 =?us-ascii?Q?hXYo9BlBnITHIsP6wIF8e4mKV2OWD4NpKpNZ3FP+qSxhB6ZvPVihdC9jHUAI?=
 =?us-ascii?Q?UGO0ewn5FEDyPCG+7pNuADydtLPVY8Fba0Yx5+DrzMzclwAQIHuY2slf0uP2?=
 =?us-ascii?Q?Dfkzx5zfnZrOjgwZ2e8iqf23oSG++YTx3AHRn5gbxQYPXq6T7NRdmTbA1yJr?=
 =?us-ascii?Q?E5R//2KaoRt65YEmYPAj2QkfWeDa5vE8AZOwXjypxjsPl325ecUK8ps1BQlj?=
 =?us-ascii?Q?XRTZJiEH11CvdzBug3udcBcf83Tve2TnMQ7QJDFoDcaI4QySd6zcrDJUjv7v?=
 =?us-ascii?Q?BhWbs1w9R1gi50pRcVDIkEsOxo/KiiJVZO7VUIc+I4vs5bbf6yIfBkM6A84n?=
 =?us-ascii?Q?OtqG4sK5KfYc/AH8HcJrKhsbI3tcx8U481AnoVzrFLouNGNqOKaFFAmnWTt4?=
 =?us-ascii?Q?hLEuJ5RSz8f1EzYnaJ3NSi3ICREglDhavrUIf1WefuTlwHTwsujZBBq7Ovg9?=
 =?us-ascii?Q?cpbQKK7mf0vTUqVc7qu8nfiaMmDfWYetdrg/EsJHHDjLITFV6rwIRWEnaPRr?=
 =?us-ascii?Q?Zg2ugJPQe/EXlkOAjB8e5CpetnC/bnj6YQuYPE8XRi/1GKQ+TyBfBkfp4GBA?=
 =?us-ascii?Q?GMFmTpAaY1EBVPe+g0viHD6LZuIfFbOa3dkd5YYUe+L2tpuE6ZaqMo3jW549?=
 =?us-ascii?Q?HFZOglkmzWGF+yjBj2uo5CRY732pc7OWs9SMbipvBj/4g5GGZxVyVmhhyN9j?=
 =?us-ascii?Q?OmgnkJ8IbXyJCVYtf3P2VpMq0oO4lGxCJ1sl0NYokwUoAUN24sSv6ORYgm7E?=
 =?us-ascii?Q?oxETBPflQ87TPp3BAgRcJKU+UFE80UYfxJZ6VPNvAlpKOmtJdEVnjT/uFefv?=
 =?us-ascii?Q?sISegX+k2Fm6S5U79ugpeRk1Ue0IOiNFXuOLHl1Ne9m4E6D9up/5TUcCwMiY?=
 =?us-ascii?Q?sR1wU+Nero5ZCeMJb0h/4oSfLWwKFyj6+4+1/qK+59jDAiVLkE1PrGRPdDIE?=
 =?us-ascii?Q?MYoh2FRp1B6Qk6mrgrydYHpVVIrH36Al71pOo73lmkr7AiABhUzlUzsV/oW2?=
 =?us-ascii?Q?ss661KH+zjzNNvUhvThyc95Ymv2OTPNDVvgJ4PyI8GVkagHjazPGi/+/ha/c?=
 =?us-ascii?Q?ZdfWx4J/8C8aP+fNcrfvI/lnp4QwFMyEMyFDSFZpy/IU3eL5EZV3hKN+1rkf?=
 =?us-ascii?Q?8eMm08N8HeVKVTvEnKytMDt715C/u3iopX07u8iC1CqknIqssEH9CZs2C8l0?=
 =?us-ascii?Q?GXoeJxKw1TmVOeZEuqJ0tvdAwArbaHMtdLiiFN+XgEJzwezT5g3rHSdA5l0Y?=
 =?us-ascii?Q?stV5quqfytzpSxewLYTXwLiCmG/vEynBl+g2WELWfl8MLx0qTqsWj/9zLjee?=
 =?us-ascii?Q?rRV3L7cQYc++X1HC8t3efQxLumteqeYahL76l+gnRap1z85igbRclFNEKePy?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db063ad2-c943-4809-12fc-08dbb216f6d0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2023 15:59:50.6535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGtU5RSqdV3aql1j6pcfkTi9iLE04sYX5jnFgeoTTrDQMT2rDDYDiyfhLj9acr6s20PmifZJyiP2dcz95u+dRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6941
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



Hello,

kernel test robot noticed "INFO:rcu_sched_detected_stalls_on_CPUs/tasks" on:

commit: 2e4f53117a649fdb8ccae2df5a4eb76b87c01ed6 ("serial: 8250: implement non-BKL console")
https://git.kernel.org/cgit/linux/kernel/git/rt/linux-rt-devel.git linux-6.5.y-rt-rebase

in testcase: boot

compiler: clang-16
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309102359.47ac0da8-oliver.sang@intel.com


[  167.273569][    C0] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  167.273679][    C0] rcu: 	1-...!: (0 ticks this GP) idle=1a34/1/0x40000000 softirq=11586/11586 fqs=0
[  167.273715][    C0] rcu: 	(detected by 0, t=105002 jiffies, g=6757, q=16 ncpus=2)
[  167.273724][    C0] Sending NMI from CPU 0 to CPUs 1:
[  167.273757][    C1] NMI backtrace for cpu 1
[  167.273760][    C1]
[  167.273762][    C1] ================================
[  167.273763][    C1] WARNING: inconsistent lock state
[  167.273765][    C1] 6.5.2-00053-g2e4f53117a64 #1 Tainted: G S      W       T
[  167.273767][    C1] --------------------------------
[  167.273768][    C1] inconsistent {INITIAL USE} -> {IN-NMI} usage.
[  167.273770][    C1] swapper/0/1 [HC1[1]:SC0[0]:HE0:SE1] takes:
[ 167.273773][ C1] c34fcd9c (console_srcu){....}-{0:0}, at: rcu_lock_acquire (include/linux/rcupdate.h:302) 
[  167.273787][    C1] {INITIAL USE} state was registered at:
[ 167.273789][ C1] lock_sync (kernel/locking/lockdep.c:5800) 
[ 167.273795][ C1] srcu_lock_sync (include/linux/srcu.h:128) 
[ 167.273800][ C1] __synchronize_srcu (kernel/rcu/srcutree.c:1347) 
[ 167.273804][ C1] synchronize_srcu (kernel/rcu/srcutree.c:1442) 
[ 167.273806][ C1] unregister_console_locked (kernel/printk/printk.c:3739) 
[ 167.273810][ C1] register_console (kernel/printk/printk.c:3681) 
[ 167.273814][ C1] univ8250_console_init (drivers/tty/serial/8250/8250_core.c:?) 
[ 167.273819][ C1] console_init (include/linux/jump_label.h:270 include/trace/events/initcall.h:48 kernel/printk/printk.c:3837) 
[ 167.273822][ C1] start_kernel (init/main.c:1005) 
[ 167.273828][ C1] i386_start_kernel (arch/x86/kernel/head32.c:56) 
[ 167.273831][ C1] startup_32_smp (??:?) 
[  167.273834][    C1] irq event stamp: 19150472
[ 167.273836][ C1] hardirqs last enabled at (19150471): _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 167.273841][ C1] hardirqs last disabled at (19150472): _raw_spin_lock_irqsave (arch/x86/include/asm/preempt.h:80 include/linux/spinlock_api_smp.h:109 kernel/locking/spinlock.c:162) 
[ 167.273846][ C1] softirqs last enabled at (19149630): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[ 167.273852][ C1] softirqs last disabled at (19149623): do_softirq_own_stack (arch/x86/kernel/irq_32.c:57 arch/x86/kernel/irq_32.c:147) 
[  167.273857][    C1]
[  167.273857][    C1] other info that might help us debug this:
[  167.273858][    C1]  Possible unsafe locking scenario:
[  167.273858][    C1]
[  167.273859][    C1]        CPU0
[  167.273860][    C1]        ----
[  167.273861][    C1]   lock(console_srcu);
[  167.273864][    C1]   <Interrupt>
[  167.273865][    C1]     lock(console_srcu);
[  167.273867][    C1]
[  167.273867][    C1]  *** DEADLOCK ***
[  167.273867][    C1]
[  167.273868][    C1] 4 locks held by swapper/0/1:
[ 167.273870][ C1] #0: c6a11af8 (&tty->legacy_mutex){+.+.}-{3:3}, at: tty_lock (drivers/tty/tty_mutex.c:19) 
[ 167.273880][ C1] #1: eea4317c (&port->mutex){+.+.}-{3:3}, at: tty_port_open (arch/x86/include/asm/bitops.h:207 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/tty_port.h:213 drivers/tty/tty_port.c:781) 
[ 167.273889][ C1] #2: c450ca9c (&port_lock_key){....}-{2:2}, at: serial8250_do_startup (drivers/tty/serial/8250/8250_port.c:?) 
[ 167.273899][ C1] #3: c34fcd9c (console_srcu){....}-{0:0}, at: rcu_lock_acquire (include/linux/rcupdate.h:302) 
[  167.273907][    C1]
[  167.273907][    C1] stack backtrace:
[  167.273910][    C1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G S      W       T  6.5.2-00053-g2e4f53117a64 #1
[  167.273913][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  167.273916][    C1] Call Trace:
[ 167.273919][ C1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 167.273924][ C1] ? vprintk (kernel/printk/printk_safe.c:69) 
[ 167.273929][ C1] dump_stack (lib/dump_stack.c:113) 
[ 167.273933][ C1] print_usage_bug (kernel/locking/lockdep.c:?) 
[ 167.273938][ C1] verify_lock_unused (kernel/locking/lockdep.c:5685) 
[ 167.273943][ C1] lock_acquire (kernel/locking/lockdep.c:5744) 
[ 167.273948][ C1] ? trace_raw_output_console (include/linux/rcupdate.h:302) 
[ 167.273953][ C1] rcu_lock_acquire (include/linux/rcupdate.h:303) 
[ 167.273958][ C1] ? trace_raw_output_console (include/linux/rcupdate.h:302) 
[ 167.273961][ C1] console_srcu_read_lock (kernel/printk/printk.c:292) 
[ 167.273965][ C1] cons_atomic_flush (kernel/printk/printk_nobkl.c:?) 
[ 167.273970][ C1] vprintk_emit (kernel/printk/printk.c:2306) 
[ 167.273976][ C1] vprintk_deferred (kernel/printk/printk.c:4100) 
[ 167.273981][ C1] vprintk (kernel/printk/printk_safe.c:69) 
[ 167.273986][ C1] _printk (kernel/printk/printk.c:2370) 
[ 167.273989][ C1] nmi_cpu_backtrace (lib/nmi_backtrace.c:109) 
[ 167.273995][ C1] ? cons_read_seq (kernel/printk/printk_nobkl.c:938) 
[ 167.273999][ C1] nmi_cpu_backtrace_handler (arch/x86/kernel/apic/hw_nmi.c:?) 
[ 167.274003][ C1] nmi_handle (arch/x86/kernel/nmi.c:?) 
[ 167.274007][ C1] ? ct_nmi_enter (kernel/context_tracking.c:297) 
[ 167.274011][ C1] ? cons_read_seq (kernel/printk/printk_nobkl.c:938) 
[ 167.274015][ C1] default_do_nmi (arch/x86/kernel/nmi.c:347) 
[ 167.274021][ C1] exc_nmi (arch/x86/kernel/nmi.c:538) 
[ 167.274026][ C1] asm_exc_nmi (??:?) 
[ 167.274030][ C1] EIP: console_try_acquire (kernel/printk/printk_nobkl.c:938) 
[ 167.274035][ C1] Code: 5d 31 c0 31 d2 c3 0f 1f 40 00 55 89 e5 56 8b 70 5c a1 18 ce 4f c3 e8 1f 2e 00 00 89 c1 29 f1 29 c8 83 da 00 5e 5d 31 c9 c3 90 <55> 89 e5 89 c1 e8 06 00 00 00 5d 31 c9 c3 66 90 55 89 e5 53 57 56
All code
========
   0:	5d                   	pop    %rbp
   1:	31 c0                	xor    %eax,%eax
   3:	31 d2                	xor    %edx,%edx
   5:	c3                   	retq   
   6:	0f 1f 40 00          	nopl   0x0(%rax)
   a:	55                   	push   %rbp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %rsi
   e:	8b 70 5c             	mov    0x5c(%rax),%esi
  11:	a1 18 ce 4f c3 e8 1f 	movabs 0x2e1fe8c34fce18,%eax
  18:	2e 00 
  1a:	00 89 c1 29 f1 29    	add    %cl,0x29f129c1(%rcx)
  20:	c8 83 da 00          	enterq $0xda83,$0x0
  24:	5e                   	pop    %rsi
  25:	5d                   	pop    %rbp
  26:	31 c9                	xor    %ecx,%ecx
  28:	c3                   	retq   
  29:	90                   	nop
  2a:*	55                   	push   %rbp		<-- trapping instruction
  2b:	89 e5                	mov    %esp,%ebp
  2d:	89 c1                	mov    %eax,%ecx
  2f:	e8 06 00 00 00       	callq  0x3a
  34:	5d                   	pop    %rbp
  35:	31 c9                	xor    %ecx,%ecx
  37:	c3                   	retq   
  38:	66 90                	xchg   %ax,%ax
  3a:	55                   	push   %rbp
  3b:	89 e5                	mov    %esp,%ebp
  3d:	53                   	push   %rbx
  3e:	57                   	push   %rdi
  3f:	56                   	push   %rsi

Code starting with the faulting instruction
===========================================
   0:	55                   	push   %rbp
   1:	89 e5                	mov    %esp,%ebp
   3:	89 c1                	mov    %eax,%ecx
   5:	e8 06 00 00 00       	callq  0x10
   a:	5d                   	pop    %rbp
   b:	31 c9                	xor    %ecx,%ecx
   d:	c3                   	retq   
   e:	66 90                	xchg   %ax,%ax
  10:	55                   	push   %rbp
  11:	89 e5                	mov    %esp,%ebp
  13:	53                   	push   %rbx
  14:	57                   	push   %rdi
  15:	56                   	push   %rsi


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230910/202309102359.47ac0da8-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

