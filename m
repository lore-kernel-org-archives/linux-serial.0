Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67817212FB9
	for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600239; cv=none; b=Ngp4yKAlzKiee5I+0xEseWJa69wuMEJKFmN5hoQ65sUjVgGAHBaFrPvWIR0tVjDxnqEr08g4QFw1hfRtN+u/qr+BadPXFE8W2JiJD6QKm8IVUL6zwAON9U3UntSbO6iTaQCntnSQQfrudKRezOYX4pZIuLaRQmya9WZ4SXxeBiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600239; c=relaxed/simple;
	bh=51Wr1zkiqucX+TpqXj27BKYwkeF8/UGUpE90bjdstNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=PO86ayqyqKGo4rd6sJ3CaMcSybASShldH4du0aaCfiaaoZpzPBvUx+xMaK0/nS/4V94VIJW2m1TtYMbA7QffcanwH4yhqhpAa2epk4NgKa8x+WjnXqH3LeFIEjXz6ebaNZqxhLblI4Wmp0+LJNf2RbZ08jybO+GF7Epxiz/uoak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mF7WodyZ; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mF7WodyZ"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250911141709epoutp0474acc5a3dc084a094daf94162c5f46fe~kQBifCxn41989719897epoutp044
	for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 14:17:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250911141709epoutp0474acc5a3dc084a094daf94162c5f46fe~kQBifCxn41989719897epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757600229;
	bh=gwxCLnysq/NZQPnFGzZvZp4/1kftabIwqJTZB7qwRU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mF7WodyZyowez10hhvI8cicy6CHY1B60Adww3K0V99BBEK73XUhNZR6pFekA9wDIA
	 Yj26wWP9NofOwfpAqlEjE0Iuxpxf86UQtftCMaVPVgj6OUk3sHg2huSgDRIcTN+300
	 bax6Gn6n1mcnbd4qkd8DrWTFhhpSdeu5wDE2f83c=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250911141708epcas5p22807e6c6a34b138c0c4c64d03a787988~kQBhzFHJD2246622466epcas5p2j;
	Thu, 11 Sep 2025 14:17:08 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.91]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cN04M2WY1z6B9m5; Thu, 11 Sep
	2025 14:17:07 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250911141706epcas5p29ba4f0af11e3a95a9754fd6255f7b5a7~kQBf-Mj1B0880308803epcas5p2X;
	Thu, 11 Sep 2025 14:17:06 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250911141702epsmtip11ecb960ff9fecf37f2cc9d9fe3c6ac0b~kQBcbig8N0084200842epsmtip19;
	Thu, 11 Sep 2025 14:17:02 +0000 (GMT)
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
Subject: [PATCH 1/3] dt-bindings: serial: samsung: Update axis,artpec8-uart
 to use samsung,uart-fifosize
Date: Thu, 11 Sep 2025 19:46:03 +0530
Message-ID: <20250911141605.13034-2-ravi.patel@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250911141605.13034-1-ravi.patel@samsung.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250911141706epcas5p29ba4f0af11e3a95a9754fd6255f7b5a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250911141706epcas5p29ba4f0af11e3a95a9754fd6255f7b5a7
References: <20250911141605.13034-1-ravi.patel@samsung.com>
	<CGME20250911141706epcas5p29ba4f0af11e3a95a9754fd6255f7b5a7@epcas5p2.samsung.com>

Update the axis,artpec8-uart compatible such that it uses the
samsung,uart-fifosize as required property.

This is to remove the axis,artpec8-uart specific code (which is
kind of duplicated) from the driver and use the other matching
exynos8895 uart code for ARTPEC-8.

Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 1a1f991d5364..08eceaae2921 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -152,7 +152,6 @@ allOf:
           contains:
             enum:
               - apple,s5l-uart
-              - axis,artpec8-uart
               - samsung,exynos4210-uart
               - samsung,exynos5433-uart
     then:
@@ -168,6 +167,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - axis,artpec8-uart
               - google,gs101-uart
               - samsung,exynos8895-uart
     then:
--
2.17.1

