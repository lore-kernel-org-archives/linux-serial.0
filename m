Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09907C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 10 Mar 2022 16:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243113AbiCJQXT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Mar 2022 11:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244221AbiCJQW4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Mar 2022 11:22:56 -0500
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FDD19ABE0
        for <linux-serial@vger.kernel.org>; Thu, 10 Mar 2022 08:20:43 -0800 (PST)
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 0A46CCF158
        for <linux-serial@vger.kernel.org>; Thu, 10 Mar 2022 16:17:08 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D726AC000A;
        Thu, 10 Mar 2022 16:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646929018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TNEWGrWM8MEFCyuhFvcwN9AqeFVgL6hJKTp6D8Wa6aw=;
        b=LzKToIzjJfKeaST+C0vREtqd+dePn1INiJJoqRM/wvRSCcCXvzTXzVMKOu8ddU4h59jXGb
        AaO32n3ds703Fr8aJv2dQWC/CBHac0IIhsL4itjJdHu5ozNmJwRLHbq0lP9qeZdiKhNmu1
        enjuJPl7aUtomGJtUGujUQ4CoxBwOTZyC+0mMMuWahxDiLc6XlNwn7of98Nb3CI4+P1E/q
        Q0fbrHwxcplLsuLsOYjkde7J/uaxg5W6xBNvk5gx/SZqTRBMWq96GG6SNqnmO4OOX7JRjo
        XEyRUKWqKp2rFvYtvkOfbYmQ5KOBiqTSltKbqRzRD2xBdywVNdn/jFIP5LqWMA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 2/7] serial: 8250_dw: Move the per-device structure
Date:   Thu, 10 Mar 2022 17:16:45 +0100
Message-Id: <20220310161650.289387-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220310161650.289387-1-miquel.raynal@bootlin.com>
References: <20220310161650.289387-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Phil Edworthy <phil.edworthy@renesas.com>

This structure needs to be reused from dwlib, so let's move it into a
shared header. There is no functional change.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
[miquel.raynal@bootlin.com: Extracted from a bigger change]
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/tty/serial/8250/8250_dw.c    | 16 ----------------
 drivers/tty/serial/8250/8250_dwlib.h | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1769808031c5..ee7562a9ec76 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -37,22 +37,6 @@
 /* DesignWare specific register fields */
 #define DW_UART_MCR_SIRE		BIT(6)
 
-struct dw8250_data {
-	struct dw8250_port_data	data;
-
-	u8			usr_reg;
-	int			msr_mask_on;
-	int			msr_mask_off;
-	struct clk		*clk;
-	struct clk		*pclk;
-	struct notifier_block	clk_notifier;
-	struct work_struct	clk_work;
-	struct reset_control	*rst;
-
-	unsigned int		skip_autocfg:1;
-	unsigned int		uart_16550_compatible:1;
-};
-
 static inline struct dw8250_data *to_dw8250_data(struct dw8250_port_data *data)
 {
 	return container_of(data, struct dw8250_data, data);
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index 83d528e5cc21..ef63eaf7e598 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -16,5 +16,21 @@ struct dw8250_port_data {
 	u8			dlf_size;
 };
 
+struct dw8250_data {
+	struct dw8250_port_data	data;
+
+	u8			usr_reg;
+	int			msr_mask_on;
+	int			msr_mask_off;
+	struct clk		*clk;
+	struct clk		*pclk;
+	struct notifier_block	clk_notifier;
+	struct work_struct	clk_work;
+	struct reset_control	*rst;
+
+	unsigned int		skip_autocfg:1;
+	unsigned int		uart_16550_compatible:1;
+};
+
 void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, struct ktermios *old);
 void dw8250_setup_port(struct uart_port *p);
-- 
2.27.0

