Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3583C43470
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 874DE61451
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbhDUJ4K (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:56:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238564AbhDUJ4J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 100E46144E;
        Wed, 21 Apr 2021 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998936;
        bh=nhn87CK4iJ6zTd1Da+AXyC2e1yQ842t5WMdzZhpMx58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nXC1quQIu4wfT/xbPUu7Ld+vnlbrcxuc+y/c9XSH5P9ItoR0uWWuc1PBiRNVYb3ms
         8QAmnr2JEhr6X4Stt7kRiJksavMY+foLiVwe95NtIPuvmQBydI2iNkHPbIE8q79/i7
         uc+GqjTZKc5jM6Q5gil3xO0qd26pcUDieoRgISN0tZuo+PvnKlrzU8mmpbro75ccZe
         QnTGmBttchBoQMIBxSHK/R9mwLmv/m7gXTdOH7NpYAX7R0M0ckFlfeUFyQkKZ4fR88
         dN9OAzBCLVaPPEXXxhBCQHcr8w4CZBZofuSjzieKyx1FluhPKitoFESmCd+DIlo1KP
         /jL2/75gDF3dQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a7-0000oV-1V; Wed, 21 Apr 2021 11:55:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 04/26] serial: amba-pl010: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:54:47 +0200
Message-Id: <20210421095509.3024-5-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit 2389b272168c ("[ARM] 4417/1: Serial: Fix AMBA drivers locking")
worked around the infamous low_latency behaviour of
tty_flip_buffer_push() by simply dropping and reacquiring the port lock
in the interrupt handler.

Since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
tty_flip_buffer_push() always schedules a work item to push data to the
line discipline and there's no need to keep any low_latency hacks around.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/amba-pl010.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 3f96edfe569c..e744b953ca34 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -159,9 +159,7 @@ static void pl010_rx_chars(struct uart_amba_port *uap)
 	ignore_char:
 		status = readb(uap->port.membase + UART01x_FR);
 	}
-	spin_unlock(&uap->port.lock);
 	tty_flip_buffer_push(&uap->port.state->port);
-	spin_lock(&uap->port.lock);
 }
 
 static void pl010_tx_chars(struct uart_amba_port *uap)
-- 
2.26.3

