From: zengzhaoxiu@163.com
Subject: [PATCH v2 28/30] serial: use parity32 in max3100
Date: Wed,  6 Apr 2016 18:18:42 +0800
Message-ID: <1459937922-8531-1-git-send-email-zengzhaoxiu@163.com>
References: <57031D9D.801@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57031D9D.801@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lars@metafoo.de, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
List-Id: linux-serial@vger.kernel.org

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
---
 drivers/tty/serial/max3100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 5c4c280..a0cc84a 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -155,7 +155,7 @@ static int max3100_do_parity(struct max3100_port *s, u16 c)
 	else
 		c &= 0xff;
 
-	parity = parity ^ (hweight8(c) & 1);
+	parity ^= parity8(c);
 	return parity;
 }
 
-- 
2.5.0
