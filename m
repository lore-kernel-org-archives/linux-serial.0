Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E842C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  2 Nov 2021 06:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B9760F02
	for <linux-serial@archiver.kernel.org>; Tue,  2 Nov 2021 06:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhKBGk5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Nov 2021 02:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhKBGk4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Nov 2021 02:40:56 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5358C061714;
        Mon,  1 Nov 2021 23:38:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c4so1591885wrd.9;
        Mon, 01 Nov 2021 23:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2jT8pDp61cxxdq+1Y9Z8tKQBn7lQoXJDwBX8tFoB6Nc=;
        b=intgKAHZdoCGHK4zPbNdwRzStRyx9vPQOP8AY+tkwZP4q1daAIoaK17BxZ4ntkkj3D
         r96IIkA528o1GnKKrkbPtsdZ6R2pGDuiV3HiTWhMsojS6fALdOsnEP7lT11j4KNCneSf
         Ct5WzHSa0FrZvQcoy85wRRYOBsqq+b4Tf+9/ZEds2mpRClIBw03lb++3sZm1bpBexfU1
         OtjdTqLLaVPihFu8k8aVBeZxsfgE76UJ/04T4/Zxo3cI4aMevIMELDwmuCPj/pMBAQvN
         Quc5qV3Cxj3h+V/3DSaoz+DX5zMBdDCjxq1ReJGG5qUVeFMfSdDrq+jPEGgbup7z3rGc
         6//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2jT8pDp61cxxdq+1Y9Z8tKQBn7lQoXJDwBX8tFoB6Nc=;
        b=VdlOOfABLVOBPg/67B6mFJSvHHYpUUhy5GFnmNR3ZWkeJ8M5yq6mTYiQNy3vUgE8FO
         3DcTooiDe6hoLhDaNFt5COkQ69PRfTVMHztgnXpZwVyoHwBQis3nD+lUSzYmUCZh9kLQ
         H209g4hx6pnsCWwBtn8S6GxUwf/BI5L/s2+IEyg7A/oCYnl1nJocEut+CZtiMIX/UdUa
         oPVfh9S51gznd3DGxY4/dBljg4fB59hgH6bznOmc3pIh2IVUSvNdKkwKYwRnv3K0S7kb
         RTbqIRMCyB2simiCBZ2ZwXbkaGKtJOzSJagVr9/0lPoDQI5+K8AxETZUc6Q6fQ/FyDDh
         XL5w==
X-Gm-Message-State: AOAM531dDcd3w4a97askLE1wffA6zBqjrpFuu3YpfqV3NkXxPvMDrIHS
        Q540o98ujJu4t5d5KOUDqyMAEhyOLJc=
X-Google-Smtp-Source: ABdhPJy5ENn/ELbYTpSsT2Xncb5YA+MGxveY/xFy5tJ+wIe6qfvxXs8znmsx/mQfXcQioHK7Xq96SQ==
X-Received: by 2002:a5d:58ed:: with SMTP id f13mr34534675wrd.373.1635835100441;
        Mon, 01 Nov 2021 23:38:20 -0700 (PDT)
Received: from localhost.elektrobit.com (eth1-fw1-nbg6.eb.noris.de. [213.95.148.172])
        by smtp.gmail.com with ESMTPSA id l5sm1402196wms.16.2021.11.01.23.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 23:38:20 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] arm: remove zte zx platform left-over
Date:   Tue,  2 Nov 2021 07:38:10 +0100
Message-Id: <20211102063810.932-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit 89d4f98ae90d ("ARM: remove zte zx platform") missed to remove some
definitions for this platform's debug and serial, e.g., code dependent on
the config DEBUG_ZTE_ZX.

Fortunately, ./scripts/checkkconfigsymbols.py detects this and warns:

DEBUG_ZTE_ZX
Referencing files: arch/arm/include/debug/pl01x.S

Further review by Arnd Bergmann identified even more dead code in the
amba serial driver.

Remove all this left-over from the zte zx platform.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
this is a new patch after the discussion around:

