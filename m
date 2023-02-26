Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E1CC64ED6
	for <linux-serial@archiver.kernel.org>; Sun, 26 Feb 2023 15:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBZPIV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 26 Feb 2023 10:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjBZPH7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 26 Feb 2023 10:07:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C76C21A10
        for <linux-serial@vger.kernel.org>; Sun, 26 Feb 2023 06:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677423288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oP3oPuchm6C78y0w7FcABuS+2qv7jrRkSYqeHoyGogM=;
        b=do4jRuD1AoS0JfwDf00YM51CgPeiVmX6ywgVPIaZeVTOqIKtPw3+Ki11T6NFs/X0LhN/Wi
        DKYUY3zSfE/HwbWTLeEAedp2LAFcPxt/jWJlzT6WeQoOg9rLXP+SfudzEku/b6pQ+JNSrY
        DcSTkF26b3uCGKxnlV7q1N0YWoWxuYw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-549-PcWj90ZoNYKTEXdIa1Mk9w-1; Sun, 26 Feb 2023 09:54:47 -0500
X-MC-Unique: PcWj90ZoNYKTEXdIa1Mk9w-1
Received: by mail-qv1-f70.google.com with SMTP id l13-20020ad44d0d000000b004c74bbb0affso2061844qvl.21
        for <linux-serial@vger.kernel.org>; Sun, 26 Feb 2023 06:54:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oP3oPuchm6C78y0w7FcABuS+2qv7jrRkSYqeHoyGogM=;
        b=FLIwS8y9Y0mB8k46BFHNFU2omP2upA2L05FY5YxJAzH2q8ucp5iiPnrpNxK9+sHXf6
         ioWZcJnC5ZooCddBd1CSORhpXwKBNldC2PLpCjZj5yGBZUclmhAb+b3n7ceJg+UmlgdC
         KCxyQJRckhQJwuIsiIf1vQ1q1wz/ZBN/V1kDDWRCqL7ZefkTPXJZ2F1lao4ULd673kxl
         4tDFbUCLzcKEdAKqfNydk2bF+0tkwzFhdK83W8WPXMhi58jT9gfK9pFxkVvDwe6UfCKS
         qHuDDIPC0pZqVfHvFr4q5pRCpm1BSGN3PCrYLwqEx+Qdl8N9L8eUK9cBD2SSmaUDEjkq
         YYNA==
X-Gm-Message-State: AO0yUKVD0D/qB/+s5uPlgAAqLiNuUd4tkwLQuFYxlj8QK7nyLd511j/9
        Q1ZwbvacsxiNqXrYXpFTMRFysm/3qDiIGuNgaM/QiyWuUPY0v/SmKqQsdVYAU/MmjxEToJ1M2E4
        BKqlYbAb2ReiohDojbstfVgsrw3qbrg==
X-Received: by 2002:ad4:5bae:0:b0:56e:957f:dd5f with SMTP id 14-20020ad45bae000000b0056e957fdd5fmr35934664qvq.50.1677423286584;
        Sun, 26 Feb 2023 06:54:46 -0800 (PST)
X-Google-Smtp-Source: AK7set/Dvnqu/AWuG3VmERieiYOLTpNGZ6BWRhVKDWe6qiHzJf2eI0ns0naoQAZr4A3CqW7FmHsMRA==
X-Received: by 2002:ad4:5bae:0:b0:56e:957f:dd5f with SMTP id 14-20020ad45bae000000b0056e957fdd5fmr35934643qvq.50.1677423286344;
        Sun, 26 Feb 2023 06:54:46 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f64-20020a37d243000000b0073ba46a585asm3127203qkj.64.2023.02.26.06.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 06:54:45 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2] tty: serial: fsl_lpuart: select SERIAL_FSL_LPUART for SERIAL_FSL_LPUART_CONSOLE
Date:   Sun, 26 Feb 2023 09:54:41 -0500
Message-Id: <20230226145441.3150640-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

A rand config causes this link error
ld: drivers/tty/serial/earlycon.o: in function `parse_options':
drivers/tty/serial/earlycon.c:99: undefined reference to `uart_parse_earlycon'

The rand config has
CONFIG_SERIAL_CORE=m
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_FSL_LPUART=m
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y

SERIAL_FSL_LPUART should have been selected instead of depends on-ed.

After applying the configs are
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: Add how the configs changed to commit log
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 625358f44419..b24d74d389fc 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1313,7 +1313,7 @@ config SERIAL_FSL_LPUART
 
 config SERIAL_FSL_LPUART_CONSOLE
 	bool "Console on Freescale lpuart serial port"
-	depends on SERIAL_FSL_LPUART
+	select SERIAL_FSL_LPUART
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 	help
-- 
2.27.0

