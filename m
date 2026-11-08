Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140122;
	b=5feObm/+9qvqAw/AhWdO8wfCNlpRcZR8kot+yQtAVvQ4a5u94jrO35MA9Vj2TAX4AN5O
	 7G8Pnhvamaa9YacHwGVqoJrFsYU+swzbz9CCpOkmgrDHqJFyeRWh5RDVKFTM7uOian1AG
	 9RojyQebkEmEphgfuJJ++PpPQgnbf8unK20q3xmTeYYEEFOvdOWAfEez9sCedEPpYc1og
	 NoNCAPy1iYDLRV64kZO/8NZD2FP2m6I/KiTrYpuFaRK1pbVHVM73J6zTpu6ZsiX+DTWWO
	 z0HVvsqLlER835ktc+YN7RgerdMihgwmyFNTP5VacVW/42l3nmNsL8V+F5rmfc1JLIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140122;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=oE9ERfXDMWCFW7DkhWsG/cmmyFOvts4e8qG7WMEgvy8=;
	b=1i3+kkD81Y79kkQR+DvYfMRPpAji1yAcK6+rT+6awBuQHYIlqa0Nt3FpPcqVQjg1i6kq
	 QebNg5BMPuLyLxA4rOp+3gdKhwJ4VieuxvOwiH8WPBYzr1YPLsr0ifegmPnO0pNthl4s6
	 Flu43rgqQFrv5pQ4YACXtmfgwqG1pQbBTUphJrVBlOzuPWvc26SdoBwKHLtMOIu8dneRi
	 QQNVRBmMh4EAld3C1MdqHDZiHCl5NNn/45FZ8b1G0cJ6TpcJieA9z4y7YDXmrf+ONcKtM
	 MAZbK5E6EWGPovjhOzYm5tbZ2QbrzdVdsBLWhT/Idvl8Y2yoAb/nxszfB8tQRWmHQVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED450606A320;
	Sun,  8 Nov 2026 12:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED450606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABX8rfSZ_BqLxubAA--.39623S2;
	Sun, 08 Nov 2026 20:15:14 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Alexey Charkov <alchark@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 linux@prisktech.co.nz,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: [PATCH] serial: vt8500: Use devm_clk_get_enabled()
Date: Sun, 08 Nov 2026 12:15:30 +0000
Message-ID: <1794138380.2883200.vulab@iscas.ac.cn>
In-Reply-To:
 <CABjd4Yy-9A0xWCDfZemHOTZDrDdtdO05nUjmN=w=sLwYjzZn8Q@mail.gmail.com>
References: <20260917155834.2161361-1-vulab@iscas.ac.cn>
 <CABjd4Yy-9A0xWCDfZemHOTZDrDdtdO05nUjmN=w=sLwYjzZn8Q@mail.gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowABX8rfSZ_BqLxubAA--.39623S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4kXr47ArWfAF18ZF4Dtwb_yoW5KryxpF
	ykKa98KF4kJFWxKa10yF1UAa4rZr40ya17Grn8GayFvw13ArWxtFySy34v9FWUZrWkC3Wj
	y3yrA3sFyFWUuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	b818PUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwYFA2rv42DP8QAAs-

Hi Alexey,

Sorry for the very late reply. Working through the review comments I got
in September has taken me far longer than it should have.

Your suggestion was right, but the leak fix went in before I could act on
it: it is commit 9d8955281d92 ("serial: vt8500: Fix clock reference leak
in vt8500_serial_probe()") in mainline, and it kept the clk_put() you
asked me to replace. It has been backported to the stable trees by now as
well. So the patch below is not a v2 of that one, which would only resend
something that is already applied, but a follow-up that does the
conversion on top of it.

devm_clk_get_enabled() gets the clock and enables it in one call and
registers the disable and put with devm, so both the manual error handling
and the clk_put() go away. Probe now returns the error code from the clock
lookup instead of a hard-coded -EINVAL, and the clock is released
automatically through devres. The success path is unchanged and nothing
else in the driver is touched.

For the record on where this came from: the candidate came from our static
analysis tooling, and DeepSeek and GPT-6.1 Sol were used to audit it and to
help write the change. I reviewed the result and I am responsible for it.
The patch is build-tested only: it compiles cleanly with W=1 for arm
(vt8500_v6_v7_defconfig, CONFIG_SERIAL_VT8500=y) and passes
checkpatch.pl --strict; I have no VT8500 hardware to test it on.

Thanks for the review,
Wentao

From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Sun, 8 Nov 2026 11:41:30 +0000
Subject: [PATCH] serial: vt8500: Use devm_clk_get_enabled()

vt8500_serial_probe() gets the clock with of_clk_get() and enables it
with clk_prepare_enable(), so the reference has to be dropped by hand on
the error path, and the clock is never disabled or released afterwards,
even though the rest of the probe is devm-managed.

Use devm_clk_get_enabled() instead, which gets and enables the clock in
one call and registers the teardown with devm. The manual error handling
and the clk_put() can then go, and probe returns the actual error code
from the clock lookup rather than a hard-coded -EINVAL.

The clock still stays enabled as long as the port is in use, so the
success path is unchanged.
---
 drivers/tty/serial/vt8500_serial.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index fc6fdc751b16..73922523dff6 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -603,7 +603,6 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	struct resource *mmres;
 	struct device_node *np = pdev->dev.of_node;
 	const unsigned int *flags;
-	int ret;
 	int port;
 	int irq;
 
@@ -647,17 +646,10 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	if (IS_ERR(vt8500_port->uart.membase))
 		return PTR_ERR(vt8500_port->uart.membase);
 
-	vt8500_port->clk = of_clk_get(pdev->dev.of_node, 0);
+	vt8500_port->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(vt8500_port->clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
-		return  -EINVAL;
-	}
-
-	ret = clk_prepare_enable(vt8500_port->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable clock\n");
-		clk_put(vt8500_port->clk);
-		return ret;
+		return PTR_ERR(vt8500_port->clk);
 	}
 
 	vt8500_port->vt8500_uart_flags = *flags;
-- 
2.34.1

