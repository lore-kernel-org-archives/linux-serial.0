Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84B3C433E3
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 16:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DB82067C
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 16:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bic/hW8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgHRQ3A (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgHRQ01 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 12:26:27 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC37C061389;
        Tue, 18 Aug 2020 09:26:26 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id y11so9825661qvl.4;
        Tue, 18 Aug 2020 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iIX0sNpmnJ6kXFsh0zKxLpYcQTRQO7AV2JMPqyWSiic=;
        b=Bic/hW8DHiQT6NI9ZYD2pLUalLPzv43IhrECzIzAy1blLkWVMCvnvwwfyDaiES+8+h
         c+Y16gYMVadeuQ1AQqjt05lsi7m2uHzKuYFVoNIFTkHuKdkiByM6epBC11bVKxykIyja
         g64CzhD91jNskkR/oUyM/MVLgWWxnqw488Y35xkz9qJfNcAirZtdgSm76DbUSaHxPhEs
         QX9ZiyNtrIyncv6FIoIYpQ/o4o5Wy6rI2wm+Lr9PXFwKG1Hpx95jztSCYvXqwoXV9fq/
         7qkR6GyaKIv3FBdHmaHGu84rVwj4YT2KH8jUwSEqJ07LShZTq4j9JnVKyQD21t5thlHb
         My5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iIX0sNpmnJ6kXFsh0zKxLpYcQTRQO7AV2JMPqyWSiic=;
        b=HlWtDXySbjDIG53XuijPF+bp7KAUb8a46mbMH0fpCF9ySgfw330iNea5ax5+OEe83s
         Brg3t+trfApIIPiuNjfGhKv7RSEQXhvHJ2zoOcJPBfn1r0Gv2ayB0I6CudR0Vbd2FgXo
         mY+4uOU/Yk0IEvmM+dA38Tx1Kzm7CdsaQuulZ5zExsQCM9uLIxkajMzjtOajoVw1eFUP
         Nq+Ki9Px9frU7qm6KBJsulqsbd3xfF4ehiHIspjuEEjdxrLGeODATb7fbk0HqGqCMcLy
         D+OKMMSYJ8qfk9GEohl5BAHzdlVfZ/du7sjjOh+waHsGi/EiN/HWLrqsoiJK3re1nE4z
         +Bhw==
X-Gm-Message-State: AOAM532qINWlgboax2RAhFe/41PmO00J3Y3UcNggPSfWqd6QfMAI75Le
        ceO+hmBmqImOqFoUWXywE18=
X-Google-Smtp-Source: ABdhPJy8t33CnDNghotiO9kPZ14KObEgHCT8T7IzUxyWuvEpZJ6mUqWnxWZvLoD137JlGgSdlYORzg==
X-Received: by 2002:a0c:f2c8:: with SMTP id c8mr19867270qvm.64.1597767986007;
        Tue, 18 Aug 2020 09:26:26 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c100:b9d:f9e2:64b4:fbc4:6485])
        by smtp.googlemail.com with ESMTPSA id u8sm11928528qkj.9.2020.08.18.09.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 09:26:25 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
        linux-serial@vger.kernel.org
Cc:     ztong0001@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3] tty: serial: earlycon dependency
Date:   Tue, 18 Aug 2020 12:25:57 -0400
Message-Id: <20200818162556.6621-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200818111954.GA283417@kroah.com>
References: <20200818111954.GA283417@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

parse_options() in drivers/tty/serial/earlycon.c calls uart_parse_earlycon
in drivers/tty/serial/serial_core.c therefore selecting SERIAL_EARLYCON
should automatically select SERIAL_CORE, otherwise will result in symbol
not found error during linking if SERIAL_CORE is not configured as builtin.

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---

Fixes: 9aac5887595b ("tty/serial: add generic serial earlycon")
v2: I made an attempt to fix the commit log
v3: I made another attempt to fix the commit log and I also changed
select to depends according to Jiri's comment

 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 8a0352eb337c..6aed721e9287 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -8,6 +8,7 @@ menu "Serial drivers"
 
 config SERIAL_EARLYCON
 	bool
+	depends SERIAL_CORE
 	help
 	  Support for early consoles with the earlycon parameter. This enables
 	  the console before standard serial driver is probed. The console is
-- 
2.25.1

