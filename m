Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778385;
	b=j4JWERQWRLPe8xMj3qkfFoa3Q28u02dJq584Pxh0T/DP3BspSfbMsHhDtdOpRSUP04y4
	 o1X3iC65hrKi/ZruJuhmLQXwYXkawKn6ExcEglE8usQHAFPleHehD3hLRrr75lGBlAoFA
	 EL6edOR3lPjaYW71L5SS1dVBj29uvTqK1WPA1z6xWICLyEPB+ZnOMOLIg5T6Hv9fK12za
	 mCVbx3XdBq+iiroe7Nbg8tdtKMVpni1GCQV9DreVeNZvTWZytfVNBjHsh+l86bLfClW56
	 gW0/lLRPoAGvSlVQGBHrajadCfjYTlFqdqWB5wNNoW4Qc6GrR+DLljDjUvFs3RwX5Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778385;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=4pIbHn3JO62FcrsS+gZGn0AqvwVBomE3MFPQ8sYkUfw=;
	b=jKGCXnejgS9zOH60jId2lS2BfFvxgt6tMp6ZuMpTHoNJZVwKy8INFoVrxH3Pmtwut0sI
	 8pYkZPr2FqjkU5NwDNTtZfPaecwCi0nxsKkEBbIal4SMLmkn77u8dcv8Or6QmtrmlLraN
	 oW/3Kuk6bOV7GP1hUq6c0+b4Lbuh04SipXsRTDcPtwxO0dTIaIHrmYzRr4YsC3FGZDqrl
	 PTXRCvwSc9bAREw7PzHPC4x3BN7P/1Srb/7SiehmJGLqoQMz7foSnj9nun530X8NQIwEV
	 QlC/TupADf59WfzXhWFYsAe9364p/KzMHur0eo0RcoYJ5iIaiKHYJ+QppqumEldAfGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9B9606A33B;
	Wed,  4 Nov 2026 07:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D9B9606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8AxXdLK4upq8TocAA--.16433S3;
	Wed, 04 Nov 2026 15:46:18 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJDxBc294upqZ0YyAA--.10037S5;
	Wed, 04 Nov 2026 15:46:18 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Haowei Zheng <zhenghaowei@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 3/3] serial: 8250_loongson: Add Loongson-2K3000 UART support
Date: Wed,  4 Nov 2026 15:45:47 +0800
Message-ID: <de8a92980b5140896ef8bdade1df4d851da9ec0f.1793776192.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1793776192.git.zhoubinbin@loongson.cn>
References: <cover.1793776192.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJDxBc294upqZ0YyAA--.10037S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEBCGrqon0C0AAAsH
X-Coremail-Antispam: 1Uk129KBj93XoW7tF4kJF47tF4fWry3WFyfuFX_yoW8Xw4xpF
	nxC3yq9ryjgF17CFn5AFyUAFWF9rWDGF9rKFsrG348KF98J3yUWr1rKF1jvr42ka4rXryI
	vFy0krWUGa4UWrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0epB3UUUUU==

The Loongson-2K3000 UART differs from earlier Loongson UARTs in that it
does not require MCR/MSR signal inversion. It also supports a fractional
baud rate divisor.

Add the corresponding OF match entry for `loongson,ls2k3000-uart` so the
driver can probe with the new driver data.

Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/tty/serial/8250/8250_loongson.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_loongson.c b/drivers/tty/serial/8250/8250_loongson.c
index 6d06ed28382d..0458a9f82d86 100644
--- a/drivers/tty/serial/8250/8250_loongson.c
+++ b/drivers/tty/serial/8250/8250_loongson.c
@@ -43,6 +43,12 @@ static const struct loongson_uart_ddata ls2k1500_uart_data = {
 	.msr_invert = 0,
 };
 
+static const struct loongson_uart_ddata ls2k3000_uart_data = {
+	.has_frac = true,
+	.mcr_invert = 0,
+	.msr_invert = 0,
+};
+
 struct loongson_uart_priv {
 	struct uart_8250_port *uport;
 	struct clk *clk;
@@ -216,6 +222,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(loongson_uart_pm_ops, loongson_uart_suspend,
 static const struct of_device_id loongson_uart_of_ids[] = {
 	{ .compatible = "loongson,ls2k0500-uart", .data = &ls2k0500_uart_data },
 	{ .compatible = "loongson,ls2k1500-uart", .data = &ls2k1500_uart_data },
+	{ .compatible = "loongson,ls2k3000-uart", .data = &ls2k3000_uart_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, loongson_uart_of_ids);
-- 
2.52.0

