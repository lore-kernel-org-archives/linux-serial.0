Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795696887;
	b=ZeX2XkaAxm+9y6KMLOgq4ObhhcI4mhtLlzca3dVF8+CK+MnsCAEJMpGJeh0m8HfhTDO1
	 cd8vM6tyO8dmr0iDRTYx804J6nXNxc13xDNWh9sKS/lavPv4MzgFETGRsxMirjJmnOu+M
	 rbfSZLzGVYNpZJqkOj214SeEacn7JAVZVBuTdukUv2Ax7quZ36uY4AXi+Xo0dmqLPADtK
	 oRhBq9zcgCGGLIlDmjSRZkoS1eS1/XTxR3dJBfjpsRJMTdEq0/hp3Dfk9ioAwzBQFCypL
	 qecDtwbMnOCokqYbAG2IJENDHV7KPmpCGfWIkhQiASQTu/yhD34aPhcqmJcxliCXFnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696887;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iCKfKqfEcSgcKqOdAiaJYu3UhCcBhL0bTGR7BdPsa/Q=;
	b=HsiHsoHf9kL6qPYCppNuWKjaLsEnBZsGOR2CZQoLRRzxeW1vl7d33KsLaThlzb5ISbBK
	 ZPtX5qJ2zGWVDd/KqgZM9bqWxy6j2tK/JZUu/fqfULQWN9jgEXgaMpJuQs1rBbUhDb7dL
	 W2O/Wl4E71x9RLSMWuYb4i+PPLe2lh58OKsG+ZaEk0pr2UpUASU1dLnjIvHD7dpUN4wSI
	 0bYbO9/qKMUEVYGd//s8M55TDncVXeRceiy8UdXjc8ETO8VkRgordVUveic/ty9xtji67
	 mVZVgUxIpMKmOSiAKBsPe8YSzqG86uiEau0jhYmKUpaUrqCpbHQNFEXuLxqkkg7NDAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTVIs8S1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430EA606A332;
	Thu, 26 Nov 2026 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTVIs8S1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795696886;
	b=It66clokLg0lnuOvNWunUOV7ew393fHEjirhVY3IQLJaBDDl9XiQQ/aQaIAy6SeOpR9I
	 Zqv4ysL6okrEucLgBkkuoSLZkIXRW5ZytZ09/a58k6Lbynhg0Jx0qc19mSdqG9Ut9XMtt
	 8wUnj/GK1W5p02Mz1ubkUeQ+5oO0P3C4r06sNPD7ZZXekvDdHVMWOeqavgYyhGiVYY58K
	 rXCwtLzpgH7VdGWnukJoLykcHk/CuNSck9bnNPI9BHh+PY22/juBdfqfz1lLFj1A5/ddH
	 SibF4Xh7iit5WjI2fCrrTw0dHWloETyu+OVE7f4m97VQK7pmWY54i3rG2su4DEky99Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795696886;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iCKfKqfEcSgcKqOdAiaJYu3UhCcBhL0bTGR7BdPsa/Q=;
	b=f0lOyYWA/A/U1yBxc9CY4mAsG8YwEgZcK7eCwGIygIGHefliU0WGdhjg5WDHxwUK3BdN
	 nn7l2FuxfJihTpuRN8RrdaaTpaD7YGFIj53xSFF2+H8Ea6lPrUu34H7xXJJn8BeZTJJkI
	 zXhAlQAfpCjocMBHtOB9B8/rlkqlkl/bf/JneCr1lLQwfiZQBKgnq2kQ6n+LZ+TAoRbGs
	 0AyyUR+mPr+W5cvaOi8Yk93ZwOOUU9pYPMyoeRT4nYPjm26tb00gsNO63BVLZKRd4BuEO
	 7/HxDiZGC6UIw9nuLhBreBh15GpLvacibaf0iscPm7nQEkwmB7JyAdxL2Q+s/Ur1Z2Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4896E1F000C0;
	Thu, 26 Nov 2026 12:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795696886;
	bh=iCKfKqfEcSgcKqOdAiaJYu3UhCcBhL0bTGR7BdPsa/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=fTVIs8S10kpW6+bkIj8kdGU+/wF2eEqImqy4uzAn3LXma4v9aRZMMYscYkDHqaR2r
	 uztXMP6ojHmiwoiuDNyCnIdG3ENWgLxhbzsKP69Bs1pB++jdmz/GI3Jrtx6dyKtWdO
	 eg1t8bBGrGQwE/x7EoI6zXL/TkEBhW3GFGPTLWJQZWhGAz+2XVHed9K9pWAlj6uU4y
	 PYiH+v8dq5EK5Qc9S8HhO+8M1fpsr4vMd+aJt8FHd9JQFB8Z019nPt91Eb0uj9P0W1
	 65FjgXPQdb14FAxIGpqxVhVtd34Ltalra27hFQRZrIfqSRPs62YXg/U3NlQY5zB9qL
	 yrxtK//1H8ktw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 097B54D4D8;
	Thu, 26 Nov 2026 12:41:17 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Thu, 26 Nov 2026 14:39:58 +0200
Subject: [PATCH 5/8] dt-bindings: interrupt-controller:
 mediatek,mt6577-sysirq: add mt6768
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
Message-Id: <20261126-6768-init-v1-5-abc364a2447e@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795696875; l=997;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=NEjlEwvpCFUThdt21n0P3H2O89Kx0qNg2KYVUhgnmd0=;
 b=wAXN7GgagyLD1XSHPpdPRJU8FYQLAWztuV/kO7bznioOC2Z69AnGUKf63JAAq8DjNoBhYpml1
 lgC+UFklrlPB/aNT+NKrmFLnFOvnWp1RoVRngVhAW37Q+02Wf1lWssh
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

Add a compatible string for the mt6768 sysirq that is compatible with
the mt6577.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 .../devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml
index b94fc3cec175..2c59a07b15de 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml
@@ -28,6 +28,7 @@ properties:
               - mediatek,mt6592-sysirq
               - mediatek,mt6755-sysirq
               - mediatek,mt6765-sysirq
+              - mediatek,mt6768-sysirq
               - mediatek,mt6779-sysirq
               - mediatek,mt6795-sysirq
               - mediatek,mt6797-sysirq

-- 
2.56.1


