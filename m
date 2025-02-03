Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27EA20E6F7;
	Mon,  3 Feb 2025 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738615157; cv=none; b=PAujb+9EsBYi0qdMSh3++EDckgf6SDtYfaU3bPptedwQQs1mWxfEm1KOhP+kpbaNVVCqM1/uooiM6lbOBtK5/qmO7TY+J/YchUkCkG4h1bltimAoDDC4LZUFmMk48qvHnRxrVj40OF1mkR/UCLtSESLSg9U/+eneLzvSvp0vUS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738615157; c=relaxed/simple;
	bh=EzyYoUZps3zDjCcM6n577kaxIQx3hsLmnb8iBzOF4mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJb5mLdr/M0x69QkIoSvB/jczfmZi06aUgNCz3C/DesW1kJZitf8PY+R1edi193jd925AEXZoe8X2bViWBkUExKkOg7pFb6n0A7FMIKef9lzphhM0SxK6CVTZ98vpij8IxQf98wJfSqAnQuxARXHRK1VvsMPVoeVL3X3+qpIXLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=XsDdfqFu; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="XsDdfqFu"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A5BF925BE3;
	Mon,  3 Feb 2025 21:39:14 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IP7yUFp_xi-K; Mon,  3 Feb 2025 21:39:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1738615153; bh=EzyYoUZps3zDjCcM6n577kaxIQx3hsLmnb8iBzOF4mg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XsDdfqFulOHI6M/PHcABgbYQ3SwrwoGhTshDD5stfM3SdzNfJbgl/3G0eo+SLh0Av
	 rFMs9amYmUbKR+0+RgV0WIdVYN+A3cNLNdIF0w9QR2jNYvjo0uIC+EZ4qXjXs2JKHv
	 Zbh+6RhWNL4D2Bw1661OR/g1wRHix0p4DUdjSxaeDAaJdPBDb8FE0/PVrBkUlMxUVC
	 /ByKRg8eI9XM5xFlbg4r6M+cSsDTXfSt1qlNaMSoapt9EsczkZ95qlmekPI7D/wlsi
	 ywPJ38FaDHlvd3B8KZn7d78f9XKdMLzcfwkTyDd1aetLpUebhNuVKJVO2hehensIkR
	 xyKeHQ8DeR/hg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 04 Feb 2025 02:08:45 +0530
Subject: [PATCH 1/2] dt-bindings: serial: samsung: add exynos7870-uart
 compatible
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-exynos7870-uart-v1-1-06be6aa96284@disroot.org>
References: <20250204-exynos7870-uart-v1-0-06be6aa96284@disroot.org>
In-Reply-To: <20250204-exynos7870-uart-v1-0-06be6aa96284@disroot.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Sergey Lisov <sleirsgoevy@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738615135; l=1217;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=EzyYoUZps3zDjCcM6n577kaxIQx3hsLmnb8iBzOF4mg=;
 b=P9dF4R9Ip6IzJ0/AQCOHBV+sLHek/IaozMBORHpLkVhVYEa3MDZTC5084SwGH7gcBEZqwQNYx
 eEtFShn/p4fC40WE8S/qJVbJdqtXEHaWaa5gIlPjTlKSwn41ObfhTr0
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Document the compatible string for Exynos7870's UART driver. The devicetree
property samsung,uart-fifosize must be mandatory, as the driver enquires about
the FIFO sizes.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 070eba9f19d3e039090c58a82f93d02eed58ab84..e4387d504407778ffddabeb674c51c984a1179b7 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -26,6 +26,7 @@ properties:
           - samsung,s5pv210-uart
           - samsung,exynos4210-uart
           - samsung,exynos5433-uart
+          - samsung,exynos7870-uart
           - samsung,exynos850-uart
           - samsung,exynos8895-uart
       - items:
@@ -161,6 +162,7 @@ allOf:
           contains:
             enum:
               - google,gs101-uart
+              - samsung,exynos7870-uart
               - samsung,exynos8895-uart
     then:
       required:

-- 
2.48.1

