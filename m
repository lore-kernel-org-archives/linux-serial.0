Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDE9C64EC7
	for <linux-serial@archiver.kernel.org>; Sat, 25 Feb 2023 17:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjBYRlV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Feb 2023 12:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBYRlU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Feb 2023 12:41:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A6ADBED
        for <linux-serial@vger.kernel.org>; Sat, 25 Feb 2023 09:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677346832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=t2xDexvbEpstvAGccLQfRgpoKZ24pDQp0rCGKgyksKU=;
        b=jCKX7/VtoXmGo415OClIltVArhzoagIhLKONoS82xfV3LgqjJbcGjAV8jGZem2WJUgrURr
        zE6EqgJ70/i8Lgs79u52F9tFIBFMTyDneHKaY6GsF3cN8zkki3uFBY/VlSp1kcP13mWfhT
        0SxhL2rg7+oY83kO0W6Tbv23Vzcaed0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-97-OLK6sjHGNgyHMojIuAWIdQ-1; Sat, 25 Feb 2023 12:40:30 -0500
X-MC-Unique: OLK6sjHGNgyHMojIuAWIdQ-1
Received: by mail-qt1-f197.google.com with SMTP id k19-20020ac86053000000b003bd0d4e3a50so1356123qtm.9
        for <linux-serial@vger.kernel.org>; Sat, 25 Feb 2023 09:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2xDexvbEpstvAGccLQfRgpoKZ24pDQp0rCGKgyksKU=;
        b=sbVCQmtv+FqnnPn9Mu+ZQ1a32itP9npRcPFkmZfidfU7d9+tYNcZtTMyhT6d204A2g
         pwbzEsK8zzCj9p0tOhfr8aEsezO0aEvObFCkFVTQldWFffuNzm7S9iwP8cmjcKt4MJLp
         tvs9aSQbxHwfZHQLotdsmwgnL5WIu7JyidPxHtm1drncdm/6M1TJjnVTlKcibVCDNiwV
         8fQg2wwvjB4qPfFDr39XaCf+l/lbrSBH7oUEf62FLz5DMg12lVa7TazCgHXXPidj+TtX
         iwwNtXGPoIoUHENqlOddZ+PyQL8ydsQ9IpT7whvsKQsi9mAmyWh3sU8xn/nY+Sg/6gCl
         flWQ==
X-Gm-Message-State: AO0yUKVlWrduPWlgijdnlCG7Qg3+mLXNQHdSJ6HIEruhsHfQP8KPDYh/
        IBD1ew6uT7IWh1LC5QEJrB0EjL5sWw3Tv6F5qISR8iBD3EH5kE3VpaPGA2Oqjy30fVmK14G2LG5
        R91IIqAGW806aM9ytnwah6n1B
X-Received: by 2002:ac8:5a8f:0:b0:3bb:995c:424c with SMTP id c15-20020ac85a8f000000b003bb995c424cmr7145950qtc.22.1677346830400;
        Sat, 25 Feb 2023 09:40:30 -0800 (PST)
X-Google-Smtp-Source: AK7set99TWS0BHK2q2+GJnqx9jqjSJfve8LytoFQraRhQF8xc5Ljq51BJkPB3eUBld1DDUhQPe4DZA==
X-Received: by 2002:ac8:5a8f:0:b0:3bb:995c:424c with SMTP id c15-20020ac85a8f000000b003bb995c424cmr7145922qtc.22.1677346830167;
        Sat, 25 Feb 2023 09:40:30 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z2-20020ac86b82000000b003bfbf16ad08sm1590282qts.74.2023.02.25.09.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 09:40:29 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] tty: serial: fsl_lpuart: select SERIAL_FSL_LPUART for SERIAL_FSL_LPUART_CONSOLE
Date:   Sat, 25 Feb 2023 12:39:49 -0500
Message-Id: <20230225173949.651311-1-trix@redhat.com>
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

Signed-off-by: Tom Rix <trix@redhat.com>
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