https://lore.kernel.org/all/20211028141938.3530-2-lukas.bulwahn@gmail.com/

 arch/arm/include/debug/pl01x.S  |  7 -------
 drivers/tty/serial/amba-pl011.c | 37 ---------------------------------
 include/linux/amba/bus.h        |  6 ------
 3 files changed, 50 deletions(-)

diff --git a/arch/arm/include/debug/pl01x.S b/arch/arm/include/debug/pl01x.S
index 0c7bfa4c10db..c7e02d0628bf 100644
--- a/arch/arm/include/debug/pl01x.S
+++ b/arch/arm/include/debug/pl01x.S
@@ -8,13 +8,6 @@
 */
 #include <linux/amba/serial.h>
 
-#ifdef CONFIG_DEBUG_ZTE_ZX
-#undef UART01x_DR
-#undef UART01x_FR
-#define UART01x_DR     0x04
-#define UART01x_FR     0x14
-#endif
-
 #ifdef CONFIG_DEBUG_UART_PHYS
 		.macro	addruart, rp, rv, tmp
 		ldr	\rp, =CONFIG_DEBUG_UART_PHYS
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d361cd84ff8c..c9534e229166 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -188,38 +188,6 @@ static struct vendor_data vendor_st = {
 	.get_fifosize		= get_fifosize_st,
 };
 
-static const u16 pl011_zte_offsets[REG_ARRAY_SIZE] = {
-	[REG_DR] = ZX_UART011_DR,
-	[REG_FR] = ZX_UART011_FR,
-	[REG_LCRH_RX] = ZX_UART011_LCRH,
-	[REG_LCRH_TX] = ZX_UART011_LCRH,
-	[REG_IBRD] = ZX_UART011_IBRD,
-	[REG_FBRD] = ZX_UART011_FBRD,
-	[REG_CR] = ZX_UART011_CR,
-	[REG_IFLS] = ZX_UART011_IFLS,
-	[REG_IMSC] = ZX_UART011_IMSC,
-	[REG_RIS] = ZX_UART011_RIS,
-	[REG_MIS] = ZX_UART011_MIS,
-	[REG_ICR] = ZX_UART011_ICR,
-	[REG_DMACR] = ZX_UART011_DMACR,
-};
-
-static unsigned int get_fifosize_zte(struct amba_device *dev)
-{
-	return 16;
-}
-
-static struct vendor_data vendor_zte = {
-	.reg_offset		= pl011_zte_offsets,
-	.access_32b		= true,
-	.ifls			= UART011_IFLS_RX4_8|UART011_IFLS_TX4_8,
-	.fr_busy		= ZX_UART01x_FR_BUSY,
-	.fr_dsr			= ZX_UART01x_FR_DSR,
-	.fr_cts			= ZX_UART01x_FR_CTS,
-	.fr_ri			= ZX_UART011_FR_RI,
-	.get_fifosize		= get_fifosize_zte,
-};
-
 /* Deals with DMA transactions */
 
 struct pl011_sgbuf {
@@ -2974,11 +2942,6 @@ static const struct amba_id pl011_ids[] = {
 		.mask	= 0x00ffffff,
 		.data	= &vendor_st,
 	},
-	{
-		.id	= AMBA_LINUX_ID(0x00, 0x1, 0xffe),
-		.mask	= 0x00ffffff,
-		.data	= &vendor_zte,
-	},
 	{ 0, 0 },
 };
 
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index edfcf7a14dcd..6c7f47846971 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -90,14 +90,8 @@ enum amba_vendor {
 	AMBA_VENDOR_ST = 0x80,
 	AMBA_VENDOR_QCOM = 0x51,
 	AMBA_VENDOR_LSI = 0xb6,
-	AMBA_VENDOR_LINUX = 0xfe,	/* This value is not official */
 };
 
-/* This is used to generate pseudo-ID for AMBA device */
-#define AMBA_LINUX_ID(conf, rev, part) \
-	(((conf) & 0xff) << 24 | ((rev) & 0xf) << 20 | \
-	AMBA_VENDOR_LINUX << 12 | ((part) & 0xfff))
-
 extern struct bus_type amba_bustype;
 
 #define to_amba_device(d)	container_of(d, struct amba_device, dev)
-- 
2.26.2

