Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IAQKax88"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A6681A8;
	Wed, 29 Nov 2023 03:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=4KSReBDzzeRrqbkauW
	k2fmkY0a7uOl8FxER0foarfow=; b=IAQKax88RMQZSR24Vm/58+eGq6iiyLyPM7
	smWCU4doydMDmMZxzZQDN2u0hyh8XGBqXZc6EQ+xkYV3JBYCDFwwgpe0dmEGUlE1
	rpkMZbwPWBUQWBgGbQmmitVmIct2VO/5A+PR2Fs9xPWPzWDT1qmHYQyhAF4S06b3
	2apMi2b1E=
Received: from localhost.localdomain (unknown [39.144.190.126])
	by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wCXd0YGJmdlsP_8EA--.44253S2;
	Wed, 29 Nov 2023 19:52:40 +0800 (CST)
From: Haoran Liu <liuhaoran14@163.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [tty/serial] 8250_acorn: Add error handling in serial_card_probe
Date: Wed, 29 Nov 2023 03:52:36 -0800
Message-Id: <20231129115236.33177-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wCXd0YGJmdlsP_8EA--.44253S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWxZr4UCw47ur4rCryUZFb_yoW8JFy3pF
	4DKrs0yFWYqF1xu3srXr45ZF1rGay8tF17GrnrG3s5trs8tr9agr4fKa4jyr4jkr95GF1a
	yF15CrWUCay2yF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEubk7UUUUU=
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiZQY3gl8ZaQ1sNQAAst
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

This patch adds error handling to the serial_card_probe
function in drivers/tty/serial/8250/8250_acorn.c. The
serial8250_register_8250_port call within this function
previously lacked proper handling for failure scenarios.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/tty/serial/8250/8250_acorn.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_acorn.c b/drivers/tty/serial/8250/8250_acorn.c
index 758c4aa203ab..378ae6936028 100644
--- a/drivers/tty/serial/8250/8250_acorn.c
+++ b/drivers/tty/serial/8250/8250_acorn.c
@@ -43,6 +43,7 @@ serial_card_probe(struct expansion_card *ec, const struct ecard_id *id)
 	struct uart_8250_port uart;
 	unsigned long bus_addr;
 	unsigned int i;
+	int ret;
 
 	info = kzalloc(sizeof(struct serial_card_info), GFP_KERNEL);
 	if (!info)
@@ -72,6 +73,14 @@ serial_card_probe(struct expansion_card *ec, const struct ecard_id *id)
 		uart.port.mapbase = bus_addr + type->offset[i];
 
 		info->ports[i] = serial8250_register_8250_port(&uart);
+		if (IS_ERR(info->ports[i])) {
+			ret = PTR_ERR(info->ports[i]);
+			while (i--)
+				serial8250_unregister_port(info->ports[i]);
+
+			kfree(info);
+			return ret;
+		}
 	}
 
 	return 0;
-- 
2.17.1

