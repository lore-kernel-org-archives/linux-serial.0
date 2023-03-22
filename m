Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2985C6FD1C
	for <linux-serial@archiver.kernel.org>; Wed, 22 Mar 2023 22:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCVWkE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Mar 2023 18:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCVWkE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Mar 2023 18:40:04 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EC827D61
        for <linux-serial@vger.kernel.org>; Wed, 22 Mar 2023 15:40:03 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id o44so10240985qvo.4
        for <linux-serial@vger.kernel.org>; Wed, 22 Mar 2023 15:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1679524802;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YXOqEKZr2B5o6lVtgaQ8oXcgjjhSK3hFg539VLGwYtU=;
        b=DJ1OnJnS2nzDaqnUo4hbb41n5bwTV6gXoRF+PN2jOACxAFdthymy5HXYY09g1iJ+jO
         0iurDM/jBOhLxfgR/+qTG/93mdx3XIke24ufOMmiGoI6ri4UBl/Qtotpqv+8PFW6SfQd
         U3qnStam6pf7PH7wH5rR4eUsdClMXSXH1cW+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679524802;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YXOqEKZr2B5o6lVtgaQ8oXcgjjhSK3hFg539VLGwYtU=;
        b=ijD3rv9mcO9yycuHgdyJ4GjWtqzt+M1bFAu92t8gOUmM5dzF3lbOJtEuE7t9ozlJKu
         +uvza12Ky0hlDP40LbXL6qTKmBDjK62qvsR+E8S7j3KX1BtOQJZeMkcIGzgs2VZ3qLI8
         +952IZ7mfdUE+yyiz9cHkJ7yihNXamY1iZKXprnAuS7LFah6Ih/s23dU/onSVdhp2SqP
         /n6se7WwXHm+LLRL4kfodi5sLDlLFVQw7XdWVcdhg4UexDx7AMqW4cjR4aA8inVZQdYG
         TOfPqcgbklWWPY5XZGddjUA5D0rbVUqb0ZNIsj3qZmRSoww1/9MqGRxSZeYfMf8N2i+V
         hTHw==
X-Gm-Message-State: AO0yUKVhSCvf8joOeKAQBIZ/yEDN/0VQUh5Fm7638Oo24Mrleh3HDsPa
        TzTD8p2XvWdAPmqMf7pnMQkNpmyuPSmAyLmJQTFETK44WHI=
X-Google-Smtp-Source: AK7set9+rBUzAvuTOZ9K8oMMcRMDA3IJ/cOUilQQFAPhh8t7H0vP9GxqKtM0kG0OApkU5spDzd2abA==
X-Received: by 2002:a05:6214:240c:b0:5a7:a434:c303 with SMTP id fv12-20020a056214240c00b005a7a434c303mr9080765qvb.25.1679524802525;
        Wed, 22 Mar 2023 15:40:02 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.com ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id x128-20020a376386000000b00746803d7e8dsm7563903qkb.113.2023.03.22.15.40.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2023 15:40:02 -0700 (PDT)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH] serial: bcm63xx-uart: add polling support
Date:   Wed, 22 Mar 2023 23:39:56 +0100
Message-Id: <20230322223956.84647-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000427da305f784d77a"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--000000000000427da305f784d77a
Content-Transfer-Encoding: 8bit

The tty framework can support polling console to allow operation
in situations where interrupts are turned off. Adding polling mode
support allows using KGDB over serial console,

Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 drivers/tty/serial/bcm63xx_uart.c | 38 +++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 62bc7244dc67..55e82d0bf92d 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -596,6 +596,40 @@ static int bcm_uart_verify_port(struct uart_port *port,
 	return 0;
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+/*
+ * return true when outstanding tx equals fifo size
+ */
+static bool bcm_uart_tx_full(struct uart_port *port)
+{
+	unsigned int val;
+
+	val = bcm_uart_readl(port, UART_MCTL_REG);
+	val = (val & UART_MCTL_TXFIFOFILL_MASK) >> UART_MCTL_TXFIFOFILL_SHIFT;
+	return !(port->fifosize - val);
+}
+
+static int bcm_uart_poll_get_char(struct uart_port *port)
+{
+	unsigned int iestat;
+
+	iestat = bcm_uart_readl(port, UART_IR_REG);
+	if (!(iestat & UART_IR_STAT(UART_IR_RXNOTEMPTY)))
+		return NO_POLL_CHAR;
+
+	return bcm_uart_readl(port, UART_FIFO_REG);
+}
+
+static void bcm_uart_poll_put_char(struct uart_port *port, unsigned char c)
+{
+	while (bcm_uart_tx_full(port)) {
+		cpu_relax();
+	}
+
+	bcm_uart_writel(port, c, UART_FIFO_REG);
+}
+#endif
+
 /* serial core callbacks */
 static const struct uart_ops bcm_uart_ops = {
 	.tx_empty	= bcm_uart_tx_empty,
@@ -614,6 +648,10 @@ static const struct uart_ops bcm_uart_ops = {
 	.request_port	= bcm_uart_request_port,
 	.config_port	= bcm_uart_config_port,
 	.verify_port	= bcm_uart_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char  = bcm_uart_poll_get_char,
+	.poll_put_char  = bcm_uart_poll_put_char,
+#endif
 };
 
 
-- 
2.32.0


--000000000000427da305f784d77a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBqw8LeLgg6s8oaiL3S
pp3hQGdPkLzWRmXALN7N8z3wmjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzAzMjIyMjQwMDJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAo/wA3cn6q3etih6c1qMFNTRIjRCSDsE4vC4z
DwS6Rh3WEMbMmNzSSS6gJHHv+1lrBllRzKOTyRcYk3pl9eK8mpA/VJ38Iayh/m8dWJtZquUf5Mf5
FNaIxxFhuU+uzV//+WGbPJkZmiJyNorDEmzicfbPDMZQaUgQHorgjRaPPEXe8rKgjExamHHT1a+w
a8fGfxhk6KMUM52xO/irnTTxiHo4pyUNVE0Fc1jdIYzjb6P66t1r7kMHEWuPv8SgHRgvKsC/4ah4
HSXfsG4C5Mva4TlmbktGOIteKTio/JvmdDUwfS04Kmi5v2VGibiJ22F+lXjbazurPAdbOfnE44HU
kQ==
--000000000000427da305f784d77a--
