Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E85C83F10
	for <linux-serial@archiver.kernel.org>; Thu, 31 Aug 2023 14:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjHaO7a (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 31 Aug 2023 10:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHaO73 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 31 Aug 2023 10:59:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F027719A
        for <linux-serial@vger.kernel.org>; Thu, 31 Aug 2023 07:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693493965; x=1725029965;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bAlykBBRRe0MFqKpbSb4Eo/OFmjbwXO9yw1Iiwt/XAM=;
  b=UI+RVCGBQ1jFG2zMYBVTP7CWOHVQUjIuDmNoL32dheNCudrHo9JvDdiw
   yyDA/jwfsxK0ouSzUh1EZy6DKolIF2BRu22fGiL6e92cV8P1ZH6DyRxaJ
   s6pqxB0wNaH45zS9682mD4XM/3ATWCz/bFLvldwSfRLQ5+wcI1ZyKlUhf
   JEiohIY2hVksddHWcWs2hew7tPp4TrooAgwoYoSvFZUyZ8pq8GelHAVZ1
   r9of0pQ+WUy1WjhTp18Lq3JDfakoAUh02dTiO4R86df2tzExNaBQE3WmX
   6HqfTZAY/h76DFbAaM+Q1waX/DyWAeUWYvLpHgH/nUPo1ChjrLTzDK7Mj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="356281169"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="356281169"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 07:59:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="854312210"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="854312210"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 07:59:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 07:59:23 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 07:59:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 07:59:23 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 07:59:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdbK44VUshkdJxPIDeO/o8UoISOdRQwuqPpJYQ+17cDorQLWj6Qn2XSkm8cGdUxbsRgXXjVsQ7t/WUDhv2lhFG93if0EfGh9IZFfO5S+H2LXhGzP38mWgYRU5e0zvI53/kYlNDiYaMsueKFXrK+yxsjsZG5JFBXbKO7Ku7IpoID3tIpt+nq8wN9JbS9MngYHgRvV3C5X4SmSIs4emymnIYBnyEHzi3VtAF+wbHZd/mxFA0lts+yJoEvye6fcdJSWBInAZTkWzTxQNHTGXoIb3X9RM8ZInRAWeP3AH0CZf4kVzP2LrLl2MEgmbWuHCF55g20uUNaW8/7L2H3UEAQQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpo02v/lDXV/NFKbAWnUkKeufyBK5QSQfDhP+s6TcOE=;
 b=R75awCVs4FpNfBWdCXpt3hTvpbwze6X6vn6+u88UtoUae0ReMtHnX2/wpGxfgDiUstgogOHBzU7m9QL5gA6UgU5jQnX/R5fLW76nB4OKSxD0Qp0CgIwxy4Xsf5BCY8yiDQAtJ2c0PmNSWaYPs0A+aS8HXJ2VdjkbYV1aCI+I/Bxmw664vvugT31tH6+higFw2MAQ8HUaWzB6kKIJMhRny+K1JnIv9//wxSwNIuvS01p+rhrlMmjVPd8mpm7kZMDlI8R4DJVCxslN7ce2VGt0D0gEj6Y5RIzt8tPgh+7zsBb9rXnQEpwItrn8cn8/sHiReuuTL6SOu3uuyfz+x6f/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA1PR11MB7040.namprd11.prod.outlook.com (2603:10b6:806:2b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 14:59:20 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 14:59:20 +0000
Date:   Thu, 31 Aug 2023 22:59:11 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     John Ogness <john.ogness@linutronix.de>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <linux-serial@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [rt-devel:linux-6.5.y-rt-rebase] [serial] bbed94a61d:
 INFO:rcu_preempt_detected_stalls_on_CPUs/tasks
Message-ID: <202308312242.eb909be8-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA1PR11MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c9a53a7-82fd-4d80-1103-08dbaa32dab6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DYe94a5w4fEj+f5lfOlL2DxBe/Jc8yndB5BB9AY9n2FthAG9GoI4spKZ9jikLnuMkRruKaKxvq5MCgbXDv9M64SGv9MIlIkgV456yrwYjifypBTMAmFe6GgF2CU5dvKcYQRveCaCpR95fq42abIR5FuZPSbwaXgTWTTuSKDbjzsygYwaOTaeK4U0SaKbf7BAm5s9s+uxhfrWmzFnx3APv9Top3p9i9TK7O3W+wCMR/IoqVsH5agBLoD5BEA9k8w9LlRj6bEH/d8XB+7q+7WnO6TVm1HMYdKzFDA5ftAZEnyuV/hCOTWOHOFbwEdVSRSD3y5rcpy+zGq3kJHKcXkHZlF5LHuCzyc8Xk5ZTTd3EH4jqJ01PGmZasxhIKlifvy8bmiJshc39+/DvA7Q5J75JmloDUmLOWSXiOsNrO5gFzDMZ9UCuTmByhOZlOVF8i7dTy0o+/WjjVIxdFkA2V8l0yEBLFM/L/vQhHWNQkOXrL5y3oR++UGe4ec/aAeH0SgwZRacEWVeqKOoYlpBrY9wRMaFTTlW4UA9vtuH9DVxFS6WxrV5goHSW1XErWtH7sQLIDDTwZM3Gv5DlcrLZq8jiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199024)(186009)(1800799009)(478600001)(38100700002)(26005)(1076003)(36756003)(966005)(66946007)(41300700001)(6512007)(2616005)(83380400001)(107886003)(82960400001)(66476007)(66556008)(316002)(6666004)(6486002)(6506007)(6916009)(5660300002)(4326008)(8936002)(8676002)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I4W5Rjple8DqG8z+BhgIP1c4eD7sBBfelSR2+37VqWjX/oa+KQ+2HtoDDwyD?=
 =?us-ascii?Q?QVjUdgFjxssIi2fHmBxMJK3P7Dc72xnGcCp6tHFjhuHOAaBPK3XtSCYzSXcU?=
 =?us-ascii?Q?giz7ucsutmS4dr3ba5vcnvofqq+xLyd6VAhqMcsbzjq6Lw8/YoxFcsNvrqII?=
 =?us-ascii?Q?uRu/KXUraJrPSs/qOD7yGly96Xr53rMW1XzbRL8cO1mzlx7ffkQaLTVxYsn5?=
 =?us-ascii?Q?NULswVlJmhmtIeET7yGkRWcCZfXYy29yaiKbQndHW8wjBHIUfgJOFt2BKDZa?=
 =?us-ascii?Q?GupzSSqs4czPyjfUdHYu/v+qZqfLMd4QfFvlCww0KgZuSmQTWFNVnEJsj+5/?=
 =?us-ascii?Q?CpX5Ci36JlBv9yhYKcwUnbonNSgEIgsY+5TF3q4TEoOxOj4qu7zS9YxJoLSp?=
 =?us-ascii?Q?zP3YFzrBW3BPVFGELfm5x9EI3t28TdAfOQyH1TU06Yc4YYizZFCn9zGJt99E?=
 =?us-ascii?Q?nC90dWOW2kkQzF7KjHef4Sdo+oUMNZhu9cqYC09CNRGk+cDtHf3n6/7rppDG?=
 =?us-ascii?Q?SYG+2h49VBVck35j243SNIRPCARYtWvZtdnhKHlb6QSWtKom3sqm8myCVZDL?=
 =?us-ascii?Q?ivRxMc1teahC2PEm2HC+2/kmKRJ2WGwVkXNPp+14MT8w9w8cwCnOS0JXy+/N?=
 =?us-ascii?Q?ITvlJ8KT6ILzOtr4HWuXwpqYcIzHM8LHERmuO5GdjC6D96Z74uEd65Ol9Xp9?=
 =?us-ascii?Q?LZpbhr/BFBbI8UIlvQIzEbJzS34HhrJnzVd4CliJxBs0Rx2NOkuap4qB0qz1?=
 =?us-ascii?Q?HUOx7h7g16a8S8JAVSN8VO0ZcyXOGEHdd+xdKSQUA3saDUqTuaLcTV4rPWH4?=
 =?us-ascii?Q?hxgphITDVTGuhUV07LyPmXwDds/VDZt41PjkD9PycBSxzIrLZzAuQu7WrG7V?=
 =?us-ascii?Q?7r/Z86c1vKmFY+uf4Q3gDrgH7miwbrC9pC2mrgFJzUTYSnOUmkGNwuSyeoRr?=
 =?us-ascii?Q?8dRLaQS1iM3zYu5UhidxfOBHCAOFXIwtOWJexF5Ku1B+N4kNWZddaBklx2Sd?=
 =?us-ascii?Q?iumZs7hiBSTjliIcKhkhPwJQ0PIP1juLgGvwq5D+38bSM/ZU9eX0jLtBQVgq?=
 =?us-ascii?Q?OeFqhht5LVMCIAXYTlH+6RtXswgXrXExZzbGHarIk2rqEFy0RKb3HCYLS14h?=
 =?us-ascii?Q?5y5UV/ODCOSVzSmz2+q1lDBOisQjTmNIoQcH1dRzBjSbkuaGeg15K1ncoqcE?=
 =?us-ascii?Q?vHa7b1SMvcHgNrv2DIvbh99KML1IFdI4aWPlxHvnZDanSJCOlP5ToaYwTj4L?=
 =?us-ascii?Q?DIk9OqPBdJSNBFDVFij82TtHxHNVfC4z0rs7wBqKISVGevxXQBa0/rMifq8d?=
 =?us-ascii?Q?a2rFyWM/Wu9O4qiZyuzoqQmtLupdj0+hBSq/9BgoZTx6YxN2XoCSvAGsjtpQ?=
 =?us-ascii?Q?/ud7BxkWsMrNOMRVFjAMRZvbwH0JBU6jPuE9fvIL2KSZ+8k4QQDm+TZ8Xczg?=
 =?us-ascii?Q?ZKs3AbXeMWKjDHjvrSldMfIswsCcBhBgOWX58bqcSFtGg0XUffcyTzWiyENK?=
 =?us-ascii?Q?4ZPxznu9ZFB7ThOW1OMPPzZ3xZhC4RZ6/7sUx5kt7/sJertctFudimlM0hAN?=
 =?us-ascii?Q?D9Scv5ZiCk2Rt2wMQFmZgSxYb1ES0YxHBcuCmDjNmXhwpdpbx6ifoVgaCsU7?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9a53a7-82fd-4d80-1103-08dbaa32dab6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 14:59:20.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I792aMeugWmSzuf3c/USMqvaFqHSLWUZFytAwZeuhom1tvfk4W4Wfxi0IRyDSj2FtJixZXyIBsfez0PedrBCfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7040
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



