Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A3BC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 22 Nov 2021 13:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbhKVNiT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Nov 2021 08:38:19 -0500
Received: from mga04.intel.com ([192.55.52.120]:22860 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231935AbhKVNiT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 08:38:19 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="233504815"
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="233504815"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 05:35:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="570315801"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 22 Nov 2021 05:35:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 962DC2AC; Mon, 22 Nov 2021 15:35:14 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH v2 0/3] serial: 8250_pci: Split Pericom driver
Date:   Mon, 22 Nov 2021 15:35:09 +0200
Message-Id: <20211122133512.8947-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Split Pericom driver to a separate module.
While at it, re-enable high baud rates.

Jay, can you, please, test this on as many hardware as you have?

The series depends on the fix-series:
https://lore.kernel.org/linux-serial/20211122120604.3909-1-andriy.shevchenko@linux.intel.com/T/#u

Changelog v2:
- rebased on top of v3 of the fix-series (see above)
- added new patch 3

Andy Shevchenko (2):
  serial: 8250_pci: Split out Pericom driver
  serial: 8250_pericom: Use serial_dl_write() instead of open coded

Jay Dolan (1):
  serial: 8250_pericom: Re-enable higher baud rates

 drivers/tty/serial/8250/8250_pci.c     | 405 +------------------------
 drivers/tty/serial/8250/8250_pericom.c | 214 +++++++++++++
 drivers/tty/serial/8250/Kconfig        |   8 +
 drivers/tty/serial/8250/Makefile       |   1 +
 4 files changed, 228 insertions(+), 400 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_pericom.c

-- 
2.33.0

