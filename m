Return-Path: <SRS0=SyHF=5B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DA3C0044D
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 10:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270992071C
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 10:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzJbPc+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbgCPKTm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:19:42 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54909 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730478AbgCPKTm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Mar 2020 06:19:42 -0400
Received: by mail-pj1-f66.google.com with SMTP id np9so1402476pjb.4;
        Mon, 16 Mar 2020 03:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=63LCAH/u0N3am5h1LJvNqX6i8qdQp745NiWQxDSlslY=;
        b=SzJbPc+Mm+fZYrwkS+qSYu81VujHdDpRhVqhNZQGBq0LUgQJrow1xyyfli9MabCJH2
         JeLZ9Z4PZ9f4kMJ2DCz1EkwPIVUPdljsaus77aynD+982toCTu7peT8Omj5fMxxdzcm3
         AHqi+pzjWJmE9suI+YIq33oKAraF+dTQUabCMOdnzLm3Q7ckEU9aTEqqcrlil7v++4Y2
         S+h8eA1d1t6npmxodMeAOlYeElHYPlV4FgMzV0qWuyqwDfIIB2hgJTT4SE5AuG9GOcpO
         00lXPRU3ASYTlWzCjdXtpmfRl7FQj2IrsMCbp6uFoZkcPEiNPIOJVUUCF8em/+y6PSLJ
         HB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=63LCAH/u0N3am5h1LJvNqX6i8qdQp745NiWQxDSlslY=;
        b=r0tlNu6QC+fnCQI2XQz6HeZ+QkLloQSCAoPifhJY92gspZUti+1muBGbbhwDJKsyyS
         ce6stqd89wcjUA9CsqENzFDzNDBNCQjrE38t8MzNLHTzbTIxvdjNF4lVFU83H5l2pz48
         TM8w4dlsyVYOR9OKOuZGZSH6brwLL7i0Y1Ca2RiV9jEVztaJcvUsFKc+KH6NpDWWFvax
         uW4TqVNyDMZo/dOXSjJdFGRCRLk5vKf+OwoycLqwQXh9nHNhESUZT+CpFgR3V2Zd0j++
         azYkIWI86vn+nBPFN4nA71t1c2mxB8skHywR743hPQ4iWqQkUYeOBi/idPmRB1Hmx7uH
         sjlg==
X-Gm-Message-State: ANhLgQ1l05QjR5FFtCwID0pgnK70xUNNlhEEJt4RyJXHq+9BCkFNdlNi
        lpraY+KwDTgUaoTP2msSow4=
X-Google-Smtp-Source: ADFU+vvS2Cz2L6Gst/+Y4IWGEORkrihGMImmfjwnS+bfc+1O3BzcLdObTuhWpBGzwCIp1S/PVc508A==
X-Received: by 2002:a17:90a:2710:: with SMTP id o16mr16122556pje.110.1584353981493;
        Mon, 16 Mar 2020 03:19:41 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id u3sm21676491pfb.36.2020.03.16.03.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 03:19:40 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 1/3] serial: sprd: check console via stdout-path in addition
Date:   Mon, 16 Mar 2020 18:19:28 +0800
Message-Id: <20200316101930.9962-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316101930.9962-1-zhang.lyra@gmail.com>
References: <20200316101930.9962-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The SPRD serial driver need to know which serial port would be used as
console in an early period during initialization, the purpose is to
keep the console port alive as possible even if there's some error
caused by no clock configured under serial devicetree nodes. But with
the patch [1], the console port couldn't be identified if missing
console command line.

So this patch adds using another interface to do check by reading
stdout-path.

[1] https://lore.kernel.org/lkml/20190826072929.7696-4-zhang.lyra@gmail.com/

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/tty/serial/sprd_serial.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 3d3c70634589..18706333f146 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1147,7 +1147,8 @@ static bool sprd_uart_is_console(struct uart_port *uport)
 {
 	struct console *cons = sprd_uart_driver.cons;
 
-	if (cons && cons->index >= 0 && cons->index == uport->line)
+	if ((cons && cons->index >= 0 && cons->index == uport->line) ||
+	    of_console_check(uport->dev->of_node, SPRD_TTY_NAME, uport->line))
 		return true;
 
 	return false;
-- 
2.20.1

