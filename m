Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75605C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 22 Nov 2021 12:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbhKVMJR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Nov 2021 07:09:17 -0500
Received: from mga07.intel.com ([134.134.136.100]:40281 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhKVMJQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 07:09:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="298184674"
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="298184674"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 04:06:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="456617097"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 22 Nov 2021 04:06:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1F3E6B8; Mon, 22 Nov 2021 14:06:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jay Dolan <jay.dolan@accesio.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/2] serial: 8250_pci patches to address issues with pericom_do_set_divisor()
Date:   Mon, 22 Nov 2021 14:06:02 +0200
Message-Id: <20211122120604.3909-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

A series patches to address three issues one customer managed to hit
all at once.

1) Fourth port not being setup correctly on some Pericom chips. Fix
the entries in pci_serial_quirks array.

2) Rewrite pericom_do_set_divisor() to always calc divisor and to use
the uartclk instead of a hard coded value. Always calculate divisor
without passing control to serial8250_do_set_divisor().

Jay, can you test this again, please?

Changelog v3:
- fix possible division by 0 in patch 2 (Jay)

Changelog v2:
- dropped no-fixes patch, left only fixes here
- amended refactoring of the ->set_divisor()
- fixed Fixes tags

Jay Dolan (2):
  serial: 8250_pci: Fix ACCES entries in pci_serial_quirks array
  serial: 8250_pci: rewrite pericom_do_set_divisor()

 drivers/tty/serial/8250/8250_pci.c | 39 +++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 14 deletions(-)

-- 
2.33.0

