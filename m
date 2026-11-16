Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849486;
	b=U/J3bes8rW0YrySrE8EW4y6H5dmIyLSvDXvc9F/bOxdG2lUWbe9MdjKR3PAn6dbCaJiD
	 RjupgpFPRu8b9LB2bOC1T/XZM9rkycb+MR9qsT6m9QHNIoonfk+5HN5GJZkKK/sDPSkqE
	 ofb3gqOo4S3Yl6WG8R/dgRk7NdaW4FZT8Sd9zyXQsK8BPA75MpIJoSJP9FdxvtV6Tlxmd
	 0sjTN31uhvm10uJl1hzEc2s0EeH7TRYCFUov+/Hlgt7cQQ6QNasloC3ykP0E38AQuJ2Ia
	 yKsJO6WSqtK3G2/sh6LLH/UTzrKXuK3qBoOY6y7VMilbbmMRhNCRi6lh7kwa0mCSUvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TNUG7rH7/qSKafTA5lrT/55Jq8bN6QIZQW36YHjhTGQ=;
	b=jPkVp10HfDihXmMYa0filDv9GSakpgOzmXMfOIZ+XY8XBLkHIo09X/kxMLmy/41z/UjG
	 IxrUEzPY3jg/94n1z+B+vcf1toh9d+TUl0B7ZsdkMSCr0ldL2t7cP/p+LOwiMF+HTqZ1f
	 yuq7hwPKVX14bJSS13/oVPSpNS12f9w9hzaD0uKfm5XkeTSIxAV7UQ7wPL/moescGw/6N
	 wlFuNdDWoviZ5FoN7UfToNQaXihr/qd1FOG+SbzlLao0Lze0Qk5k3ZfYjc1UgDPpLodv6
	 TNc2oDOTPXqHYqtNHJYBQLriQdDNYbC5YP8trgpZ8So1A5pOy+v6V8efGSRYd+dKntQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QrXJ4T9r;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4775606A336
	for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 17:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4775606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QrXJ4T9r
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso38799115e9.3
        for <linux-serial@vger.kernel.org>; Mon, 16 Nov 2026 09:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794849484; x=1795454284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TNUG7rH7/qSKafTA5lrT/55Jq8bN6QIZQW36YHjhTGQ=;
        b=QrXJ4T9r/Ao3tHH/MkzuaO3Tp136m0vb9GaSkUhytslHpV80es0UA1nNfKyycEpsWI
         5yxeF0GWHXUosnXga8Dgsc4n4ldzMzs1jTD3FBP0ZftrywCfp+/KNGPqexCpJ+/BYYET
         gCxQMLhiaM6btvruFm/M47UWAAwJU77PFxnA9jhwqxj7i13Dc5eai2zpXjfOLJkaxRVx
         49chWLg6CaAbO4xYumoUvxRJvYvEToGq68H7RwkqLpTy7+lB0LraJ1cWHAeUwJiGbc81
         dpvtG257O2u/WqVcwpN5nicOlrDDkDiDRBvCR80L00QkcjccxpqwLa1U0rMFcW4DrQVE
         UkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794849484; x=1795454284;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TNUG7rH7/qSKafTA5lrT/55Jq8bN6QIZQW36YHjhTGQ=;
        b=Wrku9K/5J/Zem9B1rAiiNnojiESR9fidI7nFuUxE7jTCkOxYCKiQlpQdIe0JAFhDTF
         ZDNF2+iPY8bQU+EqaqppF3oLNdeMn2WtsAcpHKnNfGj3k1H02ndqfV4IJhFZla5VCJ80
         V68V8ELngr6cyULw2lLJaZ5sTK6yq4LC1ki12xYguCL+XnRYnK491s/bJWoiIhUr7gVw
         Sx9Dwd4ljtyPyPQ7A9Ov5sELpCy/Z4YH0re0dbGK3HebqtFng9xX8mG7IQw57QxdCjFJ
         KhhawbosZT9q7OBDXtY1KWYn/suVG7Icr8bXa+gHAcPzHI3yvNHXDXseTMszOmOT6Dkx
         zbuQ==
