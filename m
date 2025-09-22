Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9F72ED164;
	Mon, 22 Sep 2025 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545719; cv=pass; b=kuUXmIb64uCV5GSQ0IB/llo+L6Ske3sWAl7tewHppVFl1eQ3jm7m0SUgmmicxMQxiiOGntPnnbPYYc2fn0QhtcksiqeS/45ecaaSjQ4Rzru+QiraXtJyJQ2q7R6eUkkwP1MdM0wFarScnTYF9NwOYZArOfLiUXT60OFVw5kCMk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545719; c=relaxed/simple;
	bh=w5ZIPq5ThjyGEwIRg/zVHH8FHcTm00gGBFVKYiZts7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kVPcQA2U+1kW4ZVoHOOJCHeDCy/JGMqyRFDuuCEn5kEFxqvqz+RlFYpvJ32NDLmDDgVXIWwjiCUVTtIm7riYXNvgbwdp1KOsm4J8s+4rCb4nfsvGE1g6wN12lGflcw6NAhCWQXZjlAsxeyrboIpI639CfocrVkIZCgEX8kiju70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=UIjM1hzx; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="UIjM1hzx"
ARC-Seal: i=1; a=rsa-sha256; t=1758545698; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=a7Pw2U8LKj/9G8q4teWsNgV6SPSFSdAiz8DXuxZ2FyrX4bTYiu+ElSygDAQ2L/pCN0oHsejIFaWqli5P/jL2zCRylTMTROpmU3xfwa9BDb/8EVJfSvXFiacfyLRlEuitwrz0YCL5KK10Z9ccmXoY509FuL5s1Oo5QdBceqPH7RY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758545698; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FbOLEW/EcCLP6dBCcpzVgADz1ZqyMz4Fw7/Be5J1D64=; 
	b=WgnLQjg/og6aPXT74FGC0vXfvmFL4jR9m+jq1ZXDVPGEdon5KBOkS9+oLduVTRfeyo8eu6s+DPRmyT8wE84X7u7sxbIPawlZEeVJpB+cc7Rqb9nLlgQLicVoDY7K8S6IkmOTonmFRMaN0Z39bihnjEatNjLPY1odTe4MFhQ0uV0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758545698;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=FbOLEW/EcCLP6dBCcpzVgADz1ZqyMz4Fw7/Be5J1D64=;
	b=UIjM1hzxYAs+CjO+7FDRlg5wt6eSmPtGP3YAawyQ1+ku9FktBXy/3b7MjXq7uPEM
	NZpKFGmUk1C9ZHKyGsJRd2Lxg5PS7QXDYgtOeMSory+dBrYP/dXR3Y+GVUaWe/pa8FU
	YcpWn5YHqZ5nK1MtepNKeoh9JUKjgCimxwZP1Yjs=
Received: by mx.zohomail.com with SMTPS id 1758545697043323.7993928359582;
	Mon, 22 Sep 2025 05:54:57 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 22 Sep 2025 20:46:37 +0800
Subject: [PATCH v2 07/11] riscv: Add Anlogic SoC famly Kconfig support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-dr1v90-basic-dt-v2-7-64d28500cb37@pigmoral.tech>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758545232; l=749;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=w5ZIPq5ThjyGEwIRg/zVHH8FHcTm00gGBFVKYiZts7w=;
 b=vY8tNb/qTUqOguwgBNQ9iWLAEtJ/gQlxPza89mMWGUgkPW0vmrfIbYzj9CrMok7NWWPg8vQtG
 cg/wvYlTE3uD2D2h1pdFY3ZMs6KrcomeQGZ8LH58RALBe+tWYBvtG5b
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

The first SoC in the Anlogic series is DR1V90, which contains a RISC-V
core from Nuclei.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 arch/riscv/Kconfig.socs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 61ceae0aa27a6fa3a91da6a46becfd96da99fd09..c1c0681f4364647477c50518725d9323922ff270 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -7,6 +7,11 @@ config ARCH_ANDES
 	help
 	  This enables support for Andes SoC platform hardware.
 
+config ARCH_ANLOGIC
+	bool "Anlogic SoCs"
+	help
+	  This enables support for Anlogic SoC platform hardware.
+
 config ARCH_MICROCHIP_POLARFIRE
 	def_bool ARCH_MICROCHIP
 

-- 
2.51.0

