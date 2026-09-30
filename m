Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD65B4483BE;
	Wed, 30 Sep 2026 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751603; cv=none; b=taxOQkmxNEfkoC0dmb8gA13R59x3oUy0xITBQ/PzEqMDrH/Knad6xrWHkMSI93YA4qn0JP0EgI/zBoQsv8KSPlIAJm7aH5NN/9R300qv9A8LytLzpV1fDB3M48E8VSdE/VkOM9TLdPDmdYN5P1xdwbMao9H79e523nV4Ho4Y+fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751603; c=relaxed/simple;
	bh=NUXJfcLnB98X+btHAhrx+u5ORoUQZ2deYZHabr4kZB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fY0tWVki6M39/MgJK/UqHdzkuC7Qmvgf9gJDEMa/hjwaZlmjTKlTqb3YB9+zboVnnA/KE0/4JnWHqC69VCAw+2oN5puke8o5dqbGCWp08KEopx1GCebqR2aF7/DZr4u4rl2/cGCTy3iaTCBYASx06mibEQ1Y4p4iRgkzEUk7C2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkDFR8GS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkDFR8GS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A062DC4AF12;
	Wed, 30 Sep 2026 07:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790751602;
	bh=NUXJfcLnB98X+btHAhrx+u5ORoUQZ2deYZHabr4kZB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UkDFR8GSjN+PgiSJPlq8/vwir+femwPx7WtQAp8puKe/T1M/jdLbKmmTVgCP9NAMZ
	 34tODwzhL659wWlifePExd/Quu91Se8jyyWCNQfKXtsEztwmBDDttyD3OiXcz0GqCo
	 w6M+AsPFZpZdhrMZD5lmtyPtSDRM+pvik/K76amxcOYnQsvPxWgAFM36uLmKPfZ4/G
	 KGs5mAs5pmd+JWKUH2TZqD8bAq3ZNg0J5Vs+DthklAdPwKbR9/AfrN0s9NQsMKjzDH
	 cBGYRSmXysv0WAAa4dbBJE9hzw6FoD/syUgfj+FNkUU8KONtJWcuXWaGSCeF873Zsz
	 BOjjtfOQLeBmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1B7CA5FBB;
	Wed, 30 Sep 2026 07:00:02 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Wed, 30 Sep 2026 10:00:00 +0300
Subject: [PATCH RFC 01/10] dt-bindings: vendor-prefixes: Add Securifi
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-b4-cs75xx-v1-1-4617c4463529@gmail.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
In-Reply-To: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
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
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790751600; l=847;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=hyOvjdhPlNjoQnyIsoCU9bT3wcewUSXxEPYXQqGhmH4=;
 b=1yuqSgy/VAYx0GP8v1CH5iSUHU87XL6J8ox7FlNMLlCrSWLYhNxQdlvoJDwWopnUF1gG+bJdb
 BxEm3GlqyWPCYTdD3WqlPitcFb28VoDxQC0UEWKNdNw3YoVv5Xvtloq
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com

From: Fil Dunsky <filipp.dunsky@gmail.com>

Securifi Ltd. makes the Almond series of touchscreen Wi-Fi routers.
Add a vendor prefix for it.

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


