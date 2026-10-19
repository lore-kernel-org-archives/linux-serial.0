Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F45E2D949C;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792370443; cv=none; b=af4ypz0t8UXR4a5QU5RQ3UNjLCtehnG4o56YAHOEAy8ry7HMBUzrw6V8K2ewjGctx4qXUxj4mcUfDaySVDxZdUzJylSSqn2UJXcYErzYmWkkSTz1g+Xcs/CCuWLr8yvb+/bWNrM4t/rCT8wmlLvZjcz+x9H982nvmetV9P4BCXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792370443; c=relaxed/simple;
	bh=Ul8j6b/OMgDbNJmDs3HrzxJ8CN+a8ZabmqPVjjzsVr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ptkHfzuaAQtipDKSh4ffiQScNdHDaxq6qr+UMCjBMUpXpYCJm6+jXm7UnPjKP6EFbKsj4Pw94u2okNfdrZYz8BKhENwvdiNnDGEzDCPkWHfZfy930nT0vZtn8MAy5vm5uOi0WRdvxR+a1Ys5q3AkibSazWhgH1HPStoN4LnLeeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alMLu22L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alMLu22L"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CD80C2BD00;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792370443;
	bh=Ul8j6b/OMgDbNJmDs3HrzxJ8CN+a8ZabmqPVjjzsVr8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=alMLu22LKFZ7YkTXPG7zwtua6wuvDBTNgra11qMpwXe+QW0+/x32hU0FoqWptPRCH
	 Lbxm+uFnOn2oZokv9CXVa31OlD57sFRC3eT4ONDPSs734sb80eywyNk3rwHmlJul2v
	 XI+Mla3zJChs5Gfji5YP7BaYTrq3eczlBauwiNcaS/61DDuoqnXQJOYcp33LIYP1YJ
	 GOSZPm3LIcEPFPkzXfNwz4ggox/eJ6dnaXlm9BPaLkoM8OLY2AZ5tjCWommMsBIOxT
	 3g7n5pDbPbrwcBCH2SpnNPWo7DHqHjU8vW+6DML0eEakL+HN5VUlwTCVVxzJZ+u9x2
	 u9tDtjTssy3Rg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8ABCCF2D5;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
From: Ben Grisdale via B4 Relay <devnull+bengris32.protonmail.ch@kernel.org>
Date: Mon, 19 Oct 2026 01:39:58 +0100
Subject: [PATCH 2/8] dt-bindings: interrupt-controller:
 mediatek,mt6577-sysirq: Add MT8163
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-2-f2462b2d2437@protonmail.ch>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792370441; l=1057;
 i=bengris32@protonmail.ch; s=20261018; h=from:subject:message-id;
 bh=HZvnmqsfzINWEfrRhIepftjE6COAYK/b8YuTyS5bQgM=;
 b=698Q+CEQDCJ3A6XknWlGTDX7ayPZNsO1KMPbAIxSubRinrTQ0EQaaqli2OXhKRvU6rXAPmmso
 1Nc/WpE3cMmDvpAyWejudA1XtX9HcPbCDNk8M3oW9KI3KTfX3pjkzNl
X-Developer-Key: i=bengris32@protonmail.ch; a=ed25519;
 pk=4ewFRC2yNph/tXokHVzIDlgOA9Hxecf1AlBuD4eOnaU=
X-Endpoint-Received: by B4 Relay for bengris32@protonmail.ch/20261018 with
 auth_id=1233
X-Original-From: Ben Grisdale <bengris32@protonmail.ch>
Reply-To: bengris32@protonmail.ch

From: Ben Grisdale <bengris32@protonmail.ch>

Add a compatible string for the SYSIRQ interrupt polarity controller on
the MediaTek MT8163 SoC, which is compatible with the MT6577 SYSIRQ.

Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
---
 .../devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml
index b94fc3cec175..9d2fc15fc81d 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml
@@ -36,6 +36,7 @@ properties:
               - mediatek,mt7629-sysirq
               - mediatek,mt8127-sysirq
               - mediatek,mt8135-sysirq
+              - mediatek,mt8163-sysirq
               - mediatek,mt8173-sysirq
               - mediatek,mt8183-sysirq
               - mediatek,mt8365-sysirq

-- 
2.56.0


