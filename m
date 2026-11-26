Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795696889;
	b=Q8cY6qL9IChrR5uwlQYvl6DGIbezhdFi/VsyKveCEfq5lf/eV2wxgcE2YVa5XO5uAnu6
	 khzQml0gzMdkzPRu9VuZyWDWz8dI1hZ7q55gn0tyyI6Oqf8jb3wRc1SW7g5t1HfLJIIfE
	 taTZWzBNupGhRql2goMiLXN0KFccS4hyZnvCfxwVGxoO6uRo1xWBSkzCO8fe/71lXWF7X
	 RsEFi5og7OyaL5E28vu1OQhcIzPQkFc8z0qHUnxZASskJm8tHVjbCZBuI1VONnz2J4JIC
	 W/M11FRc5xOgXTI7vGLbu/W0WQtR+OO1JoiBjx5O4u+wFvTao9IZcQOEiTEdLkNmqzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696889;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8j16vSsyX3AB0xplGqOMKluI0qfwDJhup/OQrhGuZik=;
	b=HyHtx+CCeujv5f+HajYSDSCGiwMOdnPddDJC9JuPH2ljR+C+FZGgkyTkNVxsFDWql2An
	 VlF6LvoO0Ec0NcYtGtn33CeTx0X/yUy8lNi9GzxfLT6Ep7XtLMl0PAlgPOFGVT7OSXj6s
	 93rmP2WBNU1PVgL3ozauxxV+6EDRKSxkXhDiM4hMLOYLVTh576NdDDe9IeCvvk3Vl8+zN
	 hW9BoILCjhlYyavubiv0UPIAXrExX/Eslzfyo+PzsMth7Avsyycafi8sBpKdKgAnexIO+
	 /i8wvb/BNQeacj670P6RJhQD7SVKNY8VYHN4Njct3keMXhPVL5yfJIUWk2QAybeukTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cd3lLmvC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B664606A329;
	Thu, 26 Nov 2026 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cd3lLmvC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795696888;
	b=g2fPBvDgaPzF5gua60fZ9xvF6JPSkMItPbvMitpb3QKhCvFj2OYpFjjXJ28km9qBF7JJ
	 ulgwZOfpTy4+taO9voV1/JKrp7MpK4tkXyRNtUpMg3OXfrgOM2nCdn5Ur8mY5xks6QK6U
	 8MPhyggpyU4kSIZL67LN5GgLxXbzCHZkoP/sRBsBC7OGLnjDNiwhCckUdnhqP9QJgpS+/
	 Cilr8aJxY6mgNKsxdSNKRS93WbYDvP6w+SPMGxg9S2iyxy7aonUvPuSojhXFZ3MwXTcxL
	 czWtB8BY15rZNJgoNhbnSDx3KvVL+Fzef7ZdHvEYyBORbRvs2LlBeU1v/rTQ/ySIKZA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795696888;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8j16vSsyX3AB0xplGqOMKluI0qfwDJhup/OQrhGuZik=;
	b=Er8KFz6VQAoYOToOorRvN7YNZfq4tisAxzak7TQnEMKUo1oRJg5e5cXnJHLN9Nt/FJ1j
	 SQ4vAx1iD2Ya1ZAjyA03dua+bh/zTdykHKVCdDZkxq20RsOknDdaPwEU6XI72+4i/lK8t
	 EdbcUgVE7TktbsSYAaH9+Kzja5DwPwIsfqsr7JfpTLMcyuyExQzly+ugdGHK9yzTQQZ+B
	 OzN+QpcThvE2fmjrqc+8JaBTq03NdxGk1k8ACOr6UPP8ewD1r+50cMDkOkg9XarVKE5Y5
	 USBuJj+9GCPkUjLZogHcaldd7BXRjliolMj9UOBwRhM2xVi7Au+FolMsRuXtRq/RUWg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5297F1F000D0;
	Thu, 26 Nov 2026 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795696888;
	bh=8j16vSsyX3AB0xplGqOMKluI0qfwDJhup/OQrhGuZik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Cd3lLmvCGBoB6dM8arTvwj2Bifie7LTZwsNcR5GjG7PR1QnZf4OqlvHYqac5FkiaB
	 oavURPr7evJx6N1TuyQm7SG7Ry5iEfszC1rBwL3osEO8swZY9pRThZsiMS30mm7SHO
	 hwGFw/X8rWlWgUoli3u0NcprZ4AszQ3DfVntqSB1sRJuAzoCqcmWqEfHElhU9X3k/+
	 nmai/rmiqeFXcpKsCi5OUfytDmjYsMJr9hL4at3PuPpszul61VBhCdpF5IazmXVnmG
	 A0cXoqaSyoRs1mB6Sia4tOei/yMLku7nxgupf5TFCRYg6HR/b3GiFSm8uqnlW/6qn5
	 Bgj+La3Vsw20g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7809C4D4C1;
	Thu, 26 Nov 2026 12:41:16 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Thu, 26 Nov 2026 14:39:54 +0200
Subject: [PATCH 1/8] dt-bindings: arm: mediatek: add mt6768
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
Message-Id: <20261126-6768-init-v1-1-abc364a2447e@protonmail.com>
References: <20261126-6768-init-v1-0-abc364a2447e@protonmail.com>
In-Reply-To: <20261126-6768-init-v1-0-abc364a2447e@protonmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795696875; l=832;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=+T3AUDL+O5mAW6RfROgXyiwYY80LTqaNM47Mh38zQfE=;
 b=B3tbwQiqixOoeHwCb3U9Tf7kC2DuxVBpc4FUIiOnR5yoA+i9CgFFALnVOjc8Y0gt+C4pwvigM
 cqJ8Fr+90poDF2gy6Z0RmnHb/WV4NJ0DE9uvhzjEKKIDJJkl/KKvJ1J
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

Add Xiaomi Redmi Note 9 smartphone based on the MediaTek mt6768 SoC.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 26f096587631..37189fb177c7 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -58,6 +58,10 @@ properties:
           - enum:
               - mediatek,mt6765-evb
           - const: mediatek,mt6765
+      - items:
+          - enum:
+              - xiaomi,merlin
+          - const: mediatek,mt6768
       - items:
           - enum:
               - mediatek,mt6779-evb

-- 
2.56.1


