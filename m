Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795273970;
	b=5Mm/cCMa+zCXRM/wOd3D42J9RyvE9EJBrLrL4cUrJkKqXuqJAn+kV/L8/0BKwgTMsUGm
	 tg//AxJZ9tqn6i2hoxLjqmec4u2/4xfszDW9mh5jsZE9W6IU8+n5qxBAoBuGxnBN/UXqr
	 Vm5iTPiE+X0TvRGfXZyVbZ2eFJwAf8O6QyAK0c1FGzztQB4nkojMk1hvDXJ9C5VNa19oA
	 OTFqp3JmeTxlPggGkQCU/E1POfyf0I34lb3flyP8Z5Fo5/LOBca6tRNlk/3pT1F445JlO
	 NyIWrEmbKYrB/zDRGao20GEulV8xAbVJQtOYtRQfs1sHNh7JrrrduosLtHSxn/YIQ5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795273970;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PA9Em9EJNg3bl7O0l0A2x9WKphOXUfHQjmPory2Sg5A=;
	b=uOaEXxnWXFktwa/CF6S6uv8nCgnYGPxUW2snvO/gpMXyLr0TzshduEElPwu1WQARWvul
	 jNKKc/iX2cbIJuBtpUuww6o+J6kNCqNg8olc0g+zD4D3bHzGrP+tyD0iVbHu7M/kI0X46
	 G9GDHclftIpW2WVzz4BDFfY2NGB/9fiiJvCTo3rrfAFWFM5VygOGHFLkJR7wV5w3tPUhT
	 rkFTXN/uTiNmo7roSjQ6QwaopHjgl5idtZ6bt9l7/a1BoeZ3jIhYdkY5shRBUMQMXKHpG
	 tU4+fkdFgS1CiIR7u998YxwEVFGOqJy6e/aJSNct8vCBZ5L0pwDjtLc68eA96Tb5NVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b71mBBdJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E4B606A32C;
	Sat, 21 Nov 2026 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b71mBBdJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795273970;
	b=qqLWgv3H6L5E8BqaErQumnlNJJQo9fhPBWt9bmDgG64UY5/XF/UDsF2ruKw8/5EPpM75
	 onm+r4p03nzhP2szzMAf7+KqRXEReum7NCZpr1CISHLm66rNU/x/78lm1YeKLDOl0/Yz2
	 m01ZFWQpeuSnu0jI+rlHTuMrHIAdt89KLgaNRwwRrf+q6QlPYsJoMIM7wx0gIPXby8lY6
	 OTA9wGVkHIYzrSHX2LoMjIWG7ImaUA0p7tSUcG1tX17cias4hIE6zMw3nn4WkUugXEe6z
	 xjWkWR6VmKbP8YAXdK4ZI2dfswdYksWi0C5rmNrDHFImd/Z7iq6A5/1Vmz2ndFBrlrw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795273970;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PA9Em9EJNg3bl7O0l0A2x9WKphOXUfHQjmPory2Sg5A=;
	b=azFllmfp4ejvwUfwPtPE0kjO9pl+F/aiit3wcMo2gDTWeYknZxAyM2AVaRUT4dN6GJY8
	 8i49yefppA0rmrvxacUjjyhgJ7x3AeynpbmizeXDmdeC07Wmw2XtPA3CkdzYtAZOeHwzW
	 7UGWl4xaVsp+njFC6MrHCn9HJWWsUeTYN7VBC/kK546/b4E8lXPB6hg1fHm0ouBC/aTj7
	 IVslc9iWuApem40J1iSEY8iZmM+ZKbE4rcVL3p0Z8l/TBuVfJFVoNLN9h7XxlPmOIHCXS
	 itMfW3I2cF3FY6HzzhntLEynAURFNo4CfbTVnGARGx9Z/miNHvXcEs+iyp1xlTtghvQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 80B231F000CF;
	Sat, 21 Nov 2026 15:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795273969;
	bh=PA9Em9EJNg3bl7O0l0A2x9WKphOXUfHQjmPory2Sg5A=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=b71mBBdJjXOd9WcLP3dzK1Ct92Wzy+hqvF4v98L6iWQ5djr1bYd0yNnfVu9CBcwR3
	 LTN4FNpVnT2k63slsD7MjHCW8QV2GhL6Q5Wy+2c+FVrWgxJtz84B2MO54rcb0iw+ki
	 KiGcIEFaQQNzPeIcZtr+AR608b/wXCZ2Y/F7HWQbsLnwta7bUkS4/CFIDoEnF7vMkN
	 R5WkSBsYLZX/2KG0vntz8qiA/DbM46NF3WJrM9ibkV13QDx203y7OOsx9u70TAl5ej
	 GEpD1nvB9a5Dx/CLJhq+HA8bxrLDmm5oGfVL5Gp8moWJR20IBN8Kxdwo0XaBi1+oVf
	 iHCz78NPuj8vQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D75104BCCC;
	Sat, 21 Nov 2026 15:12:48 +0000 (UTC)
