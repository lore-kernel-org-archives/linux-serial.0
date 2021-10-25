Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B76C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 25 Oct 2021 12:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 582D560EFF
	for <linux-serial@archiver.kernel.org>; Mon, 25 Oct 2021 12:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhJYMo6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Oct 2021 08:44:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:26935 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233140AbhJYMo5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Oct 2021 08:44:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="229910449"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="229910449"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 05:41:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="485660131"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 25 Oct 2021 05:41:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A20D7107; Mon, 25 Oct 2021 15:41:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] serial: 8250_pci: Remove empty stub pci_quatech_exit()
Date:   Mon, 25 Oct 2021 15:41:41 +0300
Message-Id: <20211025124142.18041-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The ->exit() callback is checked for presence anyway,
no need to have an empty stub.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 1d5579143fc8..80ac3235ec35 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1298,10 +1298,6 @@ static int pci_quatech_setup(struct serial_private *priv,
 	return pci_default_setup(priv, board, port, idx);
 }
 
-static void pci_quatech_exit(struct pci_dev *dev)
-{
-}
-
 static int pci_default_setup(struct serial_private *priv,
 		  const struct pciserial_board *board,
 		  struct uart_8250_port *port, int idx)
@@ -2176,7 +2172,6 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_quatech_init,
 		.setup		= pci_quatech_setup,
-		.exit		= pci_quatech_exit,
 	},
 	/*
 	 * Panacom
-- 
2.33.0

