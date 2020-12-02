Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B502BC64E8A
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 06:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C2322202
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 06:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgLBGKR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Dec 2020 01:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgLBGKR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Dec 2020 01:10:17 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFDAC0613CF;
        Tue,  1 Dec 2020 22:09:37 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id f1so71896plt.12;
        Tue, 01 Dec 2020 22:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfMlRUVz5l7XVnc/HFInF5rSPBCWYyUgC3VCNT+TRWQ=;
        b=TnsVZidest2ByMV+481VeSUNqpBgI1OL+PQhmx5TgiogzwSPYZVepCSjC2ngqlf/7O
         hZsNyBPtSJmroRfSPgNjJ0PRip6SsydYB6J/hU9bPT7SkeDxbLICz57lItMAAPXQ6y4u
         DKUYDpySRXQcUZv8x8YK4Zq4llEIcgqBdaOR/MrFtiRQFXLw9wujLYV8NShwUacIy8Hi
         JGZaw4BcjZk6TX6G2NcBUELOM/T6weCLLUvyfFrbDnJ4mX/s2/wXDFXWYVUIolmUEOco
         K9W14pOAUNOjeqkw8k47iR11F3WvSn0royFUX2VncGE/gyrBrzH7duq824Eb/VwNb1ve
         oV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfMlRUVz5l7XVnc/HFInF5rSPBCWYyUgC3VCNT+TRWQ=;
        b=F++q4ONptXDSlulq2TpvujuXBB7miJ12IPcvEkrpp3UKYXvky6avA7T2krbrmVm+A6
         Z2fJjuo3EawyDSpSyDcz0saErwrpVbZCU71XlredU57OVBYGBqAYIfAaZ+uWDtDS9gnV
         J7ztBZN4/x+n7Zi6N4YSwT6qN07hphI770l7euNwPHGVR0IywEhUaEXFjbnZRW+JcAqG
         4DaCgsnKvlHxF4oJ1JOe3P2a5ZZSILE6w3Q0auiI24TGbE2DiB+JfAp8y8D7ij0djBLm
         uNs2zjmwx4tpRsMGpFb+Cc/3m1uhy4gj0Xn1UVPs2hdScgVHIyLSqxt7OtsE1CFleefl
         RNTw==
X-Gm-Message-State: AOAM531flLXousOrOcM9tRWs49sXUE7H3bsNJzMQh8+PT+UeA52wk5AM
        Q1YXDzp2Szbowul/Xc3tISOrmk9YD/lnkgfb
X-Google-Smtp-Source: ABdhPJwMichy4GhT9OEjokknnoS7y6ksIMyspxwtwcpwQ7zwHPFe+rlQywsyLsPfJUBtzCHh3D6l4w==
X-Received: by 2002:a17:902:ee83:b029:da:3483:3957 with SMTP id a3-20020a170902ee83b02900da34833957mr1358300pld.38.1606889376898;
        Tue, 01 Dec 2020 22:09:36 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e004:f0c9:61ce:d6fb:ee0e:745f])
        by smtp.gmail.com with ESMTPSA id o14sm777130pgh.1.2020.12.01.22.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 22:09:36 -0800 (PST)
From:   Clement Smith <rclemsmith@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Smith <rclemsmith@gmail.com>
Subject: [PATCH] tty : serial: jsm: Fixed file by adding spacing
Date:   Wed,  2 Dec 2020 11:39:16 +0530
Message-Id: <20201202060916.34130-1-rclemsmith@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixed a coding style issue

Signed-off-by: Clement Smith <rclemsmith@gmail.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 689774c073ca..512b77195e9f 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -607,7 +607,7 @@ void jsm_input(struct jsm_channel *ch)
 				 * Give the Linux ld the flags in the
 				 * format it likes.
 				 */
-				if (*(ch->ch_equeue +tail +i) & UART_LSR_BI)
+				if (*(ch->ch_equeue + tail + i) & UART_LSR_BI)
 					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i),  TTY_BREAK);
 				else if (*(ch->ch_equeue +tail +i) & UART_LSR_PE)
 					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_PARITY);
-- 
2.27.0

