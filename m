Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795762451;
	b=KMpaOtHcWuaqO9TvWdXIc47Aj2yzzC0hpVzlvQM1GvK/LA6Xs9jvVv3EYoSQG/l8rZes
	 h4zJquqEggK0hnxn+l1h1GdLQzrpMoNymJp09FQZk64un4H6DnVLezR38/xoqRfB1yjMP
	 s7mqQg7EBDhk0AovbPvDTdzExkdRgl7LpmS5MVFQ81N3V/jKJqpiwRRd7GnA1gwBUfCHc
	 7qBlxvcEj/lAkSKjhG31DYb6L+kJQdzvgEQBXAMPf8BkpwsMNb0OLHNmeXRbEE5ubdZED
	 MsvZLDU+iwhjcQEMFb7xtWtRVuKkDUcsltPHAjiI/Czw4LTaimlSJEUq5J3iowI9Dew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762451;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=ap6iM49OwOfcQZaqrzOGzUzSj0YA0fwnTvoOD/IbYGc=;
	b=sBh99zkRKDEgYE5UjCBZaq0i8Pf25FUNscd1YAQ60pk300qiPWuozh5ofQwnsDA1vsMR
	 qjxgoRbBw1KvVHs/C/NPh9q+kMWcuOPbSkQbboAajFDrMqms5G78y0IZnvjfyjTpkek5e
	 UKVupt6Nn26TKRBxLjpYwv95Ucv7LUjoAt/jZkOncErb6JSh0mGrT8a4akpAErtK7z7Ji
	 37nj+yo437ZAwSVerU7vrlEy+GSQx1Ryd4pubMzf7JNVsQewHv4q+MPKBP07Kl0OYzhkO
	 9hWzPlDKYPBmZgp1xyR0ubze6RBWiFx05DEai4v/hDznYX+ed1WiECZjpKdwwe5qhHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56572606A32A;
	Fri, 27 Nov 2026 06:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56572606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.66])
	by gateway (Coremail) with SMTP id _____8DxytEIKQlrrXojAA--.34517S3;
	Fri, 27 Nov 2026 14:54:00 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.66])
	by front1 (Coremail) with SMTP id qMiowJAxFs3_KAlrXbc3AA--.52846S4;
	Fri, 27 Nov 2026 14:53:59 +0800 (CST)
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
Subject: [PATCH v2 2/2] serial: 8250_loongson: Add Loongson-2K3000 UART support
Date: Fri, 27 Nov 2026 14:53:43 +0800
Message-ID: <c97ce251b5fdb58f461bb36f9270cf01969d5a54.1795761142.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1795761142.git.zhoubinbin@loongson.cn>
References: <cover.1795761142.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJAxFs3_KAlrXbc3AA--.52846S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEECGsI5P0GFQAAsl
X-Coremail-Antispam: 1Uk129KBj93XoW7tF4kZrWDJFWUtrWxXry8CrX_yoW8WF18pF
	sxC3yq9ry0gF17CFs5AFyUAFWF9rZ8GF9rKFsrG348KF98J3yUWr1rKF1jvr42ka4rXryI
	vFyvkrWUGayUWrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4ApnDUUUU

The Loongson-2K3000 UART differs from earlier Loongson UARTs in that it
does not require MCR/MSR signal inversion. It also supports a fractional
baud rate divisor.

Add the corresponding OF match entry for `loongson,ls2k3000-uart` so the
driver can probe with the new driver data.

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
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

