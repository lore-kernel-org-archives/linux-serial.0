Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71B8C433EF
	for <linux-serial@archiver.kernel.org>; Tue,  8 Mar 2022 08:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242517AbiCHIKb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Mar 2022 03:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344792AbiCHIK0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Mar 2022 03:10:26 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26C03EAA8
        for <linux-serial@vger.kernel.org>; Tue,  8 Mar 2022 00:09:30 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 666273F7E1
        for <linux-serial@vger.kernel.org>; Tue,  8 Mar 2022 08:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646726969;
        bh=29Pf3ZsU5JJVOHBIO1WRfRouMVWJymQOmYuJyfmZYy4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=LkfbNmA9Vjt18uCAYkD/pVLrecoVDZlQhW5ah475s/GQnogj6tnEjYQ6nHpDib1X3
         R3473N8FT7FF25HiCF7EMiaMW6GYb2rCOMD99DeNX7sxtMEEGck8lzy7sT5Q3vpxBI
         XpwVT0ILex4z0miDeiAXMaognDhTvvCh6Za3ur3q8nAHkbimbx6oDPLOrHBm/uPr/A
         FAlsUBQA2n30Pq5et4NQzOgBQh3/2PWjbNK7MkxTLiLz3HpdqfNd4kkvD7NbRB7dl9
         IbuMAczN6X4DYZi8g9FL42hBwyVVENMDDSSZby3uCMcI2qOufJ7M7nnCTPFuV9pVTh
         irARfJ5mM/3+Q==
Received: by mail-ej1-f72.google.com with SMTP id ey18-20020a1709070b9200b006da9614af58so6220039ejc.10
        for <linux-serial@vger.kernel.org>; Tue, 08 Mar 2022 00:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=29Pf3ZsU5JJVOHBIO1WRfRouMVWJymQOmYuJyfmZYy4=;
        b=7zGdWkGFXJMyVDJwljl/K1ziz3GK76MC9DoQLrkn9sh89eyZEVqOgKCdaAmOB7SHWg
         yqwQuYcTgkBBZ80szT0pEPv0hRCc5Dr9BAzMYUchf1Wl8J9NbjmjUgP4MnVXr8ger34o
         imrecBvq/Olc9do+YQsV5ZoYmcZQJzO39InKZCN2k+LyEtSExgplCT/cdr6mBBhg2fak
         1jUj6eo3GTaPkdD3hLlC9eaDHYEWRN7HXj6RxJ+e00yIe1CIzJ+AJlxzIvQgsnYJe98+
         JhpaC4P1bwPKErykl5AqPBLrLji84BqscbODe7kmdxQ9cyUKj1cU6CEiLhJUNzcYoUD2
         dKhQ==
X-Gm-Message-State: AOAM533VhxqO6bzRuPh0APMjylT6meu0TVkE54NkF8cmx2uQWxlYNq5k
        H0TQKkRHVpTkzaFEYcSkYUpT070n3ks98h/IU5Sar6o/Zw3tEydJQM9u1ypG1+RRLKWopEjxz4P
        77Bkzl3X2jmlKGLWjLu+1cMF355EYgxy3Psd46ImQNg==
X-Received: by 2002:a17:906:9bd7:b0:6d6:e920:8d04 with SMTP id de23-20020a1709069bd700b006d6e9208d04mr12389911ejc.547.1646726969063;
        Tue, 08 Mar 2022 00:09:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCDpyzVeafJO+tBKmLNUmXCUwu/pvO8ES0IOzwYdYS55Y3KidkwCIqb81SC/LBMvb5FhouCg==
X-Received: by 2002:a17:906:9bd7:b0:6d6:e920:8d04 with SMTP id de23-20020a1709069bd700b006d6e9208d04mr12389895ejc.547.1646726968858;
        Tue, 08 Mar 2022 00:09:28 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id t4-20020a056402524400b00415b90801edsm7385697edd.57.2022.03.08.00.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 00:09:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 5/8] tty: serial: samsung: constify UART name
Date:   Tue,  8 Mar 2022 09:09:16 +0100
Message-Id: <20220308080919.152715-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220308080919.152715-1-krzysztof.kozlowski@canonical.com>
References: <20220308080919.152715-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The UART name from driver data holds only string literals.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index c4b13f2d6e26..7025306f76b7 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -63,7 +63,7 @@ enum s3c24xx_port_type {
 };
 
 struct s3c24xx_uart_info {
-	char			*name;
+	const char		*name;
 	enum s3c24xx_port_type	type;
 	unsigned int		port_type;
 	unsigned int		fifosize;
-- 
2.32.0

