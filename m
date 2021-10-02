Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E12BC4332F
	for <linux-serial@archiver.kernel.org>; Sat,  2 Oct 2021 18:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F5B61284
	for <linux-serial@archiver.kernel.org>; Sat,  2 Oct 2021 18:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhJBSxe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 2 Oct 2021 14:53:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:20462 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233900AbhJBSxe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 2 Oct 2021 14:53:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10125"; a="225382165"
X-IronPort-AV: E=Sophos;i="5.85,342,1624345200"; 
   d="scan'208";a="225382165"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2021 11:51:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,342,1624345200"; 
   d="scan'208";a="522074578"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Oct 2021 11:51:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5CAE5177; Sat,  2 Oct 2021 21:51:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Aman Kumar <aman.kumar@intel.com>
Subject: [PATCH v1 2/2] serial: 8250_lpss: Enable PSE UART Auto Flow Control
Date:   Sat,  2 Oct 2021 21:51:41 +0300
Message-Id: <20211002185141.31652-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211002185141.31652-1-andriy.shevchenko@linux.intel.com>
References: <20211002185141.31652-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Aman Kumar <aman.kumar@intel.com>

Add a call to the custom ->set_termios() which has implementation about
changing the state of RTS and CTS.

Signed-off-by: Aman Kumar <aman.kumar@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 398d2c4a40e3..d3bafec7619d 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -164,6 +164,9 @@ static int ehl_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 	 * matching with the registered General Purpose DMA controllers.
 	 */
 	up->dma = dma;
+
+	port->set_termios = dw8250_do_set_termios;
+
 	return 0;
 }
 
-- 
2.33.0

