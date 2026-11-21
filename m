Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795294932;
	b=WowNSdyVS/Nl29dyvQ8qLKfe2zBgJa5NefQMTKXJWyL40ZUp35LQFY8bKXJ6Cp0sLIvu
	 7XibRu5HgtNcTQZjUjSoMIH1taAt9xESrqQdquYJl8rKIajhHsYebiDULBjZiMCGlh31m
	 DLDT0rr28NTWxOMkWT3ROpwpbd2GncsMiOg+n0LGCo2Sncgmljfjg4swUAyKjr48U86J9
	 +pothOihDDPc9mLx+jMxb0bKY6D1AQQNgLMRzDuMJWvoa0lL0AfSWnyKGt/H8Ywhj8CjP
	 nuNylVrlxLpCZiwC5hoGsZx14L/9QM+wmUBGBrS2pmQKXJyT1a064bzVox/8iRHH+rw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294932;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vxTe7UYstr5zmWrUwGezYJ045qR2VI9dQROuNPPuSTw=;
	b=2BN+ZtfguNtrKH1YmLUVtScYXMz/CE+x5wFODJnTABrzkDEWIqyTa36EyMtEWQUMTmkJ
	 AcQDYJdXwe41LLZT/EFgZz5eP3btFABporeHsglrn2W6a4OBbqEXl2X5DMZ6MWckVN6cW
	 IvZUIl5VWyDnX2saYIdFplb5hX1rePUe3KXDN15Zyxbt/cjj+KcQMjPdNXyqr54cPiPYX
	 jh35YfQO/xwc1HbQuiPESa83AGEcIriIVjMFCef09rdR+8iFgc2QDdfHxyzQ2cwXYjdsm
	 5/6C8/7zPudNA7u5Qz5nwDqt3cGMQW9yaJPaBQ64RaKZkWntO/3bp/epEQ45yCELITA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbLMPLtH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09ED606A320;
	Sat, 21 Nov 2026 21:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbLMPLtH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795294932;
	b=2fJnnYRw3nMEngaagJ1FjPkOSA2ItVrrIySI7tg2QbajEkg6zupwDy26XHnAF1ZB7KuO
	 zrRSvmNMyBGvm6INX5f1a3TyUZ74Sk7fJd4cepxtXALmLRZUswgOlSnjBr8pASVQ+koZh
	 DJ+IJTj/kOBVqNxZ/aHinl2HMlPtFcg8C92Xiui1pSMT5OcfaHaOfCJvjMeWnZStNBW0P
	 dLgBkqHxp3Jl2gQmm7XRwUOmer94wSTTwA1M+Awj3z3WfjuDYl7WWIxXUaJWnNaU+172+
	 unPIz1Xe1CRlkJdPGt/JvVgZDrtl9Ga9C0p6rv8g5wwgJ2iCvfnicBM5+gr+oX9Wo0Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795294932;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vxTe7UYstr5zmWrUwGezYJ045qR2VI9dQROuNPPuSTw=;
	b=t5ozOomsp7iKI3sei0aseUA74JudO4UTz2amxLLSuDn+qQ6EtCaJ6dZDnUaqwuLQV/aU
	 fKGDLfezXXfcYWw1QqOslMK3Cr/dJ2FWzKPgafx+K3WTJbkrCu9ZFxETyCmyw73LZLfWl
	 C/umzOmS1VBkh3fPEsFtxMLHiSoSOHnVUuKBlLUuD+uUfPyiKWtIREaxaxVeG1TYTPt2z
	 gxM8ARhNnpYByfTBzJBM1AbsNFWoRfsYn6OhHuGtUNVyJHHXPATvxOk6aEXDBjDRc57Ij
	 ixDhFBxN3Hhm0dPj3LCcDD9fMAmgzqCWGjdhvZNWPjnzkpsWd1+sG57GSIsFGPzo81A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BD7991F000C6;
	Sat, 21 Nov 2026 21:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294932;
	bh=vxTe7UYstr5zmWrUwGezYJ045qR2VI9dQROuNPPuSTw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QbLMPLtH3KdGFjFbfvtaqZdha1mh+Sexnyu+6xTGM97Vw0aSbkX/uaVernZFa/j7I
	 V7LKfusAYVYLLkNAWoWrdh6kD1/QCz4fVX7DObQ4wssHzFda67k3X8oxxUPrB7INSi
	 XW7KiTFxL/5KirkRnPVruewuUNMVVE/LBDiWUL7zVs1QZz46MmgS80P/D1jjcwmoXM
	 JdxvetMcMT5OJytLFDTr3LeICG5mqZlzMuypkS3+k5P+dsyns4ONqJVUNMa1rs5+xP
	 jLy5CGwabYMFz41sHjCDUq0fAp6h8yENzMkHDbnucJUmhey8j9Oo8L4Bvi2CyeKupq
	 /3+MohpCiCXTQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 49CC04BD96;
	Sat, 21 Nov 2026 21:02:11 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 00:01:46 +0300
Subject: [PATCH v8 01/10] dt-bindings: vendor-prefixes: Add Securifi
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
Message-Id: <20261122-b4-cs75xx-v8-1-5f971b0dc69c@gmail.com>
References: <20261122-b4-cs75xx-v8-0-5f971b0dc69c@gmail.com>
In-Reply-To: <20261122-b4-cs75xx-v8-0-5f971b0dc69c@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Drew Fustini <fustini@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Jason Li <jason.li@cortina-access.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795294929; l=944;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=573roVKzdDYFuCfGNESYptLR9xpcGKVT07rDsXKZwOU=;
 b=9IGSTp+UPPKwidUo+IM1fJmflAPWiRdgWJM34LaPqXfLkS6YSbKB5HlKAFo0OMxaOaa7XVoWu
 0Udkp5udGS1BN/jxVxh2g71uO3xJxvsOdXh7b0LzaCN98LWeOnK7mO2
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Securifi Ltd. makes the Almond series of touchscreen Wi-Fi routers.
Add a vendor prefix for it.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5471a06f9..f1f764ddb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1499,6 +1499,8 @@ patternProperties:
     description: SDMC Technology Co., Ltd
   "^seagate,.*":
     description: Seagate Technology PLC
+  "^securifi,.*":
+    description: Securifi Ltd.
   "^seeed,.*":
     description: Seeed Technology Co., Ltd
   "^seirobotics,.*":

-- 
2.53.0


