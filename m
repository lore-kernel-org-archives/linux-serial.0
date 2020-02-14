Return-Path: <SRS0=POds=4C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561D3C3B197
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 11:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292AC222C2
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 11:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgBNLnp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Feb 2020 06:43:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:15840 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbgBNLnp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 06:43:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 03:43:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,440,1574150400"; 
   d="scan'208";a="238340371"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 14 Feb 2020 03:43:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7A9161F6; Fri, 14 Feb 2020 13:43:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/8] serial: Disable DMA and PM on kernel console
Date:   Fri, 14 Feb 2020 13:43:31 +0200
Message-Id: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is second attempt [1] to get rid of problematic DMA and PM calls
in the serial kernel console code.

Kernel console is sensitive to any kind of complex work needed to print
out anything on it. One such case is emergency print during Oops.

Patches 1-3 are preparatory ones.

After previous discussion Tony suggested to add a possibility to detach
and attach back kernel console from user space. It's done on patch 4 here.

More details on topic are in the commit messages of patches 5 and 6.

Patches 7 and 8 are deduplicate follow ups to patch 6.

The series has been tested on few Intel platforms.

Note, it depends to recently submitted and applied patches in the core
console code [2].

[1]: https://lore.kernel.org/patchwork/cover/905632/
[2]: https://lore.kernel.org/lkml/20200203133130.11591-1-andriy.shevchenko@linux.intel.com/

Changelog v2:
- added possibility to detach and attach back console from userspace (Tony)
- reworded commit messages in patches 5 and 6 (Sebastian)
- dropped console patch (it had been pushed separately [2])

Andy Shevchenko (8):
  serial: core: Introduce uart_console_enabled() helper
  serial: core: Consolidate spin lock initialization code
  serial: core: use octal permissions on module param
  serial: core: Allow detach and attach serial device for console
  serial: 8250_port: Don't use power management for kernel console
  serial: 8250_port: Disable DMA operations for kernel console
  serial: 8250_mtk: Remove duplicating code to disable DMA
  serial: 8250_omap: Remove duplicating code to disable DMA

 Documentation/ABI/testing/sysfs-tty |   7 ++
 drivers/tty/serial/8250/8250_core.c |   9 ++
 drivers/tty/serial/8250/8250_mtk.c  |   4 -
 drivers/tty/serial/8250/8250_omap.c |   4 -
 drivers/tty/serial/8250/8250_port.c |  36 ++++++--
 drivers/tty/serial/serial_core.c    | 123 ++++++++++++++++++++--------
 include/linux/serial_8250.h         |   1 +
 7 files changed, 134 insertions(+), 50 deletions(-)

-- 
2.25.0

