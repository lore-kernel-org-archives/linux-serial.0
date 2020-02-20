Return-Path: <SRS0=HSIU=4I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12B6C11D07
	for <linux-serial@archiver.kernel.org>; Thu, 20 Feb 2020 10:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEC720801
	for <linux-serial@archiver.kernel.org>; Thu, 20 Feb 2020 10:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582194402;
	bh=daVsCmO1v3JL3U9U9GNYclPkuq++4cP0R8XAHe7Vg8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rpykAPDLH1FfOL29hznPb3myw9NZf9nvG9cKDBxBhwWJ3e5jIDmZafte8oknMTl3C
	 UBBZX7Mi2F5s0ViwLD/u81uIyJVpRvHeKrpx7ncmrROUtlyflocVOPCeGMmMJBpKR+
	 a03WyoaHoxkkV6+GKsnSxrVAWgxx7Na5K6JUHoZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgBTK0j (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:26:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgBTK0j (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Feb 2020 05:26:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B996324656;
        Thu, 20 Feb 2020 10:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582194397;
        bh=daVsCmO1v3JL3U9U9GNYclPkuq++4cP0R8XAHe7Vg8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2145Zze13qEK073wjwE5VbuPHwN52BSdqZifhIV/6Sm4hpwmnnUnIc+cWNOBNh6Y
         oHFa0p1m7guvVv5E9/HImZ+8k8/cS3nidAIHNGA0Uz16nS1PWMlrrNzUzWwifoV9Gw
         M6SUN6lyZfdFA/BUEUeZ3t9xiSnxwLlAiWJfXLs0=
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
Subject: [PATCH 2/2] tty: serial: samsung_tty: remove SERIAL_SAMSUNG_DEBUG
Date:   Thu, 20 Feb 2020 11:26:28 +0100
Message-Id: <20200220102628.3371996-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200220102628.3371996-1-gregkh@linuxfoundation.org>
References: <20200220102628.3371996-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since a05025d0ce72 ("tty: serial: samsung_tty: use standard debugging
macros") this configuration option is not used at all, so remove it from
the Kconfig file.

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
 drivers/tty/serial/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index a310bd22f1e2..fa4380b0b869 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -259,15 +259,6 @@ config SERIAL_SAMSUNG_UARTS
 	help
 	  Select the number of available UART ports for the Samsung S3C
 	  serial driver
-	
-config SERIAL_SAMSUNG_DEBUG
-	bool "Samsung SoC serial debug"
-	depends on SERIAL_SAMSUNG && DEBUG_LL
-	help
-	  Add support for debugging the serial driver. Since this is
-	  generally being used as a console, we use our own output
-	  routines that go via the low-level debug printascii()
-	  function.
 
 config SERIAL_SAMSUNG_CONSOLE
 	bool "Support for console on Samsung SoC serial port"
-- 
2.25.1

