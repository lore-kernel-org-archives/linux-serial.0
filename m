Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AE913A3ED;
	Mon, 22 Sep 2025 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546100; cv=pass; b=jtlgEBK3pTHdQ0qi4/aOliv96nTB/etuA/jCtcAXm3Q807hyTsf3w+p9f8bEldEXRlyRkl1WzS3i5dCy/aP1UZG8MytrwCZvA6ATW20Xrl4xzTbEIAbkPpln1Cw+Dn+zSwC5QE6NQTNNxq81NENU8MGvAwHRYcpd9mmgmOi+WHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546100; c=relaxed/simple;
	bh=5FXdFyIr2fRFf+Ae1txoKmwxWECY148pHNFz1j152tE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PEbr6/SBgpIRPAxzt/XZ+gJC0rk/K4PbIrVcdX/esqmlV5V0HTBbt6rr5O4d49GhwerWwXW5+dG4I93NLV5nXmEBehsPugkQi/X17L4xWeLeCofMO7UkedL0cMuBbwtVPLm46oADevVMYApVjA3WWEQrrTk0KZL32g3MiakgDxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=gRRw9l79; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="gRRw9l79"
ARC-Seal: i=1; a=rsa-sha256; t=1758546062; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ICouqmTvyKcy/ch0AWJ3uHBxtEcG20RfMqSI81uN2AtkBACvQrUSc2a+WtMXMwcNNpr6y5YBoKYKBPH936ghZsh16ZMvG3hjENWqwRNFOx3HDoq3txSTlx8pOGyQbRzRztMJRkPdjfhEL7OryJUwQ6XoG6l3um7OvIN48DD5Sas=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758546062; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cMfs34T5Vja4v7ftmJgnF2ValILJIvUnI6GgN9qZHtE=; 
	b=B2RYMpNAhW13eJyVh3ywSK0/bPRuicSuAwJCe9XzIOD81KbiwPkMTRRhfA+KOotrKwy/d/+LVO2d506w4YgMe/wKjjjz3r0GS1q2w5enB0QNcBs9mW+hLn4S2jZ3GmUmwQNSZ8W3GQwPBwzoYYgfRTPxbztDdfBSFu3qmt8OJ1s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758546062;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=cMfs34T5Vja4v7ftmJgnF2ValILJIvUnI6GgN9qZHtE=;
	b=gRRw9l79CdKc1/g1du5p7nu3gyabRqPZtq43MdgQfd3ek9c7a7INwnLE2OIQlL7h
	uVrW+PzwdzpW7v4mptm9hZMNpUijo5NK9TYx1X0aMgQ0AKRpK8dzhwAHQLHE8lj1RCj
	sg/ngVcbJ7TgLWfNaTy25QTw7xLnMnbVjee2tDq0=
Received: by mx.zohomail.com with SMTPS id 1758546059371192.16620849433718;
	Mon, 22 Sep 2025 06:00:59 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 22 Sep 2025 20:46:41 +0800
Subject: [PATCH v2 11/11] MAINTAINERS: Setup support for Anlogic DR1V90 SoC
 tree
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-dr1v90-basic-dt-v2-11-64d28500cb37@pigmoral.tech>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758545232; l=1069;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=5FXdFyIr2fRFf+Ae1txoKmwxWECY148pHNFz1j152tE=;
 b=IKikTb5co2cwNgrDLxDroyXreMVTXAoHZa+CQqra3scT3SaZzrdaZa1Q1MeY0mcQp56V9YJ9N
 EfVgRbMK/4CBSfh0ZHiW5jirdnKVjs3bog/WzarlnDoxYotD+QM6oEj
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

Add myself as the maintainer of the Anlogic DR1V90 SoC tree, including
the corresponding DTS and DT bindings paths for Anlogic RISC-V-based
SoCs.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 520fb4e379a3954ff9b163bfdfda857e5c5b99d4..44b4b4f7e53c5904f6b9076f9542866292d33fce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21681,6 +21681,15 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
 F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 F:	drivers/iommu/riscv/
 
+RISC-V ANLOGIC DR1V90 SoC SUPPORT
+M:	Junhui Liu <junhui.liu@pigmoral.tech>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+T:	git https://github.com/pigmoral/linux-dr1v90
+F:	Documentation/devicetree/bindings/riscv/anlogic.yaml
+F:	arch/riscv/boot/dts/anlogic/
+N:	dr1v90
+
 RISC-V MICROCHIP FPGA SUPPORT
 M:	Conor Dooley <conor.dooley@microchip.com>
 M:	Daire McNamara <daire.mcnamara@microchip.com>

-- 
2.51.0

