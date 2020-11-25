Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47FAC56201
	for <linux-serial@archiver.kernel.org>; Wed, 25 Nov 2020 09:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469EF206B5
	for <linux-serial@archiver.kernel.org>; Wed, 25 Nov 2020 09:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMN23hZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgKYJGZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Nov 2020 04:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgKYJGZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Nov 2020 04:06:25 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9771BC0613D4
        for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2020 01:06:17 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id j10so1491157lja.5
        for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2020 01:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vgm+cuXiaDptZrOlwysn9B8OvEUyHXhxAdgDU6XRMMY=;
        b=vMN23hZR7aJ52Ns+L69HWJRFvmaW/u2steBjq5+y8P56vX5Zl6AEB6iwWSNWkj2RIm
         lMhi6xikogDwa7wr2QPBqSO4iUu3IM35npQgnPfElW4NSiQe10SIQYlBLabnlZ5svh7M
         lb1Ox1qMcYJWmDpzhajYAj2aapuierujsiaGPtl6RXiVNPWVLu5CIDIAqR0Yz1xr3U/Q
         Ulp/mifneAQ8aLMPGCXuUmtxcWDY7ujm5G7ODjwDN3f6qqNdWEFA5rQx1yoR9rJQOmSM
         CbxX/nKWEl+1l3VnzwAf+vS+YvA7jpbbLYRR6PoRb99TWN7ZSphRJg+IqqNtGxWwRfOL
         KbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vgm+cuXiaDptZrOlwysn9B8OvEUyHXhxAdgDU6XRMMY=;
        b=j3SRbSDt8NriqWoblmTIvHeEroLGPyxWXtXgmMPxxLjfX9YhzYxFDVdrsevR1SBj87
         wREzk9IkeumBsDBSp6za2K5gGu+ZpC2SN268PZLZzBn+DmMkj8R1YM7d8yDIMI7un7sc
         VCEuKf5b8Pnu0HYZ2RBlQX9d95xlznZONw8y5KRbVbP4Szf3ff7T8NoAsNatoc/Hmtwy
         OWHBCiYhmkSDtk44XtV1I1gnnnbtfY/gftsneA3kSgxlVi2/nYUT36rmPnHK7iWHFYa0
         8KeKfF0D3gvY3JHEwC2Io9T1x3bfs8zrQjKu7HdV10fLr6Et3epMhAJRAQ713vIViIzX
         sSrg==
X-Gm-Message-State: AOAM531jEc2SXfu0bX/rAbR1p66GB84OoDSDCMPj52qABQ5sRj0aYlJA
        oARGzgKtZoaw3cHL5cvqh5o=
X-Google-Smtp-Source: ABdhPJxUik8H1il9YYM658PYT3/4h79bL0gfnRbDCl98B514bQ8o161ysAWcw8xj1UThsNg4oPRiwQ==
X-Received: by 2002:a05:651c:1195:: with SMTP id w21mr948492ljo.427.1606295176111;
        Wed, 25 Nov 2020 01:06:16 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id q20sm187217lfr.110.2020.11.25.01.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 01:06:15 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2] tty: serial: bcm63xx: lower driver dependencies
Date:   Wed, 25 Nov 2020 10:06:08 +0100
Message-Id: <20201125090608.28442-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201125081352.25409-1-zajec5@gmail.com>
References: <20201125081352.25409-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Hardware supported by bcm63xx is also used by BCM4908 SoCs family that
is ARM64. In future more architectures may need it as well. There is
nothing arch specific breaking compilation so just stick to requiring
COMMON_CLK.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Just drop all ARCH_* dependencies. Thanks Greg!
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 28f22e58639c..cc67f02f5c32 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1133,7 +1133,7 @@ config SERIAL_TIMBERDALE
 config SERIAL_BCM63XX
 	tristate "Broadcom BCM63xx/BCM33xx UART support"
 	select SERIAL_CORE
-	depends on MIPS || ARM || COMPILE_TEST
+	depends on COMMON_CLK
 	help
 	  This enables the driver for the onchip UART core found on
 	  the following chipsets:
-- 
2.26.2

