Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33D5C433ED
	for <linux-serial@archiver.kernel.org>; Fri, 16 Apr 2021 14:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA4A6103D
	for <linux-serial@archiver.kernel.org>; Fri, 16 Apr 2021 14:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244330AbhDPOMA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Apr 2021 10:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243932AbhDPOLx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Apr 2021 10:11:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA2E2611AC;
        Fri, 16 Apr 2021 14:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618582288;
        bh=D27fejqWID7E6q4rHiW0aBefkPAsSCwMPL3Ng82yR88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MM+mif4vJn80/jf6UTcJSVdQ1QQPwyHU/cBGbrjVYEGHk1evDJTLKNbErzKNGSVW0
         NWKY0Z//SAPhjE8XyPYYp/tpJEuAo1qbv+qzF3WqC7YKVdAbt/LLhrMqVPS5f+AgbR
         R4dekVNLDeqrswqGP0uB5IQA1YOvBJTql55u78iLvK7kI/WogfymAvnD4zqw565MEG
         Ml0IPHLG19z/yXMMKGdQ7fAaV8cT5FTVVr4P+PS8NJIj1zL7bHyveXfKA5zEwu9tAG
         qNzcQFxKDbrMifkhX0bRGjhs8RlnqnAVWBQomDlbxp0NIKBadewcSd11LIkJhUz+i9
         huMfZbqjnCBqw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lXPBx-0006aE-JE; Fri, 16 Apr 2021 16:11:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dillon.minfei@gmail.com, Erwan Le Ray <erwan.leray@foss.st.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] serial: stm32: defer sysrq processing
Date:   Fri, 16 Apr 2021 16:05:57 +0200
Message-Id: <20210416140557.25177-4-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210416140557.25177-1-johan@kernel.org>
References: <20210416140557.25177-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use the uart_unlock_and_check_sysrq() helper to defer sysrq processing
until receive processing is done and the port lock has been released.

This allows cleaning up the console_write() implementation by not having
to work around the recursive sysrq case (by dropping locking completely)
and also makes the console code work with PREEMPT_RT by no longer
relying on local_irq_save().

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/stm32-usart.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 3524ed2c0c73..24a1dfe7058b 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -270,12 +270,12 @@ static void stm32_usart_receive_chars(struct uart_port *port, bool threaded)
 			}
 		}
 
-		if (uart_handle_sysrq_char(port, c))
+		if (uart_prepare_sysrq_char(port, c))
 			continue;
 		uart_insert_char(port, sr, USART_SR_ORE, c, flag);
 	}
 
-	spin_unlock(&port->lock);
+	uart_unlock_and_check_sysrq(port);
 
 	tty_flip_buffer_push(tport);
 }
@@ -1430,13 +1430,10 @@ static void stm32_usart_console_write(struct console *co, const char *s,
 	u32 old_cr1, new_cr1;
 	int locked = 1;
 
-	local_irq_save(flags);
-	if (port->sysrq)
-		locked = 0;
-	else if (oops_in_progress)
-		locked = spin_trylock(&port->lock);
+	if (oops_in_progress)
+		locked = spin_trylock_irqsave(&port->lock, flags);
 	else
-		spin_lock(&port->lock);
+		spin_lock_irqsave(&port->lock, flags);
 
 	/* Save and disable interrupts, enable the transmitter */
 	old_cr1 = readl_relaxed(port->membase + ofs->cr1);
@@ -1450,8 +1447,7 @@ static void stm32_usart_console_write(struct console *co, const char *s,
 	writel_relaxed(old_cr1, port->membase + ofs->cr1);
 
 	if (locked)
-		spin_unlock(&port->lock);
-	local_irq_restore(flags);
+		spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static int stm32_usart_console_setup(struct console *co, char *options)
-- 
2.26.3

