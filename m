Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795762440;
	b=1C8mH0iiklK/fH2IQTvArYjmjFwn+4sMRb4khgiKwRi3lu1f3HWSlvSjvCPv2dNGjamW
	 wo5kJIH43Ca3gw8vOmUVDZVVhy0SQn6/TTczgP4Wb2RXwBIXXFJcW5MxqpLSAT2AtFJcA
	 QnNJr6mw7STjWESP/n/D3xFlyRfEcDUXfLot8DM/8yj6eMUKYE7eZowAXwWdxK+p0A4DS
	 CvQwo2c0bNSNpBgsiTXkE16IQ/olm9uMvnUf9EVdg+ySQzNmrAGLpglcuGJb5CZhX+CFE
	 b4QCAJJZs5WTY7lTNqcIOD08QLE1V5FstRkWxUetPRfjAXn6lreK4TYP80H0ZOOMObA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762440;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=KzxaOAOiMseK9Mjtyg984kDTY9wzMOkYH0cliFv1Y5M=;
	b=W/AyK+/Myxs5afOpqCmtiP8RzlO3Wm1EJN/i1MucWou5C0AwP7fRrIu+Ir3jWFstT4QW
	 3DH3Fz2S8oUwqGBTySNSC0YUCcTnfpBBc1ExJJu5oexcS6w8VPd6e3Ohq3fvdDbcGzhzc
	 E13Mm+7YHktBxQLKN3cSqHbdtCk+rDlzlsueuqW9vkmxNMzlVHdNZbw72mk90tAXUUOlL
	 GGttYWf93ShWrUaNg1lEkqNt64pfN8VVO8GDUcvRWNGteOEKsQjIbbPJSA3bM6ARJah+S
	 yWtlypqFG8XLPBfdarkm58fh+WdYL5AUzQCcw9/c+ru1dd8Yq7ivhSN2SezJRPgpNPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A62606A31C;
	Fri, 27 Nov 2026 06:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35A62606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.66])
	by gateway (Coremail) with SMTP id _____8DxjdIDKQlrn3ojAA--.34857S3;
	Fri, 27 Nov 2026 14:53:55 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.66])
	by front1 (Coremail) with SMTP id qMiowJAxFs3_KAlrXbc3AA--.52846S2;
	Fri, 27 Nov 2026 14:53:52 +0800 (CST)
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
Subject: [PATCH v2 0/2] serial: 8250: Add Loongson-2K3000 UART support
Date: Fri, 27 Nov 2026 14:53:41 +0800
Message-ID: <cover.1795761142.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJAxFs3_KAlrXbc3AA--.52846S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEECGsI5P0GEQAAsh
X-Coremail-Antispam: 1Uk129KBj9xXoW7Wr18tw4DKr1UZr4fZry3ZFc_yoW3GFXE93
	ySv3WkX34DZF1Iy3y2yr98GryrWr4jyF1UCa4UtwnI934qkFyDJFyqk3s8J3WxX3yDuFn8
	ZFykGry0vr1fGosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14
	v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2BT5
	DUUUU

Hi all:

This series add UART support for Loongson-2K3000.

Thanks.
Binbin

========
V2:
- Add Reviewed-by tag;
- Remove the original patch for the Loongson-2K0300 UART;
- Add ls2k3000-uart to the existing enum instead of adding a separate
  two-item block.

Link to V1:
https://lore.kernel.org/all/cover.1793776192.git.zhoubinbin@loongson.cn/

Binbin Zhou (2):
  dt-bindings: serial: 8250: Document Loongson-2K3000 UART compatible
  serial: 8250_loongson: Add Loongson-2K3000 UART support

 Documentation/devicetree/bindings/serial/8250.yaml | 1 +
 drivers/tty/serial/8250/8250_loongson.c            | 7 +++++++
 2 files changed, 8 insertions(+)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.52.0

