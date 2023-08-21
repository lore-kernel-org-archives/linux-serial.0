Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B08EE4996
	for <linux-serial@archiver.kernel.org>; Mon, 21 Aug 2023 18:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjHUSzh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Aug 2023 14:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjHUSzg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Aug 2023 14:55:36 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DFE876E
        for <linux-serial@vger.kernel.org>; Mon, 21 Aug 2023 11:53:27 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68a56401c12so745440b3a.2
        for <linux-serial@vger.kernel.org>; Mon, 21 Aug 2023 11:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692644000; x=1693248800;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4QnaiqajdimjjZ+5oMeKvD+9e97m/ttVj0yqLVKTWs=;
        b=Xg8P0VrEGxsWS/LztR+4DyaYam0ijnJc/soHnMMk73pkvwwGT/V444z6Pdf1L241Xu
         VqXzhFnOPJDeDiYJgN4utRes3gfuUDn1EWEPsMYJQoXQJlMtFMh/bLqw0TeNX6M/0dzb
         H7ckN4jP2MI4r9CKIsFFljq1oI1BJV2CnwdHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692644000; x=1693248800;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4QnaiqajdimjjZ+5oMeKvD+9e97m/ttVj0yqLVKTWs=;
        b=aGI2G55Qmt9pCaFxA/jKcm4A8MCJzaQeQlkaw2XVuxx8ACmAvu8OAw7iFdrtRQ5yqe
         FejJfsRuJIxPRdB5JAVGPJSiitLmICfQld1l8X1Ca96F2R15iq5dvfKJv2IY9vGiyvSD
         AmwCDYDdfQydd9eBu16pd8OyTYQcQoWKg7ii8a4vzZeJjoflAKvSHaH9DDUoA+Ii1EhG
         rHgr7NuUkuA2JZ4g8SG0ruQJTajztuz1i+/8Onf2kPNwWPwFoOylMAtc8zDZANOABHz5
         4N8Irjsp5I20mjZfVJZSRkQDT7YHsF2QvmasYOdunLZ33Xtn0kc5AGawwtszcfxgiSXw
         9Sgw==
X-Gm-Message-State: AOJu0YwUjQsUp18qrU0TsqqKTOWFuYl6B1mB4yiaPFx2mSnmUKVXrdil
        +9eKcBfbrO/4LJHWWANZMcluR3hHK5W3OmJ0BFb2ufMkaPW035FvUWXIBMjQvY5YeVTkwVHQHgw
        92y5lqHru6NPro3htZ7gGbx07GTWsHjh2Dx/Yl4hpgVoX3jm0mRDYSsHzvW+vziTDBqwSP2iBme
        57k1Y9H9WGKYI=
X-Google-Smtp-Source: AGHT+IGCTwwQYX11qi34wNlJhy6TLOpX0IDtFVBd8HmuhERm01Ec8Wg3XrwcSWvQmnUBqFqEJKtwIw==
X-Received: by 2002:a05:6a00:22c6:b0:687:2be1:e335 with SMTP id f6-20020a056a0022c600b006872be1e335mr7019135pfj.2.1692644000063;
        Mon, 21 Aug 2023 11:53:20 -0700 (PDT)
Received: from stbirv-lnx-2.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k3-20020aa790c3000000b00682a61fa525sm6592188pfk.91.2023.08.21.11.53.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Aug 2023 11:53:15 -0700 (PDT)
From:   Justin Chen <justin.chen@broadcom.com>
To:     linux-serial@vger.kernel.org
Cc:     Justin Chen <justin.chen@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
        linux-kernel@vger.kernel.org (open list:TTY LAYER)
Subject: [PATCH v4] serial: 8250_bcm7271: improve bcm7271 8250 port
Date:   Mon, 21 Aug 2023 11:52:51 -0700
Message-Id: <1692643978-16570-1-git-send-email-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.7.4
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000061b4e006037364b9"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--00000000000061b4e006037364b9

The 8250 BCM7271 UART is not a direct match to PORT_16550A and other
generic ports do not match its hardware capabilities. PORT_ALTR matches
the rx trigger levels, but its vendor configurations are not compatible.
Unfortunately this means we need to create another port to fully capture
the hardware capabilities of the BCM7271 UART.

To alleviate some latency pressures, we default the rx trigger level to 8.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Acked-by: Doug Berger <opendmb@gmail.com>
---
v4
	- Switch PORT_BCM7271 back to 76

v3
	- Switch PORT_BCM7271 to 13
	- Added trailing comma to struct declaration

