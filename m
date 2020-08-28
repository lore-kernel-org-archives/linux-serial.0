Return-Path: <SRS0=9Cit=CG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EC2C433E6
	for <linux-serial@archiver.kernel.org>; Fri, 28 Aug 2020 12:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D0320776
	for <linux-serial@archiver.kernel.org>; Fri, 28 Aug 2020 12:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlqTF7Mj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgH1Mkm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbgH1Mki (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Aug 2020 08:40:38 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46DFC061264;
        Fri, 28 Aug 2020 05:40:37 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o196so737899qke.8;
        Fri, 28 Aug 2020 05:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ilEUfQ8pnyC2no166+acqoK2zUhtltonp2ECw8hDVOk=;
        b=AlqTF7MjmP6weBbmk4l6TzuRcByP7wT7pjUNhwx0i+ZyQBZGPydNkTYiQHLmy0TuLV
         1vraoNA3D0vlICmvInZ9iJrNVTxldswjGbX/SuyYx5o9pM7trPGAAuiFyEQnA18M0EMv
         Jt6drr5VPua77d6hCX9AsNKbv+LnU5DZZ+WTEmnaK+YPl+f5BGALgsRvzBIxz2Ttwmex
         sTVeMRAu9o5GBsGy0L0j9KcnpWcQI1R7fURV2m9xvJO9CBXEMv3CY1svFRy9wBGAv8Av
         xutB6eyzHQn2knrEb7vblLwiKWdjJsY56zWOoGpKqOvDX5eh6lDbdbG67norw+xlkx5L
         Y2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ilEUfQ8pnyC2no166+acqoK2zUhtltonp2ECw8hDVOk=;
        b=HqHEhWj0GtEP9p1zL17G6uFmX8D/T7kiINTP3WgSYQalmSNT84A/KoR7bP5Tl+t5wA
         dW64vjtWI/jlfV2nQW0O96NrjNVYFodo8mE0b5BzRxMXpPpUINgNSppAsqGPCAFNZVcH
         GrgVg3GXIy0cAoM7wM3AGmnwVplHvTXQ23PzNLr9REOg0iT+Eldxa2ytdWOQkn97NhPf
         RadSlF4FS1RDntlj5PQF0y+V+3mkVrRqIfv6+qa8jihXrx4JmP3ma1W4heZIDwRGnqSG
         UwGnWv9/ib0ESl/BOzuEpQFhb62DzbYm7o1FA5766xHhDOz5hxFopjQcvq2nG/ZaBpBs
         Tqfg==
X-Gm-Message-State: AOAM533Me5060vXZ0munKWe5yRkm0eYc7wJ/Hyam+OD731Ga6WdtBEDV
        ZDg310epGIe8tVPluwJp3s8=
X-Google-Smtp-Source: ABdhPJwYHTM7FeYKY9vGUFlp9a2rrK2t3a0Wsk1DA26XuoMbWQlNEsQ+CI9rnuRWeGKNzayY1qdjPQ==
X-Received: by 2002:a37:4e4d:: with SMTP id c74mr956228qkb.311.1598618436998;
        Fri, 28 Aug 2020 05:40:36 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c100:b9d:8cbc:4931:e171:e7fa])
        by smtp.googlemail.com with ESMTPSA id t11sm832760qtp.32.2020.08.28.05.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 05:40:36 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ztong0001@gmail.com, kernel test robot <lkp@intel.com>
Subject: [PATCH v5] tty: serial: earlycon dependency
Date:   Fri, 28 Aug 2020 08:39:50 -0400
Message-Id: <20200828123949.2642-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828082015.GA1052883@kroah.com>
References: <20200828082015.GA1052883@kroah.com>
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

Fixes: 9aac5887595b ("tty/serial: add generic serial earlycon")
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---

v2: I made an attempt to fix the commit log
v3: I made another attempt to fix the commit log and I also changed
select to depends according to Jiri's comment
v4: fixed another stupid error -- should be "depends on" not "depends"
Reported-by: kernel test robot <lkp@intel.com>
v5: fix commit log - move Fixes line

 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 9409be982aa6..54586c1aba60 100644
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

