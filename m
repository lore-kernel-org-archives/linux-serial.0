Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26436C04A94
	for <linux-serial@archiver.kernel.org>; Mon, 31 Jul 2023 08:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjGaIFm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 31 Jul 2023 04:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjGaIE2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 31 Jul 2023 04:04:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AE51716;
        Mon, 31 Jul 2023 01:03:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBC4860F7C;
        Mon, 31 Jul 2023 08:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174A0C433C7;
        Mon, 31 Jul 2023 08:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690790579;
        bh=K+H/hoatehbQhPWW2mUSJBRDUhbE9sguuS2KLp9LDIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uDrqDxWrJYHNWB0bT+ULXoW5jX5anh43k3Ky2ZjVFk8aL7n0JQTodkmshwOD33EX3
         1XvYrwsVcv6rbxAF8rXRlELFtptPGLzxZtI3WwLMPZ4WJqXdhEFn6r+0EPmYSLcEkB
         VpuWbddDgNdjodeainAp8fEDjRmMiZJpBpOnH0DYj1HukED29A+zm1Q30P5DOnz6f3
         kp9cz/vixcsJzAN5yRIHaJ5Jcr4Vac049lFnk+YeNUFax9Wds8I0gNeopvwq0Zup6/
         n+FkpwWDvnPhmm0sdOlYJNIKK0kgNcGEQPq5VyWVUS+v7p1Qrhbp0jwn0Zw+1gwBJc
         BjHqrS1+vl3EQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 06/10] serial: altera_jtaguart: switch status to u32
Date:   Mon, 31 Jul 2023 10:02:40 +0200
Message-ID: <20230731080244.2698-7-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731080244.2698-1-jirislaby@kernel.org>
References: <20230731080244.2698-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

'status' is assigned a result from readl(). There is no need for the
variable to be 'unsigned long'. readl() returns 32bit values.

Provided, this is a Nios II driver (32-bit), there is no change in
semantics. This only makes the type explicit.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/serial/altera_jtaguart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 6203ca1de769..5fab4c978891 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -110,7 +110,7 @@ static void altera_jtaguart_set_termios(struct uart_port *port,
 
 static void altera_jtaguart_rx_chars(struct uart_port *port)
 {
-	unsigned long status;
+	u32 status;
 	u8 ch;
 
 	while ((status = readl(port->membase + ALTERA_JTAGUART_DATA_REG)) &
-- 
2.41.0

