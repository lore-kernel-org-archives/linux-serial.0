Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACC639A060;
	Mon, 12 Oct 2026 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826277; cv=none; b=opcOEN65LGDVQXZWLvnMQWqxRAYCdhzzYP3OuTmj9zFAq6VuvgcUGphdzZ+Y7fhFAgoEaBaFBSCFbhBQ4DVkCv90RCb4cE/SAmZxGj4X93VgVv/QirkCVpaF4E8ST5MD7QtNWo5ikkkTdm0AUSeEIqrVXCUV7UnxHpJJzIcXYZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826277; c=relaxed/simple;
	bh=FGdKrLdjAm6HnyfgClKCSC4phcR13IbYQ7jKtBJyQUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=riq22n4c+ttqRVUQUk8l5axWKwNlV44LVYtBomZHaNASz2vlEpdYSov4rf+7TfuMhu2UIB9cfQun3I8en9f4du0WpUw0cTec3j5OT5e0sx6GVtfrZXkkNK0sSkm/6EhZWRlitukg7FGG/kSdy3CwQdBJ59+NQMUJthlEAXfwtZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDFqDzcb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDFqDzcb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 555E9C2BCFC;
	Mon, 12 Oct 2026 17:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791826277;
	bh=FGdKrLdjAm6HnyfgClKCSC4phcR13IbYQ7jKtBJyQUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XDFqDzcb727K5va9BCMIKRhAt1J1sqfBXa0rvIPvzNHWQdRaohbstP/q8R8TDRAkD
	 mjTkkiwGLRAsTUmiiAQ0itpqQPYSBWbLCqGzZM8IQjurtbounCR7Ln6cJ6gCAc871O
	 mokvDgn0pVtFmlqTTmVPW00gdqNf/AUYYOnTLd9Bi5uR6eULFbmRwxKcPDCCnRIPw2
	 2l4/lJu4rKjnjA3Oyy/Z9Uyv295AsZuxDZJNFBgbgPd8qV1x71DvGwc6+APowTcZv7
	 rfP6ZMLEwbn+8Zx2r55eEFKYzqRXroJu8AqsqDwni8TYFWc5ShczoLJj7/E19AcyUi
	 8oH8Ze8MuugoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D90CA9ED0;
	Mon, 12 Oct 2026 17:31:17 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 12 Oct 2026 20:31:15 +0300
Subject: [PATCH v4 01/10] dt-bindings: vendor-prefixes: Add Securifi
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-b4-cs75xx-v4-1-df250d903682@gmail.com>
References: <20261012-b4-cs75xx-v4-0-df250d903682@gmail.com>
In-Reply-To: <20261012-b4-cs75xx-v4-0-df250d903682@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791826275; l=944;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=xgnzc7i7xTN4fotWpFnT0TA7w9z1wGvQ4nKXVlJT/zc=;
 b=hVSDL/W9MqlTEJ6UxujEEtPx4G+EfXwDby1xdbv2njp9D333VEk186E6O2lGNX9YvZzwYg6Ey
 NqGpj32mtp5A2NXX+UZkDnaUn38L/Ee5yetV5iABf1tQf4pTad/PCz6
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


