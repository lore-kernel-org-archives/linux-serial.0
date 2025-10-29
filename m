Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCAD2BD5A1;
	Wed, 29 Oct 2025 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725103; cv=none; b=N2N5q5pbP+M/pTtjICyv1v0pHwOTBVg4RfXDvYLkdObXlV9IDyFS3IqJvIdYrZvjxYcHsiNZ5lC78L1doePbLBFtuCbqNMdzmY7QmeacGR1GdCgOq0OFcCnOZG4OPTlnRWBBSwvhXUAh80XpHJLq5qIxYRq6b6xe/S8pQXokOHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725103; c=relaxed/simple;
	bh=eRvdYNM/M5y9i4OeDJdMgwnklXbOV6DrncAoG0UcYW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k9c0OPnHmBgvvPJNjJM75pplhZPH54pE2N5dKmeKI2AO9WKpyjPz5Srxdo4saVbsiFMc1CT19gzmQ3EEUTIWalKNucLkIeMDtdmp5VLh2MEP9LCWTYACwDVt77pbDT4FCJOdCBLA54LyVYQJCMCYrPDIPGLKzPNj12HuYiewW1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowAAnrGCgygFple17BQ--.24270S2;
	Wed, 29 Oct 2025 16:04:50 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: ychuang3@nuvoton.com,
	schung@nuvoton.com,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] serial: ma35d1: Fix resource leaks on driver removal
Date: Wed, 29 Oct 2025 16:00:39 +0800
Message-ID: <20251029080039.1010-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnrGCgygFple17BQ--.24270S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4xWw4DCry8JF4rurW3KFg_yoW8WrW3pF
	ZrKay5GaykGay0qw4vkw1UZFWkZw18tayIkry3C3WfCan0qFn3tF4fta4jvFWUZFWkXr47
	Xw10y3WruF1DKFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkKA2kBkUXMWQAAsu

The driver fails to release resources acquired during probe. It calls
of_clk_get() to obtain the clock reference but never calls clk_put()
in the remove path, leaking the clock reference count. Similarly, it
calls ioremap() to map UART registers but never calls iounmap() during
removal, leaking the I/O memory mapping.

Switch to devm_clk_get() for automatic clock resource management and
add iounmap() call in ma35d1serial_remove() to properly release the
memory mapping.

Fixes: 930cbf92db01 ("tty: serial: Add Nuvoton ma35d1 serial driver support")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/tty/serial/ma35d1_serial.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 285b0fe41a86..37e9f6166290 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -711,7 +711,7 @@ static int ma35d1serial_probe(struct platform_device *pdev)
 
 	spin_lock_init(&up->port.lock);
 
-	up->clk = of_clk_get(pdev->dev.of_node, 0);
+	up->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(up->clk)) {
 		ret = PTR_ERR(up->clk);
 		dev_err(&pdev->dev, "failed to get core clk: %d\n", ret);
@@ -762,6 +762,7 @@ static void ma35d1serial_remove(struct platform_device *dev)
 
 	uart_remove_one_port(&ma35d1serial_reg, port);
 	clk_disable_unprepare(up->clk);
+	iounmap(up->port.membase);
 }
 
 static int ma35d1serial_suspend(struct platform_device *dev, pm_message_t state)
-- 
2.50.1.windows.1

