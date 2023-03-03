Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395FFC61DA4
	for <linux-serial@archiver.kernel.org>; Fri,  3 Mar 2023 22:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjCCWDc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Mar 2023 17:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjCCWDN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Mar 2023 17:03:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EE84B813;
        Fri,  3 Mar 2023 13:53:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A26261929;
        Fri,  3 Mar 2023 21:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A566C433A1;
        Fri,  3 Mar 2023 21:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677879895;
        bh=DHr65bTl5V4jvmojYqvPfDkjqi8K3e/bRx2v6zMwmvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LoHp6C+RS9QkyTasZiwukBaxXmICU9Xw+RFfwDosQlzZrIWD8zSdWJAp989z4D7jx
         Figq7CNvyhulqc+9zWax1wKLcWyv4dCIzPcR3ZUtwiXP6pJ6sb1hgG4XqApzNBFkLf
         phS3mq5vb68JrPh0JGNExZMKeE62akECExJcVjl169Ch1VDjzf+FVuIZirVvCGRwT1
         7ITomBReTUCLLeAjPCnuriMiukeur1Hl+lV4HwrzDe6G7iYBpvLL4cVlqGz8lNx23d
         moAc725iWK+hgfaoIEO/IoonVcU5Zmx6ZX6I1b+bNb8xnGi8CxDiMfAarlfR/11xVV
         1LBUIWCWO2K3g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 46/60] tty: pcn_uart: fix memory leak with using debugfs_lookup()
Date:   Fri,  3 Mar 2023 16:43:00 -0500
Message-Id: <20230303214315.1447666-46-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303214315.1447666-1-sashal@kernel.org>
References: <20230303214315.1447666-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 04a189c720aa2b6091442113ce9b9bc93552dff8 ]

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  To make things simpler, just
call debugfs_lookup_and_remove() instead which handles all of the logic
at once.

Cc: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20230202141221.2293012-1-gregkh@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/pch_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 83f35b7b0897c..abff1c6470f6a 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1779,7 +1779,7 @@ static void pch_uart_exit_port(struct eg20t_port *priv)
 	char name[32];
 
 	snprintf(name, sizeof(name), "uart%d_regs", priv->port.line);
-	debugfs_remove(debugfs_lookup(name, NULL));
+	debugfs_lookup_and_remove(name, NULL);
 	uart_remove_one_port(&pch_uart_driver, &priv->port);
 	free_page((unsigned long)priv->rxbuf.buf);
 }
-- 
2.39.2

