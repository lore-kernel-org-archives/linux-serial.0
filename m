Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794054124;
	b=xrfMthpTBwiSSZrRh+U+E0BNE9TOcxfK1iDgUTGCi0amkpVvfB8QA35FIn4CazBnDEWb
	 wXQE+XFzaMOK8FzTkpa0lbdsqYbih892myeALNDDcqN5dT4qBryLXom3r/U3S3yWm4ml0
	 fz2DDyp9+jF724Vbb9ibSxJb/yTy5nMKMkqpguEXvxzjZ3rT3AqEqhENOPYJ8qsTrSSgP
	 56TabHBUFCalhTQsZJuY94n9XhTy2+WXXcvKRFAxDOHVOXh1WEXUc2Q6I9Ktncikt6OY4
	 qh29i8WhEIMAKWq0j6r/AkPpd9Ap5cwhS0GhVlXs9qabemYXaxdBVRFiQx7nz90/TZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794054124;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iq+4RPE8xfBkVGXWnIB8K+YFPH7w7Lo6KEQ8N9HLzTs=;
	b=sxc8g7diD765jRDjgPaZGqytFRSCbZ/CF0bhyoRGcGmVMSuSecr5g5+ssot6RYJoNp9U
	 jr2hSx7pM59FJl16If8XbbuLl+8BipUWAnbjRC0KFsQUVLxmD2u2izekS0Zo4A1bO+NsI
	 iZ/EfAVs3bfWb+cjLIruZ5d65OcSrOi9zOtvA5kYOyVEKrTcCDcHq8OosXLB2JRiOUyvo
	 0iWAO0cJf5zkngfXnRexpaeeRR/FWgoNG1iPlNmBaM4d2/OSyaWge7tFDUWhd4MwM5RDQ
	 bi1ccNA+8284KKtrP0d1LCfzWz5hFo+WJogbFGZRUEHNvfQdql3Z/auLpY2V7h74KlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNd3B3A4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B23606A32E;
	Sat,  7 Nov 2026 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SNd3B3A4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794054124;
	b=n/arFKVIHv4S3V8jLEODYsSauHO3kDnBZZAyglGBUsF7+QofC7yQCOvfyx1+1V096/Uo
	 zDaSfYcRipDBia8pERZotxoBba7BJBqRodLf83HNO87ai6W6TVLrbR15pwP5WSV3BctVj
	 CBHf91tB6b4OeH7cxMX1FtyKZdviERdRZW2+hPsoxRwsEzlb9GS5Tjcb/Ec4zuSGT/dJc
	 2nSDgBzGqQdnh2Xr4NBI/XXsrb75fFyHbz40VCDP/hLXmftEa5AJXZtnNQGGpNa9p6DGV
	 6lTWow3o0XZnT2Zj5cvw6s4+1EWseunRMQlURrLztFSMGWSSXbD5U4wMy5xTJWfmACw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794054124;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=iq+4RPE8xfBkVGXWnIB8K+YFPH7w7Lo6KEQ8N9HLzTs=;
	b=brge581lxYt/QtNSYelcba8XtOpPEEUdVdNf592PktpB6tuDTTJk/Iyfsu/sL4ujU/fh
	 Y2drfn++7Tpk6Zh+FkJENIXxVFQjx3HLCLY5HzzmSatB+slXfnhm5AC+im6Vy8ClwLud1
	 dkO9o0IDCJtk/X84l+JHL3ZkStjqNWsVCFqcqd0D+B9NnA1R2HRn11d7IMhJPfZZPuXdf
	 uly/aO2mElOZiYsx9uwJeWrpBxkwP2Boy1aPGEiGBhRXkyFonB/qVfU4O+KcOt0GsBLWx
	 56FgbGoddob0R+WA68cOskrzbVy62rLfJeAh2LntknxZYZ+jHlR/U19qrHrRnw+w0bA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 69EED1F008A3;
	Sat,  7 Nov 2026 12:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794054124;
	bh=iq+4RPE8xfBkVGXWnIB8K+YFPH7w7Lo6KEQ8N9HLzTs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SNd3B3A4LqUrWO+Siuv2wt6omL2I+hovrNUDREfyLe+kbdvSymngJYlD+/9qTGGMX
	 jGSTQJCNOJ2OKQwT7e8JJeEKipBi8A6dy2S3OOQNXFu/Tm5T/+lgYYjJ5fCoy980Jw
	 SPf7e7LpEbZaZ5NGtWbtXKK+FZaLt0vFBQ+W/JEroAfntks3o8LCM6mVR/RD5UfXsM
	 HIg1PY5GXt2YcssbP5MUveP78vkkw9KmZ2YghaGV6kHS6+0L3390J/AVmLoTszhHjm
	 4dFF9gEvWEecI6TrL/I9XEnBKcVDzN/dVqDo3mWMbPny8zBIuV7apVrOO82t5fHuHW
	 oqEQEC8yds1iQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E85D347BE4;
	Sat,  7 Nov 2026 12:22:02 +0000 (UTC)
From: Rui Cao via B4 Relay <devnull+i.udp0.com@kernel.org>
Date: Sat, 07 Nov 2026 20:22:00 +0800
Subject: [PATCH 3/4] dt-bindings: serial: mediatek,uart: Add MT6833
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
Message-Id: <20261107-mt6833-base-v1-3-bda21083e9f3@udp0.com>
References: <20261107-mt6833-base-v1-0-bda21083e9f3@udp0.com>
In-Reply-To: <20261107-mt6833-base-v1-0-bda21083e9f3@udp0.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-watchdog@vger.kernel.org, linux-serial@vger.kernel.org, 
 Rui Cao <i@udp0.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794054121; l=922;
 i=i@udp0.com; s=20261107; h=from:subject:message-id;
 bh=MCmYdSBiOIw8bXy+sk2ZwCXWlI1Th2hdoYn0z9IY1kA=;
 b=hH0l5R2xfuIHSQAeZ2qg287lrnJtGDXFTbdBa2A0CTVpFX7/OhuoVWLRyB4Xm6uj09pCJm8Q3
 VbJeoSqz8CyAmk0MIi8pEyzn+nMn53mqGVYuiVNWNUIDDbIRw4dd0YM
X-Developer-Key: i=i@udp0.com; a=ed25519;
 pk=XZJKcKgnUUjjyw8KuKy7u2QeIX0JLY/L1Fxzwwje41w=
X-Endpoint-Received: by B4 Relay for i@udp0.com/20261107 with auth_id=1443
X-Original-From: Rui Cao <i@udp0.com>
Reply-To: i@udp0.com
Content-Transfer-Encoding: 7bit

From: Rui Cao <i@udp0.com>

Add MediaTek's MT6833 (Dimensity 700). Its UARTs are MT6577-compatible:
MediaTek's MT6833 device tree gives them "mediatek,mt6577-uart" alone.

Signed-off-by: Rui Cao <i@udp0.com>
---
 Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
index 5bd8a8853ae..8fb793c3408 100644
--- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
@@ -34,6 +34,7 @@ properties:
               - mediatek,mt6779-uart
               - mediatek,mt6795-uart
               - mediatek,mt6797-uart
+              - mediatek,mt6833-uart
               - mediatek,mt6893-uart
               - mediatek,mt7622-uart
               - mediatek,mt7623-uart

-- 
Git-157)


