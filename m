Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB30230AAA9;
	Mon, 22 Sep 2025 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545640; cv=pass; b=IwKmEDPPU7mEv5ybxx83wuuXggnMrs8XADp+7vgIQgOCpK02ETj6q34BFn0M/sz2q2OBPz6n4JHSGAvSjRVoC7yYLFsU97lsYEQy4uwOLZwZJqU4HIl/P2/LWyHwrxX6hE0b+wBDaxPqrmluXvtYn5ip8QF/KvqQZhyF0i5Y6ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545640; c=relaxed/simple;
	bh=vTzNi32YpZGemy8v5EhSx2Au8XpMJQEe4mvK14u1WOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pKwC2KAKbFVc1PmgUUlsviPyKRalsMiu6+gzUHvK6SuUAUDI2FTHIA91CZ1ZLuLJ5KTG/GLEb5ObHuDGaU45VFhKFltBindz8sqpHCaX0aCO0yOHdwpA1/VsgH6LRJ8sqq2R0J3Nf/3vgBEy9zhfx9/hECQL70YZIiVC6r4N5BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=L0AffTpk; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="L0AffTpk"
ARC-Seal: i=1; a=rsa-sha256; t=1758545615; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LdM68dtPSTviMta+Z1Ifpn9mJoqmboHYUTOzKvrVhoswQTBJuuDxcH5JG6nAkeXVOHlEKEovYgf9r4J+N88/3RdanGVmNE//I52ePq18quxgU6RYW7v8KRL0qYFDbQeElYkgp1HWFiNWynmDrp0OhbVQRwmxz9VDDeGQZ6c41wM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758545615; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rF2n+/erZcq5mbeYf2dZUx1CTdKHhYkYYAZkDZr4sDY=; 
	b=CvlJzpWSvOvVMxYB0HPxIkCRZxrm5skeh1q1Bz44O81j+w7fjh5zQLfPGH0pFHqp62u33iJjxxXG+UHCCRAtQUf2kIj1A+qThQogrGoFQeR1A1hVeX/XcBSL+yliC/uHcnzpPBQ924jesbNH+ndBYF5t11OBsrezGDf6T8fgGlQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758545615;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=rF2n+/erZcq5mbeYf2dZUx1CTdKHhYkYYAZkDZr4sDY=;
	b=L0AffTpkdGqML2thBic4906BAjRaKr7RuC7HwADpi96ZSrFl5PxAOqo5dA0cK9XT
	cPoC25IdJvYxsRBLui1uG3ERWWAB4mf5grOnR3HsrQj2lmAzb8cmEDKILMtPsidHXgg
	BYBeta6kfHWV+VVxCwr+cnuQIA8nMaN3yGpxMz4Y=
Received: by mx.zohomail.com with SMTPS id 1758545614133203.42447881199462;
	Mon, 22 Sep 2025 05:53:34 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 22 Sep 2025 20:46:35 +0800
Subject: [PATCH v2 05/11] dt-bindings: interrupt-controller: Add Anlogic
 DR1V90 PLIC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-dr1v90-basic-dt-v2-5-64d28500cb37@pigmoral.tech>
References: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
In-Reply-To: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Junhui Liu <junhui.liu@pigmoral.tech>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758545232; l=928;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=vTzNi32YpZGemy8v5EhSx2Au8XpMJQEe4mvK14u1WOc=;
 b=lleUVJR3dypEBu6ZXUg/5cOhLdj1W6qkJtwHNyOFCaIj+UsKmiCyqrzwp6blYYkGlbkOtMnHk
 F/7VmtzowwOCm9fhHFuNXCemnrYTiNWDPYYGhfjge8mltmh5UPXT0Yy
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

Add PLIC support for Anlogic DR1V90.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 5b827bc243011cda1fd45d739d34eca95c6e1ee2..960d45432a1d7b1042af56741053549f6a8df2cc 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -58,6 +58,7 @@ properties:
           - const: andestech,nceplic100
       - items:
           - enum:
+              - anlogic,dr1v90-plic
               - canaan,k210-plic
               - sifive,fu540-c000-plic
               - spacemit,k1-plic

-- 
2.51.0

