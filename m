Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAF4C6FA8E
	for <linux-serial@archiver.kernel.org>; Sun, 26 Feb 2023 17:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjBZRjt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 26 Feb 2023 12:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBZRjs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 26 Feb 2023 12:39:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8950518B27
        for <linux-serial@vger.kernel.org>; Sun, 26 Feb 2023 09:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677433140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=i/hpLCH1J1OZC0aaq8N5qErte4jZaIcaYpEnIIPJejU=;
        b=JNI/n/srQ2iN9KA1fJ3zBBhAzLq019H9SMRw9xFI4s8O8VtKFKw53Ljajp6mKBLdOfq5W9
        3H+FIuniHH5vhjyE1YBhIdbFlA9q0bR/o4zcX4X/Owfn9c302k09x8dl2adW5jbtduPUuw
        e71Ml8o+F2sJ+VLf9H3TLe9RneWOgL4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-65-am0DTIbBMJOc7VXv6KMN5A-1; Sun, 26 Feb 2023 12:38:59 -0500
X-MC-Unique: am0DTIbBMJOc7VXv6KMN5A-1
Received: by mail-qv1-f72.google.com with SMTP id u18-20020a0cec92000000b0056ea549d728so2244948qvo.10
        for <linux-serial@vger.kernel.org>; Sun, 26 Feb 2023 09:38:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/hpLCH1J1OZC0aaq8N5qErte4jZaIcaYpEnIIPJejU=;
        b=Nzey/bRxMIPiJowlX9wpZKaRpFvWbYu6zEV96CbqMBsYjTpoRh0n5aaDFRGkY7NMyJ
         OP30MKHRqUenpvp5ZTrEKCnCTlv4l4X9CYWS7Mg4HGMWkBLx+4em1fSip/ZpzO+SYenD
         dvpatrE+ekVDNToftSkUofCbi7vwHbAcQKHI4ZbH73COT5NentE8hay+uT/mBuD27fed
         TNwWUSqFtbGMY5RqT3M6FIOKavjwJ6AZ6WS/9itlBOm8UE+FumKYTo82XTvwnDlsC3oo
         jDGmWxbwVlQC5WUgyKNe7eiwDxW7gGguIH0zPTy99tKyibcYveipW/9ENgvrfCs5NhVc
         vKYQ==
X-Gm-Message-State: AO0yUKWBD0e9ft92XI6Yh7ZIWTSGcyZEuIF6w0hF+vI0CGF/KgYDBig3
        4DH5NAofDgGEGFLN2llVfPdr+gJTGmMsIE8WMH8lSBqq9VMGQpKKAYMa16Fl1SvvCS5FlseW6PH
        Cp/c7vgfDcKLYLb+Zxv/mHxW3
X-Received: by 2002:a05:6214:400d:b0:56e:f1fd:f16c with SMTP id kd13-20020a056214400d00b0056ef1fdf16cmr10742456qvb.20.1677433138671;
        Sun, 26 Feb 2023 09:38:58 -0800 (PST)
X-Google-Smtp-Source: AK7set9hvhZVb90JP5bKYcnQSg83aAvp4BYFORSYNpZjoUDZCW3/tH8VrWxub3amijsmOE+4vS8s9g==
X-Received: by 2002:a05:6214:400d:b0:56e:f1fd:f16c with SMTP id kd13-20020a056214400d00b0056ef1fdf16cmr10742440qvb.20.1677433138458;
        Sun, 26 Feb 2023 09:38:58 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r191-20020a37a8c8000000b00729a26e836esm3341343qke.84.2023.02.26.09.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 09:38:58 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        sherry.sun@nxp.com, jindong.yue@nxp.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] Revert "tty: serial: fsl_lpuart: adjust SERIAL_FSL_LPUART_CONSOLE config dependency"
Date:   Sun, 26 Feb 2023 12:38:46 -0500
Message-Id: <20230226173846.236691-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 5779a072c248db7a40cfd0f5ea958097fd1d9a30.

This results in a link error of

ld: drivers/tty/serial/earlycon.o: in function `parse_options':
drivers/tty/serial/earlycon.c:99: undefined reference to `uart_parse_earlycon'

When the config is in this state

CONFIG_SERIAL_CORE=m
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_FSL_LPUART=m
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y

Fixes: 5779a072c248 ("tty: serial: fsl_lpuart: adjust SERIAL_FSL_LPUART_CONSOLE config dependency")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 625358f44419..0072892ca7fc 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1313,7 +1313,7 @@ config SERIAL_FSL_LPUART
 
 config SERIAL_FSL_LPUART_CONSOLE
 	bool "Console on Freescale lpuart serial port"
-	depends on SERIAL_FSL_LPUART
+	depends on SERIAL_FSL_LPUART=y
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 	help
-- 
2.27.0

