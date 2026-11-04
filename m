Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758500;
	b=RTOdzWa+PHp1j1eNbb6iX87qTEvlHfcizwESBsnWYNiJig2JMYkakv7dVair4XaSt3Ei
	 x9Gs+BWLC5KpietBXTFiBaZvZQT6JjCY7gKUQkzM91Ud3JGIt0QHrTT/g5mckzUzle/MX
	 vLmD3oLVWb5m0aSYfBXBv7B5BtfEst14L1wt+ZZhuJ/gdXtQTSxGI4DSx2wz4T4nWhYzT
	 wKp+RnRnZHfmY323TPWBgm+/+SDNkwqif7ncfqVqL1YdpnY/slYI89Wrk6OPHrdsmg9wZ
	 A3TM5E3eZ2IVl6kA4tlY+VhkOw7/9jXvV9+Do+h3TbONnfPV4IxC3J76i5Bkj8Z3FUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758500;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=RUCWUjzucvS/E9rxLqjyLNLWUxeTCNv4/7wdXMHBHDM=;
	b=c6gj/UWGu6Uh+Hb3AZMUD5oL92i7ErVQxF0blJwXtKyv0L96KfPYTmPWqzum0nL1Ibhi
	 w9+GJRvMia8dPBJh9JMc+Ano5v0zB2vRMtXUUVCaYUCD0UxXaIxZzpW9wNBP3OP/SC1oY
	 HYx80G7xcOI/yHCWNbNjl7T9gd3fJ+9uS0HE3thAtp+oPXSGd2TAdJ/YjhmIX8aQC9TrQ
	 waJqHNaEV1a7tHuXTyA0V+s1w74BOTaITWBSV3ub+wvlAeg/ohPhWC9dUHYDnJz/0MnGz
	 NR9pE4Q7Iilkzs1KnFZWhuuF62AjiAHJm8JvFxsfgCl6wKfmMQ8qpROhm1s3GujPgnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BABC606A31B
	for <linux-serial@vger.kernel.org>; Wed,  4 Nov 2026 02:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BABC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAB3Zf8clepqS3Y+AA--.9737S2;
	Wed, 04 Nov 2026 10:14:52 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH] serial: meson: unregister the UART driver if port registration fails
Date: Wed,  4 Nov 2026 02:15:01 +0000
Message-Id: <20261104021501.1468500-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3Zf8clepqS3Y+AA--.9737S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4xZrW3ur4xAFWrur15Arb_yoW8Ar4rpF
	4DGFZ8trWUKF4xJ3WUAF45AFW3KayIqa47ury7J3sa9ry3JFy8K34ftayYyF1DtrykGFyv
	vr1UG3y8ua1UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
	v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0E
	wIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU5ENtDUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUBA2rqY-m4YgAAse

meson_uart_probe() registers the shared uart_driver on the first port and
relies on meson_uart_remove() to unregister it once the last port is
removed.  If uart_add_one_port() fails, probe returns an error, so remove
is never called and the driver stays registered, leaking its tty driver
and per-port state.

Remember whether this probe registered the driver and unregister it again
when adding the port fails.

Fixes: e71aab9d6132 ("tty: serial: meson: apply ttyS devname instead of ttyAML for new SoCs")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/tty/serial/meson_uart.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index a6cb2a535f9d..a51362f73dee 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -702,6 +702,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 	int ret = 0;
 	int irq;
 	bool has_rtscts;
+	bool registered = false;
 
 	if (pdev->dev.of_node)
 		pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
@@ -753,6 +754,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 		if (ret)
 			return dev_err_probe(&pdev->dev, ret,
 					     "can't register uart driver\n");
+		registered = true;
 	}
 
 	port->iotype = UPIO_MEM;
@@ -781,8 +783,11 @@ static int meson_uart_probe(struct platform_device *pdev)
 	}
 
 	ret = uart_add_one_port(uart_driver, port);
-	if (ret)
+	if (ret) {
 		meson_ports[pdev->id] = NULL;
+		if (registered)
+			uart_unregister_driver(uart_driver);
+	}
 
 	return ret;
 }
-- 
2.34.1

