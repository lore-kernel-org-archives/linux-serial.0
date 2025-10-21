Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135B82E7637;
	Tue, 21 Oct 2025 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039925; cv=pass; b=ZNQHhZMCDesPkuffk0sWWPL1El350ZYqrmSAlVCypoinETUItnOwBNaPLqQMp1eIl82P2wcwUwtRKSXJDPAgTntKEc79/f62L5S/CcnMxRRQc1BucqhjoogH5iGFFA+wpzq+qPyQljOMDWHeDfwvpntT+Niw0v8GiZRVdeMfX/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039925; c=relaxed/simple;
	bh=3kGr1Cc0QZvmfkpfrjnKuu3joB/2132DDmbBOQEMYJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mf18Bf29L8ZL9edklqFRTFwnE5CG5APF58cJ4BENP4rw8RvZiiu9mqGiGF51lohVSKIFUZL7ogU/byoY4wGjnKbUdOJK3CjVCwlbp/3n7L+t03iQJlJJeP7qAqf/AVPA4BDHIPzQ4BWvAD3wlunw1g4y6dPd6qjqEwqvNjAaBDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=FwuDYuVg; arc=pass smtp.client-ip=136.143.188.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="FwuDYuVg"
ARC-Seal: i=1; a=rsa-sha256; t=1761039898; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L/nwTHZCbjyMZ1Vqpb7XELvhgwzJGXGfMEs+1dW9wPA4MxGQ2q7QazEg+LghuPHAW16lzcv1py8v+pUCUy+8o3UGNGBlwGzG+qln8mStjIbzr9iL0jB8JUqlUtlvAMVtyHyxO70bLYrfFIXBD8h9QMsub3KulO5tzrZ6xgxgXwc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761039898; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AmOqVWfAgfLRDh3J46Y8FaHobM05maEtveqQQFcI/Ck=; 
	b=kPH7f6HtX2oDTbCfgPG6JhMFKbukBi7ibDoJSKKji38XIU7UbxxwGf1X+k7jYZHPVyylz+43SqDNADGkkt4U8vlCq1pfXMxn+1JS0t/96nuzWDmSMSc4QIOGooi0VVAIHJ15bofbj826CWiv0tU02M/PZ0LYL/3ebY0NQk/hT7c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761039898;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=AmOqVWfAgfLRDh3J46Y8FaHobM05maEtveqQQFcI/Ck=;
	b=FwuDYuVg/Bc5akguipAzZUuMPaMh7BpW2V7P1YpAP78+LRbmTmLjAatqNruX5V1t
	GFBVKDB0sUDyrcWfAWttnrJW/F+P93Gfg0rQ8DSkf6pxEQ61xCBRdPhZi0ICUjZzOxQ
	OFNYZ0d+fEEYUcJJZ7jWpoYvAgEUlmP19DORERbY=
Received: by mx.zohomail.com with SMTPS id 1761039896018451.7502829999422;
	Tue, 21 Oct 2025 02:44:56 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 21 Oct 2025 17:41:39 +0800
Subject: [PATCH v3 04/13] dt-bindings: interrupt-controller: Add Anlogic
 DR1V90 PLIC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dr1v90-basic-dt-v3-4-5478db4f664a@pigmoral.tech>
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
 sophgo@lists.linux.dev, linux-serial@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761039846; l=983;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=3kGr1Cc0QZvmfkpfrjnKuu3joB/2132DDmbBOQEMYJE=;
 b=oL/dw3MGWZ13QEbvWZcweHyeDNmfzMSb8YZ7uRMjG+UmepuDbMhtrMv+aMWS9MA/LWJ/84/HD
 dUhCtG0xIuFAMywNAk+MZRObB4IEAsC97etJIeGMRu1zQ+CCn1CnXn0
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

Add PLIC support for Anlogic DR1V90.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index f683d696909b9da302c53a64f6332f6251705c0d..9ebc483a05abcfcb162d9a8e4ad181ffe4c8732a 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -58,6 +58,7 @@ properties:
           - const: andestech,nceplic100
       - items:
           - enum:
+              - anlogic,dr1v90-plic
               - canaan,k210-plic
               - eswin,eic7700-plic
               - sifive,fu540-c000-plic

-- 
2.51.1

