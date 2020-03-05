Return-Path: <SRS0=YkBk=4W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D099DC3F2CD
	for <linux-serial@archiver.kernel.org>; Thu,  5 Mar 2020 14:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A078720848
	for <linux-serial@archiver.kernel.org>; Thu,  5 Mar 2020 14:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=accesio-com.20150623.gappssmtp.com header.i=@accesio-com.20150623.gappssmtp.com header.b="ralmHlh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCEOFZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:05:25 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33491 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgCEOFZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Mar 2020 09:05:25 -0500
Received: by mail-pg1-f196.google.com with SMTP id m5so2828243pgg.0
        for <linux-serial@vger.kernel.org>; Thu, 05 Mar 2020 06:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=k/hbZJ9M+zsXEJkrWVhiLS28YU8puWo+81UR6wRWoFE=;
        b=ralmHlh2GDGFpUqw0Q1NrtyH8wzz6Lpy23PXkzjKvnNg7CjDnQ9CE+7/qDcClAaOU7
         751nTwGQJAoVZ3yWwgxbdy3EqdejQNNcV68Ktp9I2aHQSBVh8UtwmO7hjMdSGqtW8C1P
         jKkEKy2t3csGLhsuHuZxR/qFPP+z+dDwBigKtmL0t0z7h9msyR4IFD7SkiHESD3tx42Z
         uHir89KoCOuMALEhtN5pNohfWa3BZQYQXAlcz2pLUDkr5SKJwKuKQb3cX/Ok+V/1Npof
         ZPNMpzvxTzUu68BZH9UagqNDJ40gG6UgsDoIzjptIMGjGB3kxYUVVOHNUQ+yEqjBL0Ww
         vWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k/hbZJ9M+zsXEJkrWVhiLS28YU8puWo+81UR6wRWoFE=;
        b=Hc9sJ2jhjdWEswDb9xeW+E/8T7h1RIW1NeKLnjfbqClg0wDu3ObklcsbF17zC+/Tq7
         IEsLKS1R3JSDr34iZ1xyJCkUEQwuUGHSp/1ZT74f/UlzkzRQbtNfJbRN1LjQSaNqKg06
         PaGXWHJJW8XLpWMzCpYmOEhjLfHOTpmK9e6nfLo1VTYxXchw39TdwnT+BQ/FIZza58kp
         ppcfUSwTZSwKx4NcuCdqzgTxiYknadiqNOwcJoNbP4j/8ECrp7gFVc/9jxn1W2vp3lya
         cjNTtUgNtAcclwdaq9xBlB/M9RMf7DaT5Jqf2zGlqccdEibzuaHY9N8y2CfIaUG937/A
         4WCA==
X-Gm-Message-State: ANhLgQ3RM+n2ix4NotYTRkkuEF9ypYO7Q8oHgnuvGWGWDhuzrtUg8Hpq
        a1glv8Mnq5sB3egJFZJeNV8W0XLue/SJEhrKTBceWyPVxf4rq+i2y1rGRrbZ0ZmIKUGI3TVmmM9
        08C5C9ZIb/LdhqFeAFb0APpxEvsFhdHGITQJa/6tetpeD3H+jRYrLd/ft0SBPW/bHl3eiP/fG9y
        qitrU=
X-Google-Smtp-Source: ADFU+vuidjAm7//BP6/pXbnf0DwE3S5eQV/kDML6hfMbotNlSDcA1ORO1dOlG0xqbfNEF9edJsl4CA==
X-Received: by 2002:a63:3111:: with SMTP id x17mr8014582pgx.422.1583417122829;
        Thu, 05 Mar 2020 06:05:22 -0800 (PST)
Received: from work-laptop.dolannet.net (cpe-70-95-148-49.san.res.rr.com. [70.95.148.49])
        by smtp.gmail.com with ESMTPSA id r198sm34717506pfr.54.2020.03.05.06.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 06:05:20 -0800 (PST)
From:   Jay Dolan <jay.dolan@accesio.com>
To:     linux-serial@vger.kernel.org
Cc:     Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH] serial: 8250_exar: add support for ACCES cards
Date:   Thu,  5 Mar 2020 06:05:04 -0800
Message-Id: <20200305140504.22237-1-jay.dolan@accesio.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add ACCES VIDs and PIDs that use the Exar chips

Signed-off-by: Jay Dolan <jay.dolan@accesio.com>
---
 drivers/tty/serial/8250/8250_exar.c | 33 +++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 91e9b070d36d..d330da76d6b6 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -25,6 +25,14 @@
 
 #include "8250.h"
 
+#define PCI_DEVICE_ID_ACCES_COM_2S		0x1052
+#define PCI_DEVICE_ID_ACCES_COM_4S		0x105d
+#define PCI_DEVICE_ID_ACCES_COM_8S		0x106c
+#define PCI_DEVICE_ID_ACCES_COM232_8		0x10a8
+#define PCI_DEVICE_ID_ACCES_COM_2SM		0x10d2
+#define PCI_DEVICE_ID_ACCES_COM_4SM		0x10db
+#define PCI_DEVICE_ID_ACCES_COM_8SM		0x10ea
+
 #define PCI_DEVICE_ID_COMMTECH_4224PCI335	0x0002
 #define PCI_DEVICE_ID_COMMTECH_4222PCI335	0x0004
 #define PCI_DEVICE_ID_COMMTECH_2324PCI335	0x000a
@@ -677,6 +685,22 @@ static int __maybe_unused exar_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(exar_pci_pm, exar_suspend, exar_resume);
 
+static const struct exar8250_board acces_com_2x = {
+	.num_ports	= 2,
+	.setup		= pci_xr17c154_setup,
+};
+
+static const struct exar8250_board acces_com_4x = {
+	.num_ports	= 4,
+	.setup		= pci_xr17c154_setup,
+};
+
+static const struct exar8250_board acces_com_8x = {
+	.num_ports	= 8,
+	.setup		= pci_xr17c154_setup,
+};
+
+
 static const struct exar8250_board pbn_fastcom335_2 = {
 	.num_ports	= 2,
 	.setup		= pci_fastcom335_setup,
@@ -745,6 +769,15 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
 	}
 
 static const struct pci_device_id exar_pci_tbl[] = {
+	EXAR_DEVICE(ACCESSIO, ACCES_COM_2S, acces_com_2x),
+	EXAR_DEVICE(ACCESSIO, ACCES_COM_4S, acces_com_4x),
+	EXAR_DEVICE(ACCESSIO, ACCES_COM_8S, acces_com_8x),
+	EXAR_DEVICE(ACCESSIO, ACCES_COM232_8, acces_com_8x),
+	EXAR_DEVICE(ACCESSIO, ACCES_COM_2SM, acces_com_2x),
+	EXAR_DEVICE(ACCESSIO, ACCES_COM_4SM, acces_com_4x),
+	EXAR_DEVICE(ACCESSIO, ACCES_COM_8SM, acces_com_8x),
+
+
 	CONNECT_DEVICE(XR17C152, UART_2_232, pbn_connect),
 	CONNECT_DEVICE(XR17C154, UART_4_232, pbn_connect),
 	CONNECT_DEVICE(XR17C158, UART_8_232, pbn_connect),
-- 
2.17.1

