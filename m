Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54F42DA755;
	Mon, 21 Jul 2025 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113061; cv=pass; b=g+Ips96C3ru0PEO8NcbqM0D17ee5pWKgB5lhKtlTICfvvBWlYklWiWA1O+nHhpER4XPp/hSc6qd6wCNKwI43J1GolLhA6YusDVluZ1uIJ3ChPkRvHcG86Ky5zozi83luo6NC81ystcF9xT273pxLKznQ6TyzZ4ZPWZcGSUD+8sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113061; c=relaxed/simple;
	bh=cdC+gHkr28j2ptGfilNq1eA/ICUbwZpjzhH/BVYbOhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UJYENJioqzzuDbQWq5ulRUCxF7PiOHATTihTlsT1jHD73ugmnc7k60IF2TDxXMFB9AMYQnLQW0mTZee/J47/Gfsx2RPlC8MaLVkzYPV9MKZahDrtwi8ngUIHpzUfUHhvfR+1kaLwHf/FXyF2vJR0iniGQu4u++qwjvc86J2bgkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=iGMAK2z/; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="iGMAK2z/"
ARC-Seal: i=1; a=rsa-sha256; t=1753113037; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JrgAnJPdtMlyCLy/ncZ2EGwJol7L02Y2NhPfSQqqtSbZdJIn35ZyVSwgxSMU8Y5w8AHVLlOLaDgGBDEnMSWkF0GPOhms7nEdvOFqykaxWYcplTGisTg1kYJC64mMGAPLKTw5ZV4ybNGFCookqlDtNlCSasoCBgwQvfnyg3qBhqg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753113037; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dr0pBN5+6Qa6Jv/l48HU1CzV1Gi4jM0bXP6wQ8s9ah0=; 
	b=RBJODeqZYx7zJDtvdYcl7O0JaEakRP/0bz3v4iDml9IDtXCFB73IuyT4uGU9ebfrWsdnIAOGCsAmxYtqjjBRfP5L/cz4tXrgiKQ8dRriHfN613LHz2UIAuWfQ1c2jVHA6yxaXJJgfpEU57fJuleqS66cfq8hyefLYygUe36BoLU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753113037;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=dr0pBN5+6Qa6Jv/l48HU1CzV1Gi4jM0bXP6wQ8s9ah0=;
	b=iGMAK2z/ddfvn4wqS9X+Wubw8bhjIKUlT6d7325jCx6VV1qSsLe5f2zs13g8tOQ2
	fxHXx+zdw20YKv3bR/LIZJItzawxIqk58zt/pg10dV6NHw2EbsyCOgL457cnzZ8l/1O
	m9iPPSvVHO+1c2kwr/3zKWigEaCrfWDfRBYD6Ais=
Received: by mx.zohomail.com with SMTPS id 1753113034418920.8574925901848;
	Mon, 21 Jul 2025 08:50:34 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 21 Jul 2025 23:46:08 +0800
Subject: [PATCH RFC 02/10] dt-bindings: riscv: Add Nuclei UX900 compatibles
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-dr1v90-basic-dt-v1-2-5740c5199c47@pigmoral.tech>
References: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
In-Reply-To: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753112991; l=946;
 i=junhui.liu@pigmoral.tech; s=20250507; h=from:subject:message-id;
 bh=cdC+gHkr28j2ptGfilNq1eA/ICUbwZpjzhH/BVYbOhg=;
 b=fAPwZIz/SLTjhDnmuDiXkGxPW6eDmJ/wZ25iYTmNlzRpbbjVsh8a0tgl+ExiijV4KRJtZS4zd
 MMHGM/CTd8sB4rxyUu3shUbCPjalI8VBGnNuZCKLd0e/apS6EOOInL2
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=d3i4H2mg9LUn4SQemoLAjLRQy0nTcyknIv6zgKMwiBA=
X-ZohoMailClient: External

The UX900 is a RISC-V core from Nuclei, used in the Anlogic DR1V90 SoC.
It features a 64-bit architecture and dual-issue, 9-stage pipeline, with
lots of optional extensions including V, K, Zc, and more.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 2c72f148a74b019e46ad5917a0b75d45777c385e..f198d8b1fa328f538b4a2983ca795340337fbd2b 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -47,6 +47,7 @@ properties:
               - amd,mbv32
               - andestech,ax45mp
               - canaan,k210
+              - nuclei,ux900
               - sifive,bullet0
               - sifive,e5
               - sifive,e7

-- 
2.50.1

