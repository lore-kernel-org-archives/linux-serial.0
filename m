Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B04C001DE
	for <linux-serial@archiver.kernel.org>; Fri, 21 Jul 2023 21:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjGUVMD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 Jul 2023 17:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjGUVMD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 Jul 2023 17:12:03 -0400
X-Greylist: delayed 344 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Jul 2023 14:11:57 PDT
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D39E359D;
        Fri, 21 Jul 2023 14:11:57 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 80C4986D18;
        Fri, 21 Jul 2023 23:06:10 +0200 (CEST)
From:   =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.com,
        =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: [PATCH 01/10] tty: serial: 8250: Define earlycon for mrvl,mmp-uart
Date:   Fri, 21 Jul 2023 22:37:43 +0200
Message-ID: <20230721210042.21535-2-duje.mihanovic@skole.hr>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721210042.21535-1-duje.mihanovic@skole.hr>
References: <20230721210042.21535-1-duje.mihanovic@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

mrvl,pxa-uart already supports earlycon and both compatible strings use
the same driver, so there's no reason for mmp-uart to not have earlycon
as well.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 drivers/tty/serial/8250/8250_pxa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index 28b341f602c6..a5b3ea27fc90 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -183,6 +183,7 @@ static int __init early_serial_pxa_setup(struct earlycon_device *device,
 	return early_serial8250_setup(device, NULL);
 }
 OF_EARLYCON_DECLARE(early_pxa, "mrvl,pxa-uart", early_serial_pxa_setup);
+OF_EARLYCON_DECLARE(mmp, "mrvl,mmp-uart", early_serial_pxa_setup);
 #endif
 
 MODULE_AUTHOR("Sergei Ianovich");
-- 
2.41.0


