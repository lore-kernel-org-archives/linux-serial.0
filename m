Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D911C433B4
	for <linux-serial@archiver.kernel.org>; Thu, 15 Apr 2021 21:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CDFE61182
	for <linux-serial@archiver.kernel.org>; Thu, 15 Apr 2021 21:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbhDOVKb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Apr 2021 17:10:31 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:60368 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235184AbhDOVKa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Apr 2021 17:10:30 -0400
Received: from passgat-Modern-14-A10M.homenet.telecomitalia.it
 ([95.244.94.151])
        by smtp-35.iol.local with ESMTPA
        id X9FQlqwfIpK9wX9FVlNnYm; Thu, 15 Apr 2021 23:10:05 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1618521005; bh=BU6QpTHMH2NJnQ1rC1dBMw85xBIg/eYek96M3arDbWo=;
        h=From;
        b=uTofGlBA0z88ttAwNDxPLQc7o/c10hFUbzF+etzTRQV7RlBl0gPjOa6OspxDuLLk3
         Nz7BPAD4IuNj6G9bqQJcOk+hKyGC3OwBQv7mBtwj8MUgrzG92PgqOaZHXOG5HY/NgI
         va6djABeHf2mRgIChy3PNmvhR01eqG20b13Fcr+bDi4wcbFOV+6lzAX0ZBzlrd3wq0
         vAwXVkYDeiFN7bZ2jaKb+WzP67nKt0e1AJfkeXVCh0Ld+5LiAsIqN+Qxse7FHNP7ra
         LinfocnorSGcE45+Y19Fw1ppEEo56gurV6SiqtB4WDz38uVJGh7QUnv1U9b8IXhv/E
         pQ/P3MEQr7ljQ==
X-CNFS-Analysis: v=2.4 cv=A9ipg4aG c=1 sm=1 tr=0 ts=6078abad cx=a_exe
 a=ugxisoNCKEotYwafST++Mw==:117 a=ugxisoNCKEotYwafST++Mw==:17
 a=49ILBaynaru_GK_EE9QA:9
From:   Dario Binacchi <dariobin@libero.it>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dariobin@libero.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Mark Jackson <mpfj-list@newflow.co.uk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v2] serial: omap: don't disable rs485 if rts gpio is missing
Date:   Thu, 15 Apr 2021 23:09:45 +0200
Message-Id: <20210415210945.25863-1-dariobin@libero.it>
X-Mailer: git-send-email 2.17.1
X-CMAE-Envelope: MS4xfAdsLpJws4AmXieEViH67zPzWlgOmx3vf+HqnAlq1Kx+/8bsDmqh1YUtnZaR6+58/iZXX18SpygmRKw5OV/l8FcB12JL6VxT4wCtvoHzRmJDvDZoTyLt
 yhyCvLS6h51QeCD8Af+fGSZBGThbJT5+iVf30GUrW7r5E+4k5qU3vraVWuDenNqY2uBswdXhD9h/Cb38HY525Bw/tbQ7l7o1sMm/TzTfTvhcmxdgESvbWRTZ
 lLm+5P7nHFQyELUZEO9azCWaLKjsymyb3v1j1Atgm8OpUAtot0jErezCtc+a7PehySxDM47k0RHGdiYp7lcDxB8zDFLECramKotbtKaN4sMX2/dG/Wqd0BcQ
 d+vOCBY0RkXc77KoHYaNkdGGbl3luUho1eH/GLCaATeUNzEvlS8S6eWURm1wau83xXGTcIE3
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There are rs485 transceivers (e.g. MAX13487E/MAX13488E) which
automatically disable or enable the driver and receiver to keep the bus
in the correct state.
In these cases we don't need a GPIO for flow control.

Fixes: 4a0ac0f55b18 ("OMAP: add RS485 support")
Signed-off-by: Dario Binacchi <dariobin@libero.it>

---

Changes in v2:
- Add 'Fixes' tag

 drivers/tty/serial/omap-serial.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 76b94d0ff586..1583e93b2202 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -302,7 +302,8 @@ static void serial_omap_stop_tx(struct uart_port *port)
 			serial_out(up, UART_OMAP_SCR, up->scr);
 			res = (port->rs485.flags & SER_RS485_RTS_AFTER_SEND) ?
 				1 : 0;
-			if (gpiod_get_value(up->rts_gpiod) != res) {
+			if (up->rts_gpiod &&
+			    gpiod_get_value(up->rts_gpiod) != res) {
 				if (port->rs485.delay_rts_after_send > 0)
 					mdelay(
 					port->rs485.delay_rts_after_send);
@@ -411,7 +412,7 @@ static void serial_omap_start_tx(struct uart_port *port)
 
 		/* if rts not already enabled */
 		res = (port->rs485.flags & SER_RS485_RTS_ON_SEND) ? 1 : 0;
-		if (gpiod_get_value(up->rts_gpiod) != res) {
+		if (up->rts_gpiod && gpiod_get_value(up->rts_gpiod) != res) {
 			gpiod_set_value(up->rts_gpiod, res);
 			if (port->rs485.delay_rts_before_send > 0)
 				mdelay(port->rs485.delay_rts_before_send);
@@ -1407,18 +1408,13 @@ serial_omap_config_rs485(struct uart_port *port, struct serial_rs485 *rs485)
 	/* store new config */
 	port->rs485 = *rs485;
 
-	/*
-	 * Just as a precaution, only allow rs485
-	 * to be enabled if the gpio pin is valid
-	 */
 	if (up->rts_gpiod) {
 		/* enable / disable rts */
 		val = (port->rs485.flags & SER_RS485_ENABLED) ?
 			SER_RS485_RTS_AFTER_SEND : SER_RS485_RTS_ON_SEND;
 		val = (port->rs485.flags & val) ? 1 : 0;
 		gpiod_set_value(up->rts_gpiod, val);
-	} else
-		port->rs485.flags &= ~SER_RS485_ENABLED;
+	}
 
 	/* Enable interrupts */
 	up->ier = mode;
-- 
2.17.1

