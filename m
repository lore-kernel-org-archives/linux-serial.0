Return-Path: <SRS0=ezJB=ZU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB51FC432C3
	for <linux-serial@archiver.kernel.org>; Thu, 28 Nov 2019 14:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B18B21774
	for <linux-serial@archiver.kernel.org>; Thu, 28 Nov 2019 14:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Dwl4dqLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfK1O7O (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:59:14 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44446 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfK1O5s (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19so1822064lji.11
        for <linux-serial@vger.kernel.org>; Thu, 28 Nov 2019 06:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PS8hZ/FNZ5fnmFnMC7wpuYE5CME6gqxRCzSgU7yOKOk=;
        b=Dwl4dqLdHHKnldphnAGAr1ToN610EqBZwSqoR/hgQSNxfsV/4wXOcOzAUM9uz6FotW
         9qwt38QjaaeFHldetsUOgPoIM24I2pCcWdKTSDI7nv8y8op+zapWHlf8st+tVkHCz7P5
         bh30cwYMxpmBmbI75/QPPKlSxYLuOhMWYJifE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PS8hZ/FNZ5fnmFnMC7wpuYE5CME6gqxRCzSgU7yOKOk=;
        b=iGVi+ELuKEdTrKyLQqS3hU0+RLpNymrfoNwSYGHuuiKFHdSwv17cOYLbBd3JCcLi0Z
         HG1OssgZtImYQvKzdGd91MmZCmzAicTzmgFv0oreodTXlTQ/f63hdrq05DLeCU/3ZMPH
         x1nfr8wpndfSNFR6UZ8RfDnvkS75SiHTpOCZRSGlWKEBDc0cbc80PshGxlTjsTRjXpLo
         rhRi2W8cvbaPE8SOLt/ca59UO4oElerOV9bh2+7h5V5eaa5RS1p8Al8Kkg1JthA8d9D3
         VKKmD7nKf3dxajD7DMJgYk82XqKUeBYcZSogKMQ4q5MKfCukLnnGzlzsWUYNcIheDqZh
         5xkQ==
X-Gm-Message-State: APjAAAWLAXTB3BEyPPCJ/gud8YghBq45pBqGnD1McnhtFCR70BIASTjG
        D8gQfGyI7tu2HjbYPUNASnvHjw==
X-Google-Smtp-Source: APXvYqxr+KXWNUM6J8K1e3cWke7H28D8dBWc6wxWxJZiGdbp/JimSWw2nVOwCFqjHzoiT5BiVmBGsA==
X-Received: by 2002:a2e:3e08:: with SMTP id l8mr5147340lja.236.1574953064981;
        Thu, 28 Nov 2019 06:57:44 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:44 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v6 30/49] serial: ucc_uart: factor out soft_uart initialization
Date:   Thu, 28 Nov 2019 15:55:35 +0100
Message-Id: <20191128145554.1297-31-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The "soft uart" mechanism is a workaround for a silicon bug which (as
far as I know) only affects some PPC-based SOCs.

The code that determines which microcode blob to request relies on
some powerpc-specific bits (e.g. the mfspr(SPRN_SVR) and hence also
the asm/reg.h header). This makes it a little awkward to allow this
driver to be built for non-PPC based SOCs with a QE, even if they are
not affected by that silicon bug and thus don't need any of the Soft
UART logic.

There's no way around guarding those bits with some ifdeffery, so to
keep that isolated, factor out the
do-we-need-soft-uart-and-if-so-handle-the-firmware to a separate
function, which we can then easily stub out for non-PPC.

Reviewed-by: Timur Tabi <timur@kernel.org>
Acked-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 110 ++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 52 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 8a378ee5d34f..f286e91714cb 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1183,70 +1183,76 @@ static void uart_firmware_cont(const struct firmware *fw, void *context)
 	release_firmware(fw);
 }
 
