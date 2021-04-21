Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569FDC43461
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20EA66008E
	for <linux-serial@archiver.kernel.org>; Wed, 21 Apr 2021 09:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbhDUJ4X (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:56:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238677AbhDUJ4K (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 21 Apr 2021 05:56:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A921061450;
        Wed, 21 Apr 2021 09:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618998937;
        bh=8rsXg0JIL9WIWG+sWtMdopUQAIhyepLhKLIESm5IaBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dVPBGZ7YsqqEZZI3xvTkFdi+qvoVlDEv47x01iGH+yeApKs/mdCRT4QwWUmIu+AFD
         57Uda2l7vGOKb3alsqwY9/GSvIOwo1eJQxk6km5XZ7n7FdpAWoGHuFkSn9NHNgenU/
         MVpQZN/jr4M02n0Vp0zfc1IGIzGSf6QNvihHYwsW3s7+3/vqukT2rb+rZ/MupOO8sK
         auIo/KFqLZVUX+bOAkS6kwTX1DmoEt6kvyzNQWt9lRcTLvBIL0S4V16T1GQRwIul7l
         K1cIkXIdicK6BFeRNbwJS1P/zhWlAWsoVq9G+VDuhwbNz+PEBeKXwSKycNMHfZjB0d
         S0qxmWIwTTLwg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZ9a8-0000pk-Sa; Wed, 21 Apr 2021 11:55:40 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 26/26] serial: xilinx_uartps: drop low-latency workaround
Date:   Wed, 21 Apr 2021 11:55:09 +0200
Message-Id: <20210421095509.3024-27-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210421095509.3024-1-johan@kernel.org>
References: <20210421095509.3024-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit c8dbdc842d30 ("serial: xuartps: Rewrite the interrupt handling
logic") reworked the driver interrupt processing but also, without
comment, added an unnecessary workaround for the infamous low_latency
behaviour of tty_flip_buffer_push() which had been removed years
before.

Specifically, since commit a9c3f68f3cd8 ("tty: Fix low_latency BUG"),
tty_flip_buffer_push() always schedules a work item to push data to the
line discipline and there's no need to keep any low_latency hacks around.

Cc: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/xilinx_uartps.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index a14c5d996473..67a2db621e2b 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -301,9 +301,8 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 		tty_insert_flip_char(&port->state->port, data, status);
 		isrstatus = 0;
 	}
-	spin_unlock(&port->lock);
+
 	tty_flip_buffer_push(&port->state->port);
-	spin_lock(&port->lock);
 }
 
 /**
-- 
2.26.3