v2
	- Switch PORT_BCM7271 to 76
	- Elaborated commit message
	- Renamed port name

 drivers/tty/serial/8250/8250_bcm7271.c | 4 +---
 drivers/tty/serial/8250/8250_port.c    | 8 ++++++++
 include/uapi/linux/serial_core.h       | 3 +++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index d4b05d7ad9e8..aa5aff046756 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -1042,7 +1042,7 @@ static int brcmuart_probe(struct platform_device *pdev)
 	dev_dbg(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");
 
 	memset(&up, 0, sizeof(up));
-	up.port.type = PORT_16550A;
+	up.port.type = PORT_BCM7271;
 	up.port.uartclk = clk_rate;
 	up.port.dev = dev;
 	up.port.mapbase = mapbase;
@@ -1056,8 +1056,6 @@ static int brcmuart_probe(struct platform_device *pdev)
 		| UPF_FIXED_PORT | UPF_FIXED_TYPE;
 	up.port.dev = dev;
 	up.port.private_data = priv;
-	up.capabilities = UART_CAP_FIFO | UART_CAP_AFE;
-	up.port.fifosize = 32;
 
 	/* Check for a fixed line number */
 	ret = of_alias_get_id(np, "serial");
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 16aeb1420137..7fb1d7c00001 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -322,6 +322,14 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes   = {2, 66, 130, 194},
 		.flags          = UART_CAP_FIFO,
 	},
+	[PORT_BCM7271] = {
+		.name		= "Broadcom BCM7271 UART",
+		.fifo_size	= 32,
+		.tx_loadsz	= 32,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01,
+		.rxtrig_bytes	= {1, 8, 16, 30},
+		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
+	},
 };
 
 /* Uart divisor latch read */
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 281fa286555c..7e66067b6c06 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -144,6 +144,9 @@
 /* Blackfin bf5xx */
 #define PORT_BFIN	75
 
+/* Broadcom BCM7271 UART */
+#define PORT_BCM7271	76
+
 /* Broadcom SB1250, etc. SOC */
 #define PORT_SB1250_DUART	77
 
-- 
2.7.4


--00000000000061b4e006037364b9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
NhTY3E+cXCB11wty89QStajwXdhGJTYEvUgvsq1h8CwJj9w/38ldAQf5WjhPmApYeJR2ewFrBMCM
4lHkdRJ6TDc9nXoEkypUfjJkJHe7Eal06tosh6JpAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGp1c3Rpbi5jaGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIWGeYuaTsnIada5Xx8TR3cheUbgw
DQYJKoZIhvcNAQELBQADggEBAHNQlMqQOFYPYFO71A+8t+qWMmtOdd2iGswSOvpSZ/pmGlfw8ZvY
dRTkl27m37la84AxRkiVMes14JyOZJoMh/g7fbgPlU14eBc6WQWkIA6AmNkduFWTr1pRezkjpeo6
xVmdBLM4VY1TFDYj7S8H2adPuypd62uHMY/MZi+BIUys4uAFA+N3NuUBNjcVZXYPplYxxKEuIFq6
sDL+OV16G+F9CkNMN3txsym8Nnx5WAYZb6+rBUIhMGz70V05xsHQfzvo2s7f0J1tJ5BoRlPPhL0h
VOnWA3h71u9TfSsv+PXVm3P21TfOS2uc1hbzEqyENCP4i5XQ0rv0TmPW42GZ0o4xggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwj8BKLXNpALfemdRAwDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJAdecKngu/+3K0xsfF5XKTZStAVhqzR+42e
Aq8Zz/5aMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgyMTE4
NTMyMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQAZPDL3mg+/itcZ92DMPuCFh6YwohxfZkveprrYM2CEfAVr+LrjWKct
y20eH1+qNeMxsq/4HMR8id+Np7eqSyFfUTxTgWdXmShC+NLbO+h4u5PBfCYoIq2gdaC6529JlmD1
Ef3LsFhvAbKevdYq8kAVIS0jdUrpq0BZjI4u3MM+4pN1KaPzkE+oRFKhIRulUCg/Y3iYGWKtw2L5
6AEx3BWz1tvPczBVLuOtzfFwA2KwCFVAT5pwx/ExI/Ye63pdkDryS+/FDFRreTlHMaD6e0EMqny3
3FnAfZvic23C+T5x2EahTANowS2CSKKF/yJP8jsefkjicI3MplpbFap6V8X8
--00000000000061b4e006037364b9--
