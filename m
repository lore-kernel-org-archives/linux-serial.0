From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 30/73] drivers/tty: add missing of_node_put()
Date: Wed, 12 Dec 2018 23:27:55 -0500
Message-ID: <20181213042838.75160-30-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Yangtao Li <tiny.windzz@gmail.com>, "David S . Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit dac097c4546e4c5b16dd303a1e97c1d319c8ab3e ]

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
This place is not doing this, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/suncore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/suncore.c b/drivers/tty/serial/suncore.c
index 70a4ea4eaa6e..990376576970 100644
--- a/drivers/tty/serial/suncore.c
+++ b/drivers/tty/serial/suncore.c
@@ -112,6 +112,7 @@ void sunserial_console_termios(struct console *con, struct device_node *uart_dp)
 		mode = of_get_property(dp, mode_prop, NULL);
 		if (!mode)
 			mode = "9600,8,n,1,-";
+		of_node_put(dp);
 	}
 
 	cflag = CREAD | HUPCL | CLOCAL;
-- 
2.19.1
