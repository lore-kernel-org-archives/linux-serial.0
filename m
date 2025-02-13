Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE6F227E94;
	Thu, 13 Feb 2025 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445872; cv=none; b=o0s5nlwdIkWA8LEHh4KVOn9bRtN+ECjXokQ0p07j6xWNhXpks52e6Iglt7nyPloxuXn5L/j/2JenLAivo3E4of4T7f1KpHw+M0X/5EMUJSkkRXesMC8B95QPyPJmnSoynt35Qq94/AKxuCfTVnNzrWfRc4oe1s8Gj0k9wpmkjOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445872; c=relaxed/simple;
	bh=FXihfidZnsfjYAnSRNblC4RxoPE1meWXnh2EGviX4iM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Se2HOvEzwBKT/lXk473YVIJEwXwss6lDUjg6ssFxOZyVje3vTPvh5jRVFrmBQ0fH4AXvXcukTAJ8KlbD2pZUSJ2K+lk3+zk7JQPZpwf3FKt6URlQKbNdzVnIS2s4zDj9oGGLBnAQNExyDs+me7F6KXW2187UgCDMLPK8ZTjnBO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=TIGdJJ76; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="TIGdJJ76"
Received: from ldvnode.intra.ispras.ru (unknown [10.10.2.153])
	by mail.ispras.ru (Postfix) with ESMTPSA id 707324226E06;
	Thu, 13 Feb 2025 11:24:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 707324226E06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1739445866;
	bh=4QJVLDvWsDWRMQkm29I/yRVaDWamxuy5N9/YEC1ux80=;
	h=From:To:Cc:Subject:Date:From;
	b=TIGdJJ768Z2yBZ/Zu+rVnHatw0HDInhwvE295xuwuxNrRN5d/LqhiRkcKRzgn4oYm
	 AlSCwb6+KTYtd679GTLrncHd/l/vYurXCBUXAK4mqdqqZrTPVcYecx+lr3ARtwgxrH
	 EsK4u//Nl1NaWIilE3ueKgQwC1Ka/Atirfe6cKGg=
From: Vitalii Mordan <mordan@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vitalii Mordan <mordan@ispras.ru>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Amit Singh Tomar <amittomer25@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] tty: owl-uart: fix call balance of owl_port->clk handling routines
Date: Thu, 13 Feb 2025 14:24:16 +0300
Message-Id: <20250213112416.1610678-1-mordan@ispras.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If owl_port->clk was enabled in owl_uart_probe(), it must be disabled in
all error paths to ensure proper cleanup. However, if uart_add_one_port()
returns an error in owl_uart_probe(), the owl_port->clk clock will not be
disabled.

Use the devm_clk_get_enabled() helper function to ensure proper call
balance for owl_port->clk.

Found by Linux Verification Center (linuxtesting.org) with Klever.

Fixes: abf42d2f333b ("tty: serial: owl: add "much needed" clk_prepare_enable()")
Cc: stable@vger.kernel.org
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
 drivers/tty/serial/owl-uart.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 0542882cfbbe..64446820437c 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -680,18 +680,12 @@ static int owl_uart_probe(struct platform_device *pdev)
 	if (!owl_port)
 		return -ENOMEM;
 
-	owl_port->clk = devm_clk_get(&pdev->dev, NULL);
+	owl_port->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(owl_port->clk)) {
-		dev_err(&pdev->dev, "could not get clk\n");
+		dev_err(&pdev->dev, "could not get and enable clk\n");
 		return PTR_ERR(owl_port->clk);
 	}
 
-	ret = clk_prepare_enable(owl_port->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "could not enable clk\n");
-		return ret;
-	}
-
 	owl_port->port.dev = &pdev->dev;
 	owl_port->port.line = pdev->id;
 	owl_port->port.type = PORT_OWL;
@@ -701,7 +695,6 @@ static int owl_uart_probe(struct platform_device *pdev)
 	owl_port->port.uartclk = clk_get_rate(owl_port->clk);
 	if (owl_port->port.uartclk == 0) {
 		dev_err(&pdev->dev, "clock rate is zero\n");
-		clk_disable_unprepare(owl_port->clk);
 		return -EINVAL;
 	}
 	owl_port->port.flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP | UPF_LOW_LATENCY;
@@ -725,7 +718,6 @@ static void owl_uart_remove(struct platform_device *pdev)
 
 	uart_remove_one_port(&owl_uart_driver, &owl_port->port);
 	owl_uart_ports[pdev->id] = NULL;
-	clk_disable_unprepare(owl_port->clk);
 }
 
 static struct platform_driver owl_uart_platform_driver = {
-- 
2.25.1

