Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778378;
	b=mR9L78CaNBmjrT5ayMsR7McChD/RnTozHIl4NiuabKOT3O0OvZfVE6iuzu5fO84F5ts9
	 2yT05D9aG2GGZHJ7v6F0OVi76jgzq/d0klqcp2gHf6c25REaOvLdoQgZ2yUmDC86SWJgf
	 XWdvFUTzhPQ22ihu4Peb/k822B1zFkwLhsP7G3SCg2bmoYvaBuDV9vflslZcT6dgkWBbC
	 1sSDijkrr3uzhkn4V9ibALaN514qlOcq+pMQCD0HR1qdmAjQebnJ25VJ9P0hS+oZxY1Wh
	 HIpsRuHCB/sVypWglwIDMMkKxsQfdsjEFd1dL+TyV44aD1UVICYskZr1S3PM8HJl9NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778378;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=zYdj96Jjn4TYMr6TAGtl+RCu/tlDibSZcE0dt7Llbx8=;
	b=uJvlWazFSYTAtr0W++fOZbsj1F4WPKmRz0PdgEXMn0kLsH8cZDGPqRFirur+hz71BoXV
	 C/HO6SBRuYOU/+yCyMhLgfHy39V2suHweuymZBAryPjRmeArkgajj9HKlzt/RZXzPpYKy
	 jmaOYSJSnpPUdZzexPOfzsPoEBkfz+Ymt6lZ9XIHx1Y5wK8Ku3bYmBy6hWcM85Hi6CpjC
	 ZgnhMYVM2d1BNDIYefFPG/UDIVhkeA/VAoqxkNjO6XajzyEa/h4i4HApGBUAtVOEbH1aK
	 N14sdFcArpbRwuxSchY7YZR8qHmiBp3DFIufZjjzdYrKCT8W2+cRMACWpdlE8crpeog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C1B606A326;
	Wed,  4 Nov 2026 07:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27C1B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8AxX9PA4upq3TocAA--.16124S3;
	Wed, 04 Nov 2026 15:46:08 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJDxBc294upqZ0YyAA--.10037S3;
	Wed, 04 Nov 2026 15:46:07 +0800 (CST)
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
Subject: [PATCH 1/3] dt-bindings: serial: 8250: Document Loongson-2K0300 UART compatible
Date: Wed,  4 Nov 2026 15:45:45 +0800
Message-ID: <cf76d5d46eaba55b832287d1193111c369bcf548.1793776192.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJDxBc294upqZ0YyAA--.10037S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEBCGrqon0CygAAsd
X-Coremail-Antispam: 1Uk129KBj9xXoWrKryruw47XF13ArWrKr4xKrX_yoWfurX_A3
	WIv3Wkurs8AF1S93yYvr48Kr4fXr42kFyxCF18A3WkZ34jvrZxGF92ywn8Cr1UGr45ur13
	uan3GryjvwnrGosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
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

The UART on the Loongson-2K0300 SoC is identical to the Loongson-2K1500
UART. Document the SoC-specific compatible `loongson,ls2k0300-uart`
with fallback to `loongson,ls2k1500-uart` and then `ns16550a`.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 50d5c977afa3..01abd39509a7 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -192,6 +192,7 @@ properties:
               - loongson,ls3a4000-uart
               - loongson,ls3a5000-uart
               - loongson,ls3a6000-uart
+              - loongson,ls2k0300-uart
               - loongson,ls2k2000-uart
           - const: loongson,ls2k1500-uart
           - const: ns16550a
-- 
2.52.0

