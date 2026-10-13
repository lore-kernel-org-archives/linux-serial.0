Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F368352032;
	Tue, 13 Oct 2026 03:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863166; cv=none; b=AJBqqC4wI62N0yi43M4oCj8+MXgh+zpWLgR8nCXJmPBr8QICxda0DsRuIokpcjhSbj1dE3UUCEAiiPjxw51bxTGmGNVcOPeeS+YRMKzCDyg266AuZ5lTZe6JB5Gil93WF94AFkG4/F1BRA4crVA8x12QUnlkqePCzgxp+V0hu9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863166; c=relaxed/simple;
	bh=FGdKrLdjAm6HnyfgClKCSC4phcR13IbYQ7jKtBJyQUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ngoh8sJFjYRdi+P9+XbnGohpDmtbooI8IE0MnA55g1q2/n5w3GJYXIh1k+UwTWiI+WMZm9PHk+nfyD8TcMyPwrLFL0BYVphe0S8LHmwsqzD4Jqhx8PE+N5cWfO07D7QcLUYoht2O+G42AF0o/HRKu3JW2bWRimAIprSudD+YzSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsylyM1n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsylyM1n"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B311C2BCFB;
	Tue, 13 Oct 2026 03:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791863165;
	bh=FGdKrLdjAm6HnyfgClKCSC4phcR13IbYQ7jKtBJyQUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HsylyM1ncl9vVVwKqURNQvY5bh1+8emEfvfTg53W4/QEUUwkFWdpnTCAcoecuyxsF
	 yaAo/v7OcyTxIEwVjVlV1j/dBjccOUxAQ8Kci6xa3NBiNSx39/62o7w1G3dWEg9xRl
	 ZCo16iU3qFL5wmqYdKG2eREmO0iBT4fTlPU0ugbqjy75MBOvrCy7UnfKYenD7w80g9
	 o9N06fWw9G2BAYWK7ox4zK5WTwxW97lvHjXMwt5HXYjU8Rs9DTBYYEK0afrqnx2ycm
	 qnnCBtRCU66Aissq3rG7/qNYFwMjLsBa0RJ0R8k/tc9HRFB+bZQKJbYcSx+oRxQaJZ
	 j+LxmS8fHGzLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DB4CA9ECF;
	Tue, 13 Oct 2026 03:46:05 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Tue, 13 Oct 2026 06:46:04 +0300
Subject: [PATCH v5 01/10] dt-bindings: vendor-prefixes: Add Securifi
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-b4-cs75xx-v5-1-4e72aa383d39@gmail.com>
References: <20261013-b4-cs75xx-v5-0-4e72aa383d39@gmail.com>
In-Reply-To: <20261013-b4-cs75xx-v5-0-4e72aa383d39@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791863163; l=944;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=xgnzc7i7xTN4fotWpFnT0TA7w9z1wGvQ4nKXVlJT/zc=;
 b=0J93C2V2/t9qoScb0amWEWnoxmjN3YXgRkbAwOqB9cVPlU8jZkxL+xOY2i/0suRrrX4USK8Ft
 1xLuA6Bu8uWBQccF64JG+Qft6fLRy7wvMwnOZYdOgunvjcuHgrEPOVX
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


