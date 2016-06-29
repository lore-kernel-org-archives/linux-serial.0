From: zengzhaoxiu@163.com
Subject: [patch V4 27/31] serial: use parity8 in max3100
Date: Wed, 29 Jun 2016 22:57:08 +0800
Message-ID: <1467212228-12044-1-git-send-email-zengzhaoxiu@163.com>
References: <20160625172500.GA18790@kroah.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160625172500.GA18790@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
List-Id: linux-serial@vger.kernel.org

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
2.7.4
