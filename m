Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06736C4332F
	for <linux-serial@archiver.kernel.org>; Tue, 15 Nov 2022 07:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiKOHRe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Nov 2022 02:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiKOHRd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Nov 2022 02:17:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671B01DF07;
        Mon, 14 Nov 2022 23:17:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AF5AB816E1;
        Tue, 15 Nov 2022 07:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A75C433B5;
        Tue, 15 Nov 2022 07:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668496649;
        bh=Sg6Xpqv3xz30myfUt2Jwhn6u7Q0v3+pg5wo8zEwC8aA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lA8lBgKinNH0e8VMXvQ+tE19umChfhaiW57zjRDPC/nO35XHwLq2JxGI+9zZxNPKR
         As/aV0ezJ30JyGaEARzMUn00ecxRyk3caEsdH3JSA5H0FdeLUnXeNhrZIIRpwzOuR0
         dXtZHrLYpzWM5KF9ZfRATY76yEfdvAYtKjhgcN4NyWNLUDQzgVhkLTcyADw91E6vM7
         u7IL5LTV/dHV6+JQF/ZJlJ6yUlIQUux1UbijgInVlrVnjKJ32E8dNMGSZfO71S44Cr
         Uy/lrD/QFHd4FZ3ziSy1+SyiEA47i9dEPcPXXaglsEKxGleO0NvNmssdhwHGGgk9QC
         xpBFSpo15IePQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 2/4] tty: serial: altera_jtaguart: remove unused altera_jtaguart::sigs
Date:   Tue, 15 Nov 2022 08:17:22 +0100
Message-Id: <20221115071724.5185-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115071724.5185-1-jirislaby@kernel.org>
References: <20221115071724.5185-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Nothing uses struct altera_jtaguart::sigs. Remove it.

Cc: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/altera_jtaguart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 8d1729711584..b83eade64b22 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -55,7 +55,6 @@
  */
 struct altera_jtaguart {
 	struct uart_port port;
-	unsigned int sigs;	/* Local copy of line sigs */
 	unsigned long imr;	/* Local IMR mirror */
 };
 
-- 
2.38.1

