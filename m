Return-Path: <SRS0=lI39=CK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFD1C433E2
	for <linux-serial@archiver.kernel.org>; Tue,  1 Sep 2020 15:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CED5221548
	for <linux-serial@archiver.kernel.org>; Tue,  1 Sep 2020 15:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974277;
	bh=hRHvPfyODUedIyJaZ2MhAzqCT6E0WyLbz0tk8Et2M10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dkxjHP7oZVcGiN9w1pY0JnfUi2ifumgOaGxIWuEPpse/u2ySmGbGU/oWAhqu6nWzg
	 cLt/hbXaumbk6k7Z9gR/f2bj8/enZwjWJpiTuVzUgpncMLJgAs5Wr+Ept80F5MeJAN
	 6Kn2UJVIPi7qQqOssPOBIoCGOjy89rjNfILvi/Zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbgIAPbQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:31:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730681AbgIAPbO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Sep 2020 11:31:14 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8E20207D3;
        Tue,  1 Sep 2020 15:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974273;
        bh=hRHvPfyODUedIyJaZ2MhAzqCT6E0WyLbz0tk8Et2M10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FgtprEiaMA12V+a4eyAMQvqBuq0zq5O53C9sAgIyGMapnQCQgnol0g7xMHGMnvaY/
         HisXdopg/V+c4VPOzODcDXCuOYVh1XgZbJXFyUpA8xnOFKD68ZN4Z+4pyWDrzmiESN
         qZG//G04yUF3xG9pRIjGO0wUSjRW/psTPS5kioy8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Lukas Wunner <lukas@wunner.de>, linux-serial@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] serial: core: Simplify with dev_err_probe()
Date:   Tue,  1 Sep 2020 17:31:00 +0200
Message-Id: <20200901153100.18827-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901153100.18827-1-krzk@kernel.org>
References: <20200901153100.18827-1-krzk@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/tty/serial/serial_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f797c971cd82..2c52e0457faf 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3264,9 +3264,7 @@ int uart_get_rs485_mode(struct uart_port *port)
 	if (IS_ERR(port->rs485_term_gpio)) {
 		ret = PTR_ERR(port->rs485_term_gpio);
 		port->rs485_term_gpio = NULL;
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Cannot get rs485-term-gpios\n");
-		return ret;
+		return dev_err_probe(dev, ret, "Cannot get rs485-term-gpios\n");
 	}
 
 	return 0;
-- 
2.17.1

