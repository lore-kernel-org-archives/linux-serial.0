Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A922DC78A;
	Tue, 21 Oct 2025 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039952; cv=pass; b=YbIOoRe8OrfsCHO9jLUnAt9/XHdn4yHjW85tnc0+BAaaw21FeXVmGjMdV3wrqGPPXrkuPBbRBo9DJ0cgMF5laudL789KggxICspkIzeijt4PT/8bC+niRMD5xKQR9YZzdNc1YeYUDljfsH2CE42sqhM9xzd/aZtQpATa2TN74nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039952; c=relaxed/simple;
	bh=qLFixdERw6/lQNqNbS7Kg6KosBChJd6vjjzVCdUNNm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l0aKxK6/cesOwAjqlQEg8EHN4M+Xzl6YDQDGzOKwx7CeF4aMoNUgBjSQRZjqp2sT6TQ3TpnOhEkXjov59fZ74d9v1EgSUf0a4+d4Hi/BxAeUNV3/dfbQoeKhUw8hFmjM84svtzPmMxjzqgPxDCaKjorQ4QNzJZmzZ+76vQ8fTSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=G/5mFZbu; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="G/5mFZbu"
ARC-Seal: i=1; a=rsa-sha256; t=1761039927; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dfhpZYKoveexamaQCVElCGaJLiTc2xrns0AMRTqOxr8+7bpkDioT6j4W/+S+AYMpT+WKdqLxxD7F0MQLWc/QQ8g6HQHiHzJ4T/jJojllfiNiimVCPxakiwbk31Pm+fXd0DiT86M2L6B4hMcXQ8peaz+Wng0Hr7KP9i4Ux+B9JG8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761039927; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3XKmOUD68v7s8B225JgJPjyUttooN2f1rFW8XAfBjsE=; 
	b=mbKP6VZKmd3C4VH0IXOJz5gHX/FhnRCllBfEX02h5F9lus+rUnv79ncUb+hId53ucgCYH1AnogdPGcshGT4/i32sugu7U1iHJFpQY6q8cKnlb/Ifrdl+VtMFnp/+Enh1JXA0GrCiTi+kI112lk2+zZkYr1XpsflzRNzEfglA8bQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761039927;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=3XKmOUD68v7s8B225JgJPjyUttooN2f1rFW8XAfBjsE=;
	b=G/5mFZbux2cR5YesIjvgQUAo1lD986wBftc5/Wmun+nocEjkWwYAwZPz3ASPtWNh
	e2Lz48nwgMSeGLwZ7aiJQfA+3bDGrCLBJl9ErkSWMVRwdb4IloIsTSfmt9/AeA/HTyL
	CNJyCqpprLWl60yEJHGZUVPdymX7+3KuoPW2MQEI=
Received: by mx.zohomail.com with SMTPS id 1761039925257369.8137969868252;
	Tue, 21 Oct 2025 02:45:25 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 21 Oct 2025 17:41:42 +0800
Subject: [PATCH v3 07/13] dt-bindings: timer: Add Anlogic DR1V90 ACLINT
 MTIMER
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dr1v90-basic-dt-v3-7-5478db4f664a@pigmoral.tech>
References: <20251021-dr1v90-basic-dt-v3-0-5478db4f664a@pigmoral.tech>
In-Reply-To: <20251021-dr1v90-basic-dt-v3-0-5478db4f664a@pigmoral.tech>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, Inochi Amaoto <inochiama@outlook.com>, 
 sophgo@lists.linux.dev, linux-serial@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761039846; l=1564;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=qLFixdERw6/lQNqNbS7Kg6KosBChJd6vjjzVCdUNNm8=;
 b=QVg+Wg0v4lyB+LuQvRbsyM+X0St+qBC6zWgPsYRjcIMc7Qpj2Rc4PoAfSdiOuqJRhG9B1Ywqf
 GEli48LJQfAAs8eXixUtp/vX2BPn7ljmxmx9h29fW/xJolvYod2Xyqu
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

Add MTIMER support for Anlogic DR1V90 SoC, which uses Nuclei UX900 with
a TIMER unit compliant with the ACLINT specification.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 .../bindings/timer/thead,c900-aclint-mtimer.yaml        | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
index 4ed30efe40525f9e70b7f1b1dda1c833b0c3a40c..cf7c82e980f674afcf59fc726742dc4f49c1a820 100644
--- a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
+++ b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
@@ -4,18 +4,23 @@
 $id: http://devicetree.org/schemas/timer/thead,c900-aclint-mtimer.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Sophgo CLINT Timer
+title: ACLINT Machine-level Timer Device
 
 maintainers:
   - Inochi Amaoto <inochiama@outlook.com>
 
 properties:
   compatible:
-    items:
-      - enum:
-          - sophgo,sg2042-aclint-mtimer
-          - sophgo,sg2044-aclint-mtimer
-      - const: thead,c900-aclint-mtimer
+    oneOf:
+      - items:
+          - enum:
+              - sophgo,sg2042-aclint-mtimer
+              - sophgo,sg2044-aclint-mtimer
+          - const: thead,c900-aclint-mtimer
+      - items:
+          - enum:
+              - anlogic,dr1v90-aclint-mtimer
+          - const: nuclei,ux900-aclint-mtimer
 
   reg:
     items:

-- 
2.51.1

