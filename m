Return-Path: <SRS0=dZFG=DZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF9BC433DF
	for <linux-serial@archiver.kernel.org>; Sun, 18 Oct 2020 08:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4A1216C4
	for <linux-serial@archiver.kernel.org>; Sun, 18 Oct 2020 08:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JE1tIkDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgJRImR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 18 Oct 2020 04:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgJRImR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 18 Oct 2020 04:42:17 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269E7C061755
        for <linux-serial@vger.kernel.org>; Sun, 18 Oct 2020 01:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1mj6/4l53W4QGUwMJTD3Bls1KfMZAPCGH64YtbOVYCs=; b=JE1tIkDDyoxXVUv3fx8u41pz1k
        X9fFW3EPlSoR1QoWxYjAMNg7XgwxirruAda+DXHK0+4Cx+QDVcGyhfCyg5dIxYGCo0SDkmN4mFK9u
        HK96Mji/OlBj2gFB82nzuvpZbdiDnm4OvTXFe0EQGk24pQUX3+p9Ky/W10faqGgCQAYkVk/nCZsY8
        Dr22gopkYNXPynOhak89BSAw1QChWNi2WqS0u2jiD4YL6+hv4WW4E0nklZU6PSwpgYSzl0kRVVmEG
        cCFKxV4mGSQ8kYGS4OPCA3WjZ+kcSbkZbfrh8K2sDYUrO8Ksle8FjSg+97oQ29v3I5zQaiZJXOKU/
        pX2PdBlQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34816 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1kU4GT-00047Z-1P; Sun, 18 Oct 2020 09:42:05 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1kU4GS-0006lE-OO; Sun, 18 Oct 2020 09:42:04 +0100
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: [PATCH] tty: serial: 21285: fix lockup on open
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1kU4GS-0006lE-OO@rmk-PC.armlinux.org.uk>
Sender: "Russell King,,," <rmk@armlinux.org.uk>
Date:   Sun, 18 Oct 2020 09:42:04 +0100
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit 293f89959483 ("tty: serial: 21285: stop using the unused[]
variable from struct uart_port") introduced a bug which stops the
transmit interrupt being disabled when there are no characters to
transmit - disabling the transmit interrupt at the interrupt controller
is the only way to stop an interrupt storm. If this interrupt is not
disabled when there are no transmit characters, we end up with an
interrupt storm which prevents the machine making forward progress.

Fixes: 293f89959483 ("tty: serial: 21285: stop using the unused[] variable from struct uart_port")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/tty/serial/21285.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 718e010fcb04..09baef4ccc39 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -50,25 +50,25 @@ static const char serial21285_name[] = "Footbridge UART";
 
 static bool is_enabled(struct uart_port *port, int bit)
 {
-	unsigned long private_data = (unsigned long)port->private_data;
+	unsigned long *private_data = (unsigned long *)&port->private_data;
 
-	if (test_bit(bit, &private_data))
+	if (test_bit(bit, private_data))
 		return true;
 	return false;
 }
 
 static void enable(struct uart_port *port, int bit)
 {
-	unsigned long private_data = (unsigned long)port->private_data;
+	unsigned long *private_data = (unsigned long *)&port->private_data;
 
-	set_bit(bit, &private_data);
+	set_bit(bit, private_data);
 }
 
 static void disable(struct uart_port *port, int bit)
 {
-	unsigned long private_data = (unsigned long)port->private_data;
+	unsigned long *private_data = (unsigned long *)&port->private_data;
 
-	clear_bit(bit, &private_data);
+	clear_bit(bit, private_data);
 }
 
 #define is_tx_enabled(port)	is_enabled(port, tx_enabled_bit)
-- 
2.20.1

