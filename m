Return-Path: <SRS0=aTVb=7K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57551C433DF
	for <linux-serial@archiver.kernel.org>; Thu, 28 May 2020 02:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251232084C
	for <linux-serial@archiver.kernel.org>; Thu, 28 May 2020 02:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzXAAMH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgE1CYq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 27 May 2020 22:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgE1CYq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 27 May 2020 22:24:46 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE2FC05BD1E;
        Wed, 27 May 2020 19:24:46 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 124so6500312pgi.9;
        Wed, 27 May 2020 19:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kG9QF8UOVZAbX8uqsWrlEl3h/AG9SuRQ3+J+hENs33Y=;
        b=DzXAAMH0ncxzEdIhGCaGhBkVKMyPjK1AiOoJNV0elT/GXe3o8sq/htXuaPcTFDsEIX
         ru5S9BpkOXHDghusOYCXuVWL2pnNWx5u8uwWzVAnLo9klFdchSUHQYpLbFvBuuef49T3
         xocVJ+g1QeFVtdAsLecTbLTOcae4hkh449FdLsEvPcEJTJ8OzRGVHWAWcEIAT7poqp0j
         feBZhJ2Ok55Ae3b0q3NhQPYsdGDPX6a1SgjMfjDZnjpreOSWN1pVYzSRJFLSJ31JJrAF
         /DFIjCqMZtfd91ZMbmZ3mvwx1949uOjuIBTfoFbMN6/2VIMFqvcUxVEm26U/A50zQivL
         4x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kG9QF8UOVZAbX8uqsWrlEl3h/AG9SuRQ3+J+hENs33Y=;
        b=AEG98YAQtIB3HF9uZyDFyEYsGDXJz3jaK16M8+a8GZhfg2+jhSv5kHnmh9vXD9VgdI
         81qMBIfTOOmmZLRBu3vghtbzutyNHlTZilanQKa9LhNyVcTPJfpYAl7qtSPCifPktr44
         3lxbX+pIEq9hj0h3u988gVivhWsnS13h3krWDJsTgae1eq+DcJ+T9KCeDICTZ6g8jf8g
         62FE1CW8RdSVz3BkjBq0k+gJtn1b/ggSekm4AELgAqp9BPQHfMsuxFrh2Q416o0oZ8Sd
         xGVbZ/L4CcZlOdNoxAZXbaiul3QzsrTkmsp09Vj2M8eLJMcP9iqTpF/xNn9nqdY+JWnV
         /06Q==
X-Gm-Message-State: AOAM530DNxDF8gtUmeWV/i71sHjs4shM2c6YIldah/zJXa5LlK3Y/3ne
        0i2EbkfCz4OaNAQ3WycN2NI=
X-Google-Smtp-Source: ABdhPJyD1088l9zMEtL9cN7OhM6oDDRTEz8XKszmBA9bUujIR5QmQdEOKAwiJi9kNKDoZ4ixKoSCEw==
X-Received: by 2002:a63:214d:: with SMTP id s13mr685317pgm.277.1590632685685;
        Wed, 27 May 2020 19:24:45 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id v17sm3041414pfg.164.2020.05.27.19.24.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 May 2020 19:24:44 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>,
        Ji-Ze Hong <peter_hong@fintek.com.tw>
Subject: [PATCH V1 1/1] serial: 8250_fintek: Add F81966 Support
Date:   Thu, 28 May 2020 10:24:29 +0800
Message-Id: <20200528022429.32078-1-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fintek F81966 is a LPC/eSPI to 6 UARTs SuperIO. It has fully compatible
with F81866. It's also need check the IRQ mode with system assigned.

F81966 IRQ Mode setting:
        0xf0
                Bit1: IRQ_MODE0
                Bit0: Share mode (always on)
        0xf6
                Bit3: IRQ_MODE1

        Level/Low: IRQ_MODE0:0, IRQ_MODE1:0
        Edge/High: IRQ_MODE0:1, IRQ_MODE1:0

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
Cc: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
---
 drivers/tty/serial/8250/8250_fintek.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 31c91c2f8c6e..d1d253c4b518 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -19,6 +19,7 @@
 #define CHIP_ID2  0x21
 #define CHIP_ID_F81865 0x0407
 #define CHIP_ID_F81866 0x1010