-static int ucc_uart_probe(struct platform_device *ofdev)
+static int soft_uart_init(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
-	const unsigned int *iprop;      /* Integer OF properties */
-	const char *sprop;      /* String OF properties */
-	struct uart_qe_port *qe_port = NULL;
-	struct resource res;
+	struct qe_firmware_info *qe_fw_info;
 	int ret;
 
-	/*
-	 * Determine if we need Soft-UART mode
-	 */
 	if (of_find_property(np, "soft-uart", NULL)) {
 		dev_dbg(&ofdev->dev, "using Soft-UART mode\n");
 		soft_uart = 1;
+	} else {
+		return 0;
 	}
 
-	/*
-	 * If we are using Soft-UART, determine if we need to upload the
-	 * firmware, too.
-	 */
-	if (soft_uart) {
-		struct qe_firmware_info *qe_fw_info;
-
-		qe_fw_info = qe_get_firmware_info();
-
-		/* Check if the firmware has been uploaded. */
-		if (qe_fw_info && strstr(qe_fw_info->id, "Soft-UART")) {
-			firmware_loaded = 1;
-		} else {
-			char filename[32];
-			unsigned int soc;
-			unsigned int rev_h;
-			unsigned int rev_l;
-
-			soc = soc_info(&rev_h, &rev_l);
-			if (!soc) {
-				dev_err(&ofdev->dev, "unknown CPU model\n");
-				return -ENXIO;
-			}
-			sprintf(filename, "fsl_qe_ucode_uart_%u_%u%u.bin",
-				soc, rev_h, rev_l);
-
-			dev_info(&ofdev->dev, "waiting for firmware %s\n",
-				filename);
+	qe_fw_info = qe_get_firmware_info();
 
-			/*
-			 * We call request_firmware_nowait instead of
-			 * request_firmware so that the driver can load and
-			 * initialize the ports without holding up the rest of
-			 * the kernel.  If hotplug support is enabled in the
-			 * kernel, then we use it.
-			 */
-			ret = request_firmware_nowait(THIS_MODULE,
-				FW_ACTION_HOTPLUG, filename, &ofdev->dev,
-				GFP_KERNEL, &ofdev->dev, uart_firmware_cont);
-			if (ret) {
-				dev_err(&ofdev->dev,
-					"could not load firmware %s\n",
-					filename);
-				return ret;
-			}
+	/* Check if the firmware has been uploaded. */
+	if (qe_fw_info && strstr(qe_fw_info->id, "Soft-UART")) {
+		firmware_loaded = 1;
+	} else {
+		char filename[32];
+		unsigned int soc;
+		unsigned int rev_h;
+		unsigned int rev_l;
+
+		soc = soc_info(&rev_h, &rev_l);
+		if (!soc) {
+			dev_err(&ofdev->dev, "unknown CPU model\n");
+			return -ENXIO;
+		}
+		sprintf(filename, "fsl_qe_ucode_uart_%u_%u%u.bin",
+			soc, rev_h, rev_l);
+
+		dev_info(&ofdev->dev, "waiting for firmware %s\n",
+			 filename);
+
+		/*
+		 * We call request_firmware_nowait instead of
+		 * request_firmware so that the driver can load and
+		 * initialize the ports without holding up the rest of
+		 * the kernel.  If hotplug support is enabled in the
+		 * kernel, then we use it.
+		 */
+		ret = request_firmware_nowait(THIS_MODULE,
+					      FW_ACTION_HOTPLUG, filename, &ofdev->dev,
+					      GFP_KERNEL, &ofdev->dev, uart_firmware_cont);
+		if (ret) {
+			dev_err(&ofdev->dev,
+				"could not load firmware %s\n",
+				filename);
+			return ret;
 		}
 	}
+	return 0;
+}
+
+static int ucc_uart_probe(struct platform_device *ofdev)
+{
+	struct device_node *np = ofdev->dev.of_node;
+	const unsigned int *iprop;      /* Integer OF properties */
+	const char *sprop;      /* String OF properties */
+	struct uart_qe_port *qe_port = NULL;
+	struct resource res;
+	int ret;
+
+	/*
+	 * Determine if we need Soft-UART mode
+	 */
+	ret = soft_uart_init(ofdev);
+	if (ret)
+		return ret;
 
 	qe_port = kzalloc(sizeof(struct uart_qe_port), GFP_KERNEL);
 	if (!qe_port) {
-- 
2.23.0

