Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D13EC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 16 Sep 2021 17:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 746A860EFF
	for <linux-serial@archiver.kernel.org>; Thu, 16 Sep 2021 17:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbhIPRMn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Sep 2021 13:12:43 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59514
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345169AbhIPRK3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Sep 2021 13:10:29 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0301840261
        for <linux-serial@vger.kernel.org>; Thu, 16 Sep 2021 17:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631812148;
        bh=xPpOqBWr7It3vesqmSTKYQnMNxzHvZ+jahU7C4r+dU0=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Iooevi3UgMJ+mkq676NMoJgjiVvtG0YQy+kX8NGAWYvMHVHPpNelUZaK0d0XFUHAA
         P2ToA54XP3ak9kiytO6d9CELRmMyfoDH4bNlmMFctM5Ij/4/hRqBgxP2mL86+5mhKd
         brJ/Jtp6sY6JNaQCW8nZ3iOjaeyhsRhK2hYRLjgNPA01JosPHbirobHVJSkpfqAMRe
         ABNlNGRjAGse3og45yS34fhwA0A69GhC++yEbvBXeF6DH/8r6tXvFM3N2fJZ4tJ2E+
         oCczyH38JeQur4iEfekno82Q9DmzZsvepk4Nwf4tdibeou5EPsEHP46Tv0Xiq4lSoG
         7D7uDxyCIU4aA==
Received: by mail-wm1-f71.google.com with SMTP id c187-20020a1c35c4000000b00304b489f2d8so3399289wma.6
        for <linux-serial@vger.kernel.org>; Thu, 16 Sep 2021 10:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xPpOqBWr7It3vesqmSTKYQnMNxzHvZ+jahU7C4r+dU0=;
        b=SBJU8VINvpwt0igghkyBNfDRDTiDSruE2V+0r5PNFAxNLsnxtrZmNYk49dxhBSz5fw
         fu3NBLeY5vZcN4t0i/TxZjjtHX+k86IMurxi9q59XpKV99aMYzGZQ5L8/oNsiRBiqSW9
         ITPUpv+w/vDFY+M0k/wozm7AtXY8IicJrbg5oRfdjoe4iCCeA+b9KcQJOWC0XPN39hny
         MM53IshXDSI0nxKXmqWqx0fzloxGunkmBtqAJQTGSzDLcGdlqT9/Y6PiN1LrOkj2uAw5
         i4z4UgTIz5XZgADwjGq2BbQ3uB3IaauGQTV6L/E9JCB8bjDaQ2G5Y3hMdK24HrUwOpnj
         BjPQ==
X-Gm-Message-State: AOAM532ubENm9Lm3PCp8ZoLEmjASoQov8iIDTusw057IptjfCNr7YPKe
        yRvKThhuP3mB6twC88PeFsmtyOkIanENLryUY+HAQcpRbFacO71M++D3yD7e5KNO/rBakcVeIoF
        iTZz1Lh4FtKbAbBZe+jHP8dUE4VDdNBsZv4btBvc3aQ==
X-Received: by 2002:a1c:acc2:: with SMTP id v185mr6116422wme.71.1631812146008;
        Thu, 16 Sep 2021 10:09:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPp03RDoAih9s3NW/qGubj3h1EcnVLf9/Ph3lRs8Ac+5xs5w5VZJCzJ/TDFN0K5bf63k0ndA==
X-Received: by 2002:a1c:acc2:: with SMTP id v185mr6116411wme.71.1631812145892;
        Thu, 16 Sep 2021 10:09:05 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id f20sm7893839wmb.32.2021.09.16.10.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:09:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH] serial: 8250: remove duplicated BRI0A49 and BDP3336 entries
Date:   Thu, 16 Sep 2021 19:08:59 +0200
Message-Id: <20210916170859.138813-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

BRI0A49 and BDP3336 are already on the list.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/tty/serial/8250/8250_pnp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 98e5ee4d0d08..1974bbadc975 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -56,10 +56,6 @@ static const struct pnp_device_id pnp_dev_table[] = {
 	{	"BRI1400",		0	},
 	/* Boca 33.6 Kbps Internal FD34FSVD */
 	{	"BRI3400",		0	},
-	/* Boca 33.6 Kbps Internal FD34FSVD */
-	{	"BRI0A49",		0	},
-	/* Best Data Products Inc. Smart One 336F PnP Modem */
-	{	"BDP3336",		0	},
 	/* Computer Peripherals Inc */
 	/* EuroViVa CommCenter-33.6 SP PnP */
 	{	"CPI4050",		0	},
-- 
2.30.2

