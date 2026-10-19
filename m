Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F54D2DA768;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792370443; cv=none; b=Gw+ejq/CgDdbNFm4hWt0YuWIYa2dSTKeZzl3nqkfMhhErutdCvgPraXczsWOSSIdVct3NKsdvK2rD+XaiZCMu2jTKtXBqj75/Mn4+ICkoeTBKj9XcPNiCuXgpcMT9xrxVW83Ye74w44mzxGQoy96d5Ai4Oxuelp4hM7GKqRTtP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792370443; c=relaxed/simple;
	bh=jznJ0Z7RYsRj9sXHfcC1phHU7GFTQm+3wdEjEdHvxUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AMFIeSeOf2p+qkmjcA8qnyS+eMmlwqQw5Z/eXyCXUWfBW+TGD9VAfLWVXILeap6agacqQIzbf0uUbfvLXpPlp+SpZ9mErPyqkPHMcPQBG6Y9qI1OHk8+8uZY/3O+OD65bBD/hl/U8GUxKC+/VkhvtuWWQI+qaI5rNkHBPk0+lH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQd+uDF9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQd+uDF9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 449F8C2BCFD;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792370443;
	bh=jznJ0Z7RYsRj9sXHfcC1phHU7GFTQm+3wdEjEdHvxUk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NQd+uDF97j4rrMsbJpW7xxI88ff8Okb8JuHDG0H9RfGlyqhkJI4eNrFYXTkd/2iXe
	 k7nKMXFkiBFQQmPHKAyH2rSICjTTb2co+2mmZxCuPITCaPEpES8HiKuCNyCENoGYqz
	 xHN1qh+7UtFp2+LddMJ/OQJCrqVDJzE1TD+peZJ0ILUdkZOR716C0g7mg36B6Hl2D3
	 MDRc2Qwbr6fOllH3CvUL2VO0XmD8CyFwkRV8T71LWlQWJnw4gHHO03OZ7GLHNeUARS
	 lfNENZi9ki36n9Kg/HJEMQQaWLkuTlj1YXIjCwFPTAhfDzQ47irngiFvqmg1q56166
	 6W6ziEGkQYDpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F698CCF2D8;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
From: Ben Grisdale via B4 Relay <devnull+bengris32.protonmail.ch@kernel.org>
Date: Mon, 19 Oct 2026 01:39:59 +0100
Subject: [PATCH 3/8] dt-bindings: timer: mediatek,timer: Add MT8163
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-3-f2462b2d2437@protonmail.ch>
References: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
In-Reply-To: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 Ben Grisdale <bengris32@protonmail.ch>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792370441; l=938;
 i=bengris32@protonmail.ch; s=20261018; h=from:subject:message-id;
 bh=3xuTm8KVqqOy+c6wEveW1qrzh5JMWbSUP68J1edcFPE=;
 b=5xxeKM3jCTOI/3iVDXFYvJrKS+VRr9DQVdy5HzvvIIUdOf8zZbPJoalhzEb8LxpZBVaw8gLSe
 VnqCvW4kL+GAsCr+0wnFHM4Lp4LWHUWe4f6fFjCvvUctZsyKsvd/EIQ
X-Developer-Key: i=bengris32@protonmail.ch; a=ed25519;
 pk=4ewFRC2yNph/tXokHVzIDlgOA9Hxecf1AlBuD4eOnaU=
X-Endpoint-Received: by B4 Relay for bengris32@protonmail.ch/20261018 with
 auth_id=1233
X-Original-From: Ben Grisdale <bengris32@protonmail.ch>
Reply-To: bengris32@protonmail.ch

From: Ben Grisdale <bengris32@protonmail.ch>

Add a compatible string for the general purpose timer (GPT) on the
MediaTek MT8163 SoC, which is compatible with the MT6577 timer.

Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
---
 Documentation/devicetree/bindings/timer/mediatek,timer.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
index 337580dc77d8..fcf4303e1426 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
+++ b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
@@ -34,6 +34,7 @@ properties:
               - mediatek,mt7623-timer
               - mediatek,mt8127-timer
               - mediatek,mt8135-timer
+              - mediatek,mt8163-timer
               - mediatek,mt8173-timer
               - mediatek,mt8516-timer
           - const: mediatek,mt6577-timer

-- 
2.56.0


