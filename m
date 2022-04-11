Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C34C4167E
	for <linux-serial@archiver.kernel.org>; Mon, 11 Apr 2022 08:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbiDKIg6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Apr 2022 04:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239294AbiDKIg4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Apr 2022 04:36:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B273616C
        for <linux-serial@vger.kernel.org>; Mon, 11 Apr 2022 01:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649666072; x=1681202072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RoHbAwM38hUlTpoJ3Pktnqw41Zoe+0jl6/0G7fo9OQI=;
  b=PkJedDP2kpWXnwxKKyRLPpjojziMApEFPU7dSu3NnvpK0A9VDGwsJ+b9
   LmMa0uaCTUi0gjpc0u3GaWQ95YGhCN6gDia4CV67g3+vPBfaPX47Bo9mB
   PI9q3gBTmZsfPgQ8Q5ECqNz1P8ldo7ur7vSY0K8eZifwmng4n+MACHEnM
   1Oru6UxhdcI98l/ebVlaLWjxIbUTKaR8HofLHaUs6uHcNDSAjbET4kmVt
   i90RK01C0qHUsqH+C5P9hCL7pR2Z8Ep1XFw1XtzGyB742nbghMk2DnzSd
   lSwGWO1EB6oMb2fHME9mSEldMVztxknkUaafhLLi++GZPMqemSPkqt+d3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="262246346"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="262246346"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:34:32 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="572028860"
Received: from azahoner-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:34:29 -0700
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
Subject: [PATCH v3 11/12] serial: 8250_lpss: Use 32-bit reads
Date:   Mon, 11 Apr 2022 11:33:20 +0300
Message-Id: <20220411083321.9131-12-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
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

