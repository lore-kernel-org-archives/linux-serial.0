Return-Path: <SRS0=xUyI=72=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FDFC433E0
	for <linux-serial@archiver.kernel.org>; Sat, 13 Jun 2020 13:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 001572074D
	for <linux-serial@archiver.kernel.org>; Sat, 13 Jun 2020 13:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fudan.edu.cn header.i=@fudan.edu.cn header.b="nLWTGCHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgFMNAB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 13 Jun 2020 09:00:01 -0400
Received: from mail.fudan.edu.cn ([202.120.224.10]:56252 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbgFMNAB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 13 Jun 2020 09:00:01 -0400
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Jun 2020 08:59:59 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=Suh4kyMQAm/69hp5zrf+9wckzOzZ4rI36X3FQdKEKTs=; b=n
        LWTGCHbGq7cZpM0l2kHBIOH05bflddUP8iMNn4pb4pnhOXY0HWqOCyLXkeogXpOr
        Hei4W7osRHqWCcW15Fyeden50q14qy5Ohmo8qE4Gft20750RkB8XYZGHe0IiPgOZ
        E8kQAGvybdZAJfNapb7fY1UhgaYjCYOOMMtvm9h8Wc=
Received: from localhost.localdomain (unknown [120.229.255.202])
        by app1 (Coremail) with SMTP id XAUFCgC3GBLPy+ReV9cYAA--.20581S3;
        Sat, 13 Jun 2020 20:51:29 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] tty: serial_core: Fix uart_state leak when port shutdown
Date:   Sat, 13 Jun 2020 20:51:04 +0800
Message-Id: <1592052665-95042-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XAUFCgC3GBLPy+ReV9cYAA--.20581S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW3XF47XrWxurWxJw13Jwb_yoW8Gw4kpF
        sxKr9IyF95Wa1xXa1DCw1kAFWY9a4qqFya9ry0gwn8XrWYqrySkr1YyrWqvF4UG3srAryr
        AF1vyws0yF1DAFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE14v_Xr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfUOo7KUUUUU
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

uart_shutdown() invokes uart_port_lock(), which returns a reference of
the uart_port object if increases the refcount of the uart_state object
successfully or returns NULL if fails.

However, uart_shutdown() don't take the return value of uart_port_lock()
as the new uart_port object to "uport" and use the old "uport" instead
to balance refcount in uart_port_unlock(), which may cause a redundant
decrement of refcount occurred when the new "uport" equals to NULL and
then cause a potential memory leak.

Fix this issue by update the "uport" object to the return value of
uart_port_lock() when invoking uart_port_lock().

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 57840cf90388..ab8756ef2b60 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -313,7 +313,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	 * console driver may need to allocate/free a debug object, which
 	 * can endup in printk() recursion.
 	 */
-	uart_port_lock(state, flags);
+	uport = uart_port_lock(state, flags);
 	xmit_buf = state->xmit.buf;
 	state->xmit.buf = NULL;
 	uart_port_unlock(uport, flags);
-- 
2.7.4