From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD_via_B4_Relay?= <devnull+cleverline1mc.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 16:10:33 +0100
Subject: [PATCH] dt-bindings: serial: pl011: Reference rs485.yaml
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
Message-Id: <20261121-pl011-rs485-v1-1-0d18008f4a12@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGi0AWsC/yXMQQ5AMBBA0avIrDXplIq4ilgUgxFBOohE3F2xf
 Iv/LxDyTAJFdIGng4WXOQDjCJrBzT0pboPBaJMhGlTrpBGVlzS3KiOLmLi8c66FUKyeOj6/W1n
 9lr0eqdneBdz3A/wxiwNvAAAA
X-Change-ID: 20261121-pl011-rs485-6e5113a8faad
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc: Matous Hybl <hyblmatous@gmail.com>, Miroslav Ondra <ondra@faster.cz>, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795273968; l=1427;
 i=cleverline1mc@gmail.com; s=20261121; h=from:subject:message-id;
 bh=WApAvtSzKPrLcGtYRifdtaAM+A81CWvw2/q5/+yJ1kQ=;
 b=h4uA8WUuBALQ2FRUKebfcFwq8+kH6St6F99HGuzVqUBLVZi6RYzrHHpm7mrEAIj97L3HiW+RY
 piRUPmrx7E7A5u7n19NLpQaIpyAesSY/gzGw0POSiqG4zftrx9QumKD
X-Developer-Key: i=cleverline1mc@gmail.com; a=ed25519;
 pk=2UEUVmQyfsiFZkNS7dkgFg0rUmhbcMIytM6NYhxFt/Y=
X-Endpoint-Received: by B4 Relay for cleverline1mc@gmail.com/20261121 with
 auth_id=1594
X-Original-From: =?utf-8?q?Kry=C5=A1tof_=C4=8Cern=C3=BD?= <cleverline1mc@gmail.com>
Reply-To: cleverline1mc@gmail.com
Content-Transfer-Encoding: 8bit

From: Kryštof Černý <cleverline1mc@gmail.com>

The amba-pl011 driver supports RS-485 and parses the generic RS-485
properties with uart_get_rs485_mode(), but the binding does not allow
them. Reference rs485.yaml.

Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")

Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
---
The PL011 driver has supported RS-485 since v5.15, added in
https://git.kernel.org/torvalds/c/8d479237727c, but dtbs_check rejects
properties such as linux,rs485-enabled-at-boot-time on PL011 nodes.
We hit this on a BCM2711 (CM4) board using two PL011 UARTs for RS-485.

An AI assistant (Claude) helped check the driver and write commit message.
---
 Documentation/devicetree/bindings/serial/pl011.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml b/Documentation/devicetree/bindings/serial/pl011.yaml
index 3fcf2d042372..3c5f35eed04a 100644
--- a/Documentation/devicetree/bindings/serial/pl011.yaml
+++ b/Documentation/devicetree/bindings/serial/pl011.yaml
@@ -12,6 +12,7 @@ maintainers:
 allOf:
   - $ref: /schemas/arm/primecell.yaml#
   - $ref: serial.yaml#
+  - $ref: rs485.yaml#
 
 # Need a custom select here or 'arm,primecell' will match on lots of nodes
 select:

---
base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
change-id: 20261121-pl011-rs485-6e5113a8faad

Best regards,
--  
Kryštof Černý <cleverline1mc@gmail.com>


