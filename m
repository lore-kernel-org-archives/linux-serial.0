Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E30C48F03F;
	Tue, 13 Oct 2026 06:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791871564; cv=none; b=PTVRioLCT4WL/YVuQGppUgoajLDDu6wWrVoBXBdsHaVe5v0gDrRvincUhva3XRY8fBIoS+R+gUsA92jw/NOQhkZ3/MY2fLfTqCNmy7D4T8koEcj61SCT52YDyOykU/FKJPDaUMfy6YIChKz3iUZCLFizqgPNCTQUrfyvQDwm5vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791871564; c=relaxed/simple;
	bh=FGdKrLdjAm6HnyfgClKCSC4phcR13IbYQ7jKtBJyQUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ltwKt3roVXmlDRtYRUysANMoaeK4DDGdNKiG/RU2MPJaywXPRDZ7Sb3yDcah3tYj6/1DtHuXg3RVkKIwW9X0lcNQo/kAEXIWKNe2X7JRiqZM6LHJ6IXR0E2D/I/eeCkLuWpJ8snJDGIcUg0DFr7+DEErXt1VzFamUDNUumErTA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6wa4XSn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6wa4XSn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8F9DC2BCFC;
	Tue, 13 Oct 2026 06:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791871564;
	bh=FGdKrLdjAm6HnyfgClKCSC4phcR13IbYQ7jKtBJyQUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q6wa4XSnFO11KBBKPpaqIvWYAh9qENMAUtUttiHvxGbKFmeQ/IIrbsWbYe15LlxoH
	 E5afu1sZD0d4r8V0rD3i6gOXnXZGG9zfO38wq1F9ZZNtKFJV2tV7L2y7qaaLdDEj98
	 WaUNeJPiSfrIjkCLb7MI6LGFVFnXExyzO6iaU3EyBIBcRlygYYpy9j49dg9gu2s8Tn
	 fjFmsftui5hnaco1ytfrcR1AbvQGhk3hF1lJOQ31Ch7u2N/1rpEv4aEF61sRtowLXJ
	 vkSi5mQNswhuzbe1iVSyuqNO0YWlDsLSc55A95Ficvl2Uq+M+3DSlraZWQJKkgGo6O
	 z8tBHXiea2D0w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E1CCC6B09;
	Tue, 13 Oct 2026 06:06:03 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 13 Oct 2026 09:06:02 +0300
Subject: [PATCH v6 01/10] dt-bindings: vendor-prefixes: Add Securifi
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-cs75xx-v6-1-37e8f3969b7c@gmail.com>
References: <20261013-b4-cs75xx-v6-0-37e8f3969b7c@gmail.com>
In-Reply-To: <20261013-b4-cs75xx-v6-0-37e8f3969b7c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791871561; l=944;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=xgnzc7i7xTN4fotWpFnT0TA7w9z1wGvQ4nKXVlJT/zc=;
 b=yzkRYUQWI3fEO2TwyaICuILvVq8N3ONMeSHu6dBuJX+kA+9MeuYijqS+J99OE3f8CQOnliPb/
 A7UA9OmAWrRBN7i9sNF/C/3ccenoPVLXvfCjf2zQISIRZ4bfDVgmPjF
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
index 5ddeae3a6..71e6f82a7 100644
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


