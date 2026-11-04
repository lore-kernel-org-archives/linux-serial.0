Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778380;
	b=mYU7IGIl67HxGhtTDMHx9wlY7RrfF3AcL8HXA+HRsbJTkLvTUAd7TgvNRgP9uU14WXOP
	 pKzgXb6MIYCbPTdVsD4L4uhc9cOi/x0ajHBXQ4BANF5sCkgnoEz9DEvzznZOWWoHO0DJT
	 nKp864yUDr75BCkO7pfbkm/uGemXX0gP0allbSFC7ltH6637duNqzMCiXRmOM/jZGWhPo
	 2Z09ZoZllF0SYzdY9XKEKaWa+dSBkfRSKgILNhOskW8Kc+k7g7Zxh+MfaiKbaNrrIocbm
	 u8L9ahml+CoDOW50nwBwBOfxXd6vy0wmK8jl/BHBReana2oXh02O3cJeoghQklSXZ0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778380;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=7oS569UmNWNCphbGbEDhGijwxYpSM6/8yQ/ULT8ORQw=;
	b=nX6a7MKyM4myx4k+A8aUDcCiPjXmma0x7Z41xKU+/KDpQEw7fN8KdYKJeCO46W/NqO8L
	 ZqWrenaD48jIrmsM0Y40ESEHLOU44LUDWdIHdkhQTOA/JFzw752RyhTy9ZNfva7zHAUC/
	 mR622aPHh3YI0o1tcOKi8bQ56mRIrsjEBH9DWn5pZt6j1A5KQZjD3icJyJ8AGMdK14YEG
	 qkNzLcIPpBV6wULAqE1LjmPc528dILgaq2UU3EO5EeC+dFttqFbHgNAHkRemNma81hkfU
	 +nZvvD5g72mgbLmhmKP6yW1OR/g8Oz87oTC2dQeVQKrLbhLMZl8gCCx12jHXwgVVeZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD633606A334;
	Wed,  4 Nov 2026 07:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD633606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8DxTNLJ4upq6zocAA--.15902S3;
	Wed, 04 Nov 2026 15:46:17 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJDxBc294upqZ0YyAA--.10037S4;
	Wed, 04 Nov 2026 15:46:08 +0800 (CST)
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
Subject: [PATCH 2/3] dt-bindings: serial: 8250: Add dedicated Loongson-2K3000 UART compatible
Date: Wed,  4 Nov 2026 15:45:46 +0800
Message-ID: <c194b5248184779da500476281fd411fc80a98d6.1793776192.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJDxBc294upqZ0YyAA--.10037S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEBCGrqon0CzgAAsZ
X-Coremail-Antispam: 1Uk129KBj9xXoW7XrWftFWxJryxuFy3GrWfWFX_yoWDurc_Aa
	4xZw4vqr1fAF1S93yjvr47KryrXa42kFn7C3Wkt3WkZ3yjgrZxGryvk3s8CrWxWr4Uur1r
	urs3CrW09rnxGosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxhiSDUUUU

Unlike earlier Loongson UARTs, the Loongson-2K3000 UART does not require
MCR/MSR signal inversion. Add a dedicated compatible so the driver can
distinguish it from the existing Loongson UART variants.

Document `loongson,ls2k3000-uart` with `ns16550a` as fallback.

Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 01abd39509a7..33c13c48ed56 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -196,6 +196,9 @@ properties:
               - loongson,ls2k2000-uart
           - const: loongson,ls2k1500-uart
           - const: ns16550a
+      - items:
+          - const: loongson,ls2k3000-uart
+          - const: ns16550a
       - items:
           - enum:
               - aspeed,ast2600-vuart
-- 
2.52.0

