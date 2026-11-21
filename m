Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795296961;
	b=Zaa8NAih/A2jaFPIqJRkH61QxsS73TwHwsfAlhJ2rr1YjNdtT96kUFXX6mdwn9nr+8GV
	 cnXEp8a9bTbtjf1Wt5z5RHCX+7RdwNPOR5IAXULnfFBOQEFL8oNB0BkFEBOrF13lOkuk1
	 Anu2ejERJZNTSVwB2Qjqx+BzctEuiVb3F4F5RSvp7HWzvn9fTiysH3tU5HvwaV5daW33L
	 rk4HCwKtcMUDZlgbA5MtSDL0+yQVxEvESiWvdgUNaX0z75ySQXh1q2hUxQlMOBr9c+dsz
	 U2WdG6lStqOT+gqqTAAEUt5DfUxV3kaq6qHjCdUK/WZxKmj4QWaOCQ4vwxcAENU7p7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296961;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vxTe7UYstr5zmWrUwGezYJ045qR2VI9dQROuNPPuSTw=;
	b=mAqU4GXtSVcOMHL+RpcKLs7XQ4oXoNb5KD9PT0pq6hsrlUWBB/HKqR7GO/vtBsVKre/8
	 ZNH2h2yqUG4U6FPX6DmDSmbp56EBj00TNMzmRcHowQ/RZmLcBQv0JQfNRMs8UoHLNKGyg
	 o/jxYT/F0mxyw4T+CmgEIbS2A3r3p7Q2h2xkwBix5qtyzsop48v2Iuy5wiDpML9zQLtGz
	 WW0Xgdq0WdmpvLNaK40PIZTDqnnhg53UTpmO+X+vHL9sRXpzoN+FPMzFkRyQt2syxlOcJ
	 3iMTnFd+WCxKVO01BP9TZ7cvPYjKOG6h3IyBpuo8YPpxoX35efLy2AiHQLpz8dgvVYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WQ1FapKF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A5F606A320;
	Sat, 21 Nov 2026 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WQ1FapKF
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795296960;
	b=nA4hgaMVXPIbWJ34MNvgKLHmBpaGnHdu8eFGHUFvEf3mCLyfEtW8VEmGG96QfOd4Frnx
	 1UikhL0oWaArt5RiYKoMcP66yyuvSfoclwD7ykoSQAPyMs2XqE9orgjbCgc53vZbCKjcv
	 xF8WEkMnxEs0njnUP4L4sc0sXEy/Twv9z2Amr7t/ma5j5X3uO2MdotUhLuzk92xJM58mG
	 F5PwEsAxglYk1RA7Fxri4VAQ6DjJ29dDqLmLDLZDpkqBzVDtn7+uOxd7yiHK0CS4bBEwD
	 eFUKoi8swU6OTpcJE5edX5405cS8XCc7nn3ImfxfVeA7fkQLdqBiPCLrW00lO/eFJhg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795296960;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vxTe7UYstr5zmWrUwGezYJ045qR2VI9dQROuNPPuSTw=;
	b=rg9SBj+zpNnSXoCYE619SqZYDcNRCP77uPEWCukU/vgvSvS+GKa2kolkLmop1lM1sJ17
	 n+AHohMBWfhmkM1iNuk44TqB6rPfOd1vXrYbaEqy80cT78xhyotIXGXOFhaB1tjz6PuvT
	 DExUIuS+mB4RNSilVbwaUgOUbEV5pYRkuDuZAekqCxo1xHqz7CdU2HFFcMjyssRn2SoqU
	 dP4X3m74PLM7nR5Sl3h58tQYXBT8ASax4kytpEQoeqCGNCnM85jSlwNycHFjbs8msSZzS
	 7p/Qn9T28J7Ab74YmzhoSjxrjoAkB2+tX8fBvI/lHYMjeEnj40zXQJXq1pFQ2TYxz5A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EC48A1F000C6;
	Sat, 21 Nov 2026 21:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795296960;
	bh=vxTe7UYstr5zmWrUwGezYJ045qR2VI9dQROuNPPuSTw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WQ1FapKFFXkrKoT9Qp7+QbBvdJ3g5dgUP3HmqzDATvEVOajIA6pnch5/OzDzdqRDv
	 ntaf+yTXp6yI0ALbt+Udu/FVklgIQd+LJu+P6FDKm79FiBvwsD3j9jPJhwuR4OcqMB
	 MGG/MzeMa5AcW1zkiQU/42kes4q08Tr1RYmHusHJMCcujLb4i3JcJcXOO8zWNexWGa
	 A6MhsyyaMfWSidAkKB7Gr/FOqIi1atJVEEnIcm9kjomKYftREDCyoeu2qEOS3xWLQI
	 n/7bWrnZVPU+y/u8CFxx2rqig4RK1z/jZpKMX28+8ZETdgU/W6AdGgeryDKOmHxdyg
	 UKQlcfHSs48Wg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 799DE4BDEC;
	Sat, 21 Nov 2026 21:35:59 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 00:35:46 +0300
Subject: [PATCH v9 01/10] dt-bindings: vendor-prefixes: Add Securifi
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
Message-Id: <20261122-b4-cs75xx-v9-1-1fc1b90bd097@gmail.com>
References: <20261122-b4-cs75xx-v9-0-1fc1b90bd097@gmail.com>
In-Reply-To: <20261122-b4-cs75xx-v9-0-1fc1b90bd097@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795296958; l=944;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=573roVKzdDYFuCfGNESYptLR9xpcGKVT07rDsXKZwOU=;
 b=qZV+7PsIoAs6rx65ELMjzNgCkSpGirEaRjILMSTf9jTg3fmA8MHitrZyiUJRwNoSlcJts6u57
 6bv24uB4uA5DJUuB9bb28Acp8yK9DTYLEUG4vxLHHIlv95HWdLryKBQ
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


