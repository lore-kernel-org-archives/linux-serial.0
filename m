Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795762443;
	b=R11qFZzWjkKTqq1A+FGkiFyI/dGS62NjYLa81gKTuD9/jUAkMgMQQdD0VEg6B8V6Y63G
	 fLaw/+HIedjH9jjCfbwUPLIrGy+8pvBMrXreNTpoJkOqIp43ko+2kWwixP8b4xfUZKFS/
	 Y6M4hyx4rZH6QqMAqIUDNUWCC377qPlZvg+jZBRZqobn1gtlQMZWnrQUZpPGgVb82kXAp
	 6SoyBjZXZ52BWzIVlBJiQvLdTbnFYcNZ+gHUV/7DOQi2wPr1uL5Wy7tZ/6ka2enyFFhOU
	 jL4oq8xqeXlCUq8HPinem6QjhwEqvkmVV+Dr86Fzs4g8qTJc1JjB5GBLk/GJIHoCgAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762443;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=etMIRKpPRyg5p1f5SSu1Q7sUXYF1xtuvPyJAFBd6Q5g=;
	b=ADnpJ7vvIfXJ+5UKNFvL8Orgz9ziqgKlWWOMlWnYujCDlPlxT2Z48L6Paj7fz4a6SBzN
	 pNpREh1EnbqhPYx1JHJIC8GjhfNQvxPM/CnGGR1EsmOBFiV5idlpcBfSxEEHCRUXYcoJJ
	 2S+VOycEMcTtFYWxm/b/NV9vXrmrNR0zFY1itPkILCLRmnYkpTXQPzhZ/KpnV0y1i3wC0
	 mk1nzrhOGXliXr3YHsRTJzA5gHAycryF4v8RH5PxaYyaG3bAZt04JpDWVaegXgfOAY401
	 tavXI2lHWquWc8TLl+ugHFGxEyyJjL+UhonADUEIZWN4Csrs+U2mJKBFHttAZB0IbYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8A9606A32D;
	Fri, 27 Nov 2026 06:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D8A9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.66])
	by gateway (Coremail) with SMTP id _____8DxztIHKQlrqHojAA--.34423S3;
	Fri, 27 Nov 2026 14:53:59 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.66])
	by front1 (Coremail) with SMTP id qMiowJAxFs3_KAlrXbc3AA--.52846S3;
	Fri, 27 Nov 2026 14:53:55 +0800 (CST)
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
Subject: [PATCH v2 1/2] dt-bindings: serial: 8250: Document Loongson-2K3000 UART compatible
Date: Fri, 27 Nov 2026 14:53:42 +0800
Message-ID: <c429fd68b6c08e3bf4f9af2bbed40c699cf205a9.1795761142.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJAxFs3_KAlrXbc3AA--.52846S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAQEECGsI5P0GEwAAsj
X-Coremail-Antispam: 1Uk129KBj9xXoW7JrW5Jw4xur45XrWUWFW5twc_yoWDGFb_Za
	4Ivw1kurs3AF1F93yYvr4xtr1fXw12kF4kC3Wkt3WkZ3yj9rZ8GFyvk3s8Cr4xWrWDur15
	urs7GrWI9rsrGosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j2MKZUUUUU=

The Loongson-2K3000 UART does not require MCR/MSR signal inversion,
unlike earlier Loongson UARTs. Add a dedicated compatible so the driver
can distinguish it from the existing Loongson UART variants.

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 50d5c977afa3..166cb7995b09 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -137,6 +137,7 @@ properties:
               - ti,da830-uart
               - loongson,ls2k0500-uart
               - loongson,ls2k1500-uart
+              - loongson,ls2k3000-uart
           - const: ns16550a
       - items:
           - enum:
-- 
2.52.0

