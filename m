Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A40288CA6;
	Mon, 22 Sep 2025 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545317; cv=pass; b=hriUEC3zxLfMWqtbyb6RKIHk4+t97DKPqukK7A8602KgORHxBBmgsVnVdc8/kZelBjzlQ1Yo8F+Ux4RCv1yU8Xxcn/VRm+je4Ka5kZLufMcRHPVJyrDjEC5sCVQL+2ujEnGR69PGrjGGxCf7Q3U0KMrh1KjEzvta1IlvhH95kNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545317; c=relaxed/simple;
	bh=zWigtbHICOHZv/MBQkLY0zNIFybRsTN993Qc0QHlYvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sv7dqX7XlBwcPXA0Wj2B5XDH8GSPZTwdimmtNs4vtTn96UpPwcc90Pypoh1nT0lfNMgTxlFzcawCFm6GDpPe3RC2ABnJjNmTZe0YzQ1JxWHJChsyUKNdFHCbYwGWk9XIV5Pb51Pw46zjNQPpV7TFPnuQv6TgVCX9kNpSUig7X58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=f3t1DDKM; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="f3t1DDKM"
ARC-Seal: i=1; a=rsa-sha256; t=1758545272; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KD2l9UbNTB4kJuy7FWLtmbAqEF0Fqd6SjGLDv0Bsp8AS9KFTlIK/Poe/OVagVViMa1NhP+yt+L1LTwl/zhKuH4MkRvAdwtzVEtgYXwIgH6IVBao5Ptar/5uKG1nYgKYg8marLznqNR3ZkNz4LuUYfz9/0Yq+pvCjMzvGEK0I6eM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758545272; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pjiKam0+mZychvVqZOK5D3a/2RehwZD3c7TXNFdrSHw=; 
	b=XWS9u+4nQqIZtlHiIE7vA7At1yU1l0Zqyvf48CiyV7PW1mFuz+Nl0sn6b1mi83zNXn5vUPwWFE/xj60QP7Ey75N5CqVQu9nNWlafzyF+eP3PSgjQZ28x7Z4HUwR8oalfnW9OhU/yZE1UGMkJoFsJu1auCVagDDG2lCyamghhtVY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758545272;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=pjiKam0+mZychvVqZOK5D3a/2RehwZD3c7TXNFdrSHw=;
	b=f3t1DDKMfV3oh+/WTJ9yjb3IgzaDDXEPd1n2/FVxdVGcs09gSw2bOinxc93n6kxX
	D2CKham5IEnNRAesVCJHPUPCsVLLSUAzvIV2gmDJux/uZ0jwW2OhH75awFCVo/bbyeM
	fivScx8y/nn8qjIh+EHPtK/rUe5FK7KPvlt1ePKE=
Received: by mx.zohomail.com with SMTPS id 1758545269617286.2755232484285;
	Mon, 22 Sep 2025 05:47:49 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 22 Sep 2025 20:46:31 +0800
Subject: [PATCH v2 01/11] dt-bindings: vendor-prefixes: Add Anlogic,
 Milianke and Nuclei
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-dr1v90-basic-dt-v2-1-64d28500cb37@pigmoral.tech>
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
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758545232; l=1663;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=zWigtbHICOHZv/MBQkLY0zNIFybRsTN993Qc0QHlYvI=;
 b=FyERTkcK2pLiMRXfyiHdLWvcmZUlu1C2UIa2m1EOtqvXI/VMzK/SpTN0dxPwXk7WBtRaKQkhP
 BIGI2fLxB6GBcaeGg/KHAPBTXohjrAfhs9khKlSrTYqqmIcVSFMFl7K
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

Add vendor prefixes for "anlogic", "milianke" and "nuclei". These are
required for describing the Milianke MLKPAI-FS01 board with DR1V90 SoC
from Anlogic, which uses a processor core designed by Nuclei.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9ec8947dfcad2fa53b2dca2ca06a63710771a600..d5071dcc3b97b9030087992e872afc7b6d36160e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -128,6 +128,8 @@ patternProperties:
     description: Anbernic
   "^andestech,.*":
     description: Andes Technology Corporation
+  "^anlogic,.*":
+    description: Shanghai Anlogic Infotech Co., Ltd.
   "^anvo,.*":
     description: Anvo-Systems Dresden GmbH
   "^aoly,.*":
@@ -985,6 +987,8 @@ patternProperties:
     description: MikroElektronika d.o.o.
   "^mikrotik,.*":
     description: MikroTik
+  "^milianke,.*":
+    description: Changzhou Milianke Electronic Technology Co., Ltd
   "^milkv,.*":
     description: MilkV Technology Co., Ltd
   "^miniand,.*":
@@ -1100,6 +1104,8 @@ patternProperties:
     description: Novatek
   "^novtech,.*":
     description: NovTech, Inc.
+  "^nuclei,.*":
+    description: Nuclei System Technology
   "^numonyx,.*":
     description: Numonyx (deprecated, use micron)
     deprecated: true

-- 
2.51.0

