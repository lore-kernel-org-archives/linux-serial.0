From: zengzhaoxiu@163.com
Subject: [patch V4 27/31] serial: use parity8 in max3100
Date: Thu, 30 Jun 2016 01:25:54 +0800
Message-ID: <1467221154-59517-1-git-send-email-zengzhaoxiu@163.com>
References: <20160629164323.GA27356@kroah.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160629164323.GA27356@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
List-Id: linux-serial@vger.kernel.org

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Use parity8(c) instead "hweight8(c) & 1" to improve readability,
and improve performance on some CPUs that without popcount support.

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
2.7.4
