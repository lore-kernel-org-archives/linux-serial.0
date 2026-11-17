Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794906699;
	b=OV4L8tsL7ZiqQujnXXDuj/qfLdZvjvkLRsJUNbIqDBIcNDQGymDlg6ts/LlhSFQqSKXX
	 gqXrT2tqK/zmrG0I51zFvXAK7p1ICQFywac2ZHG3oNN9fQw3GPpRUisU+0ptA5eYWPLkz
	 r9AYHic3gJRKQ24XeyOkTMynDx92S5tg914iIan5eoDKFtA7uOhN7rtYSsIPdxfJznUwQ
	 51rhwLMkpb+vK66tLzqFwzyvJ/cVbOyxxs6VUsSjczvNapQZCjvD+jOIddai8/P/wPlk3
	 iGLZnHCWBSzR+D6jdo3Wv4mVJFRC0JDyw84UnhZuiMoRfbygGHrpDLPO/4MJt0qC4MA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906699;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NNMKqJ6UJ2dmcZEN3dlZmd+hJqSDh3rdufx7kyBbe/s=;
	b=uUg7K8r8spEaI43uqVXUzNhoXsQOQbYJaj9hdIz2bc/nR/fCMxjjw1jqx/IbNSgJjZR7
	 iNGtMqXFOT+fQgscI61Mq34wcabPUZ4qxpV+NxCMYIKc8LbCbZZ9kVT1i+9dlVmCYA2XI
	 Ux46dpc1vstHs361kZlQt2rUCrpmGYqE2LT9mUtHrtcowo3NvgnTD+6OXpht9DrfaK/tB
	 aOolGiK7AQzS0lVr1LiBaUFnMPwIdknWnnOLmRB9X7HlPQZsBINolwUi2A9Qu0WC43arD
	 v6QTm6k+w16zua+/NCkaFaCpLrREv99PDl6kTJ9InOErulgzKhUSmZiLco0mZUbSkCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAgl0hWT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBBF606A883;
	Tue, 17 Nov 2026 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAgl0hWT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794906699;
	b=oQcX0ggSbWpCl3C1hUSV3rfJmDLRgw0G6T5X324YP/n8l70oyCINZNKI3Sp20R8aaj7x
	 cZ9JdBGcWaFLnTz4dHD7u2EFI7dTzzYKzHPfQ5N6pmkNJNvphiFROJqYtgU4XThPTiD6T
	 prnm7ZBoP8G2q0mY6miF/EQ4bGKP/wt+yeoSyeNuHB2yVzy2Rr9fOXb+0i3GtV091c9xh
	 xrQSUQSjdSrRx3KELDIntRho38cBnbRiY3qqIngn3UMpBieg+fZVgQ+JnXWmSQszRQOx7
	 jPE3WGZZTV1Hy+FHfuqpVmKRPBHIqoN7Z2w2PSpEKfCEuViG0l7K0wTon1IVl9uRceQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794906699;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NNMKqJ6UJ2dmcZEN3dlZmd+hJqSDh3rdufx7kyBbe/s=;
	b=KWssRM1Ol4a1jA77+pwawQvkP3Bkxlx5iQmFJUsL9sNnKnRD3FGgtBL5H1rR3YsYVAdK
	 EmkKoHyUFL4/uiBGSN7pvDF6HbynzSjfTmPNbOHgEsWS+Mvl5VCT7glQPa5pcImapeAen
	 zu9EJ1zMM0rPqFwHOhpr9d5plRiOp8BEREwpt6lD0guLvj1aoO/IQ6QSRUlm9/r/D8kDI
	 7cz8R7bun6o261lyee6cqyMDVKDDM4jsMN3M4U8+cCvzc4W0CpWlbzrGbsGedb+mfvTax
	 OW7lvZgd0jX5JoReY9r4o9GclWqKaseo8yieRDwJOgMAoeROTyU51/RyrDTuPYPN/8w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F097A1F000C5;
	Tue, 17 Nov 2026 09:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794906699;
	bh=NNMKqJ6UJ2dmcZEN3dlZmd+hJqSDh3rdufx7kyBbe/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=aAgl0hWTf3SLHIGLcsnGNgkIH9I1I6CHe9MS9di9XtEkUvMzq+hbZmecSqM1y7vxC
	 O3B7YB2LB2S+JBIpCuUEbq8fLZysnlwKHfsuFh7toFVv6ox+pk+HYRCilupZUuOwk0
	 ePvMYFvs2cUZrBut0o0OhT+hxXe6O4tZVZ3dWCP2Ga8WZq3/MrrAddsyJS4cbcM0PG
	 nT78ETBpBnUUaDQtyS6IhgkxSOHh2EklWQ9Bx9XhGVWOFI68bCZgV19yGXd9I1Jjn7
	 ZcY5/2mMmqj27D3MbT89YZZv/ciEQeqC/csHZsJPC7UhGRSp3eWtZyH2O1KX5Pe0Ce
	 ujj20v7lRpt5A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7545E4A77F;
	Tue, 17 Nov 2026 09:11:37 +0000 (UTC)
From: Rui Cao via B4 Relay <devnull+i.udp0.com@kernel.org>
Date: Tue, 17 Nov 2026 17:11:34 +0800
Subject: [PATCH v2 4/5] dt-bindings: serial: mediatek,uart: Add MT6833
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-mt6833-base-v2-4-058a0685c40c@udp0.com>
References: <20261117-mt6833-base-v2-0-058a0685c40c@udp0.com>
In-Reply-To: <20261117-mt6833-base-v2-0-058a0685c40c@udp0.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, linux-serial@vger.kernel.org, 
 phone-devel@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>, 
 Rui Cao <i@udp0.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794906695; l=1044;
 i=i@udp0.com; s=20261107; h=from:subject:message-id;
 bh=zoWluHfjwKwOYFFQBfnTx5qN73W+HlpVvqafQNgPfPA=;
 b=eDdve851oWXnmkWyQaofzfoAylL5gfmwuRoCotgZ1xtomidX89d4PFye1wFlQr4F9h4oXxhuX
 doPhRybJD05CzSVy2ZzKIoImW47x6COPq+56AWYIaOogeUC7WpEsU02
X-Developer-Key: i=i@udp0.com; a=ed25519;
 pk=XZJKcKgnUUjjyw8KuKy7u2QeIX0JLY/L1Fxzwwje41w=
X-Endpoint-Received: by B4 Relay for i@udp0.com/20261107 with auth_id=1443
X-Original-From: Rui Cao <i@udp0.com>
Reply-To: i@udp0.com
Content-Transfer-Encoding: 7bit

From: Rui Cao <i@udp0.com>

Add MediaTek's MT6833 (Dimensity 700). Its UARTs are MT6577-compatible:
MediaTek's MT6833 device tree gives them "mediatek,mt6577-uart" alone.

Reviewed-by: Roman Vivchar <rva333@protonmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Rui Cao <i@udp0.com>
---
 Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
index 5bd8a8853ae..8fb793c3408 100644
--- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
@@ -34,6 +34,7 @@ properties:
               - mediatek,mt6779-uart
               - mediatek,mt6795-uart
               - mediatek,mt6797-uart
+              - mediatek,mt6833-uart
               - mediatek,mt6893-uart
               - mediatek,mt7622-uart
               - mediatek,mt7623-uart

-- 
Git-157)


