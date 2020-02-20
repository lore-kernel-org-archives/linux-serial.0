Return-Path: <SRS0=HSIU=4I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1212CC11D04
	for <linux-serial@archiver.kernel.org>; Thu, 20 Feb 2020 10:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB05424672
	for <linux-serial@archiver.kernel.org>; Thu, 20 Feb 2020 10:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582194395;
	bh=knx4Hgx/CQsPzc3qhbTlsEci9Vu+cNKPN13+ZBa+OjQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=PgXMuQSMh02K2xSw6QZ0J5DlRp+x9HhkuCYJ5wGxfDj5xa4xICyC5qy88/Ff5PbPZ
	 mQv9eMdkVbZe4t5u3JA4HUzmJnQBVQn5X5/fyFeX8uC+XJkYaCjPaMiKdD23UosTmQ
	 TsGCGXeSOHluX8OP0Pde9fV0qc4aD1FcceM/hJSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgBTK0f (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:26:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgBTK0f (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Feb 2020 05:26:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 697D520801;
        Thu, 20 Feb 2020 10:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582194394;
        bh=knx4Hgx/CQsPzc3qhbTlsEci9Vu+cNKPN13+ZBa+OjQ=;
        h=From:To:Cc:Subject:Date:From;
        b=UOkzX+M1c99UqqKhr4svRsN2562BewZJrAgnDGHKFxyYpMgahf65G5FLB+rRp5Srm
         gu4l6KVq2RwkcZUHoZ6vad/HAQDJgsExrDkfKkK/PVTnVblWvV1eJNaoXffS7ux3Ip
         BWoNhfyknyu8zo/cAQdaAXpC9SEEOE8Y2RjIPcBc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kukjin Kim <kgene@kernel.org>,
        Donghoon Yu <hoony.yu@samsung.com>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tty: serial: samsung_tty: build it for any platform
Date:   Thu, 20 Feb 2020 11:26:27 +0100
Message-Id: <20200220102628.3371996-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is no need to tie this driver to only a specific SoC, or compile
test, so remove that dependancy from the Kconfig rules.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Donghoon Yu <hoony.yu@samsung.com>
Cc: Hyunki Koo <kkoos00@naver.com>
Cc: HYUN-KI KOO <hyunki00.koo@samsung.com>
Cc: Shinbeom Choi <sbeom.choi@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 52eaac21ff9f..a310bd22f1e2 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -237,7 +237,6 @@ config SERIAL_CLPS711X_CONSOLE
 
 config SERIAL_SAMSUNG
 	tristate "Samsung SoC serial support"
-	depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,

base-commit: 11a48a5a18c63fd7621bb050228cebf13566e4d8
-- 
2.25.1

