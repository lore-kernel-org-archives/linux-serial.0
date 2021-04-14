Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9732C433B4
	for <linux-serial@archiver.kernel.org>; Wed, 14 Apr 2021 13:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F48611AD
	for <linux-serial@archiver.kernel.org>; Wed, 14 Apr 2021 13:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347993AbhDNNqd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Apr 2021 09:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347508AbhDNNqb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Apr 2021 09:46:31 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C55C06138D;
        Wed, 14 Apr 2021 06:46:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u14-20020a17090a1f0eb029014e38011b09so6038956pja.5;
        Wed, 14 Apr 2021 06:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IClDkxkOgk97PqHf7aJuGK/4ZYtS9MWZcXOFYoonY40=;
        b=bgVQ3X2y/AzGGCtLlINMT8L/dsQAZ2hIVLIVjBHiQZJTDXuW8AoSOotMOVkJEcAdQq
         ONbjnOgHyWuDESxHvgmXrVy5AvcflxyPz39QIGlfcam3pxvJ4yqesRTbT9R4oPBR/HEO
         l5yN7yHsVYrnKlo0XqZrFqGut1qLXqN2OwUMhaPXy6EVz9A03kVODXkzr+266kpGOmD7
         1ETaoOc4Rw8ZSVoxK/p771eTHclowzIC7rJTmZfWhV8dZIwq3mxwtR05v4Pxbs0PLH9+
         aUR1Kz/f2rxjpVaNLmVhhhj4YINPyfEf9aRadQNkvtiZdm2s9x8kK5YnOOHectj3aCJx
         P7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IClDkxkOgk97PqHf7aJuGK/4ZYtS9MWZcXOFYoonY40=;
        b=QDiwzyOaeXklErInTXPelxO6rdF7Wta/z7ylGmsXcnGmx5grDVUyd2OLA3/U6x/z1V
         0WNViSSReN4kVWBNA8TPh89W0h223b7EvR3nnezV5/ik1fv02kjeXt6iGLoEzN0h6bQN
         OLXbFR9hFynUwv1XXdcXxfJGbTbCgRG/LyYW4EIGHmqMeOgWkuwngOkvXmBL62Mmj+QI
         yqsRS5k3eiU8RugaHCqIW0RD4ERBVYGdC/IWefG5aPFkkINEv2xwFzgkh+kUZuYzEPrl
         SNTnvyh1NSriAfvgR/HmCgLS1imbzLWSTpqO8N7utX2IkjBR5/QL0eeaUmfz8mgaigBz
         zv2Q==
X-Gm-Message-State: AOAM531VcZqpgwJaHJUt+gi2VWhkPmiQxAym4++cXJiCo9ot/FsYPesj
        feTpnXR2/nstcCkdIJ5hU6zkMgE9Hb8=
X-Google-Smtp-Source: ABdhPJxDFyer9inN7N7LVCAEgIVcLMSkd7PrbgwMVPHkO5DLgwRuSEeHYH2EsQ/Wq6tRIcNR/qP4bg==
X-Received: by 2002:a17:902:aa87:b029:e9:8d9e:6808 with SMTP id d7-20020a170902aa87b02900e98d9e6808mr32899107plr.34.1618407968552;
        Wed, 14 Apr 2021 06:46:08 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p2sm16604698pgm.24.2021.04.14.06.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 06:46:08 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [-next] serial: 8250: Match legacy NS16550A UARTs
Date:   Wed, 14 Apr 2021 09:45:39 -0400
Message-Id: <20210414134539.42332-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

Older 32-bit only Broadcom STB chips used a NS16550A compatible UART,
the 8250_bcm7271.c driver can drive those UARTs just fine provided that
we let it match the appropriate compatible string.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 725a450058f8..023a2de8b2d6 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -204,6 +204,13 @@ static const u32 brcmstb_rate_table_7278[] = {
 	MHZ(48),
 };
 
+static const u32 brcmstb_rate_table_16550a[] = {
+	MHZ(81),
+	0,
+	0,
+	0,
+};
+
 struct brcmuart_priv {
 	int		line;
 	struct clk	*baud_mux_clk;
@@ -865,6 +872,10 @@ static const struct of_device_id brcmuart_dt_ids[] = {
 		.compatible = "brcm,bcm7271-uart",
 		.data = brcmstb_rate_table,
 	},
+	{
+		.compatible = "ns16550a",
+		.data = brcmstb_rate_table_16550a,
+	},
 	{},
 };
 
-- 
2.17.1

