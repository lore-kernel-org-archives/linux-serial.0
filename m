Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B54E7734F
	for <linux-serial@archiver.kernel.org>; Sat, 30 Sep 2023 02:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjI3Ckb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Sep 2023 22:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjI3Cka (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Sep 2023 22:40:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDDFDD
        for <linux-serial@vger.kernel.org>; Fri, 29 Sep 2023 19:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696041628; x=1727577628;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dzuxYsGjLajwbHTu9rRZRh2x3oN8RrICtugTA0pbHBY=;
  b=M13GSNdWTQRr4BzVGJ1MY41CCYh1HumYW1bFe/1AxXhlXUzjenHx3KPd
   4ANj5P29NlPxtbe9rb8hSqXj5yUQdaj0XB6DEF+mtEHZBUTVko5a8ND3/
   vVCviGCeiC3BSqBw265pxbV69jHCXwjFFXxclVSFEbjKKV2dJEcK5SSOH
   bVqZgSZ8ZSPLwOdXrQ0c09TWQ+2DuphU9dpTDaQ7qQ1la4eWSeNH6u77O
   WIjkFDgYMasVJKED+D864eZKPoc+ny+RGLAz7oxPQXuGNTBqiAQXExH6M
   O01IW3dQP3qp0KNcqNz9d5OwAjVCbJpBs2hHHmDaR5mpSZaEOV+ZR3BDs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="3991113"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="3991113"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 19:40:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="753557296"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="753557296"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 19:40:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 19:40:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 19:40:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 19:40:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 19:40:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5bbxm2bjeRtfc2HIeqr9xgcR0kbubZVLtAvF3M/dH8tsfXqT1iJ5wvUCQhWiYth2vjD96CnwJq/CXG3AGnvTQh0JQnitm3v9Qyjlh4KxZ+PO615TwWS/jctMQNUQ7jGo8SkFQ9tiTHeCaGUakqzGpW9gLXQ+6fWBm1XTJNj0cI2SDwOQyk+RjdpLWXj7pwXOorxGCLd+MfPU8Yt1VauKcJP8VTHsbwAHvfE1LFXf1AxIXYXLMNH7kieAHVMr3HaXFistSc+GTB3ssfPPZwfCzSg0A6ZRKmgFUHUFwupgqjHFZfjZ5bBnwqMaMs761gt6WgaDA6DJsXzAEmycIncGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12eZ5+DKcCUk583jZfaeKvbzAMnvGgeF5ft4xDQd1pU=;
 b=NBhbYjvTimN9XVw97n3wMUkWgu/EurfIbWnFb/5TkKiA/LHwk70v97dgmigk7xS4UcKshCws4KCDS94wrUmEKP9kh2fBiA0iA7aPnSMK47nbPx0cb9zBObZaQ9bZYQUsPUvIQaUoiDUeLwQ7rZCAL55NxfkeC37YpKTgQNm/j8X/A4K8BT34Ltmw6ZYMG6EG9kwJ+NCfCO3eTQbgx4tWiuJM4Kr+0uy6zrmoEWpeJ37TBDKC0oIgg1Ua+FKwIMFGLfxSUDVYJLLbsgs1nhMgiaswbyD1ZBua2dp4UbnDEkgS7skZtD8EYo+syGRRfawNTWmaQJ527YTGw69iZdqkKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SN7PR11MB7973.namprd11.prod.outlook.com (2603:10b6:806:2e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Sat, 30 Sep
 2023 02:40:19 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6813.017; Sat, 30 Sep 2023
 02:40:18 +0000
Date:   Sat, 30 Sep 2023 10:40:09 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     John Ogness <john.ogness@linutronix.de>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <linux-serial@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [rt-devel:linux-6.6.y-rt-rebase] [serial] 7ae7fa6bcb:
 dmesg.inconsistent{INITIAL_USE}->{IN-NMI}usage
Message-ID: <202309301045.1475d353-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SN7PR11MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e97606-a842-461a-bdfa-08dbc15e9537
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmBlrD69o6uUFBG5S/3UpjxOVsuV/sVdnm2Zi+ag8uKYiRS9+8YgZ+kNj4YjYAqXhVqAKA9F3BJ/LhX8HR+J/QdRBRybAUA9rVsqB3apM68C1RE/jcZMnlcP8wAZwxmM0ZRWWBLg0D2sYtVtmx2rljoTHHfiUTbSmTEnmTPwnpcvUykmMOdvyppFHPnbQzPmifr4gPMu6BtIN+0a+M+qHWfJrfgJ/fpsygtEnSId0SoKNUFrOFP7Ru7UelQsMBgXT8bIz8A02EfKxnylPbc42NqY3vAM6BGp4EtzVT7cZnLAFEPDrsXmuZAI3X/DR3cMGw06ZuJoKburW187TkrzReVshez/+ZtsyaSjMwZilXGftRkD6QCDS8gV8YPBO/SEha+RWvkxk8owr5U8L0igwRL/u6i7RKn2qdeHmeY32CRpMpdGnxxc0Jw/b9+pBcwZZxTiW0jK6Kp7a67CNuyXCzvqECny1LhvwLZAy5wzuSYmkM2K9CV8YLCuWASy1smT9rsPHoYWRHyd4xyVmwZK4PoCijLEAfsIsIJARZlTFiD2xd7GsyTM4e/uIjz8JnFmkLsqmJlaXe4q1iveGUc59g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(66946007)(316002)(66556008)(66476007)(6916009)(36756003)(8936002)(4326008)(8676002)(26005)(41300700001)(1076003)(107886003)(2616005)(6486002)(83380400001)(478600001)(966005)(6506007)(6666004)(6512007)(86362001)(38100700002)(82960400001)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zGsRYdV7/8PDodGhzxVouX0okWE/B98s/YfdJ25thhmimCbVBbXRDJA5Os7n?=
 =?us-ascii?Q?mDm10bGksIPKkaeU041MNnxSuwJjV+pp60FpZjCSSxxlEfL2MdgDBmTN1lmI?=
 =?us-ascii?Q?6MYgLSdslJq9mVdleZrc2C4o1KojoUg+rzDKG7ThXnAh8wVtCxy0ZxNruSm8?=
 =?us-ascii?Q?OyLX2j6fvJ+v8/+qZXgrL5gdtVTiDx708u72n3z53IKSFqzA3nKLko9VpoC3?=
 =?us-ascii?Q?cgGJEx83Gr69oM5jf2c8tCVBLU95pR1/630x96jjhF6S0re1nuVlr7ykA5ia?=
 =?us-ascii?Q?oQoNof6R7HheqKE/26O8fh73QAJJmhDGUGhJgr65gPhizCaCvbpa10LdvvQI?=
 =?us-ascii?Q?zDujPXEAZtfKPgMJCN1j3DlpTS/dW/ulfGEd5M1ecFsuw5ca8IqHj6zcmSE9?=
 =?us-ascii?Q?esjgWaYQS/GcuwGzbSJLWqn13salDL+Zo+hFomJgsr23cxlQRXanCJWIy1B2?=
 =?us-ascii?Q?RhjpODO63m9UAukZfpwnwmucvdp8ZGxH/0NbDYH2x0cxzJVRb91lhfzLxld8?=
 =?us-ascii?Q?w2dPoLGXX2WBNV7P3FtY2hKwKGICxAQ++s8kCgULKZxhWGgj5PgqTMp8oofM?=
 =?us-ascii?Q?Kn0DrYNRk9vMuyG0fa1IKenyyRjVHRkICo79diELVuRFIeQ8l5XMElx+H+mI?=
 =?us-ascii?Q?Mu0jQqcaSAufrF6p9sJdjyeqbmCviLINxKKEqKol+QOZO6G9P736hgAA+QOO?=
 =?us-ascii?Q?nGEBQSBQ5fynIplbgAtYmT1nCve+27l8kJomKcL26XK5CQNNbWs+B1PkqcTA?=
 =?us-ascii?Q?eT118LZr5lQp7C+XXeNNOHhfk5aTQ6jXsaTlYCrxMWa7iRwbiNmrR4P2/KvS?=
 =?us-ascii?Q?Hj/+XI5wR8PJKUK1JIO69yNdi8JKvEeI6W7ZKpur8pXcq2zgbi4xrXPjNU9M?=
 =?us-ascii?Q?jMNOelCwiJu8kAKWOt+SMWkl1ZS/v6CvswGbnLiT1l7bUbaVqSV5CiVZ7nv/?=
 =?us-ascii?Q?Db8klz8IzFErkfbnC9+Q23Bp/VZbSO+oyJ2nVkCZqVfrWVIapq5RtmgLKTSh?=
 =?us-ascii?Q?mwE4dCjXzMGKGY7gL1xfc98ag2KnhAbOAny8T3MSxbVUOwOqshMRXLrQyE13?=
 =?us-ascii?Q?mFdpc67zuonusPdifsppvUmcYMW6oHBgvpKnwfVKcUCJCWsv84hT9QTMDo4J?=
 =?us-ascii?Q?O2yNyZsOgxShDnn4Q6w7UkxU2jOIkjdu57imxlqVyAQw08+F7dWRaFS35W3O?=
 =?us-ascii?Q?LLvVL3mDZmSB+y3rNHNjaXi8t1nYLFtV+LrLsXJfOXv4cNy26IxA2or0Tj+c?=
 =?us-ascii?Q?yR2LA0q2b4PR+syA7/hd2v1/SUmLdAWW91zg+sJ4jckM4HeKEw+W56/eKDU0?=
 =?us-ascii?Q?DwbcS/X4uvshKuXYUZTU5MUwke5skhQgAQn+ZABwCS3fOg7Lmr2Ri6XceaxK?=
 =?us-ascii?Q?CwxQHhmq3FM9FkJQUyiOF/s2widtZk2mO+Fh+ajUe6uctVfKLnJzeGSUhsB4?=
 =?us-ascii?Q?H47r4FT5FvK/vXs+5IxOJ0CJ86+cHU8GbCf9K5h7WWKrC12dFfAJmFiVaO1U?=
 =?us-ascii?Q?NlvAw/L9pvFYjUafNjBLUpO7EVQPn+k38NMX87QyWgZo7tqLdkncSHrLt4uU?=
 =?us-ascii?Q?Ic8MeVyd/1WqmoHb1RQLd7zct6zz1joghNnlVf8k?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e97606-a842-461a-bdfa-08dbc15e9537
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2023 02:40:18.0238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xESwecnP3rWb+Frffw/lS99Hc/l1qRbZrgSFKydwFUhN917CGCq4USgANi3+18CaCPjJWpTR039luvPGG5qKkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7973
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



Hello,

kernel test robot noticed "dmesg.inconsistent{INITIAL_USE}->{IN-NMI}usage" on:

commit: 7ae7fa6bcb29a234a2e618f94bb69f533cecaf53 ("serial: 8250: implement non-BKL console")
https://git.kernel.org/cgit/linux/kernel/git/rt/linux-rt-devel.git linux-6.6.y-rt-rebase

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309301045.1475d353-oliver.sang@intel.com



[  504.779539][    C1] NMI backtrace for cpu 1
[  504.779544][    C1] 
[  504.779546][    C1] ================================
[  504.779547][    C1] WARNING: inconsistent lock state
[  504.779549][    C1] 6.6.0-rc3-00047-g7ae7fa6bcb29 #1 Tainted: G        W        N
[  504.779551][    C1] --------------------------------
[  504.779552][    C1] inconsistent {INITIAL USE} -> {IN-NMI} usage.
[  504.779554][    C1] swapper/0/1 [HC1[1]:SC0[0]:HE0:SE1] takes:
[  504.779557][    C1] c383e7c8 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x0/0x58
[  504.779571][    C1] {INITIAL USE} state was registered at:
[  504.779572][    C1]   __lock_acquire+0x2d1/0xb68
[  504.779579][    C1]   lock_sync+0x80/0xd0
[  504.779583][    C1]   __synchronize_srcu+0x4c/0x168
[  504.779588][    C1]   synchronize_srcu+0x9a/0xc0
[  504.779591][    C1]   unregister_console_locked+0xaa/0x228
[  504.779594][    C1]   register_console+0x33d/0x500
[  504.779598][    C1]   univ8250_console_init+0x1b/0x30
[  504.779604][    C1]   console_init+0x46/0x21c
[  504.779610][    C1]   start_kernel+0x240/0x490
[  504.779614][    C1]   i386_start_kernel+0x43/0x44
[  504.779618][    C1]   startup_32_smp+0x156/0x158
[  504.779621][    C1] irq event stamp: 224066784
[  504.779622][    C1] hardirqs last  enabled at (224066783): [<c26e24e5>] _raw_spin_unlock_irqrestore+0x51/0x80
[  504.779630][    C1] hardirqs last disabled at (224066784): [<c26e22c5>] _raw_spin_lock_irqsave+0x5d/0x60
[  504.779635][    C1] softirqs last  enabled at (224065172): [<c2555944>] fib_create_info+0x66c/0x8e0
[  504.779639][    C1] softirqs last disabled at (224065170): [<c2555888>] fib_create_info+0x5b0/0x8e0
[  504.779642][    C1] 
[  504.779642][    C1] other info that might help us debug this:
[  504.779643][    C1]  Possible unsafe locking scenario:
[  504.779643][    C1] 
[  504.779644][    C1]        CPU0
[  504.779645][    C1]        ----
[  504.779645][    C1]   lock(console_srcu);
[  504.779648][    C1]   <Interrupt>
[  504.779649][    C1]     lock(console_srcu);
[  504.779651][    C1] 
[  504.779651][    C1]  *** DEADLOCK ***
[  504.779651][    C1] 
[  504.779652][    C1] 4 locks held by swapper/0/1:
[  504.779654][    C1]  #0: cb13ccf0 (&tty->legacy_mutex){+.+.}-{3:3}, at: tty_lock+0x2b/0x54
[  504.779665][    C1]  #1: cb17117c (&port->mutex){+.+.}-{3:3}, at: tty_port_open+0x48/0xc0
[  504.779674][    C1]  #2: c4719e70 (&port_lock_key){....}-{2:2}, at: serial8250_do_startup+0x2a6/0xb70
[  504.779682][    C1]  #3: c383e7c8 (console_srcu){....}-{0:0}, at: console_srcu_read_lock+0x0/0x58
[  504.779689][    C1] 
[  504.779689][    C1] stack backtrace:
[  504.779691][    C1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W        N 6.6.0-rc3-00047-g7ae7fa6bcb29 #1
[  504.779695][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  504.779697][    C1] Call Trace:
[  504.779699][    C1]  dump_stack_lvl+0x70/0xe0
[  504.779704][    C1]  dump_stack+0x12/0x18
[  504.779707][    C1]  print_usage_bug+0x26b/0x360
[  504.779713][    C1]  lock_acquire+0x1cc/0x2a0
[  504.779718][    C1]  ? prb_final_commit+0x1a/0x2c
[  504.779723][    C1]  ? console_srcu_read_lock_is_held+0x2c/0x2c
[  504.779727][    C1]  console_srcu_read_lock+0x4e/0x58
[  504.779730][    C1]  ? console_srcu_read_lock_is_held+0x2c/0x2c
[  504.779733][    C1]  cons_atomic_flush+0x4c/0x390
[  504.779738][    C1]  vprintk_emit+0x8d/0x300
[  504.779743][    C1]  vprintk_deferred+0x29/0x30
[  504.779747][    C1]  vprintk+0x28/0x38
[  504.779750][    C1]  _printk+0x18/0x1c
[  504.779752][    C1]  nmi_cpu_backtrace+0xc3/0x1cc
[  504.779758][    C1]  nmi_cpu_backtrace_handler+0xa/0x10
[  504.779762][    C1]  nmi_handle+0x124/0x30c
[  504.779768][    C1]  ? nmi_handle+0x18/0x30c
[  504.779773][    C1]  default_do_nmi+0x36/0x1bc
[  504.779781][    C1]  exc_nmi+0xde/0x118
[  504.779785][    C1]  asm_exc_nmi+0xae/0x29c
[  504.779790][    C1] EIP: serial8250_do_startup+0x954/0xb70
[  504.779794][    C1] Code: c6 02 00 8b 45 ec ba 01 00 00 00 8b 7d e4 89 90 84 02 00 00 89 b8 5c 02 00 00 8b 45 e8 e8 14 43 51 ff 84 c0 75 34 f3 90 85 f6 <8b> 55 f0 bf 40 00 00 00 74 86 c6 02 00 8d 52 01 bf 3f 00 00 00 f6
[  504.779797][    C1] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
[  504.779799][    C1] ESI: 00000000 EDI: c3993800 EBP: c4acbcd4 ESP: c4acbc9c
[  504.779801][    C1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000046
[  504.779806][    C1]  ? trace_raw_output_console+0x2f/0x64
[  504.779812][    C1]  ? serial8250_do_startup+0x954/0xb70
[  504.779815][    C1]  ? mark_held_locks+0x43/0x68
[  504.779821][    C1]  serial8250_startup+0x19/0x1c
[  504.779824][    C1]  uart_port_startup+0xec/0x264
[  504.779829][    C1]  uart_startup+0x26/0x38
[  504.779832][    C1]  uart_port_activate+0x37/0x74
[  504.779836][    C1]  tty_port_open+0x6d/0xc0
[  504.779840][    C1]  uart_open+0x15/0x20
[  504.779844][    C1]  tty_open+0x13a/0x698
[  504.779848][    C1]  ? chrdev_open+0x1c7/0x1f8
[  504.779854][    C1]  ? tty_init_dev+0x204/0x204
[  504.779857][    C1]  chrdev_open+0x99/0x1f8
[  504.779861][    C1]  ? __unregister_chrdev+0x3c/0x3c
[  504.779865][    C1]  do_dentry_open+0x1e5/0x540
[  504.779871][    C1]  ? inode_permission+0x63/0x1b4
[  504.779875][    C1]  ? __unregister_chrdev+0x3c/0x3c
[  504.779879][    C1]  vfs_open+0x2e/0x38
[  504.779883][    C1]  do_open+0x22d/0x384
[  504.779888][    C1]  path_openat+0xcb/0x1d4
[  504.779891][    C1]  ? kmem_cache_alloc+0x189/0x390
[  504.779898][    C1]  do_filp_open+0xa2/0x144
[  504.779906][    C1]  file_open_name+0x180/0x1a8
[  504.779911][    C1]  filp_open+0x2b/0x5c
[  504.779916][    C1]  console_on_rootfs+0x1a/0x58
[  504.779920][    C1]  ? wait_for_initramfs+0x38/0x60
[  504.779923][    C1]  kernel_init_freeable+0x196/0x2dc
[  504.779927][    C1]  ? kernel_init+0x15/0x1c4
[  504.779930][    C1]  ? rest_init+0x18c/0x18c
[  504.779933][    C1]  kernel_init+0x15/0x1c4
[  504.779936][    C1]  ? schedule_tail+0x4e/0x54
[  504.779941][    C1]  ret_from_fork+0x35/0x40
[  504.779946][    C1]  ? rest_init+0x18c/0x18c
[  504.779950][    C1]  ret_from_fork_asm+0x12/0x18
[  504.779953][    C1]  entry_INT80_32+0xf0/0xf0
[  504.779959][    C1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W        N 6.6.0-rc3-00047-g7ae7fa6bcb29 #1
[  504.779962][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  504.779964][    C1] EIP: serial8250_do_startup+0x954/0xb70
[  504.779968][    C1] Code: c6 02 00 8b 45 ec ba 01 00 00 00 8b 7d e4 89 90 84 02 00 00 89 b8 5c 02 00 00 8b 45 e8 e8 14 43 51 ff 84 c0 75 34 f3 90 85 f6 <8b> 55 f0 bf 40 00 00 00 74 86 c6 02 00 8d 52 01 bf 3f 00 00 00 f6
[  504.779970][    C1] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
[  504.779972][    C1] ESI: 00000000 EDI: c3993800 EBP: c4acbcd4 ESP: c4acbc9c
[  504.779975][    C1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000046
[  504.779978][    C1] CR0: 80050033 CR2: b7efdcd4 CR3: 03d2d000 CR4: 000406d0
[  504.779985][    C1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  504.779987][    C1] DR6: fffe0ff0 DR7: 00000400
[  504.779989][    C1] Call Trace:
[  504.779990][    C1]  ? show_regs+0x51/0x58
[  504.779994][    C1]  ? nmi_cpu_backtrace+0xca/0x1cc
[  504.779999][    C1]  ? nmi_cpu_backtrace_handler+0xa/0x10
[  504.780003][    C1]  ? nmi_handle+0x124/0x30c
[  504.780006][    C1]  ? nmi_handle+0x18/0x30c
[  504.780011][    C1]  ? default_do_nmi+0x36/0x1bc
[  504.780016][    C1]  ? exc_nmi+0xde/0x118
[  504.780020][    C1]  ? asm_exc_nmi+0xae/0x29c
[  504.780024][    C1]  ? trace_raw_output_console+0x2f/0x64
[  504.780029][    C1]  ? serial8250_do_startup+0x954/0xb70
[  504.780033][    C1]  ? serial8250_do_startup+0x954/0xb70
[  504.780036][    C1]  ? mark_held_locks+0x43/0x68
[  504.780042][    C1]  serial8250_startup+0x19/0x1c
[  504.780045][    C1]  uart_port_startup+0xec/0x264
[  504.780049][    C1]  uart_startup+0x26/0x38
[  504.780053][    C1]  uart_port_activate+0x37/0x74
[  504.780057][    C1]  tty_port_open+0x6d/0xc0
[  504.780061][    C1]  uart_open+0x15/0x20
[  504.780065][    C1]  tty_open+0x13a/0x698
[  504.780068][    C1]  ? chrdev_open+0x1c7/0x1f8
[  504.780072][    C1]  ? tty_init_dev+0x204/0x204
[  504.780076][    C1]  chrdev_open+0x99/0x1f8
[  504.780080][    C1]  ? __unregister_chrdev+0x3c/0x3c
[  504.780083][    C1]  do_dentry_open+0x1e5/0x540
[  504.780088][    C1]  ? inode_permission+0x63/0x1b4
[  504.780091][    C1]  ? __unregister_chrdev+0x3c/0x3c
[  504.780095][    C1]  vfs_open+0x2e/0x38
[  504.780099][    C1]  do_open+0x22d/0x384
[  504.780103][    C1]  path_openat+0xcb/0x1d4
[  504.780107][    C1]  ? kmem_cache_alloc+0x189/0x390
[  504.780112][    C1]  do_filp_open+0xa2/0x144
[  504.780120][    C1]  file_open_name+0x180/0x1a8
[  504.780125][    C1]  filp_open+0x2b/0x5c
[  504.780130][    C1]  console_on_rootfs+0x1a/0x58
[  504.780134][    C1]  ? wait_for_initramfs+0x38/0x60
[  504.780137][    C1]  kernel_init_freeable+0x196/0x2dc
[  504.780141][    C1]  ? kernel_init+0x15/0x1c4
[  504.780145][    C1]  ? rest_init+0x18c/0x18c
[  504.780148][    C1]  kernel_init+0x15/0x1c4
[  504.780151][    C1]  ? schedule_tail+0x4e/0x54
[  504.780155][    C1]  ret_from_fork+0x35/0x40
[  504.780158][    C1]  ? rest_init+0x18c/0x18c
[  504.780161][    C1]  ret_from_fork_asm+0x12/0x18
[  504.780164][    C1]  entry_INT80_32+0xf0/0xf0



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230930/202309301045.1475d353-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

