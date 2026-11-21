Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795294933;
	b=KV74U50IwfJGv9w/7Vg1DvCFeUjFDphOh68m+eFLOQBFk/hsoT/9FEpwwIXc6grN/D1/
	 nRgJBnUwoL8AspxkxL3nMm2ZO/yB/0N+tB54IRBaBB0plu9oqdQAK4qFTTn1RBxK4LAg9
	 xvS478tbpBnhQB7UdP+58zAL5QOR6kQRtMKHJs0E8JQ7iB6KwEF9CLZKZod6f4/1DKWdc
	 iMoBwRytUmou5oRbV73MALGnnIDjaV6488KG07VnlSz10Vi43ZYrnWz+SxS+bFEyj//jX
	 y0FY0mxHww7s5LkdrDk/0vGH8X8WORP1uiUNrwbVl7ZrPUsBcB7dN4GOi2zPy5V3JtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294933;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2CbMbhj1YJKeMqmSmi9IRjYMrfEw9kWn4Z0tl8AznQs=;
	b=x2BXI6oHOMdf8jyaimUcM5ARqEkJDtSiFtFzRvJDxIPrA8PU2E83zGfE50BOj/uZoxMA
	 Jyq9KGpunBrPjMMIQiFYT6Ge5xg4AWQ1NmWi1cjB0SnrmsmZslI+4tNwCnxJM39VfKr3J
	 rjNWcspnmHJCBQhKPGZ36+54v+H8FM8Te8v6db5gtryAfcS6P4N5KUeb6TTl5qeswsx60
	 PkXNNOnzyjT2j/asfyUzfowBEubJ6RwDesA7JoCjyJLOrZDKXyMXyjFjIKb+7QFXtdiXn
	 UU19OKlGLLyj5A6EE8d6nfD6pu4quO9Ny4xo9Z1oAJ2mlGMZAZNSEo5AyxmQDcbJ4Qw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Izspf0o9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11A7606A32A;
	Sat, 21 Nov 2026 21:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Izspf0o9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795294932;
	b=01Fd03i+7cbGYx5Dk2MpwL83XwBLofBZC1+8uLgZs4WI9TrL3AP3YDKn2kUZDSP6b1aW
	 OcOI2Hn/LsgLbG84W/B4+SwOZmnaK4PSc4SFsDzPi0BJ7+LNhmS+dABdUk+o7azK4ZHGS
	 3kOAcq5hCDnoeguPVmizfxainuusfseUZZjvSusx/HU8v9plkqy3LVJj9dX5RsqESKs4/
	 aW3tOxGBxD4JBXXdAVGSpgj39mLIZc+nWT7yysE/qumfqmAoahTzUtXbWgqObn10nOlwe
	 XejiHKeBHpod9YAzEm5oEBbkQpLyI+gUikwy5/nh0Pqpa4ppOYrKrB3KPW5MyXkcUnw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795294932;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2CbMbhj1YJKeMqmSmi9IRjYMrfEw9kWn4Z0tl8AznQs=;
	b=S8qJ7TJvZUXjPbFKEVhg1GXN1Nlg/UpzVfRX2kLNSVmjKB3ds/3U7fod3nA+scKppCW2
	 WJBjuf7S24yQ6n4dpdRvuX9KfL0k/gDBPMYKKTK/dj4TpLtEhBit4iuYYGyONl3rBj4e3
	 thchrqeTU1/918RnCGFdMlyH8B/tyo8noix+EDt6zEUqbdKyLz/s7cGhQZygJG4c65edN
	 fqNeMXYf9nfgQW1Fr60LlTGrRKZ0h27GfeI5CwgR/xb1OH7e6nZEJvtKoZdUIIYbxgDK3
	 l/wPv06eIF333KInbENsyYRVRdQYefR9umW3/py4cIQ4DCbi5Z1ahlTZa7fkm02UWAw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F264D1F000D0;
	Sat, 21 Nov 2026 21:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294932;
	bh=2CbMbhj1YJKeMqmSmi9IRjYMrfEw9kWn4Z0tl8AznQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Izspf0o9cXqN3/cjqmKZhouSyAvhjmeWymOitEVg5YZhSCxeeMS5z2s8g0BT4t4v6
	 RTyl2nooDkvttwtlsiiu8bryMNbANnRog+eKIfqsAihrA/09+eQKQ9Jo8RNZn+AnBy
	 szNmoYrbEbIDQDiuNmC5539MJwI+wFFmiKxPTnnjNlvUH2tQpfQFRMl+sPjCoYcZrv
	 bPTCtjiuQ538L4PzfMkE4Kpd1l6QutEbNYD2ZaSH1EUl3qzWIX0glgh1p2r0WV+5Ac
	 IEorPXu1ukACA2Vf0DsdzitZkReE+UATdjbY7gGJTjZgUAx/4559NvKUitwvXqPZ64
	 Iv1OJVdJqpljw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7EABF4BDAE;
	Sat, 21 Nov 2026 21:02:11 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 00:01:48 +0300
Subject: [PATCH v8 03/10] dt-bindings: arm: cpus: Add Cortina Systems
 CS7542 enable method
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
Message-Id: <20261122-b4-cs75xx-v8-3-5f971b0dc69c@gmail.com>
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
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795294929; l=1316;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=2pJil7R2I4RJ4Qw+FGFzoukNOQ10CC3HjRA0bSlNdco=;
 b=WlY8b9E8AdITWV+qUKiaHmWpxXDiahKt/vuDbXxTP+x0kRNjzezMHzuI9wBdYuSScDBaa9Lvy
 hay6fojvmCQCSPcllPKNpS1oKa5yqQoMA7oQl8wTuKrbmtPetVpv2Wg
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

On the CS7542 the bootloader parks the secondary Cortex-A9 core in a WFI
loop that polls a global software register and jumps to the address
found there. Add the "cortina,cs7542-smp" enable method for it and,
as with the other release-address based methods, require cpu-release-addr
to point at that register.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 96136b70d..7a394c500 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -269,6 +269,7 @@ properties:
           - brcm,bcm63138
           - brcm,bcm-nsp-smp
           - brcm,brahma-b15
+          - cortina,cs7542-smp
           - marvell,armada-375-smp
           - marvell,armada-380-smp
           - marvell,armada-390-smp
@@ -484,6 +485,7 @@ allOf:
         enable-method:
           enum:
             - spin-table
+            - cortina,cs7542-smp
             - renesas,r9a06g032-smp
       required:
         - enable-method

-- 
2.53.0


