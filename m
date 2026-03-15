Received: from va-2-29.ptr.blmpb.com (va-2-29.ptr.blmpb.com [209.127.231.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A6637188F
	for <linux-serial@vger.kernel.org>; Sun, 15 Mar 2026 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773600193; cv=none; b=lztGSaZzZuCTVseV8ZGTNQV5tPN2F4zEi6kHDEWbfeCf+rmywz16Uhp2ePNAO1zmrHpEkHucCjM8YCpiu9tuhpPBgVZi45sGaeIrfk4bDFcE38NvA5YZFBOqDKOTrPjt3f4t/XOEh2NoFThgdhHUts584EtXK4lUl9mK8JNtoqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773600193; c=relaxed/simple;
	bh=q5xIUKZReGhegwzVm5wpFVFK6UdQUvqkkcucwpyLAKU=;
	h=To:References:Cc:Date:Message-Id:Content-Type:Mime-Version:From:
	 Subject:In-Reply-To; b=Cgmq3f/nELZcu1HUQylYwC+n89TH9+7/AifpL+6RNC6l+tub470IoPT1DQknkuda2pfWcPzpRwJWJ9bxHyOSF5zDJEyfvTZtbz7H2kEWxpRS+EXhwieq1Q70rgsU0MRmUQiqwCkjcTZisz3WJPQMnjOo8bQsnTlzY98FPHIFP2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com; spf=pass smtp.mailfrom=oss.cipunited.com; dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b=EH3pQm2s; arc=none smtp.client-ip=209.127.231.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.b="EH3pQm2s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1773600186;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Mlb8YeoNc+25qTnDUkz1Hsif+FZNdijfFkl8bVFYpk8=;
 b=EH3pQm2s/vUmyzDBGrCTHbyAaUaqNq+II1oTccDNIWiR0lLeBdVZ+GXFpI5k1vOfDPOm4k
 YVhX2m/K+bbAGmD7mqrQl/oHaS+m4KTe6VCyzjQkQI42RbNxyj4zx4IJaQqREv9iEzY3xo
 2oOaUwExPfFtXVtzK2N5+lasOKTmWoppFv3Bk4MICARsF98pnN94+UAV9NIdVvgxKJ1bYT
 mXVTEf4LPj9iQoDjWzT4YT5bI18uYnQo3+GhtVLdGCReqyrRLiBkXiy8ofhS3Q0B8ul2Qc
 pAHsDrfvojJquK58lAfKLqjLYM8ZjFc0QhK8k9WJ7owJjnEWySUcR+mKPDyggg==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, 
	"Jiri Slaby" <jirislaby@kernel.org>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, 
	"Huacai Chen" <chenhuacai@loongson.cn>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>
References: <20260315184301.412844-1-rongrong@oss.cipunited.com>
X-Mailer: git-send-email 2.53.0
Cc: "Rong Zhang" <rongrong@oss.cipunited.com>, 
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>, 
	<linux-mips@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	"Yao Zi" <me@ziyao.cc>, "Icenowy Zheng" <uwu@icenowy.me>, 
	"Rong Zhang" <i@rong.moe>, 
	"Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 02:42:56 +0800
Message-Id: <20260315184301.412844-2-rongrong@oss.cipunited.com>
Received: from tb ([223.88.91.90]) by smtp.feishu.cn with ESMTPS; Mon, 16 Mar 2026 02:43:04 +0800
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+269b6fdb8+ed863d+vger.kernel.org+rongrong@oss.cipunited.com>
Content-Transfer-Encoding: 7bit
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
From: "Rong Zhang" <rongrong@oss.cipunited.com>
Subject: [PATCH v2 1/2] dt-bindings: serial: 8250: Add Loongson 3A4000 uart compatible
In-Reply-To: <20260315184301.412844-1-rongrong@oss.cipunited.com>

The UART controller on Loongson 3A4000 is compatible with Loongson
2K1500, which is NS16550A-compatible with an additional fractional
frequency divisor register.

Add loongson,ls3a4000-uart as compatible with loongson,ls2k1500-uart.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 73851f19330d..1d1f2a22776c 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -179,6 +179,7 @@ properties:
           - const: ns16550a
       - items:
           - enum:
+              - loongson,ls3a4000-uart
               - loongson,ls3a5000-uart
               - loongson,ls3a6000-uart
               - loongson,ls2k2000-uart
-- 
2.53.0
