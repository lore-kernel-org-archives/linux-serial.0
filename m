Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB61BC433DF
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 18:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 985762067C
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 18:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWNgsnEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHRSz1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbgHRSzZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 14:55:25 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3904C061389;
        Tue, 18 Aug 2020 11:55:23 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id f19so11455571qtp.2;
        Tue, 18 Aug 2020 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b3jNsyj/qiBAuy4YJCoytwqosstgAXD/++wTpyEbakU=;
        b=dWNgsnEipriITe0mjwq95y0gULU3kOwQLSobXeWaYDw0Cbjwwf4MCX3g8yrdz3GKWV
         d/XtOuS4ZxHZwU3PqZ3kgWFv7DQ/E2i1BGrS5Kuvso24spEjd9bgIpn6L/QCloULM0SN
         PiY2NGbhJmkkgs1101USl1jvVUD43zUSzXwOAcPxq16oXrCwkv1ZvgFSdlPs1QqpsxHu
         fnaErg4JTIWYY69JmDoaLxn4JDA5wmAAxy7PMiZUv8HyZDxSwiNGVERnMSKclXioPkaJ
         FXblSXCadnQ+AkVJ0lBRVxHS8tZ6tRshG3hNCbHXiSh5rNUb+EXRF44BTSxUYmW5+OhC
         iJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b3jNsyj/qiBAuy4YJCoytwqosstgAXD/++wTpyEbakU=;
        b=QXDlwwRgveAQMqv2UxRrARK2szQUG4ZI4ssqkQGfc/9HZXlzeK5cdZ6p7qSmZ3N8nH
         uAyb1B1UqEKxJbPdDxOOIiSs9Yyn/jrZ+G7ut1vKvZQ+MQT6svUONcl3RKaiBTKf0Jt2
         OMJaXrAQJon/STI/axrHDecAOqFog/fptVP8dfnO6in7UJ45X9cDLs0tN0QKKi6UiXpp
         CZO4qXZIhTUOqQOTJFadY+pztELHhb+zjB9M30127Af+KLyh0ApfB5zX3Lv/M07v6ds9
         wde1f6OPbBJswaX9XXa+ztbmwLXxf09Kagjq35np3EV0es35dM/nHXMj/ErdLVRCP2g9
         aWBg==
X-Gm-Message-State: AOAM532r0ihhvEXZkD4xBQY4iyPcYAn2Oj+/Mey0IXm/asI5ndi223XZ
        oW7ztSp+1fYUuwrl0kz9K0w=
X-Google-Smtp-Source: ABdhPJzMq+tTPcrnH3DTevTOuTLR+H4yZD2srB20pl4xe+6ZIBA/sei9Ubuxgt0mzdIYmUmNHemhiA==
X-Received: by 2002:aed:2199:: with SMTP id l25mr18742965qtc.309.1597776923228;
        Tue, 18 Aug 2020 11:55:23 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c100:b9d:f9e2:64b4:fbc4:6485])
        by smtp.googlemail.com with ESMTPSA id x198sm23498821qka.37.2020.08.18.11.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 11:55:22 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ztong0001@gmail.com, kernel test robot <lkp@intel.com>
Subject: [PATCH v4] tty: serial: earlycon dependency
Date:   Tue, 18 Aug 2020 14:54:59 -0400
Message-Id: <20200818185458.84418-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200818162556.6621-1-ztong0001@gmail.com>
References: <20200818162556.6621-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

parse_options() in drivers/tty/serial/earlycon.c calls uart_parse_earlycon
in drivers/tty/serial/serial_core.c therefore selecting SERIAL_EARLYCON
should automatically select SERIAL_CORE, otherwise will result in symbol
not found error during linking if SERIAL_CORE is not configured as builtin

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---

Fixes: 9aac5887595b ("tty/serial: add generic serial earlycon")
v2: I made an attempt to fix the commit log
v3: I made another attempt to fix the commit log and I also changed
select to depends according to Jiri's comment
v4: fixed another stupid error -- should be "depends on" not "depends"
Reported-by: kernel test robot <lkp@intel.com>

 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 8a0352eb337c..759ac4a5a5c5 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -8,6 +8,7 @@ menu "Serial drivers"
 
 config SERIAL_EARLYCON
 	bool
+	depends on SERIAL_CORE
 	help
 	  Support for early consoles with the earlycon parameter. This enables
 	  the console before standard serial driver is probed. The console is
-- 
2.25.1

