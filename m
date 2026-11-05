Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793888945;
	b=fbG2TFiFClVlyubP6y1wZJIQ9RVewHri96s5CuLNA15Jfr7F/V5FgeM2FcUWpHEdU/q1
	 wx6CVvHD7Kvl0hmfoftOmwyZ5DFdHhPv46cYbwrBfz237gJDUUKIofBJ25l1sAmusfUf/
	 BPUPhLrFrv0fFC3ddtCfaukrIw+uB0JzQxjfm0HAs5tb6ZOl8Zq04ob9mHk8KHZ7KM914
	 OzlBxrTcVDaKz658xxo+Hqpvqmxv4p3j+smqVxh/cdyx1s5684qMfAlECMXN/n3GwXE/W
	 NgtzWtCDqHRBqVDoKNXVuThvYhG0Bp9pxhA8QdSIXPEKfEeawcohKZbuV2TCV5lbkww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888945;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=e/ChMMTeQfEb3CPDQNx/z+/EfxozOTsC5cPmwjyqKac=;
	b=lSbfg6tFXCtgu93pDGXzu7Pe1uPaNLLF5YHx1/hv75cWxGa09gGPZ4YqcGCR3kEBLVXU
	 ZSpplNLilQKaHeEPGQrdVR3I/VESYC5m5ZH0xNwcfT2ZOp5poMKyUnI2e72Jhr0Fw1D/1
	 hftoS24J0Q349dIqY54xx4cF8IYuKhj8brOp8bpeNzjbQa8K9vjFfnbAkgZBCOx+j43M0
	 +KT9k9KLQhuZQJxlZwn9Nv+urL8FpjYNZO1ZgNyAlDcKDscT5U3Ab6/rn5MhWOONZ6950
	 g13kYEgS+wk1buYBOUYuCTqDkBSRI4ov49H+xMYdioGV9eoXBKdffXZyfBvFV+7Cesw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k43Qo7Lr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5086A606D817;
	Thu,  5 Nov 2026 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k43Qo7Lr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793888945;
	b=VOXyyYF8mG/g9gFLPlnG1kGEBr4FVLK/bHWf19NY2OLnFWM2WHSgFmzHDThaymPjHAii
	 HrSL1JX6Hwkqtvz/PpL9NOSI1mhTY/2zZqJ6HTbl7BB1PL3KLo2B9F2SB20CAa+Sl5f+J
	 sAUDa32pS9UJZWGp2iNo2KhX48+5LbDA06KrRk1Yvk5XiXoI3JYEKxHYUuxdiOsU0b2z6
	 b5PjObMKFhkyAFjKWsDd8gOz/nmwUnnK+9N/wdGhQHnjhzZkjZ+LXP5w8+sEr6GCURz2T
	 DRDy649L5pImJ1aH5g+rlg+/e7DLKKIGKU2fBSFm8beu2i146QjPUFygCmLPoH3anFA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793888945;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=e/ChMMTeQfEb3CPDQNx/z+/EfxozOTsC5cPmwjyqKac=;
	b=Inc0iasj0IZbbPgyIMJfiejGGMqocqDF7JR55PQXqJK/uL/2b2yYT0DLsVnAucKZo7Nv
	 7dqovLlETjDF7vbguX1mMymgyGiPBqWMyWNpwfPhAfsD3nPbxygClDzmHLG1VUBiLiiYA
	 /RM4xGfYsauSA35bx+JUOqhoUo871DgUT0xOn+iW2qobHwWZk4I0qVEto4coL//UK8/g/
	 kV1+XiUcFUTpEj5O/FHdwx11ObFA3wM6IdW81XjJl4V9B3jRkQzrwaFUjAp/Ni75PGGNO
	 jP9irGw0n9LvY55IJvyh65jXHyVARvgDKtF8bnctR6A+Ah7DHiDClgTblFnopRfRj+Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B520F1F00A17;
	Thu,  5 Nov 2026 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888945;
	bh=e/ChMMTeQfEb3CPDQNx/z+/EfxozOTsC5cPmwjyqKac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=k43Qo7LrWLFlQfZ76OkxWrcoa4gUc8RGLGqcUkFWi+zg0nw4Q3wUfKrYByWT2/Bi5
	 Si/3hIIWLljVdofkUP+VYbhj9zvm3SrdCcXKgCwVzrxeMPOIwsf4NqEmfAkc8pJhYE
	 7lzvOJHOLKBBrjwWoWNwn7l+sWos0H6Xnc2iQ7d1b7r8vryv8e+Nb+gj/R7bY9Z8/j
	 gWbE9TAu9aq3OGXAAFGIJYw6O0+NIHP4dV3LJcsPbYO7Z3coO10I7vHvdCPQAh4F1r
	 xpDsu/7FkogNlYMKOt+D2kLZHXR9xXtlvPQa8iyvcz6CSSQh/xaBImuxYJCsgDAT5+
	 jGLAWFMIq2fwQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4372B472BF;
	Thu,  5 Nov 2026 14:29:02 +0000 (UTC)
From: Ben Grisdale via B4 Relay <devnull+bengris32.protonmail.ch@kernel.org>
Date: Thu, 05 Nov 2026 14:28:48 +0000
Subject: [PATCH v2 3/6] dt-bindings: timer: mediatek,timer: Add MT8163
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
Message-Id: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-3-e68d7d428f99@protonmail.ch>
References: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch>
In-Reply-To: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793888941; l=1008;
 i=bengris32@protonmail.ch; s=20261018; h=from:subject:message-id;
 bh=dyVoGhC2K4A9ebVKVo2WduqTmMX5amrsOD71wWVM2cs=;
 b=OTStIQccVtbXfsOKoJMQUEM6nzxD0nG6K5+Y5Ody2l1HoHMDW8gTHIuZ23PFPnh8pwfRID2rZ
 qXSU98wrc79AoYUMRQONjXK7f+gient4R1vufxCb/2Fq/ryEZmhG9VI
X-Developer-Key: i=bengris32@protonmail.ch; a=ed25519;
 pk=4ewFRC2yNph/tXokHVzIDlgOA9Hxecf1AlBuD4eOnaU=
X-Endpoint-Received: by B4 Relay for bengris32@protonmail.ch/20261018 with
 auth_id=1233
X-Original-From: Ben Grisdale <bengris32@protonmail.ch>
Reply-To: bengris32@protonmail.ch
Content-Transfer-Encoding: 7bit

From: Ben Grisdale <bengris32@protonmail.ch>

Add a compatible string for the general purpose timer (GPT) on the
MediaTek MT8163 SoC, which is compatible with the MT6577 timer.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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


