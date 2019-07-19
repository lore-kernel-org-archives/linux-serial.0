From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 10/45] tty/serial: digicolor: Fix digicolor-usart already registered warning
Date: Fri, 19 Jul 2019 00:12:29 -0400
Message-ID: <20190719041304.18849-10-sashal@kernel.org>
References: <20190719041304.18849-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190719041304.18849-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Hulk Robot <hulkci@huawei.com>, Baruch Siach <baruch@tkos.co.il>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

[ Upstream commit c7ad9ba0611c53cfe194223db02e3bca015f0674 ]

When modprobe/rmmod/modprobe module, if platform_driver_register() fails,
the kernel complained,

  proc_dir_entry 'driver/digicolor-usart' already registered
  WARNING: CPU: 1 PID: 5636 at fs/proc/generic.c:360 proc_register+0x19d/0x270

Fix this by adding uart_unregister_driver() when platform_driver_register() fails.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Acked-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/digicolor-usart.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
index 02ad6953b167..50ec5f1ac77f 100644
--- a/drivers/tty/serial/digicolor-usart.c
+++ b/drivers/tty/serial/digicolor-usart.c
@@ -545,7 +545,11 @@ static int __init digicolor_uart_init(void)
 	if (ret)
 		return ret;
 
-	return platform_driver_register(&digicolor_uart_platform);
+	ret = platform_driver_register(&digicolor_uart_platform);
+	if (ret)
+		uart_unregister_driver(&digicolor_uart);
+
+	return ret;
 }
 module_init(digicolor_uart_init);
 
-- 
2.20.1
