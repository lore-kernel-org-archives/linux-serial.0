Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778372;
	b=Eq1tpwtGY46xb/5tuFTayEUee+9U/NMW4PVkjplmUGQp9xj9xYSF+NTJN5K9ypDAF8KV
	 IML60i9aG+Ha5TsuEY890kYFVJDWPuS+eZ8mna4nmggAhJLTxKJfP4l0BsdzJMwdsq/Yy
	 Ht0+Tt2ZCVhNn4g2x0+Zsu5GFVqwUtnvS60bXLDQFY/dUCLoTL1YyEEptR0ICMEcTfgEf
	 pV4HFB0HtfHMJqOjzOn7Kf+keNQr/sPG3CEYh4uh0iB+cWQgtynnCUCM5vDYgrMtpBNqT
	 oFQ/lZ3EKnaLDDE/NzZelHaUSsWxE33ss9CyfOfDCU8lopCXos4CI2f8D26ZoKdaq8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778372;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=BKtEwN9SjzU3vDDD4SW+5UbctESaNHA3sfD45hV8J9c=;
	b=NBkmLcWMT5gGELUM5nsibSe1/2OPjv3OQXTVDtzYQMCKORhEqMg7yE9wZEku8j2SBKU8
	 ygY/TJGZUfn79NhKgIY86gN4MujYO67MHNzQDG+mjUWnBcJnh6vLlTgMycJi0+QUpZsgM
	 +NP90dfwC4l+lsp/kBp3WP9R91Bdjfr/cH2iUmRTqxhPt3x5+mqySjAOlaIcXGhI5YeYQ
	 2mgllBdJA/+xxzWqTvGzCOXdJ8d7M8lOich0VpVIBWCteCRIE3k5Sgi03XpYAPPyn6Aue
	 9wLK2FOQu/2AtwZM5pspWxRnnRXMqzgE/D9maI7pu5BdpnuUEhCB8wNfJxqu9+yK5NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535B2606A31B;
	Wed,  4 Nov 2026 07:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 535B2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8AxXdLA4upq3jocAA--.16432S3;
	Wed, 04 Nov 2026 15:46:08 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJDxBc294upqZ0YyAA--.10037S2;
	Wed, 04 Nov 2026 15:46:06 +0800 (CST)
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
Subject: [PATCH 0/3] serial: 8250: Add Loongson-2K0300 and Loongson-2K3000 UART support
Date: Wed,  4 Nov 2026 15:45:44 +0800
Message-ID: <cover.1793776192.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
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
X-CM-TRANSID:qMiowJDxBc294upqZ0YyAA--.10037S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEBCGrqknoEBAAAsh
X-Coremail-Antispam: 1Uk129KBj9xXoW7Gw1xGw4kAw1xGr47AF4UKFX_yoWDXFgE9w
	1SvF18W345CFnFq3yaqrW3Cr4fWFWqkF1qkw1kt3yS9342kryDuryqkryDC3W3XrWDuFn8
	ZrWkGry09w1fGosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5ID7UUUUU=

Hi all:

This series adds UART support for two Loongson SoCs.

The Loongson-2K0300 UART is the same as the one found on the
Loongson-2K1500, so it is documented as falling back to
"loongson,ls2k1500-uart" and then "ns16550a". No driver changes are
needed.

The Loongson-2K3000 UART differs from earlier Loongson UARTs in that it
does not require MCR/MSR signal inversion. It also supports a fractional
baud rate divisor. A dedicated compatible and driver data are added so
the driver can distinguish it.

Thanks.
Binbin

Binbin Zhou (3):
  dt-bindings: serial: 8250: Document Loongson-2K0300 UART compatible
  dt-bindings: serial: 8250: Add dedicated Loongson-2K3000 UART
    compatible
  serial: 8250_loongson: Add Loongson-2K3000 UART support

 Documentation/devicetree/bindings/serial/8250.yaml | 4 ++++
 drivers/tty/serial/8250/8250_loongson.c            | 7 +++++++
 2 files changed, 11 insertions(+)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.52.0

