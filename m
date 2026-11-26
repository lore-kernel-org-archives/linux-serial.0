Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795696889;
	b=Jb343QUwgdcnP/H/4nk90M1wTPZqozodQz1F7MwASRHpNJ0eKq/c65++tlvYsE7J1zdl
	 cWx7WPCX0t78ppeguCHUkyurDODYBhDrtKNovk9PLTF3gKY2mL8yNHT5/V4LmW/ifNnHD
	 uvSpTk84EBZHHA2hdkMHHu53H0FkymF9qoKH2/m3PULyjCxJFmr1GMfbyFPSkYZ3Ho5R+
	 lWN+g58LW098xuNyE/5fhxDn6SbiyW0YJJozqyixGBVT9tXv1XhaGuxldLJGhksvF8ft4
	 K1qA+7nJErXtAeZ//LiLt953WEVeqfShrZ+PexFL4m8nujynoFuqslY4pNFBoz6Czwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696889;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SjpbVUORvM/BvTGUVTvdLM0c2sbh4H3tlWX7jQXZfu8=;
	b=0nIgkJeRFSCSxyQgmcKVpo6b0sLPj9v/30G9ZbWjgT06TDILexjbBA4gZjSSjmyyZ0vo
	 KGbIR+APEJ3ZclwKGfVrc7pvqPt5c0vUU8CFkY04XnhPPab1GcUfyTBnyEQs3KMIcOlZY
	 TX/96sjkesUO9T7DOJkKRo6WsMwQK39e4ajt0oSUAIgHT6wdLXQpKcyQ+YvSr3bUI9mvZ
	 XGrhujeFZe0f0jC1kyxwq+E1tyjuNSUiJmqBdSYpX4PBrkxVVqoJnk/u9YPfEWkRv9E1V
	 8Uu41cKU87vGR4hDt4c7r6utxIT+rugjkXCVB3uVbcdyTYmIWs5cV2Th0w4plDwuvOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjWcARKN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B64A606A327;
	Thu, 26 Nov 2026 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjWcARKN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795696888;
	b=B/YGZW6qt/dse5Qm44wHNb5Zy4+ayAg4ULVZC0DfEFK36Hyvoe7dnFHi+ieP4IG3dltH
	 rFCzssk/duBCbfDpvV77BSGDS8WEOLwVplkTpz0gTu8FAhOgVZ3AP94HH/3KajnKy02M7
	 v1gmeeM2w4xACwWR36ToOS07h/0hL2CS6qdrypPbexEcQzPkgawtrLn5cSTlpFukRMKQd
	 wzou6XnNKnO2PuBZiH7yK5PIRtOkdWvpNuH4bVMQ1wyxtExFK0TdmZoh9/i/+041lZoK8
	 DRXUyjwiHgS7b+p2iwjS/sSEeCLRRt2gNECPV8QwJsjh2tNpO1Af/9fzHvEdmnMWfIA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795696888;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SjpbVUORvM/BvTGUVTvdLM0c2sbh4H3tlWX7jQXZfu8=;
	b=e1pFeP/xJjiKiMOgJHojJsYuJ01dfz+VEYJVoB/DsFoH/Ip9OnJQGmLPfnn6tAl+GMhC
	 JZFOpncx47PX/4TYmB7uityhszqr632B4N5gqNLP7JQG0d0kBfFXYjUVIPoq3m2EoJwRg
	 W7JCdnsDIXyS3ZoRtXT8HV1cEaoka+mnrIi2hJKijAmwPmthMej8dgVou8zA7nl9suFws
	 NJHRMdNMkwzj2WtRdxEbwSHChyJUIONckOnhljDiyxetJQL9qryMMdwh5LMpon30eh20W
	 QK5ATOP1hfeyTt6JA8+iWVQ67+NFomUutWkpvOXD7XvOVFutxsSH6w8Oi/G+GzL8j9g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 59A8B1F000D1;
	Thu, 26 Nov 2026 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795696888;
	bh=SjpbVUORvM/BvTGUVTvdLM0c2sbh4H3tlWX7jQXZfu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CjWcARKNeEVD9vkxQCIrtJkKAAf0qNiZSUJjhIlUNJbCST+3OxmrKTuvNKOzpOgBt
	 enp6zj+cTw0EUpXqLpJlSUSEM4E87rxwauIJxUGoBrGQ2zsOGJ6npPr/9QFvSel/j5
	 dNXUJh/BEET0zZ7qU3f6SA4y4iDeiB//ZuK5jvC7SW1mDqjghbfzHYIYi2pO+EtNEV
	 CXs2mvqzG55FIdCHUuLRI9hUZadYYprXKOHQYMZeFCE5+sh52HBoPKNUdGwF4DPgy+
	 0QgQ3QeU2l09xpHBdEeTn5O/AYCuKFkOTI40SoQqoCJK9dT5Pi4aFN4vs0i0FGUJ9r
	 ygraw5M2Ehu0Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DCF3E4D4D4;
	Thu, 26 Nov 2026 12:41:16 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Thu, 26 Nov 2026 14:39:57 +0200
Subject: [PATCH 4/8] dt-bindings: timer: mediatek,timer: add mt6768
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
Message-Id: <20261126-6768-init-v1-4-abc364a2447e@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795696875; l=826;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=NGd4Hn7heos5qVJtPfP2QH/SqVPqRmKe6GXcwrzmpug=;
 b=oPyw04jky2NZuEhsSdV3OT8f3GZczlDvO+TDel/JKhmlkL8yyK3t5Q5w3hhtkmmc0JkNgmcJp
 O90A7Zt7EkyCWHzlDnB0+GfxqsFeuQoi23yUuZYtF1sdV0MFBGQbSbG
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

Add a compatible string for the mt6768 systimer that is compatible with
the mt6765.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 Documentation/devicetree/bindings/timer/mediatek,timer.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
index 337580dc77d8..6abb62145621 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
+++ b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
@@ -40,6 +40,7 @@ properties:
       # SYST Timers
       - items:
           - enum:
+              - mediatek,mt6768-timer
               - mediatek,mt7629-timer
               - mediatek,mt8183-timer
               - mediatek,mt8186-timer

-- 
2.56.1


