Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2833DC433F5
	for <linux-serial@archiver.kernel.org>; Mon,  4 Apr 2022 08:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiDDIc5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Apr 2022 04:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbiDDIck (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Apr 2022 04:32:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5A935AA4
        for <linux-serial@vger.kernel.org>; Mon,  4 Apr 2022 01:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649061043; x=1680597043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RoHbAwM38hUlTpoJ3Pktnqw41Zoe+0jl6/0G7fo9OQI=;
  b=TdOtpHXT1cxrMGHSn76XHmf/j+Yqe1iMUJBZmxP34KUf5bDp5QiUlcgo
   KmUrH0AFL7A1Ny7unnFG5trjEOdHWv6km3WWOu7mC7lMlLWFfbM4VlPiJ
   u7+/KB7DjP9Ex9PMN4j5+GGUzrvxteoqfhoV2W/aiT3SjiDLC1KwngWJl
   Xh2LdZKhbSARAn3pOIgbGjHzAf0IE0uvjTVuCUGEkFx+F1MxJDwkZXsZQ
   f4fzKepY4MIOFbMoIus0iVv8VkJIf5uh3bl6QFBcEW7MR/d83i3AKBXq0
   u4QXIYHWk07YTE38gD3k2Kriow7t3T5auzY6nq+11zLanBWLTRwK9pwuf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="241053050"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="241053050"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 01:30:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="569293806"
Received: from rhamza-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.211.126])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 01:30:39 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 11/12] serial: 8250_lpss: Use 32-bit reads
Date:   Mon,  4 Apr 2022 11:29:11 +0300
Message-Id: <20220404082912.6885-12-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404082912.6885-1-ilpo.jarvinen@linux.intel.com>
References: <20220404082912.6885-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use 32-bit reads in order to not lose higher bits of DW
UART regs.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 0f5af061e0b4..4ba43bef9933 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -330,7 +330,7 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	uart.port.irq = pci_irq_vector(pdev, 0);
 	uart.port.private_data = &lpss->data;
 	uart.port.type = PORT_16550A;
-	uart.port.iotype = UPIO_MEM;
+	uart.port.iotype = UPIO_MEM32;
 	uart.port.regshift = 2;
 	uart.port.uartclk = lpss->board->base_baud * 16;
 	uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE;
-- 
2.30.2

