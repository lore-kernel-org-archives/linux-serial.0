Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FACF2DC792;
	Tue,  6 Oct 2026 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310662; cv=none; b=SwBUNho4bTT8zhyeLV/U7IUnabA7Ta5PX/flxf1LA15QBQcz/smSNw/POmjVMKxN05+4kVJs7hrI8SsDdc1DuFx+bMt4DRno6EQxDroG95++ZeOC6r+vOOiqR4hNcui8MwU2ZyoBWMitE/S7FUEnDOORjPZ+rF93b6X2WYcJom8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310662; c=relaxed/simple;
	bh=sgYfUcu7GyRGgxbZhaOkxktNM/oFDer4hX5xhaurLGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tH3odawkr20m5LrJgCOSN9DbR8KTRHzJ9HyjO/GkdloHwhtNS53HauOpt4VcmuNXqsojWv6rxxcG+EYRFBW5kHL61GPBW7544RL+C3HEXlt9y9bZ1g6wOOqIocWszzGLVf49Kr/0bVBsrDYVWzIryqXefFWISLUguaYWKzpFIUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwElanHY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwElanHY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5A5BC4AF60;
	Tue,  6 Oct 2026 18:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791310662;
	bh=sgYfUcu7GyRGgxbZhaOkxktNM/oFDer4hX5xhaurLGI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fwElanHYNnfyPGagNOVh13y4hanQUvipjW55IMHO5ViMv7hH4VHNOutY3fNydrCoZ
	 9KQM6Da681uxziqnwDf7WIza9o2ZY7nvz8zOfE3YHrIFC1kXGfcfZLC0OGICX0tZS5
	 J6pW4uDyJl8Fbb1hDTQ+Jp6jKnQ8ZF3ReCvtBESBxm+JQoeVif/ZBoKrMoOtY+6f1u
	 vNFxcJVwFELqg+bs1RiiTRt+tD1YqIOl1fRcAfG8G4Lq6lTF95Bc3/xrVh4UphhVGW
	 c/Yev65PDPv3KdgAsag3KaniKNovLVJrJPvMvyxlYS1DWvDB3Fw0eOnyNQdkwaq2Ai
	 wxMObFVBbPFrw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5562CA5FED;
	Tue,  6 Oct 2026 18:17:41 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 06 Oct 2026 21:17:39 +0300
Subject: [PATCH RFC v2 01/10] dt-bindings: vendor-prefixes: Add Securifi
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-cs75xx-v2-1-b7d6e1e24d44@gmail.com>
References: <20261006-b4-cs75xx-v2-0-b7d6e1e24d44@gmail.com>
In-Reply-To: <20261006-b4-cs75xx-v2-0-b7d6e1e24d44@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791310659; l=948;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=cJwqTaoWX2eJxg+ff3KcczPwLtWrJdQ6O7AAzDuJAuA=;
 b=Vr3oBnffvK0bolCHdLxxw90SgVGlbFLam1KSdvhzvgkKBUJ3HJvoGyjNlQHfeMQfOY1Jy9SDJ
 zCA36Uk4nVTC1xQB0+Dm70VMkA7zLqQ0An8pmQ5Y6tq2tZTvgX4XFw4
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

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
index 5ddeae3a697..71e6f82a71f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1497,6 +1497,8 @@ patternProperties:
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


