Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853FD287507;
	Tue, 21 Oct 2025 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761085941; cv=none; b=mA47is8lCRTaABEvMY31xjsIfMssrNnox4ruI0W4oVY5Z6f8kRMuhJfpF41gU1FLe7EMNHg7+9Pw6pAUKCOfk/iqk+m8owtA8IvUAWzxtbNNEPD4Txt2c+wJkPSdIYqX5gEcliRg5Cn/1lkcQFBlcWu80f+2+vTgpTGIK4lyEGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761085941; c=relaxed/simple;
	bh=XVDN38Ce3is+BThCyx2vMfnTnnfFYvAvkgtYjiNqHaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZ8dAPwixWcq/uFloA7RDvdWLnhNLRkblZXaOMvt+79+9vN/OsCv5Tn5OSMMCooXhGUxYlWo0DAf6SkJftWtME1W2arfQot6Y91NMJVw05SnZCGsFTt17l0M5JPGjOTCKHyn23rVonjJ+nVO6JUaNxy6axMApXder+UvGP1FgeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=VP2WUpw4; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="VP2WUpw4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=NVduo6AU/bBVeWob5x7Axw4B39GBzhToTLxXRQ8b3FQ=; b=VP2WUpw4rA73g9Boh/9ywlGd3X
	6iH1hkd9+i0cC09Rf/SwrHc/NQI8jl5Hh3E5SnLyH7LV1Se5wm5T9+en4C+4e9T1eNKYZ2KioYqsZ
	QzhXgZSR/yY7SUM8rOHp4ksSqVS08BZO6CwQqclJ9b3v6UkMPF/4quBpzYtkVSA91ucdU5zSUlVuH
	h/GebZWfjwzIjYyO3EJcI5NcTbqkEeKpNdTxWiRVfUTpM7oJBkxXwBcHmxbQSP9O5VqBR/plvMdi5
	OOhKq3MqBXkmkSSVGBksdamgypN4w8rc1LDT1xUOF4Zm1TNG0qKuuxYtgb8nFN/GGlWeKGTyZDsWH
	JmadYqiQ==;
Received: from i53875b19.versanet.de ([83.135.91.25] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vBKts-0006ih-5F; Wed, 22 Oct 2025 00:32:16 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] dt-bindings: serial: snps-dw-apb-uart: Add support for rk3506
Date: Wed, 22 Oct 2025 00:32:09 +0200
Message-ID: <20251021223209.193569-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The uarts used in the RK3506 SoC are still the same dw-apb-uart compatible
type as on the SoCs that came before, so add the RK3506 to the list
of variants.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index cb9da6c97afc..7a71b58f880a 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -64,6 +64,7 @@ properties:
               - rockchip,rk3328-uart
               - rockchip,rk3368-uart
               - rockchip,rk3399-uart
+              - rockchip,rk3506-uart
               - rockchip,rk3528-uart
               - rockchip,rk3562-uart
               - rockchip,rk3568-uart
-- 
2.47.2