X-Forwarded-Encrypted: i=1; AL+hErFYjFWHgc9dR5lZP1Yz/IyA3k1xHROLBEB4ZvV76KxCAic0ErsXNOl0BgkXLTHWMu50JrieOaSeZ2PJoq4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2Q0dM83Q2w/gZizpeHBhvljVAKRqR+HaUoks4xvEpHLi2+0do
	GlgWgqIzaAO4FfmqfVrLtE10GBXxbA19zVoxjR3N9yZLLr7AAL+Xk8hdBhFR7ePkVdmIU4Al6Ch
	IZtDXo8k=
X-Gm-Gg: AYBFou2zCDeJdYkN+Q04K7jfRELidEOROOZ8A3B497zKr/n3wV4Fm5iaFz/yRhgn3hH
	XEATgFWTbKGlRavd7aMg4HFhI1lUTSDBrP5DqW1xCh/4XyQFJIQdflS4BchcAoWwWpsQgpnAQol
	ZPMrJwPMp5m2GLGzeoTFt93vY49JV5MSAtxxaGL2KiLvut8FAKAGPLnlr/HJth2jnJyR9ndlbQ1
	/fhsHFjqIsBFWzifPwJkXyrTgMZCCOS6v44swrknrnsGTB0rI4Ns/ppPgMU1ghZcLYuDBkf9kkE
	Ud2LoURNH6AMsgT5c8izuL6lh1WYOX6uWjdBtd97zGNoCZc6R3R3rPQ9yR/MjqfiL/1Sz1nWOIQ
	15+FALJHV1sa073uKxSC7hnWT5bI85i9vFNxTASbWbf38mPCh63oBrmsccZrxZlX+pdg0/+2J4C
	HK4+luglXhxRizxJ9rreKkZEf7KK56gigW90VO2EBahlNxICHbEqd9mU4YpuP3FSf2hvTimRDex
	7eAaomhmiyFrqsSf6JluU9iufJsCeElRz5VKzbqoi8SLXmn9DnWXTqcJvzMe0bKdU1FnyB/L9r4
	5cVstIES51M01c1Zwji57Ggt7geHLNhQJumY+VcNLHtIdjorXhe2ypdgCzoZ8Eye
X-Received: by 2002:a05:600c:3507:b0:4bb:68c4:2044 with SMTP id 5b1f17b1804b1-4bb68c4240fmr134923375e9.11.1794849484047;
        Mon, 16 Nov 2026 09:18:04 -0800 (PST)
Received: from localhost ([2001:861:80:deb0:b65e:146c:107f:26ed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783c255asm2418175e9.13.2026.11.16.09.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:18:03 -0800 (PST)
From: Julien Masson <jmasson@baylibre.com>
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Jiri Slaby
 <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-serial@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-kernel@vger.kernel.org, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, =?utf-8?Q?N=C3=ADcolas?= F. R.
 A. Prado
 <nfraprado@collabora.com>
Subject: [PATCH RESEND] dt-bindings: serial: mediatek,uart: Add compatible for
 MT8196
Date: Mon, 16 Nov 2026 18:18:03 +0100
Message-ID: <87zev8wv90.fsf@baylibre.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Add a compatible string for the MediaTek MT8196 Chromebook SoC,
which UART IPs are fully compatible with MT6577.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Julien Masson <jmasson@baylibre.com>
---
This patch was posted in June 2025 as part of the "Add MT8196
compatibles to bindings" series [1]. The timer and i2c patches of that
series have been applied, but this one got lost and was never picked
up. Resending it unchanged, rebased on v7.4-rc1.

[1] https://lore.kernel.org/r/20250611110800.458164-1-angelogioacchino.delr=
egno@collabora.com

 Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/=
Documentation/devicetree/bindings/serial/mediatek,uart.yaml
index 5bd8a8853ae0..bf0b1df449ee 100644
--- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
@@ -49,6 +49,7 @@ properties:
               - mediatek,mt8188-uart
               - mediatek,mt8192-uart
               - mediatek,mt8195-uart
+              - mediatek,mt8196-uart
               - mediatek,mt8365-uart
               - mediatek,mt8516-uart
           - const: mediatek,mt6577-uart
--=20
2.56.0

