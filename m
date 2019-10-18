Return-Path: <SRS0=Hh8y=YL=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC93CA9EA0
	for <linux-serial@archiver.kernel.org>; Fri, 18 Oct 2019 12:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B37222CC
	for <linux-serial@archiver.kernel.org>; Fri, 18 Oct 2019 12:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="TidEzT1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410075AbfJRMww (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:52:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40552 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410066AbfJRMww (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Oct 2019 08:52:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id 7so6107034ljw.7
        for <linux-serial@vger.kernel.org>; Fri, 18 Oct 2019 05:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pFyIkShUP070T1MCe1PZHDrW/Mw93dXatTsiD8H58Vo=;
        b=TidEzT1giC2Jh121pQGun9aW1g6lMhBfTyTOD0z3AV8CZfc/kN8w6/T5TIOp6CwnyL
         Lp+Ce/mQ73ZwV/P4bEPMVvAqsTBSu+GsCShsUoPBJF0/etODAuZGq8d9uag7/34zzBrt
         MMymPFrUp1zyB/TcGssfWaGbpiAqQyFzb35P4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pFyIkShUP070T1MCe1PZHDrW/Mw93dXatTsiD8H58Vo=;
        b=LLlIVkke0sbK/dsvoDh4Z0jKSq8NLgt9Pv0yOhlW8ew8ZNKKDZZHyQdswPS2T/g4dS
         PWH7zfU/2l+5B9u4qBhvAQoKpeG3IVuIYsgVwLcPW8rrTnAgEXJa2gCLCMGq3a6OZuyK
         1P1LPyw2xr6GB3DyLQOug2W4EW6IBi9q/pINEWADZz1Ome/scgNpdqdpUgIbeIeyztC+
         bU+86J68EimK+jA9S/gaLFyVMkixggqxiTLLFWVEnXH3Nk484gS/ruDdZnsdpSy22Ij3
         cOHlmIlfc8HAWHiDWMifwqpKqVrr31u51qyF9GrUHum9lPVY+dZJtOwUjbO4aLaMY+1+
         snhw==
X-Gm-Message-State: APjAAAUgFEYu59GtoOTxgrtpaOBtRnte6oa+3jPYmJsLJqDq2h2bNl7E
        jZFcXR4MByEtr1+t2oqiFaMjjA==
X-Google-Smtp-Source: APXvYqx3Q7vbfdx4DL4qphQSptphuCSVjI5Ms226wcgo4SYrpulmH7OUNwVi/mF3j1JenZroGCEqZg==
X-Received: by 2002:a2e:b010:: with SMTP id y16mr6295556ljk.147.1571403170007;
        Fri, 18 Oct 2019 05:52:50 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m17sm7454792lje.0.2019.10.18.05.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 05:52:49 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] serial: make SERIAL_QE depend on PPC32
Date:   Fri, 18 Oct 2019 14:52:32 +0200
Message-Id: <20191018125234.21825-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Currently SERIAL_QE depends on QUICC_ENGINE, which in turn depends on
PPC32, so this doesn't add any extra dependency. However, the QUICC
Engine IP block also exists on some arm boards, so this serves as
preparation for removing the PPC32 dependency from QUICC_ENGINE and
build the QE support in drivers/soc/fsl/qe, while preventing
allmodconfig/randconfig failures due to SERIAL_QE not being supported
yet.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 67a9eb3f94ce..78246f535809 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1056,6 +1056,7 @@ config SERIAL_LANTIQ
 config SERIAL_QE
 	tristate "Freescale QUICC Engine serial port support"
 	depends on QUICC_ENGINE
+	depends on PPC32
 	select SERIAL_CORE
 	select FW_LOADER
 	help
-- 
2.20.1

