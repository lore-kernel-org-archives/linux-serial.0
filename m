Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480B8C43600
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD3061446
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbhDUJ4R (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238613AbhDUJ4J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97A7961474;
        Wed, 21 Apr 2021 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998936;
        bh=GXf9JQz9uOBMOtADoys8RVhTcC0zBy8R1BiZtPKj/QE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eb8U4/U+lXEfqJlwcjFlu4nRlW5tFdfcJvzR+BR0yl+TA3j2MbzfDromZLLje9MAg
         /OBZ+CJSBjz3SBtsns3CdprESQ8qFHPBXHfZ5/wyOk/OqtiaUvRDbYvkbhSWDWsScG
         +3Xt2tW156AAq+b253Cu+pp08TvCq2+K0LPaCAhAkB7wJof9xIG7KYnIpnxaA6BlVp
         dEDnV3DoIemIJ1ZJCjJBMjN6yOvmW1HLYasnaes0BnQ7k43+C+9sUJIvD+xMNrQCgz
         fv3h9MEj3KNDx3swaTJADMicvq+hZmVEMfP3S4C69wXlXnf8LmiM/JMfVhn4JqlmN5
         uLw1qftp+/wWA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a7-0000p1-TY; Wed, 21 Apr 2021 11:55:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 14/26] serial: meson: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:54:57 +0200
Message-Id: <20210421095509.3024-15-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The meson driver has always carried an unnecessary workaround for the
infamous low_latency behaviour of tty_flip_buffer_push(), which had
already been removed by the time the driver was added by commit
ff7693d079e5 ("ARM: meson: serial: add MesonX SoC on-chip uart driver").

Specifically, since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
tty_flip_buffer_push() always schedules a work item to push data to the
line discipline and there's no need to keep any low_latency hacks around.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/meson_uart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 69eeef9edfa5..529cd0289056 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -226,9 +226,7 @@ static void meson_receive_chars(struct uart_port *port)
 
 	} while (!(readl(port->membase + AML_UART_STATUS) & AML_UART_RX_EMPTY));
 
-	spin_unlock(&port->lock);
 	tty_flip_buffer_push(tport);
-	spin_lock(&port->lock);
 }
 
 static irqreturn_t meson_uart_interrupt(int irq, void *dev_id)
-- 
2.26.3

