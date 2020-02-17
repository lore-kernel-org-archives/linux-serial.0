Return-Path: <SRS0=lWnk=4F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35554C761A4
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 11:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E4620836
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 11:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgBQLkV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Feb 2020 06:40:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:26496 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728901AbgBQLkU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Feb 2020 06:40:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 03:40:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,452,1574150400"; 
   d="scan'208";a="228394915"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 17 Feb 2020 03:40:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9B66F2BA; Mon, 17 Feb 2020 13:40:16 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 0/6] serial: Disable DMA and PM on kernel console
Date:   Mon, 17 Feb 2020 13:40:10 +0200
Message-Id: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is third version to get rid of problematic DMA and PM calls in
the serial kernel console code.

Patches 1, 3 and 4 are preparatory ones.

After previous discussion Tony suggested to add a possibility to detach
and attach back kernel console from user space. It's done in the patch 2.

Kernel console is sensitive to any kind of complex work needed to print
out anything on it. One such case is emergency print during Oops.

More details on topic are in the commit messages of the patches 5 and 6.

The series has been tested on few Intel platforms.

Note, it depends to recently submitted and applied patches in
the core console code [2, 3]. Petr, may you confirm that [3] is
immutable or even send Greg KH a PR?

Greg, see above note before applying, thanks!

[1]: https://lore.kernel.org/patchwork/cover/905632/
[2]: https://lore.kernel.org/lkml/20200203133130.11591-1-andriy.shevchenko@linux.intel.com/
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/log/?h=for-5.7-console-exit

Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Petr Mladek <pmladek@suse.com>

Changelog v3:
- dropped applied patches
- dropped "cleanup" DMA patches, that they were not tested and actually are regressions
- added DEVICE_ATTR_RO/_RW conversion patches (Greg)
- added pr_*() to dev_*() conversion patch (Greg)
- updated commit message to note OMAP behaviour change (Russell)
- replace run-time PM callbacks to be _sync() (Tony)

Changelog v2:
- added possibility to detach and attach back console from userspace (Tony)
- reworded commit messages in patches 5 and 6 (Sebastian)
- dropped console patch (it had been pushed separately [2])

Andy Shevchenko (6):
  serial: core: Switch to use DEVICE_ATTR_RO()
  serial: core: Allow detach and attach serial device for console
  serial: 8250_port: Switch to use DEVICE_ATTR_RW()
  serial: 8250_port: Use dev_*() instead of pr_*()
  serial: 8250_port: Don't use power management for kernel console
  serial: 8250_port: Disable DMA operations for kernel console

 Documentation/ABI/testing/sysfs-tty |   7 ++
 drivers/tty/serial/8250/8250_core.c |   9 +++
 drivers/tty/serial/8250/8250_port.c |  64 +++++++++------
 drivers/tty/serial/serial_core.c    | 117 ++++++++++++++++++++--------
 include/linux/serial_8250.h         |   1 +
 5 files changed, 141 insertions(+), 57 deletions(-)

--
2.25.0

