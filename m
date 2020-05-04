Return-Path: <SRS0=QloM=6S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669C0C3A5A9
	for <linux-serial@archiver.kernel.org>; Mon,  4 May 2020 14:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F9D2206D7
	for <linux-serial@archiver.kernel.org>; Mon,  4 May 2020 14:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="sCyOY7cW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgEDO1d (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 May 2020 10:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgEDO1c (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 May 2020 10:27:32 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC807C061A0F
        for <linux-serial@vger.kernel.org>; Mon,  4 May 2020 07:27:31 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x25so8709004wmc.0
        for <linux-serial@vger.kernel.org>; Mon, 04 May 2020 07:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R8hMysgCANDxPI0D+IpQRpi6VaDo+fsmsuFYs+cuTuA=;
        b=sCyOY7cWz+Zih2Gcur3hgcfiu3oSiZBTIp0cZmq5uKEDB6IrRn9BCNvLxR0Y2FnQ75
         J/sWlpL8ZM/H2nEmr1COYKz40Odhyre7AgPfsXQpuO/yVTvFrL7svixV/hPPXLFe76NL
         a5ZxjdqpicIx5Ol0TULum1FfemlP16K3/LeIY6MvaApt2ME7+3l3YC+1xxuqIB3+2AXc
         RgQkc912evPAICrllpKV+xm0uyGmeiHBUw2pviROwFNmFGQMeMlbHDH+To1RM+10fxCp
         PtzF1sTkIAtzaTNVqC2EXQGruoXv5gwMTh5A5y1Jlrv5srccEch/nFZZN7jXn7v8L8r6
         FHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=R8hMysgCANDxPI0D+IpQRpi6VaDo+fsmsuFYs+cuTuA=;
        b=C+KBVjlaNZB0+QkdavFEU8/lrMCoF4o+CFFE7lOkHC2+TYwpjw1swQFsJgins7GlpV
         wEDvwn0LG8+eNc0eJARotWVD/z0jVkQsPZ2cyWBfQJnZAjDAJw/0obBKVlAvY+W6/Eqd
         vO0C7Khv27noxoEH9exaxce3SCxoeODfSrKY32VgoYBFtUrBhWQ43RiwkMl56eY0L+ps
         34msQtA/i9sYb8TXj00TED1/wjLWKmFieQ3xp5lf7+pjmY3fu2HzI23KLxa6i9qvK4Lf
         nANNIgI4aSat1LC5xgM15PmOIJ+VCLYbpv7VMQ3q/XQl5T22PiOtXZIOtemVaB9fVPUX
         /3FQ==
X-Gm-Message-State: AGi0PuaOA+Rvf2vzpH5DxJaoniZxM9QdOzd9IuUBjOvNgEQa3N545l+c
        419UJ/JOFfNhKi4PSWZYZvU1kg==
X-Google-Smtp-Source: APiQypJvPehbbUthQvX9YGeEq+Ipj4rzULCq/PSfWLN7t0/wgJVu4JxunEJ5TD5rohgmepaA63orXw==
X-Received: by 2002:a1c:1bcb:: with SMTP id b194mr15744884wmb.4.1588602450462;
        Mon, 04 May 2020 07:27:30 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id g6sm19438716wrw.34.2020.05.04.07.27.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 May 2020 07:27:29 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, stable@vger.kernel.org
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: [PATCH v2] tty: xilinx_uartps: Fix missing id assignment to the console
Date:   Mon,  4 May 2020 16:27:28 +0200
Message-Id: <ed3111533ef5bd342ee5ec504812240b870f0853.1588602446.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

When serial console has been assigned to ttyPS1 (which is serial1 alias)
console index is not updated property and pointing to index -1 (statically
initialized) which ends up in situation where nothing has been printed on
the port.

The commit 18cc7ac8a28e ("Revert "serial: uartps: Register own uart console
and driver structures"") didn't contain this line which was removed by
accident.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Do better commit description
- Origin subject was "tty: xilinx_uartps: Add the id to the console"

Greg: Would be good if you can take this patch to 5.7 and also to stable
trees.

---
 drivers/tty/serial/xilinx_uartps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 672cfa075e28..b9d672af8b65 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1465,6 +1465,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		cdns_uart_uart_driver.nr = CDNS_UART_NR_PORTS;
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 		cdns_uart_uart_driver.cons = &cdns_uart_console;
+		cdns_uart_console.index = id;
 #endif
 
 		rc = uart_register_driver(&cdns_uart_uart_driver);
-- 
2.26.2

