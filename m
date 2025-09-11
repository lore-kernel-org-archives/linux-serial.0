Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37FA1FE46D
	for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600239; cv=none; b=UBymqq83s4maai1vtJNmIhEQZihA4+TBOktT6EdMz2s7DhND2de8g7aUyB3LQJ6SMSI+bxRxaRhOefDLtSOjqdm2eyejYn+T/PapuWDsshDfVySo6IAHLrvAXkJMEtgFctVTzi4IVbD5WzctG0GZLKrcSVIMlRlqZAtPxq4a5Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600239; c=relaxed/simple;
	bh=QAkJSSRSi/BwImwzkIxcT5GbTZk5FqYPBKjQeHAJg9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=tJh/BkDSkkjYclmYmQNkQwajZGOQ1L021jJ9TnPVcyq7xYdSHexH1T7Ipb1qyGdyEy+QIInh0VwIPerDH8R04uTC4KUAOuvT8tvO+1tkGDjV5563YE6ZVG0Nq8zTX+tySHe+a7bSb4zV7yrt4EdFO7jH3FaQfidlNzUYz5LOJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Y3XUE5wE; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y3XUE5wE"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250911141713epoutp026e9d1d04b4bb87dead13ae8982e6175d~kQBmzs9fH0368603686epoutp02u
	for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 14:17:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250911141713epoutp026e9d1d04b4bb87dead13ae8982e6175d~kQBmzs9fH0368603686epoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757600233;
	bh=Jg8MFO3EvcQCH2GMBa7esLpNK5V25mOJPytVnl79R0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y3XUE5wEkA3/opDPTwcYqxbUqa35BrKznBmAnVJS+PkmoPxis/HGSYrT/wEJ44HbF
	 D0VP4EfpFp4e6oYY2Jls8p0Miujma/+3bP8FbtwkSr8nIK1XFJZvaMrwToBvSsdw2C
	 36zc+WS8zW94Db4PdybebVkKhn7Q9FT033EgTBK4=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250911141712epcas5p36d9f96f77cbd7fc897d915f22de68fa0~kQBlhE0bP0750507505epcas5p3Y;
	Thu, 11 Sep 2025 14:17:12 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.89]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cN04R2NX1z6B9m4; Thu, 11 Sep
	2025 14:17:11 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250911141710epcas5p190bae9561e3886250c74a9e11def935b~kQBjrqDaJ0925909259epcas5p1F;
	Thu, 11 Sep 2025 14:17:10 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250911141706epsmtip127af8a1ef2bade909c2937ce4b346240~kQBgOqSyA0081400814epsmtip1h;
	Thu, 11 Sep 2025 14:17:06 +0000 (GMT)
From: Ravi Patel <ravi.patel@samsung.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jesper.nilsson@axis.com,
	lars.persson@axis.com, alim.akhtar@samsung.com, arnd@kernel.org,
	krzk@kernel.org
Cc: andriy.shevchenko@linux.intel.com, geert+renesas@glider.be,
	thierry.bultel.yh@bp.renesas.com, dianders@chromium.org,
	robert.marko@sartura.hr, schnelle@linux.ibm.com, kkartik@nvidia.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@axis.com,
	ksk4725@coasia.com, kenkim@coasia.com, smn1196@coasia.com,
	pjsin865@coasia.com, shradha.t@samsung.com, Ravi Patel
	<ravi.patel@samsung.com>
Subject: [PATCH 2/3] arm64: dts: axis: Add samsung,exynos8895-uart
 compatible for serial node
Date: Thu, 11 Sep 2025 19:46:04 +0530
Message-ID: <20250911141605.13034-3-ravi.patel@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250911141605.13034-1-ravi.patel@samsung.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250911141710epcas5p190bae9561e3886250c74a9e11def935b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250911141710epcas5p190bae9561e3886250c74a9e11def935b
References: <20250911141605.13034-1-ravi.patel@samsung.com>
	<CGME20250911141710epcas5p190bae9561e3886250c74a9e11def935b@epcas5p1.samsung.com>

Add the samsung,exynos8895-uart compatible in the serial node
and also add samsung,uart-fifosize property.

This is to remove the axis,artpec8-uart specific code (which is
kind of duplicated) from the driver and use the other matching
exynos8895 uart code for ARTPEC-8.

Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
---
 arch/arm64/boot/dts/exynos/axis/artpec8.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/axis/artpec8.dtsi b/arch/arm64/boot/dts/exynos/axis/artpec8.dtsi
index db9833297982..0f018b258b60 100644
--- a/arch/arm64/boot/dts/exynos/axis/artpec8.dtsi
+++ b/arch/arm64/boot/dts/exynos/axis/artpec8.dtsi
@@ -223,7 +223,7 @@
 		};

 		serial_0: serial@16cc0000 {
-			compatible = "axis,artpec8-uart";
+			compatible = "axis,artpec8-uart", "samsung,exynos8895-uart";
 			reg = <0x16cc0000 0x100>;
 			clocks = <&cmu_fsys CLK_GOUT_FSYS_UART0_PCLK>,
 				 <&cmu_fsys CLK_GOUT_FSYS_UART0_SCLK_UART>;
@@ -231,6 +231,7 @@
 			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&serial0_bus>;
+			samsung,uart-fifosize = <64>;
 		};
 	};

--
2.17.1