Hello,

kernel test robot noticed "INFO:rcu_preempt_detected_stalls_on_CPUs/tasks" on:

commit: bbed94a61d7be55a64c9d87e0c5d55faef924f57 ("serial: 8250: implement non-BKL console")
https://git.kernel.org/cgit/linux/kernel/git/rt/linux-rt-devel.git linux-6.5.y-rt-rebase

in testcase: boot

compiler: gcc-7
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202308312242.eb909be8-oliver.sang@intel.com



[  148.995863][    C1] NMI backtrace for cpu 1
[  148.995867][    C1]
[  148.995868][    C1] ================================
[  148.995870][    C1] WARNING: inconsistent lock state
[  148.995871][    C1] 6.5.0-00051-gbbed94a61d7b #1 Tainted: G        W        N
[  148.995873][    C1] --------------------------------
[  148.995874][    C1] inconsistent {INITIAL USE} -> {IN-NMI} usage.
[  148.995876][    C1] swapper/0/1 [HC1[1]:SC0[0]:HE0:SE1] takes:
[ 148.995878][ C1] 828529a8 (console_srcu){....}-{0:0}, at: rcu_lock_acquire (include/linux/rcupdate.h:302) 
[  148.995889][    C1] {INITIAL USE} state was registered at:
[ 148.995890][ C1] lock_sync (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5811) 
[ 148.995893][ C1] __synchronize_srcu (kernel/rcu/srcutree.c:1347) 
[ 148.995897][ C1] synchronize_srcu_expedited (kernel/rcu/srcutree.c:1386) 
[ 148.995900][ C1] synchronize_srcu (kernel/rcu/srcutree.c:1439) 
[ 148.995902][ C1] unregister_console_locked (kernel/printk/printk.c:3739) 
[ 148.995905][ C1] register_console (kernel/printk/printk.c:3681) 
[ 148.995908][ C1] univ8250_console_init (drivers/tty/serial/8250/8250_core.c:754) 
[ 148.995911][ C1] console_init (kernel/printk/printk.c:3836) 
[ 148.995913][ C1] start_kernel (init/main.c:1005 (discriminator 3)) 
[ 148.995917][ C1] mk_early_pgtbl_32 (arch/x86/kernel/head32.c:74) 
[ 148.995919][ C1] startup_32_smp (arch/x86/kernel/head_32.S:305) 
[  148.995921][    C1] irq event stamp: 3902978
[ 148.995922][ C1] hardirqs last enabled at (3902977): _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 148.995926][ C1] hardirqs last disabled at (3902978): _raw_spin_lock_irqsave (arch/x86/include/asm/preempt.h:80 include/linux/spinlock_api_smp.h:109 kernel/locking/spinlock.c:162) 
[ 148.995929][ C1] softirqs last enabled at (3902962): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:413 kernel/softirq.c:595) 
[ 148.995932][ C1] softirqs last disabled at (3902951): call_on_stack (arch/x86/kernel/irq_32.c:57) 
[  148.995936][    C1]
[  148.995936][    C1] other info that might help us debug this:
[  148.995937][    C1]  Possible unsafe locking scenario:
[  148.995937][    C1]
[  148.995938][    C1]        CPU0
[  148.995938][    C1]        ----
[  148.995939][    C1]   lock(console_srcu);
[  148.995941][    C1]   <Interrupt>
[  148.995941][    C1]     lock(console_srcu);
[  148.995943][    C1]
[  148.995943][    C1]  *** DEADLOCK ***
[  148.995943][    C1]
[  148.995943][    C1] 4 locks held by swapper/0/1:
[ 148.995945][ C1] #0: ed98f914 (&tty->legacy_mutex){+.+.}-{3:3}, at: tty_lock (drivers/tty/tty_mutex.c:19) 
[ 148.995952][ C1] #1: 868f51b4 (&port->mutex){+.+.}-{3:3}, at: tty_port_open (drivers/tty/tty_port.c:781) 
[ 148.995957][ C1] #2: 8365b8d0 (&port_lock_key){....}-{2:2}, at: serial8250_do_startup (drivers/tty/serial/8250/8250_port.c:2366) 
[ 148.995964][ C1] #3: 828529a8 (console_srcu){....}-{0:0}, at: rcu_lock_acquire (include/linux/rcupdate.h:302) 
[  148.995970][    C1]
[  148.995970][    C1] stack backtrace:
[  148.995971][    C1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W        N 6.5.0-00051-gbbed94a61d7b #1
[  148.995975][    C1] Call Trace:
[ 148.995979][ C1] dump_stack_lvl (lib/dump_stack.c:107) 
[ 148.995982][ C1] dump_stack (lib/dump_stack.c:114) 
[ 148.995985][ C1] print_usage_bug (kernel/locking/lockdep.c:4008) 
[ 148.995988][ C1] ? console_list_unlock (include/linux/rcupdate.h:302) 
[ 148.995991][ C1] lock_acquire (kernel/locking/lockdep.c:5693 kernel/locking/lockdep.c:5752) 
[ 148.995994][ C1] ? console_list_unlock (include/linux/rcupdate.h:302) 
[ 148.995997][ C1] ? prb_final_commit (kernel/printk/printk_ringbuffer.c:1671) 
[ 148.996000][ C1] rcu_lock_acquire (include/linux/rcupdate.h:304) 
[ 148.996002][ C1] ? console_list_unlock (include/linux/rcupdate.h:302) 
[ 148.996005][ C1] console_srcu_read_lock (kernel/printk/printk.c:293) 
[ 148.996007][ C1] cons_atomic_flush (kernel/printk/printk_nobkl.c:1587) 
[ 148.996012][ C1] vprintk_emit (kernel/printk/printk.c:2333) 
[ 148.996017][ C1] vprintk_deferred (kernel/printk/printk.c:4101) 
[ 148.996021][ C1] vprintk (kernel/printk/printk_safe.c:65) 
[ 148.996023][ C1] _printk (kernel/printk/printk.c:2371) 
[ 148.996026][ C1] nmi_cpu_backtrace (lib/nmi_backtrace.c:110) 
[ 148.996029][ C1] nmi_cpu_backtrace_handler (arch/x86/kernel/apic/hw_nmi.c:46) 
[ 148.996033][ C1] nmi_handle (arch/x86/kernel/nmi.c:150 (discriminator 7)) 
[ 148.996037][ C1] default_do_nmi (arch/x86/kernel/nmi.c:347) 
[ 148.996041][ C1] exc_nmi (arch/x86/kernel/nmi.c:543) 
[ 148.996043][ C1] asm_exc_nmi (arch/x86/entry/entry_32.S:1149) 
[ 148.996046][ C1] EIP: cons_try_acquire (kernel/printk/printk_nobkl.c:736 kernel/printk/printk_nobkl.c:836) 
[ 148.996049][ C1] Code: 34 8d 00 00 00 00 83 e0 e3 89 55 e8 83 e7 03 c1 e7 03 09 f0 09 f8 83 e0 9f 88 45 e8 8b 45 e8 25 7f 00 00 fe 0b 45 d0 89 45 e8 <8a> 45 e4 a8 01 75 1f 8d 45 e8 8d 4d e4 31 d2 50 8b 45 e0 e8 60 fd
All code
========
   0:	34 8d                	xor    $0x8d,%al
   2:	00 00                	add    %al,(%rax)
   4:	00 00                	add    %al,(%rax)
   6:	83 e0 e3             	and    $0xffffffe3,%eax
   9:	89 55 e8             	mov    %edx,-0x18(%rbp)
   c:	83 e7 03             	and    $0x3,%edi
   f:	c1 e7 03             	shl    $0x3,%edi
  12:	09 f0                	or     %esi,%eax
  14:	09 f8                	or     %edi,%eax
  16:	83 e0 9f             	and    $0xffffff9f,%eax
  19:	88 45 e8             	mov    %al,-0x18(%rbp)
  1c:	8b 45 e8             	mov    -0x18(%rbp),%eax
  1f:	25 7f 00 00 fe       	and    $0xfe00007f,%eax
  24:	0b 45 d0             	or     -0x30(%rbp),%eax
  27:	89 45 e8             	mov    %eax,-0x18(%rbp)
  2a:*	8a 45 e4             	mov    -0x1c(%rbp),%al		<-- trapping instruction
  2d:	a8 01                	test   $0x1,%al
  2f:	75 1f                	jne    0x50
  31:	8d 45 e8             	lea    -0x18(%rbp),%eax
  34:	8d 4d e4             	lea    -0x1c(%rbp),%ecx
  37:	31 d2                	xor    %edx,%edx
  39:	50                   	push   %rax
  3a:	8b 45 e0             	mov    -0x20(%rbp),%eax
  3d:	e8                   	.byte 0xe8
  3e:	60                   	(bad)  
  3f:	fd                   	std    

Code starting with the faulting instruction
===========================================
   0:	8a 45 e4             	mov    -0x1c(%rbp),%al
   3:	a8 01                	test   $0x1,%al
   5:	75 1f                	jne    0x26
   7:	8d 45 e8             	lea    -0x18(%rbp),%eax
   a:	8d 4d e4             	lea    -0x1c(%rbp),%ecx
   d:	31 d2                	xor    %edx,%edx
   f:	50                   	push   %rax
  10:	8b 45 e0             	mov    -0x20(%rbp),%eax
  13:	e8                   	.byte 0xe8
  14:	60                   	(bad)  
  15:	fd                   	std    
[  148.996052][    C1] EAX: 00000089 EBX: 8365bb40 ECX: 00000000 EDX: 0000000d
[  148.996054][    C1] ESI: 00000000 EDI: 00000008 EBP: 865f5d30 ESP: 865f5d00
[  148.996055][    C1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000002
[ 148.996059][ C1] ? build_sched_domains (kernel/sched/topology.c:2268 kernel/sched/topology.c:1467 kernel/sched/topology.c:2494) 
[ 148.996064][ C1] ? build_sched_domains (kernel/sched/topology.c:2268 kernel/sched/topology.c:1467 kernel/sched/topology.c:2494) 
[ 148.996067][ C1] ? cons_try_acquire (kernel/printk/printk_nobkl.c:736 kernel/printk/printk_nobkl.c:836) 
[ 148.996071][ C1] console_try_acquire (kernel/printk/printk_nobkl.c:942) 
[ 148.996074][ C1] serial8250_enter_unsafe (drivers/tty/serial/8250/8250.h:222 drivers/tty/serial/8250/8250.h:250) 
[ 148.996077][ C1] serial8250_do_startup (drivers/tty/serial/8250/8250_port.c:2369) 
[ 148.996081][ C1] serial8250_startup (drivers/tty/serial/8250/8250_port.c:2513) 
[ 148.996084][ C1] uart_startup (drivers/tty/serial/serial_core.c:290 drivers/tty/serial/serial_core.c:332) 
[ 148.996086][ C1] uart_port_activate (drivers/tty/serial/serial_core.c:1967) 
[ 148.996089][ C1] tty_port_open (drivers/tty/tty_port.c:786) 
[ 148.996092][ C1] uart_open (drivers/tty/serial/serial_core.c:1950) 
[ 148.996095][ C1] tty_open (drivers/tty/tty_io.c:2154) 
[ 148.996100][ C1] chrdev_open (fs/char_dev.c:415) 
[ 148.996105][ C1] do_dentry_open (fs/open.c:915) 
[ 148.996107][ C1] ? cdev_put (fs/char_dev.c:374) 
[ 148.996110][ C1] vfs_open (fs/open.c:1049) 
[ 148.996112][ C1] path_openat (fs/namei.c:3636 fs/namei.c:3793) 
[ 148.996117][ C1] do_filp_open (fs/namei.c:3821) 
[ 148.996122][ C1] ? kmemleak_alloc (mm/kmemleak.c:724 mm/kmemleak.c:976) 
[ 148.996126][ C1] ? slab_post_alloc_hook+0x7e/0x8d 
[ 148.996132][ C1] file_open_name (fs/open.c:1353) 
[ 148.996136][ C1] filp_open (fs/open.c:1372) 
[ 148.996138][ C1] console_on_rootfs (init/main.c:1508) 
[ 148.996141][ C1] kernel_init_freeable (init/main.c:1557) 
[ 148.996144][ C1] ? rest_init (init/main.c:1429) 
[ 148.996146][ C1] kernel_init (init/main.c:1439) 
[ 148.996148][ C1] ret_from_fork (arch/x86/kernel/process.c:151) 
[ 148.996151][ C1] ? rest_init (init/main.c:1429) 
[ 148.996154][ C1] ret_from_fork_asm (arch/x86/entry/entry_32.S:741) 
[ 148.996156][ C1] entry_INT80_32 (arch/x86/entry/entry_32.S:947) 
[  148.996161][    C1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W        N 6.5.0-00051-gbbed94a61d7b #1
[ 148.996163][ C1] EIP: cons_try_acquire (kernel/printk/printk_nobkl.c:736 kernel/printk/printk_nobkl.c:836) 
[ 148.996165][ C1] Code: 34 8d 00 00 00 00 83 e0 e3 89 55 e8 83 e7 03 c1 e7 03 09 f0 09 f8 83 e0 9f 88 45 e8 8b 45 e8 25 7f 00 00 fe 0b 45 d0 89 45 e8 <8a> 45 e4 a8 01 75 1f 8d 45 e8 8d 4d e4 31 d2 50 8b 45 e0 e8 60 fd
All code
========
   0:	34 8d                	xor    $0x8d,%al
   2:	00 00                	add    %al,(%rax)
   4:	00 00                	add    %al,(%rax)
   6:	83 e0 e3             	and    $0xffffffe3,%eax


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230831/202308312242.eb909be8-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