+#define CHIP_ID_F81966 0x0215
 #define CHIP_ID_F81216AD 0x1602
 #define CHIP_ID_F81216H 0x0501
 #define CHIP_ID_F81216 0x0802
@@ -62,9 +63,9 @@
 #define F81216_LDN_HIGH	0x4
 
 /*
- * F81866 registers
+ * F81866/966 registers
  *
- * The IRQ setting mode of F81866 is not the same with F81216 series.
+ * The IRQ setting mode of F81866/966 is not the same with F81216 series.
  *	Level/Low: IRQ_MODE0:0, IRQ_MODE1:0
  *	Edge/High: IRQ_MODE0:1, IRQ_MODE1:0
  *
@@ -155,6 +156,7 @@ static int fintek_8250_check_id(struct fintek_8250 *pdata)
 	switch (chip) {
 	case CHIP_ID_F81865:
 	case CHIP_ID_F81866:
+	case CHIP_ID_F81966:
 	case CHIP_ID_F81216AD:
 	case CHIP_ID_F81216H:
 	case CHIP_ID_F81216:
@@ -171,6 +173,7 @@ static int fintek_8250_get_ldn_range(struct fintek_8250 *pdata, int *min,
 				     int *max)
 {
 	switch (pdata->pid) {
+	case CHIP_ID_F81966:
 	case CHIP_ID_F81865:
 	case CHIP_ID_F81866:
 		*min = F81866_LDN_LOW;
@@ -248,6 +251,7 @@ static void fintek_8250_set_irq_mode(struct fintek_8250 *pdata, bool is_level)
 	sio_write_reg(pdata, LDN, pdata->index);
 
 	switch (pdata->pid) {
+	case CHIP_ID_F81966:
 	case CHIP_ID_F81866:
 		sio_write_mask_reg(pdata, F81866_FIFO_CTRL, F81866_IRQ_MODE1,
 				   0);
@@ -274,6 +278,7 @@ static void fintek_8250_set_max_fifo(struct fintek_8250 *pdata)
 {
 	switch (pdata->pid) {
 	case CHIP_ID_F81216H: /* 128Bytes FIFO */
+	case CHIP_ID_F81966:
 	case CHIP_ID_F81866:
 		sio_write_mask_reg(pdata, FIFO_CTRL,
 				   FIFO_MODE_MASK | RXFTHR_MODE_MASK,
@@ -291,6 +296,7 @@ static void fintek_8250_goto_highspeed(struct uart_8250_port *uart,
 	sio_write_reg(pdata, LDN, pdata->index);
 
 	switch (pdata->pid) {
+	case CHIP_ID_F81966:
 	case CHIP_ID_F81866: /* set uart clock for high speed serial mode */
 		sio_write_mask_reg(pdata, F81866_UART_CLK,
 			F81866_UART_CLK_MASK,
@@ -327,6 +333,7 @@ static void fintek_8250_set_termios(struct uart_port *port,
 	case CHIP_ID_F81216H:
 		reg = RS485;
 		break;
+	case CHIP_ID_F81966:
 	case CHIP_ID_F81866:
 		reg = F81866_UART_CLK;
 		break;
@@ -373,6 +380,7 @@ static void fintek_8250_set_termios_handler(struct uart_8250_port *uart)
 
 	switch (pdata->pid) {
 	case CHIP_ID_F81216H:
+	case CHIP_ID_F81966:
 	case CHIP_ID_F81866:
 		uart->port.set_termios = fintek_8250_set_termios;
 		break;
@@ -443,6 +451,7 @@ static void fintek_8250_set_rs485_handler(struct uart_8250_port *uart)
 	switch (pdata->pid) {
 	case CHIP_ID_F81216AD:
 	case CHIP_ID_F81216H:
+	case CHIP_ID_F81966:
 	case CHIP_ID_F81866:
 	case CHIP_ID_F81865:
 		uart->port.rs485_config = fintek_8250_rs485_config;
-- 
2.17.1

