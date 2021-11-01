Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43FCC433EF
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 15:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82B2661053
	for <linux-serial@archiver.kernel.org>; Mon,  1 Nov 2021 15:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhKAPvH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 Nov 2021 11:51:07 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:43964 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231362AbhKAPvG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 Nov 2021 11:51:06 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 5CCD04403CA;
        Mon,  1 Nov 2021 17:48:24 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1635781704;
        bh=tSMjvFvBgqvo/xkcE6IAYCelGDli8f59sU0FoHnDnww=;
        h=From:To:Cc:Subject:Date:From;
        b=mLUJNdc/vGDOwrMGEo8GLzO7vzVzfhww/L2hTLfIHT+8qOuQ3VTjGo0ItbgzAKnvo
         X82wgTb0zR/DcGnkG7rAF7I7cyxm03IrtYEbxYKr10G0EGJDXCAahMMssMaNhlDxGc
         CYYk5niYw+2gI/ELudfjV7xyy0lZ9TK0zOc4fEfS2iSsmKY1BpLsT4RgdYroUgnikI
         VcfpkpjjNiiebDn4NOZfNs0raPKr/sQTVbvL4g3mYZ13m1n6Ax6CQU+cBSzzYxx4q5
         GhT4BmTzjqb04yES6seYcwy9gsr0XKbrmfHkY2njbRI7epU3nTpNpKZLBpwK3P2Ysw
         olKjBVf1Qv/rw==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>
Subject: [RFC PATCH] tty: flush buffer on signal interrupted tty close
Date:   Mon,  1 Nov 2021 17:48:08 +0200
Message-Id: <319321886d97c456203d5c6a576a5480d07c3478.1635781688.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When a signal interrupts tty_wait_until_sent() on a UART device, there
might be data left on the xmit buffer that the UART will never transmit.
This causes set_termios() to wait forever in tty_wait_until_sent().

The hang reproduces easily on my system that is equipped with DesignWare
8250. Run

  while true; do echo -ne 0123456789abcdef01 > /dev/ttyS1; done

Hit Ctrl-C to interrupt the loop. When data is left in the struct
uart_state xmit buffer, the following command hangs:

  stty -F /dev/ttyS1 raw -echo

Call tty_driver_flush_buffer() on signal interrupted wait, to discard
data from the xmit buffer.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/tty/tty_ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 507a25d692bb..0bf6fad7ecb3 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -203,6 +203,8 @@ void tty_wait_until_sent(struct tty_struct *tty, long timeout)
 
 	timeout = wait_event_interruptible_timeout(tty->write_wait,
 			!tty_chars_in_buffer(tty), timeout);
+	if (timeout == -ERESTARTSYS && tty->closing)
+		tty_driver_flush_buffer(tty);
 	if (timeout <= 0)
 		return;
 
-- 
2.33.0

