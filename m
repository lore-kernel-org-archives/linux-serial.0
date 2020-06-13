Return-Path: <SRS0=xUyI=72=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC50CC433E1
	for <linux-serial@archiver.kernel.org>; Sat, 13 Jun 2020 13:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7CC2074D
	for <linux-serial@archiver.kernel.org>; Sat, 13 Jun 2020 13:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fudan.edu.cn header.i=@fudan.edu.cn header.b="lI3M49gF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgFMNAB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 13 Jun 2020 09:00:01 -0400
Received: from mail.fudan.edu.cn ([202.120.224.10]:56254 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbgFMNAB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 13 Jun 2020 09:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=oeRbaKJ4ubcIH3C117R3MYxefSczLaaLiNN/4rd1qYA=; b=l
        I3M49gF3ncvo/aA/VvJumF544eEhuxNDF3xeSJ0B8k5IxFZzuN4w1QtdtI0TCWaX
        dVEs/tPNaaloVIYqRZRdwQcy9qdWZIqp8MSj8bV+uNbpHfzgK/VELvGTulFnxsE+
        2vjM7cvTW6MQRHUHm8R55uQ9FwpSDWTtVrmQ93LZoU=
Received: from localhost.localdomain (unknown [120.229.255.202])
        by app1 (Coremail) with SMTP id XAUFCgCHjTEYzORemtkYAA--.21047S3;
        Sat, 13 Jun 2020 20:52:40 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] tty: serial_core: Fix uart_state refcnt leak when the port startup
Date:   Sat, 13 Jun 2020 20:52:18 +0800
Message-Id: <1592052738-95202-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XAUFCgCHjTEYzORemtkYAA--.21047S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1kAryUXrWkKFW5GFWfKrg_yoW8GF4kpF
        43Kr9IyrWqgay8X3WDCw4vyrWY9a4qqFy2gry0kwn8trZ0qrySkr1YyrWq9F1UJry7Aryr
        AF4vyrs8Aa1UJF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE14v_Xr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUbeOJUUUUUU==
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

uart_port_startup() invokes uart_port_lock(), which returns a reference
of the uart_port object if increases the refcount of the uart_state
object successfully or returns NULL if fails.

However, uart_port_startup() don't take the return value of
uart_port_lock() as the new uart_port object to "uport" and use the old
"uport" instead to balance refcount in uart_port_unlock(), which may
cause a redundant decrement of refcount occurred when the new "uport"
equals to NULL and then cause a potential memory leak.

Fix this issue by update the "uport" object to the return value of
uart_port_lock() when invoking uart_port_lock().

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 57840cf90388..968fd619aec0 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -205,7 +205,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 	if (!page)
 		return -ENOMEM;
 
-	uart_port_lock(state, flags);
+	uport = uart_port_lock(state, flags);
 	if (!state->xmit.buf) {
 		state->xmit.buf = (unsigned char *) page;
 		uart_circ_clear(&state->xmit);
-- 
2.7.4

