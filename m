Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A72DC78A;
	Tue, 21 Oct 2025 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039932; cv=pass; b=KD09UCldarKFmeB8UMdCv/6WwrTzIrSVCYpfle9nCo4SaGlBuqI5Jby0A56oWJZNS7abjIVq32UAC7AD8T67udOlcHj5qeiTMu1U9gj/oEKvvQ0gK042bLxEfLvY5cli5kXEcSYrFsh1ahOnrYNXj+VMUgc3NoJN7Bk2j069bJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039932; c=relaxed/simple;
	bh=vGVFGtCMw2Cq6PHj7NWFAOotdNYwXl0pGR0c3nhA58Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XgYWILwWlxQ4pRD99+1I3h4VgWvStgPp/Fh+nZ3ifqdqgG8eSTZNy2GlBCqKlWNZQ5Lxcm//ITUYjXfCbYChLMQUZjDHauUW0HEzZJEU5L6x+h40hao79IQGbdqLwi7P4e0RD1laAU26pce+fNx/FpDhZSjphjYbHXC1Z7LMBq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=ATJxVpFm; arc=pass smtp.client-ip=136.143.188.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="ATJxVpFm"
ARC-Seal: i=1; a=rsa-sha256; t=1761039907; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CcilNr+RvKWz+LIjGAZ2gKgra5rHTtiXYgjU3oRq0GoeZvvhoIgL1KEz/ZRMAUsZj0XjPge3D5iHyz6bKmk11WdX489pvIOnE/VcBwXkVb4D5CFgQxeZdKWWoNxZrtmrmRvUMcrqlHsoymzF2wD5d/rirGimIYhcqxUFzkGMAno=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761039907; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XeAz0aRyrxGa0E4TqGNpNqstyOLvl6ihWlA2SgMF7cI=; 
	b=fFKEDjjVO4U2XMGOKa1cd0igtw2l0T7VEP83FA9vRawh3s55EGu0uqRhO8h0IhlxdKJivY16vgEiU+aCk2upbL/f6E815HAc2xO61ODAj5RreuODPqS5xTbx23VdUxeG7T2bxK/bQinuBXTUMjR0l6ykmJObTr4nMgys9hnL2MY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761039907;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=XeAz0aRyrxGa0E4TqGNpNqstyOLvl6ihWlA2SgMF7cI=;
	b=ATJxVpFmb2kmF8vq2MHCQe5TrVjpnEgaWeKnVabiao0YoMw40lCtvwOHYwDzZBsD
	JSL1vcYrCcfJAx8cRg1gJkx69560490m1YImP1YutdO/psxWYWAaTRQfWX8DL1TXzgf
	RqhXSSGQE70GGwbsh+T1zi7CghRYkji7/MJfKZjw=
Received: by mx.zohomail.com with SMTPS id 1761039904574148.51559392405807;
	Tue, 21 Oct 2025 02:45:04 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 21 Oct 2025 17:41:40 +0800
Subject: [PATCH v3 05/13] dt-bindings: interrupt-controller: Add Anlogic
 DR1V90 ACLINT MSWI
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dr1v90-basic-dt-v3-5-5478db4f664a@pigmoral.tech>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761039846; l=1670;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=vGVFGtCMw2Cq6PHj7NWFAOotdNYwXl0pGR0c3nhA58Y=;
 b=NDgGrbY4ENxh1RD/GL6Y7DZuZPgbeqbgg+xKtjr/vkvTg38T2xaBuPn15Np/e3d+7ff3K6/aj
 uvKMokY88HGCAn2EL0w+Fw4zSX/Vfb7ZC6JEdmQb/qF6WBOXZ6EdFWv
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

Add MSWI support for Anlogic DR1V90 SoC, which uses Nuclei UX900 with a
TIMER unit compliant with the ACLINT specification.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 .../interrupt-controller/thead,c900-aclint-mswi.yaml    | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-mswi.yaml b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-mswi.yaml
index d6fb08a54167f21d454e33a1992e19b358d42dbd..62fd220e126e650e3800d8eee2a749fdbbde6108 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-mswi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-mswi.yaml
@@ -4,18 +4,23 @@
 $id: http://devicetree.org/schemas/interrupt-controller/thead,c900-aclint-mswi.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Sophgo sg2042 CLINT Machine-level Software Interrupt Device
+title: ACLINT Machine-level Software Interrupt Device
 
 maintainers:
   - Inochi Amaoto <inochiama@outlook.com>
 
 properties:
   compatible:
-    items:
-      - enum:
-          - sophgo,sg2042-aclint-mswi
-          - sophgo,sg2044-aclint-mswi
-      - const: thead,c900-aclint-mswi
+    oneOf:
+      - items:
+          - enum:
+              - sophgo,sg2042-aclint-mswi
+              - sophgo,sg2044-aclint-mswi
+          - const: thead,c900-aclint-mswi
+      - items:
+          - enum:
+              - anlogic,dr1v90-aclint-mswi
+          - const: nuclei,ux900-aclint-mswi
 
   reg:
     maxItems: 1

-- 
2.51.1

