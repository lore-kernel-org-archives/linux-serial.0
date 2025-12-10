Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CCB224B0D
	for <linux-serial@vger.kernel.org>; Wed, 10 Dec 2025 06:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765348696; cv=none; b=uutcJWw5XwRsVdbXw0y24sg1Ut09IJBnb0gkiR7DUkKExQlsX6rnlfkhJjhw6/vivZ0A6FPFGNow7v56TuViM0MlBw+3nL6m8CK2fIa9jLP2lmdyB6RrmLvv7w3r08qqTnufokHZVFJMPY5eANbJwbOg0Os3XvVeFddQYnj8Yto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765348696; c=relaxed/simple;
	bh=bWaeLXyrwPQoZNpJTS4rkPRAP6IqE3KxyPJwwHYaX+0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S8Km92Mic/gsEhvxglz3qMT9gQFRYl+1eKZ2Nd7aPXvUW+EE10tYKcYypsBw6TCtgu8MV0ANLAL+Cy6KJpGnihChUQ2Qh93V6OEM8tEs/kMsciol5DhphDSpRkmJu07fWng+1Br8wQttLaA1/siGoQoscAtuihlYh+kDcs5SbzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=XoRbGIJF; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="XoRbGIJF"
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 5BA6ZlFp012763;
	Wed, 10 Dec 2025 14:35:47 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (zeshmbx09.spreadtrum.com [10.29.3.107])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4dR5TY664mz2KXpDt;
	Wed, 10 Dec 2025 14:31:29 +0800 (CST)
Received: from zeshkernups01.spreadtrum.com (10.29.55.99) by
 zeshmbx09.spreadtrum.com (10.29.3.107) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Wed, 10 Dec 2025 14:35:45 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, Cixi
 Geng <cixi.geng@linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Wenhua
 Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
        Zhaochen
 Su <Zhaochen.Su@unisoc.com>,
        Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Subject: [PATCH V2] serial: sprd: Use devm_clk_get_optional() to get the input clock
Date: Wed, 10 Dec 2025 14:35:43 +0800
Message-ID: <20251210063543.2185727-1-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 zeshmbx09.spreadtrum.com (10.29.3.107)
X-MAIL:SHSQR01.spreadtrum.com 5BA6ZlFp012763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1765348560;
	bh=bhfoQ/zG52KjLQqtMHJaCHwh3Ur9GbyKvPw5AodW5WE=;
	h=From:To:CC:Subject:Date;
	b=XoRbGIJFapLl2RJkcd6LM0VBc2WjyuMyOv57qw+Ggjd7dxIC7nDrFmqlQfzL9gjX0
	 quAhxMRIp/71qiXbp0SzdqKb/99dX9RxxCUjAJBE/JMWem1c7NwlqMA4qqntgODrRm
	 TGLX5O0BUJceqIaEAV0SpMjOXj7hahlhHSSLEenAdU3DExF3xlIU7k/owIDI66C+0a
	 atLYGF2OcEHL7d4BAMYvZ2fpP9Iqj2DNnuu0qUWaG5GbGJrphikUfh+0638YSq6Dr1
	 OqTG4rJtxNViyS0AONmi/5Bh1eoPzGp77RXv2koPw7chyR+stREm/nRoIf2YyplQov
	 xGvBV+anJru1A==

Simplify the code which fetches the input clock by using
devm_clk_get_optional(). If no input clock is present
devm_clk_get_optional() will return NULL instead of an error
which matches the behavior of the old code.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
Change in V2:
-Change title.
-Change commit message.
-Replace devm_clk_get() by devm_clk_get_optional() and drop NULL assignment.
-Delete the sprd_uart_is_console function, after using the devm_clk_get_optional()
 interface, this conditional check is redundant.
---
 drivers/tty/serial/sprd_serial.c | 40 +++++++-------------------------
 1 file changed, 9 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 8c9366321f8e..83ce77b435ee 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1115,34 +1115,21 @@ static void sprd_remove(struct platform_device *dev)
 		uart_unregister_driver(&sprd_uart_driver);
 }
 
-static bool sprd_uart_is_console(struct uart_port *uport)
-{
-	struct console *cons = sprd_uart_driver.cons;
-
-	if ((cons && cons->index >= 0 && cons->index == uport->line) ||
-	    of_console_check(uport->dev->of_node, SPRD_TTY_NAME, uport->line))
-		return true;
-
-	return false;
-}
-
 static int sprd_clk_init(struct uart_port *uport)
 {
 	struct clk *clk_uart, *clk_parent;
 	struct sprd_uart_port *u = container_of(uport, struct sprd_uart_port, port);
 
-	clk_uart = devm_clk_get(uport->dev, "uart");
+	clk_uart = devm_clk_get_optional(uport->dev, "uart");
 	if (IS_ERR(clk_uart)) {
-		dev_warn(uport->dev, "uart%d can't get uart clock\n",
-			 uport->line);
-		clk_uart = NULL;
+		return dev_err_probe(uport->dev, PTR_ERR(clk_uart),
+			"uart%d can't get uart clock\n", uport->line);
 	}
 
-	clk_parent = devm_clk_get(uport->dev, "source");
+	clk_parent = devm_clk_get_optional(uport->dev, "source");
 	if (IS_ERR(clk_parent)) {
-		dev_warn(uport->dev, "uart%d can't get source clock\n",
-			 uport->line);
-		clk_parent = NULL;
+		return dev_err_probe(uport->dev, PTR_ERR(clk_parent),
+			"uart%d can't get source clock\n", uport->line);
 	}
 
 	if (!clk_uart || clk_set_parent(clk_uart, clk_parent))
@@ -1150,19 +1137,10 @@ static int sprd_clk_init(struct uart_port *uport)
 	else
 		uport->uartclk = clk_get_rate(clk_uart);
 
-	u->clk = devm_clk_get(uport->dev, "enable");
+	u->clk = devm_clk_get_optional(uport->dev, "enable");
 	if (IS_ERR(u->clk)) {
-		if (PTR_ERR(u->clk) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-
-		dev_warn(uport->dev, "uart%d can't get enable clock\n",
-			uport->line);
-
-		/* To keep console alive even if the error occurred */
-		if (!sprd_uart_is_console(uport))
-			return PTR_ERR(u->clk);
-
-		u->clk = NULL;
+		return dev_err_probe(uport->dev, PTR_ERR(u->clk),
+			"uart%d can't get enable clock\n", uport->line);
 	}
 
 	return 0;
-- 
2.34.1

