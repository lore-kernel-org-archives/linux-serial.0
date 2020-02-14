Return-Path: <SRS0=POds=4C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75D1C2BA83
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 16:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB5E20656
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 16:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581699253;
	bh=HceIHS8bxkvrOY7fzMyMpGes80SOfkL4QeY5pgm/e8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LeR5GYkX6RxZkb6SAxVJymje9S9JYCnflpZY20Zr4fa/emN8nQ7S4UhcYV47mFFSO
	 Kgd+slNCIg/IfpYerpEqoXQSTNRjijFyrvntfgMtK9N6352xBC9OsrFQnJ5cxV4w2X
	 blHXNAkdFG5SkT7609A4EPPzDT9RCI71xUuSqoCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404835AbgBNQSn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:18:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404830AbgBNQSm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 11:18:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02BD324708;
        Fri, 14 Feb 2020 16:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697121;
        bh=HceIHS8bxkvrOY7fzMyMpGes80SOfkL4QeY5pgm/e8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JpIb9o9z5NwMpenUZ0S/qEZ5gAg68Q1BrD9x9ZNlbJ9dbaW2Bv47vCClSDekT6wgk
         mSdOoHng0z9JHGXoAlIgJd7b1/MorvUGn6oXuAtT2rmbA+sF0oraqY51iMTzk7t94S
         rVvsnxmPCp95tAPeFNu1Y29zMvpEAkilPtbkiUUY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 067/186] tty: omap-serial: remove set but unused variable
Date:   Fri, 14 Feb 2020 11:15:16 -0500
Message-Id: <20200214161715.18113-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Xiongfeng Wang <wangxiongfeng2@huawei.com>

[ Upstream commit e83c6587c47caa2278aa3bd603b5a85eddc4cec9 ]

Fix the following warning:
drivers/tty/serial/omap-serial.c: In function serial_omap_rlsi:
drivers/tty/serial/omap-serial.c:496:16: warning: variable ch set but not used [-Wunused-but-set-variable]

The character read is useless according to the table 23-246 of the omap4
TRM. So we can drop it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Link: https://lore.kernel.org/r/1575617863-32484-1-git-send-email-wangxiongfeng2@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/omap-serial.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 26a22b100df10..517f984c89128 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -497,10 +497,13 @@ static unsigned int check_modem_status(struct uart_omap_port *up)
 static void serial_omap_rlsi(struct uart_omap_port *up, unsigned int lsr)
 {
 	unsigned int flag;
-	unsigned char ch = 0;
 
+	/*
+	 * Read one data character out to avoid stalling the receiver according
+	 * to the table 23-246 of the omap4 TRM.
+	 */
 	if (likely(lsr & UART_LSR_DR))
-		ch = serial_in(up, UART_RX);
+		serial_in(up, UART_RX);
 
 	up->port.icount.rx++;
 	flag = TTY_NORMAL;
-- 
2.20.1

