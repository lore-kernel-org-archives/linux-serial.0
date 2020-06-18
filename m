Return-Path: <SRS0=rTT/=77=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61435C433E0
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 16:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E013208C7
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 16:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgFRQsO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:48:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:18733 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732035AbgFRQsA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Jun 2020 12:48:00 -0400
IronPort-SDR: 5MWh+y/XlxQepES0Ksq5pdL/oAb2mbygpAQXz4o+JYXqwA1djyzYDy02djRAZBHHvhPU4fdo04
 UjPZiOaVfCQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="142595297"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="142595297"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 09:47:59 -0700
IronPort-SDR: gnwiKIZgSkk3/AxCIm8t/GILe68cRFc4Z0vydQtAGTORUP0KdGveh0V1As8ajOuWcNEh5jdrc9
 7hO+YzG6PkPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="262979081"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 18 Jun 2020 09:47:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A318513B; Thu, 18 Jun 2020 19:47:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/6] console: unify return codes from ->setup() hook
Date:   Thu, 18 Jun 2020 19:47:45 +0300
Message-Id: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some of the console providers treat error code, returned by ->setup() hook,
differently. Here is the unification of the behaviour.

The drivers checked by one of the below criteria:
1/ the driver has explicit struct console .setup assignment
2/ the driver has assigned callback to the setup member

All such drivers were read in order to see if there is any problematic return
codes, and fixed accordingly which is this series in the result.

Andy Shevchenko (6):
  mips: Return proper error code from console ->setup() hook
  serial: sunsab: Return proper error code from console ->setup() hook
  serial: sunzilog: Return proper error code from console ->setup() hook
  tty: hvc: Return proper error code from console ->setup() hook
  console: Propagate error code from console ->setup()
  console: Fix trivia typo 'change' -> 'chance'

 arch/mips/fw/arc/arc_con.c    | 4 +++-
 drivers/tty/hvc/hvsi.c        | 2 +-
 drivers/tty/serial/sunsab.c   | 2 +-
 drivers/tty/serial/sunzilog.c | 2 +-
 kernel/printk/printk.c        | 8 ++++----
 5 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.27.0

