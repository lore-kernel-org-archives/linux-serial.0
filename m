Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19882E7F0D;
	Tue, 21 Oct 2025 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039951; cv=pass; b=NalUg8cBEsj7ViEEn+HCCCR8zzuOZXjNTnBp+VT0bRHj++sJvKyNyMA1nfBJy6uukNvQKEbc898VI6PqRiifm7AM1m+FclcJ0GXXR8AilAqOptzs8IYs0/4gILhxJF56G5hDOI5gf5+FvnsB8OJAo+pI9GRMhprDLMRXY1cNOg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039951; c=relaxed/simple;
	bh=fl5hyCXAvBdfFabZv8zxxn9xdRe/LUyyfUTfBWPaLXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oppnuPgljtvLUXe+IwJ3IbhZdl87sz+HgqIEGc24/oc/G96IXYD78BPVZuxYU0iVVBVaCjgQY2ET7Xg0Nj0506+1rLeyHH5RoOTVii3HKGKxEnj0b2c293RGs5Yx0khLFKTsa1bpTr5zCTsVH3SfRw/Qh9Z81FFPaAkRL6cMTX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=kOfFved3; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="kOfFved3"
ARC-Seal: i=1; a=rsa-sha256; t=1761039917; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KXPM+rVpOPjpUeBEDfR7+xmSetNxtfUKxpvbsPNSQZlGAcdYe2z+ch5XsJQJYFmDMBQ/L+R0FG0DB8Owy4K/uxuBPZohXOLxdyTMMyvwSNC/YReM95jY8crduwDwtS0cb9ISlPb+iWqyA5VDs1e5x4OlMRwdZA4ovwEo33Z4Csk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761039917; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Tx1F4S/ptu3BmWEn2NV0nloWcaxAiOTKuzP+EBsZYF8=; 
	b=SXFLLkNWQNpRbcPbZEG3Vo+Wuw8sGXbCVQTEmGbe4aRs/xVmdwwbCdmrN/YBqLcSDPPhOFFmIbBKz70bCtVF6NaeSk1ibjNBRuGa8+CMMVCrjIv7mF/k6C2C3aL7DFhyU6ZpZkupBNs1k2YuvTAlvJeZozCYabX4U0ryUxb1e2s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761039917;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Tx1F4S/ptu3BmWEn2NV0nloWcaxAiOTKuzP+EBsZYF8=;
	b=kOfFved3byAitNZR96TYYUcJo8tzHIzRe5kz1bg7jQwTd0ZVWXAkA/3YNRTpKIrb
	z0R7Ieka7GwuhXpBjExESFL1X6YDyW0J+8Ut2M8W61vqkyoeA4s7PmATGxMxoYASbGC
	3AhPoAcUSA2XDsvzAGO3ooJVq5teoNkSCHW6nI7s=
Received: by mx.zohomail.com with SMTPS id 1761039915364293.16697789941225;
	Tue, 21 Oct 2025 02:45:15 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 21 Oct 2025 17:41:41 +0800
Subject: [PATCH v3 06/13] dt-bindings: interrupt-controller: Add Anlogic
 DR1V90 ACLINT SSWI
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dr1v90-basic-dt-v3-6-5478db4f664a@pigmoral.tech>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761039846; l=1073;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=fl5hyCXAvBdfFabZv8zxxn9xdRe/LUyyfUTfBWPaLXQ=;
 b=2S9mRH95qJPBW6vFhIShFG2busZR/MOSiAMG3107LGqQzuoGCjUX329dm+rbjQV9el6lugf9E
 QoSLY7yDt8EBla8fG3/Z/IwoKsKP0F2jhD5q4mowyYbmr4mp+hLSlJJ
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

Add SSWI support for Anlogic DR1V90 SoC, which uses Nuclei UX900 with a
TIMER unit compliant with the ACLINT specification.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 .../bindings/interrupt-controller/thead,c900-aclint-sswi.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml
index c1ab865fcd64f1347e7eda7f538c7669f55ff906..d02c6886283af790d75357f77a714558f68bb7d1 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml
@@ -30,6 +30,10 @@ properties:
           - const: thead,c900-aclint-sswi
       - items:
           - const: mips,p8700-aclint-sswi
+      - items:
+          - enum:
+              - anlogic,dr1v90-aclint-sswi
+          - const: nuclei,ux900-aclint-sswi
 
   reg:
     maxItems: 1

-- 
2.51.1

