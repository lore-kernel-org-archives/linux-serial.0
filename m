Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA9BCD343E
	for <linux-serial@archiver.kernel.org>; Tue, 19 Sep 2023 06:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjISGS7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Sep 2023 02:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjISGS7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Sep 2023 02:18:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55063100
        for <linux-serial@vger.kernel.org>; Mon, 18 Sep 2023 23:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695104332; x=1726640332;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WF/ZOak4XaoUe48w+xC61+9fQawWbMXm6hNlpYY4UjI=;
  b=D8HtfONVh/Z7X6KqkhXGyUe4FXRCF7j6vqC6EXyod1cUEt8kIq6peC/S
   zAqp7QwOk3RUcIiIUU1OHHQWL7AanusSEEioUK2mep/JzH4AIjhh342ML
   Ko2T9OuwmLSQOyredJH5DPFVWtPWnCt1KDzaXHOssf/6uHqedSCFWI3a6
   mMPR0joEPIdvY4YdXJdotcqnSdmYuFnY82IMXfiKz+HqP8Oe5Jb10sC00
   YZLuJf46OVjcAUTIyT0wmIlQhI6rBOuOgIqRBsfGbKNwgzT17Yti9sym5
   KB2bgNlg39XUuEYMpECq8WAhOoB+XOYwdlcvtGnKMF/qy+iM2Gt/Ebcsl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="383685140"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="383685140"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 23:18:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="869857628"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="869857628"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 23:18:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 23:18:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 23:18:47 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 23:18:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XH7hJu/MQyho31pCQFeqECYr5xyM5A5SfLb7uEj/lmwSposKJEzrLAHkZ/hEnkI8uIdB/5AhByZOiBxkF0STcC3sjqd70AfCbxHwPiP84X3h1UZpZMKbfySdqIDSLsaQ798c4EQ1tHcOdt/NXzVPXAOXpA4u4uoo6ekOrtyBZ1HxldotONhYqcQWs4sLELqq2WuWREfORVdyFGge5AAtPic+LfFUlhoBGX+9ufu2oyyEnzM/tg8vsmyhTFm4rtB9UT+FLalMBEyIiOk+syoU6F6+0eX2cKcLsD49D6UH2kEO5cm3ApN6IfhL2sMy8J/M0El6cUxCGay/KnVMcwGCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4C5DMwihYNmWaAAWN+Q0wDmmTUYm98B9NT6e/4ihBCc=;
 b=lFK4r5l6oaPzN5aQe9w9T1c0U96a4oR4FHI+yYZiCSAXy9fnWNUNG6DKGAcniWgTV4CKOcoeCUvmbKbk3spH3ysJFDQLdKHPFACvTpJN6yM7fZbLGPbYm5c87sHwGcDxWhAwejOLkXlJHynTAaffbbzU2+tPKbiupHdObuWUFU9VMFvkJl9mimQsduwXVjTN8nbRMMcFVIEYcOEGHgiURLC9jwhBIkSIta2i8PpZnl289q013BowcdppBZQMztlKDpvL5cryJx4aMfYuB3lFGc3TSVdwf1h7w99/8sIQNTPgCjt406exlfTevLj1TND9zN6R+R1lG5iT50nzad4/lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CH3PR11MB7203.namprd11.prod.outlook.com (2603:10b6:610:148::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 06:18:34 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 06:18:34 +0000
Date:   Tue, 19 Sep 2023 14:18:23 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     John Ogness <john.ogness@linutronix.de>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <linux-serial@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [rt-devel:linux-6.6.y-rt-rebase] [serial] c209576ea5:
 INFO:rcu_sched_detected_stalls_on_CPUs/tasks
Message-ID: <202309191353.5e1f2931-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CH3PR11MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: ef74fb41-6116-4a4c-641a-08dbb8d84088
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: plqRRVZhK/bDJ+wll/uIPmsavgJ7pVk9LTAr98DCWNBqomxyPprPOQ+AB60ogK9cwuVBMnsz7L+bcpQk2JqqbPUZc2qX6W6KCwm9u1OCL/0BG2bh8HhCfzUamXPTz/IxM5cXNOh+qOb59PIKMw6ZZyYp62Op90z/Ya4xpugUgMfSgNIqV22NGzokhGSD8an0zP6ZrVmrK/YAd06l++hzaF6JemhdFSe2gN0CK2NA6wZ9YzpzVbbvlCFdm7k9KLUCttT5paUujFk57JkPoLP6jbMYavBkMpJZMotPvKQUjY7G6PR6SWQD0pDqIiY0TVWXRshvr77xftAcz4qJYJSIfsDctCERIJMH+cj99cke02/ZY23CqcAScPDGOfJgr+k6ArAXnpFZpdZyD0eiliK6dcA9eZqQVPVVbnILZuMSvB7fzG/09HmbOrVr9Lsgh34IHZw9qC1cSuAiQy8FhwqnsbHcoS6M0kPsE8P0vFhiFbcBlpVO3JVu5KVGObQvg0D6772paOWKJkpIC3d5KfXliNT6xrw1RzLbuL3vAp9UnWXbl9Qr3/ikpEtDBoOveoQv5vQt0y5RmrzScWfOxwwFEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199024)(1800799009)(186009)(6486002)(966005)(6506007)(86362001)(6512007)(316002)(66946007)(41300700001)(38100700002)(66556008)(66476007)(6666004)(5660300002)(478600001)(6916009)(82960400001)(2616005)(8936002)(8676002)(26005)(2906002)(36756003)(30864003)(4326008)(107886003)(1076003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tKBqmiLrWHCkzpHL96cMHWpEtDU2D7VS+WaclIVXxcnITisRfMZp6r7e0l1j?=
 =?us-ascii?Q?/VuPzrv/ladwRY7Ju2Qfpt88gEZteN/mshesGExVYLP7mrD+fUtUC9Md3PcE?=
 =?us-ascii?Q?ucKCGtheApgGUpq+9QncleFRoK+OdgNMpjTUtEHG3Q0ExTVB4oEXYQq6rNNt?=
 =?us-ascii?Q?e8tKG0uS8L78y62PmHMZmhEplcHqJQzpTosG9fOcZYjp8f4NIsHvzHVNq+Og?=
 =?us-ascii?Q?iC6SvS4oVcZ8V4/PLWmXitogJ9VV4PVYRh3tFwpEiINDyCMl2X33A3N2bwRF?=
 =?us-ascii?Q?g0+VeVoZPpjA7tBW8VN4EKU8eC8IaU4Z3s/Zh3SybM4p7y8o7lb9y6X0oL6w?=
 =?us-ascii?Q?zilUYRUwuOV2wR5YEPSwToDvz5O5jjZuVn1zDZYJs360VYqeEhkUsAL6htY8?=
 =?us-ascii?Q?9fdZ7FwOK7mMZ0fnbqLQ9upCp8TahL1GoipLq5w+0hHlRcV+rLQNneFbXhUJ?=
 =?us-ascii?Q?3h50hYxX6CWhFvqJTTWu4OFfzGTDjLZ7RCL3bhTuoJYygySVS6KJzi7W+R/j?=
 =?us-ascii?Q?5HcYzerYi+77nRtLKjRXj3AzJhH3t/l0vgYuZtXsQ8WXSisV3/ri39OcEsyv?=
 =?us-ascii?Q?AkheaQ80t91626MiV2dt08RISddTN/fry5+vsDSOUXE8akTVFSdb47n6hQRd?=
 =?us-ascii?Q?Psx39nnhqp6bNUDaZrCsaEQJSxSxDRyonYSS2KehVSbWgUYTsYAhRYUXLJRV?=
 =?us-ascii?Q?FOuKeYTfBf0rfk1ZcWr/v0fnUofJM1NYBAIeAM+ojA8NLflAVXFar/8Or1lK?=
 =?us-ascii?Q?JUjyuf1coV6a5dAgIfZgN2TlY2W6RIpFEY4nvAXO7Ub8gHFOfkltEKnBjmyT?=
 =?us-ascii?Q?2/uBRbZCx4MLlxtuSnXuZ9aJP0y6QztI6nUuLUZEBq4yUjGgJiQWu6xQZ8T+?=
 =?us-ascii?Q?M+OAEoIXQ3LUPhxUQ7AUUCtUQG5s3yGnIVsvDpoN7MMQx5U5DGYtxc+72t09?=
 =?us-ascii?Q?H2BQckPIyJpfZHH3IDN5eVUKoB7kTS0OTPRkC32FX6EujiUsj89DCbjyr1wk?=
 =?us-ascii?Q?9EHdRllu03n/I/bQ9DLAAsoZnbqzKVTl4BuBanMB6qRMYbE2ilxknVPe7kWQ?=
 =?us-ascii?Q?PFhIyxzmHXye5JWh38czrzIlpfYxb7BtWTox+sEgTrNAQW/Lsk3a+0+vgr7W?=
 =?us-ascii?Q?8651yUleLzEFKZHhITdHh/7RQk0nSvPG2jswNS+p9rSwCYqz0SfFgeJF0B+X?=
 =?us-ascii?Q?Ps2ntbvxzDcUvAeQjC0+TioAey3S2jFHUznqDlL8PWt929XYw3HHdRmec/mZ?=
 =?us-ascii?Q?FT86fOQQvn+8F/Hyn1wfI2nnUMShJeNcoutzk+WL9XswvpdQ9CbA+/PgguMj?=
 =?us-ascii?Q?SigHFbckfJVNuj7lcx7vaCsfttgLRWD6HMUinCjSURqU6fCE4FxWpo8XGzCd?=
 =?us-ascii?Q?UOoN/4vB14i8RZN4Nh0iEDkwi8YCnnyLYSUs6LoIcdcdp6WDUTLqnJQtMtAz?=
 =?us-ascii?Q?uy5FPMHnxZEzvjcIkN3kWroWsUpFgrab4AAw9Aksp3S3cj9aA9lFuVTHiIzy?=
 =?us-ascii?Q?H5KBzBY8uXaWTSAd/wmiKqiSFtaWSl+awyN/P6G0Ftjk2aJX/Ruz/4ASYZBc?=
 =?us-ascii?Q?g9LQk8kOntjCbj3waHo3s5GiS5uG6wvE5oohXwsmG7r7iDeXkh0oy/UqcoVb?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef74fb41-6116-4a4c-641a-08dbb8d84088
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 06:18:34.0935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjh9hD5cjHBoFWauKkJWEty8DGHsK9IgjRRj+zDQQSIRkRFb3flJLq2FrUEKnk9VW5MMS9rnWA5EFD7gDfdJ0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7203
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org




Hello,

kernel test robot noticed "INFO:rcu_sched_detected_stalls_on_CPUs/tasks" on:

commit: c209576ea5dba795e84cfcb4c087171dc9285733 ("serial: 8250: implement non-BKL console")
https://git.kernel.org/cgit/linux/kernel/git/rt/linux-rt-devel.git linux-6.6.y-rt-rebase

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309191353.5e1f2931-oliver.sang@intel.com


[  184.154437][    C0] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[  184.155698][    C0] rcu: 	1-...0: (0 ticks this GP) idle=c224/1/0x4000000000000000 softirq=4954/4954 fqs=6328
[  184.156994][    C0] rcu: 	(detected by 0, t=31503 jiffies, g=1721, q=60 ncpus=2)
[  184.158001][    C0] Sending NMI from CPU 0 to CPUs 1:
[  184.158827][    C1] NMI backtrace for cpu 1
[  184.158837][    C1]
[  184.158841][    C1] ================================
[  184.158843][    C1] WARNING: inconsistent lock state
[  184.158846][    C1] 6.6.0-rc1-00043-gc209576ea5db #1 Tainted: G        W
[  184.158851][    C1] --------------------------------
[  184.158852][    C1] inconsistent {INITIAL USE} -> {IN-NMI} usage.
[  184.158855][    C1] swapper/0/1 [HC1[1]:SC0[0]:HE0:SE1] takes:
[ 184.158861][ C1] ffffffff97ee39b0 (console_srcu){....}-{0:0}, at: console_srcu_read_lock (kernel/printk/printk.c:291) 
[  184.158893][    C1] {INITIAL USE} state was registered at:
[ 184.158896][ C1] __lock_acquire (kernel/locking/lockdep.c:5090) 
[ 184.158903][ C1] lock_sync (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5803) 
[ 184.158908][ C1] __synchronize_srcu (kernel/rcu/srcutree.c:1347) 
[ 184.158913][ C1] unregister_console_locked (kernel/printk/printk.c:3755) 
[ 184.158919][ C1] register_console (kernel/printk/printk.c:3699) 
[ 184.158924][ C1] univ8250_console_init (drivers/tty/serial/8250/8250_core.c:754) 
[ 184.158935][ C1] console_init (kernel/printk/printk.c:3852) 
[ 184.158941][ C1] start_kernel (init/main.c:1005 (discriminator 3)) 
[ 184.158947][ C1] x86_64_start_reservations (arch/x86/kernel/head64.c:544) 
[ 184.158952][ C1] x86_64_start_kernel (??:?) 
[ 184.158956][ C1] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433) 
[  184.158962][    C1] irq event stamp: 3061484
[ 184.158965][ C1] hardirqs last enabled at (3061483): _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 184.158973][ C1] hardirqs last disabled at (3061484): _raw_spin_lock_irqsave (include/linux/spinlock_api_smp.h:108 kernel/locking/spinlock.c:162) 
[ 184.158979][ C1] softirqs last enabled at (3061450): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:413 kernel/softirq.c:595) 
[ 184.158985][ C1] softirqs last disabled at (3061427): irq_exit_rcu (kernel/softirq.c:440 kernel/softirq.c:663 kernel/softirq.c:679) 
[  184.159005][    C1]
[  184.159005][    C1] other info that might help us debug this:
[  184.159007][    C1]  Possible unsafe locking scenario:
[  184.159007][    C1]
[  184.159008][    C1]        CPU0
[  184.159010][    C1]        ----
[  184.159011][    C1]   lock(console_srcu);
[  184.159016][    C1]   <Interrupt>
[  184.159017][    C1]     lock(console_srcu);
[  184.159022][    C1]
[  184.159022][    C1]  *** DEADLOCK ***
[  184.159022][    C1]
[  184.159023][    C1] 4 locks held by swapper/0/1:
[ 184.159026][ C1] #0: ffff8881173d61c0 (&tty->legacy_mutex){+.+.}-{3:3}, at: tty_init_dev (drivers/tty/tty_io.c:1404) 
[ 184.159049][ C1] #1: ffff88810dd182a8 (&port->mutex){+.+.}-{3:3}, at: tty_port_open (include/linux/instrumented.h:68 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/tty_port.h:214 drivers/tty/tty_port.c:779) 
[ 184.159063][ C1] #2: ffffffff9af326f8 (&port_lock_key){....}-{2:2}, at: serial8250_do_startup (drivers/tty/serial/8250/8250_port.c:2373) 
[ 184.159078][ C1] #3: ffffffff97ee39b0 (console_srcu){....}-{0:0}, at: console_srcu_read_lock (kernel/printk/printk.c:291) 
[  184.159092][    C1]
[  184.159092][    C1] stack backtrace:
[  184.159094][    C1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W          6.6.0-rc1-00043-gc209576ea5db #1 7664dafc032eafd57dc59b7cf194852ca466eb92
[  184.159102][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  184.159106][    C1] Call Trace:
[  184.159113][    C1]  <NMI>
[ 184.159118][ C1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 184.159127][ C1] lock_acquire (kernel/locking/lockdep.c:3970 kernel/locking/lockdep.c:5685 kernel/locking/lockdep.c:5744 kernel/locking/lockdep.c:5718) 
[ 184.159133][ C1] ? lock_sync (kernel/locking/lockdep.c:5721) 
[ 184.159140][ C1] ? console_srcu_read_lock (kernel/printk/printk.c:291) 
[ 184.159147][ C1] console_srcu_read_lock (kernel/printk/printk.c:292) 
[ 184.159153][ C1] ? console_srcu_read_lock (kernel/printk/printk.c:291) 
[ 184.159159][ C1] cons_atomic_flush (kernel/printk/printk_nobkl.c:1588) 
[ 184.159168][ C1] vprintk_emit (kernel/printk/printk.c:2333) 
[ 184.159175][ C1] ? defer_console_output (kernel/printk/printk.c:2293) 
[ 184.159186][ C1] _printk (kernel/printk/printk.c:2363) 
[ 184.159192][ C1] ? kmsg_dump_get_line (kernel/printk/printk.c:2363) 
[ 184.159198][ C1] ? lock_sync (kernel/locking/lockdep.c:5721) 
[ 184.159204][ C1] ? nmi_handle (arch/x86/include/asm/preempt.h:80 include/linux/rcupdate.h:95 include/linux/rcupdate.h:747 arch/x86/kernel/nmi.c:136) 
[ 184.159211][ C1] ? __printk_cpu_sync_try_get (arch/x86/include/asm/atomic.h:109 include/linux/atomic/atomic-arch-fallback.h:2042 include/linux/atomic/atomic-instrumented.h:1214 kernel/printk/printk.c:4500) 
[ 184.159218][ C1] nmi_cpu_backtrace (lib/nmi_backtrace.c:111) 
[ 184.159226][ C1] nmi_cpu_backtrace_handler (arch/x86/kernel/apic/hw_nmi.c:47) 
[ 184.159234][ C1] nmi_handle (arch/x86/kernel/nmi.c:150 (discriminator 7)) 
[ 184.159242][ C1] default_do_nmi (arch/x86/kernel/nmi.c:347 (discriminator 22)) 
[ 184.159249][ C1] exc_nmi (arch/x86/kernel/nmi.c:537) 
[ 184.159254][ C1] end_repeat_nmi (arch/x86/entry/entry_64.S:1471) 
[ 184.159261][ C1] RIP: 0010:__cons_try_acquire (kernel/printk/printk_nobkl.c:99 kernel/printk/printk_nobkl.c:719) 
[ 184.159269][ C1] Code: 00 00 00 0f b7 47 48 f6 c4 01 0f 84 9b 08 00 00 48 8d 87 80 00 00 00 49 8d 7d 10 4c 89 74 24 30 49 bf 00 00 00 00 00 fc ff df <48> 89 44 24 18 48 c1 e8 03 4c 01 f8 48 89 7c 24 48 48 89 44 24 50
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 0f                	add    %cl,(%rdi)
   4:	b7 47                	mov    $0x47,%bh
   6:	48 f6 c4 01          	rex.W test $0x1,%spl
   a:	0f 84 9b 08 00 00    	je     0x8ab
  10:	48 8d 87 80 00 00 00 	lea    0x80(%rdi),%rax
  17:	49 8d 7d 10          	lea    0x10(%r13),%rdi
  1b:	4c 89 74 24 30       	mov    %r14,0x30(%rsp)
  20:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  27:	fc ff df 
  2a:*	48 89 44 24 18       	mov    %rax,0x18(%rsp)		<-- trapping instruction
  2f:	48 c1 e8 03          	shr    $0x3,%rax
  33:	4c 01 f8             	add    %r15,%rax
  36:	48 89 7c 24 48       	mov    %rdi,0x48(%rsp)
  3b:	48 89 44 24 50       	mov    %rax,0x50(%rsp)

Code starting with the faulting instruction
===========================================
   0:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
   5:	48 c1 e8 03          	shr    $0x3,%rax
   9:	4c 01 f8             	add    %r15,%rax
   c:	48 89 7c 24 48       	mov    %rdi,0x48(%rsp)
  11:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
[  184.159274][    C1] RSP: 0000:ffff8881008ef778 EFLAGS: 00000002
[  184.159279][    C1] RAX: ffffffff9858bf60 RBX: ffffffff9af32aa0 RCX: fefefefefefefefe
[  184.159283][    C1] RDX: 0000000000000000 RSI: ffffffff97ee39b0 RDI: ffffffff9af32ab0
[  184.159303][    C1] RBP: ffffffff9af32aa0 R08: 0000000000000000 R09: 0000000000000000
[  184.159307][    C1] R10: ffffffff9af32aa0 R11: 0000000000000001 R12: fffffbfff35e6554
[  184.159311][    C1] R13: ffffffff9af32aa0 R14: 1ffff1102011defc R15: dffffc0000000000
[ 184.159320][ C1] ? __cons_try_acquire (kernel/printk/printk_nobkl.c:99 kernel/printk/printk_nobkl.c:719) 
[ 184.159327][ C1] ? __cons_try_acquire (kernel/printk/printk_nobkl.c:99 kernel/printk/printk_nobkl.c:719) 
[  184.159333][    C1]  </NMI>
[  184.159335][    C1]  <TASK>
[ 184.159339][ C1] ? lock_sync (kernel/locking/lockdep.c:5721) 
[ 184.159345][ C1] ? cons_try_acquire_spin (kernel/printk/printk_nobkl.c:708) 
[ 184.159351][ C1] ? spin_bug (kernel/locking/spinlock_debug.c:113) 
[ 184.159358][ C1] console_try_acquire (kernel/printk/printk_nobkl.c:836 kernel/printk/printk_nobkl.c:941) 
[ 184.159364][ C1] ? console_srcu_read_lock (kernel/printk/printk.c:291) 
[ 184.159369][ C1] serial8250_do_startup (drivers/tty/serial/8250/8250.h:222 drivers/tty/serial/8250/8250.h:250 drivers/tty/serial/8250/8250_port.c:2374) 
[ 184.159381][ C1] uart_port_startup (drivers/tty/serial/serial_core.c:288) 
[ 184.159388][ C1] uart_port_activate (drivers/tty/serial/serial_core.c:331 drivers/tty/serial/serial_core.c:322 drivers/tty/serial/serial_core.c:1960) 
[ 184.159394][ C1] tty_port_open (drivers/tty/tty_port.c:784) 
[ 184.159400][ C1] ? check_tty_count (arch/x86/include/asm/bitops.h:207 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/tty_port.h:224 drivers/tty/tty_io.c:288) 
[ 184.159407][ C1] uart_open (drivers/tty/serial/serial_core.c:1941) 
[ 184.159412][ C1] tty_open (drivers/tty/tty_io.c:2144) 
[ 184.159419][ C1] ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2155 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 kernel/locking/spinlock_debug.c:115) 
[ 184.159425][ C1] ? tty_init_dev (drivers/tty/tty_io.c:2112) 
[ 184.159433][ C1] chrdev_open (fs/char_dev.c:414) 
[ 184.159439][ C1] ? __unregister_chrdev (fs/char_dev.c:374) 
[ 184.159444][ C1] ? fsnotify_perm+0x141/0x4e0 
[ 184.159452][ C1] do_dentry_open (fs/open.c:929) 
[ 184.159458][ C1] ? __unregister_chrdev (fs/char_dev.c:374) 
[ 184.159463][ C1] ? may_open (fs/namei.c:3268) 
[ 184.159470][ C1] do_open (fs/namei.c:3639) 
[ 184.159478][ C1] path_openat (fs/namei.c:3797) 
[ 184.159486][ C1] ? do_mknodat (fs/namei.c:3778) 
[ 184.159494][ C1] do_filp_open (fs/namei.c:3823) 
[ 184.159512][ C1] ? may_open_dev (fs/namei.c:3817) 
[ 184.159517][ C1] ? lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5755 kernel/locking/lockdep.c:5718) 
[ 184.159530][ C1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4565) 
[ 184.159538][ C1] file_open_name (fs/open.c:1361) 
[ 184.159544][ C1] ? __ia32_sys_openat (fs/open.c:1361) 
[ 184.159550][ C1] ? getname_kernel (fs/namei.c:250) 
[ 184.159556][ C1] filp_open (fs/open.c:1388) 
[ 184.159561][ C1] console_on_rootfs (init/main.c:1508) 
[ 184.159569][ C1] kernel_init_freeable (init/main.c:1558) 
[ 184.159574][ C1] ? rest_init (init/main.c:1429) 
[ 184.159579][ C1] kernel_init (init/main.c:1439) 
[ 184.159584][ C1] ? _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 184.159589][ C1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 184.159597][ C1] ? rest_init (init/main.c:1429) 
[ 184.159602][ C1] ret_from_fork_asm (arch/x86/entry/entry_64.S:312) 
[  184.159611][    C1]  </TASK>
[  184.159615][    C1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W          6.6.0-rc1-00043-gc209576ea5db #1 7664dafc032eafd57dc59b7cf194852ca466eb92
[  184.159621][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 184.159624][ C1] RIP: 0010:__cons_try_acquire (kernel/printk/printk_nobkl.c:99 kernel/printk/printk_nobkl.c:719) 
[ 184.159630][ C1] Code: 00 00 00 0f b7 47 48 f6 c4 01 0f 84 9b 08 00 00 48 8d 87 80 00 00 00 49 8d 7d 10 4c 89 74 24 30 49 bf 00 00 00 00 00 fc ff df <48> 89 44 24 18 48 c1 e8 03 4c 01 f8 48 89 7c 24 48 48 89 44 24 50
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 0f                	add    %cl,(%rdi)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230919/202309191353.5e1f2931-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

