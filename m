Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66460ECAAD3
	for <linux-serial@archiver.kernel.org>; Sun,  4 Sep 2022 15:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiIDPmD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 4 Sep 2022 11:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiIDPmB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 4 Sep 2022 11:42:01 -0400
Received: from smtpbg.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308BC275CE
        for <linux-serial@vger.kernel.org>; Sun,  4 Sep 2022 08:41:54 -0700 (PDT)
X-QQ-mid: bizesmtp85t1662306096txcoayox
Received: from localhost.localdomain ( [182.148.14.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 04 Sep 2022 23:41:34 +0800 (CST)
X-QQ-SSF: 01000000002000C0C000B00A0000000
X-QQ-FEAT: ElntjVByhgW3gJ/I0cS6R7QlY8dKXumBC0x5vKJFDdjIJbW24zPZT/Uqsi+b2
        R2G7TfhLJp5voX0haDc/L5U10pwX3Df46HUzbqn0NjXB3sj9jAx0p7dcbrh/yulo+yN2Khg
        k+LvXRD4Z4JkqKATvL3mN0hqahiPJ6m2Gda+CdyPfUxEvHXIA8vpV3rEMONPVFLGH2AszI3
        d6mOO4dWQgiWhnubpxVG8SEt3KPXiiiwK/crP+7+K44Wk1X3iO5bJFDtctXvg+jyQBQ+0e8
        huaJsi160dDPYr6jvx55D+nPlT5kiD+g5FPuAnclSPbiQIGbvevyUlDu0ls5peZ2lc7Tg9N
        m/gpgdoL/e4blzTjL7y22jLTJd4HatZnj6vfl+K
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc:     jirislaby@kernel.org, Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] tty: serial: Fix comments typo
Date:   Sun,  4 Sep 2022 11:39:47 -0400
Message-Id: <20220904153947.23597-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Delete the repeated word "have" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/tty/serial/8250/8250_omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 0dcecbbc3967..cb14cdbb6d06 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -345,7 +345,7 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
 }
 
 /*
- * OMAP can use "CLK / (16 or 13) / div" for baud rate. And then we have have
+ * OMAP can use "CLK / (16 or 13) / div" for baud rate. And then we have
  * some differences in how we want to handle flow control.
  */
 static void omap_8250_set_termios(struct uart_port *port,
-- 
2.35.1

