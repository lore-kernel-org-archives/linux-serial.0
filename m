Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8393262A6;
	Mon, 22 Sep 2025 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545612; cv=pass; b=XLle4kDGqqoygqGRDtuLk3qzFiZcXU1l4nEll9I7VvcRvHUL4ks2Gy9CzR4hzVZjcxTDhkqUg9opke2QZI0Wpc7HkPKI+89Bv2dVAb94olO+I7hoZfxajwwX4OIWYOJ5M4dvjF2iKk8PWnOM6WMeSaVRg+DH97SFsXuJH4rPzjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545612; c=relaxed/simple;
	bh=eOipe/Sn3bAQRsqRp8QLAdpWF4T4V+UpWtlRriazdjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mGzYrxAcAurtpk76zxiGEv9RbrmhTuf/u18uyy2rJI8cvfhEVunWZF29cGgPHVsGCNjf6k4ckQzTRHYJSh95dp2KklPW5Q5LuhlL8X+DgPW9rl7G0hLYm/SdkaUgUrxrcSVbYoSSlaZYz/8cWzqBEdBIO7lbdmjLItiOQJx1ZYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=GUXI1k19; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="GUXI1k19"
ARC-Seal: i=1; a=rsa-sha256; t=1758545593; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jgY/nh+y15BHifMIdd/REVh/xjQfAOjh4Euxvg9/japqnXrHsMFjJNtmY4kbR5VViIS+WFg6NnwmEzGlznKr5ltLFMAne/yx/x/ju0PwFJ9xkOf2K+jU+9utYmHc2UK+BgQc4Xdj4uIs/XBty6AEjKzjdE8G0opFt3CoznNnkFs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758545593; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AzPN14CQDR7GdRQ0bhai+yzKrO6MX8eixNS0CyDzQSw=; 
	b=KOSj9WRsa1UXmbZ+G76dUmSTYlLLOKHu9hy7llxigbXpFPyvNxBLp0G9ftJo/e/owcZsunNu6nRwRJyPx9ZTzqR9/oULRtFfgNtsJq4d+2iu+36PzA0cQZa5ceX/AXEZaZglnGq1s6vplcQ0QFDd1CNqc3MgJA8DKStWkTTAxJ8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758545593;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=AzPN14CQDR7GdRQ0bhai+yzKrO6MX8eixNS0CyDzQSw=;
	b=GUXI1k19F4CAQyVtn64CvRfK8Tjy3w0yvT/1MVsjJ/+RV6idbXtv9zwa16/GN9l8
	4w2Q0g+kqx70qgZdpDzaPhkjULwe6DHSPKDiJvQy5cxcSf+fr6lUUGMvKrKyz87+W3Q
	awwpI+BOFAAfCZK18ASby90kbp4x2VIrCu4NcU3g=
Received: by mx.zohomail.com with SMTPS id 1758545590809698.9443345062982;
	Mon, 22 Sep 2025 05:53:10 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 22 Sep 2025 20:46:34 +0800
Subject: [PATCH v2 04/11] dt-bindings: timer: Add Anlogic DR1V90 CLINT
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-dr1v90-basic-dt-v2-4-64d28500cb37@pigmoral.tech>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758545232; l=942;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=eOipe/Sn3bAQRsqRp8QLAdpWF4T4V+UpWtlRriazdjQ=;
 b=CrY8cXYflx/6y2PKSggRYQ10ZFL6WXY+/pfriid5c3ignGpySBP7LjeTaLHr7VKhMr5ZYQqQo
 P162LLEh9+/Act4TqmuC1+o9dlar3XlU9f6OyiTSEWNmSzvsA6BCnU2
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

Add CLINT support for Anlogic DR1V90.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index d85a1a088b35dabc0aa202475b926302705c4cf1..16b8c0bdce82a55765046cfdc8d1f85a8dfb3912 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -29,6 +29,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - anlogic,dr1v90-clint    # Anlogic DR1V90
               - canaan,k210-clint       # Canaan Kendryte K210
               - eswin,eic7700-clint     # ESWIN EIC7700
               - sifive,fu540-c000-clint # SiFive FU540

-- 
2.51.0

