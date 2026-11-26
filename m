Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795696881;
	b=qrayohOCcaYI9FOCDIAFuPYpbkGhk98Kuy++857w7xrd4+Hw70Ef7akBYBHevSlbCQFV
	 HdV/KJuP+iXAIZ+z0jXUh31vCMz5OSaabudXPc+4T9Csg7k+ZdNRUCIOn3nDyTC44aBIo
	 EyB3o6l5onvIM4/JUj8zChnQr3SzYEtZwLyAoWJN/AgKO9xTDIoOgLhZqN5QguonY4cXI
	 PAjNhloZ2FYygWFS63xhQnVvJDpavsqeGZG/ya7tBC0O0KvqPg9k6JHbfD9OIRrWjKdUh
	 h5RSnxcHGx1sn9MV8WzLAZXu6L6qywr7MXJ6e+RCxvP3xpZDKt6JFMtFVOm8kXmFJQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696881;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4KBHPFKj2qwMwwc1Q5EeyKyjx5sRcICnCsSXsgsl/EE=;
	b=qpVD7ppmLKf6+i6wVDOO8b53CnCiMzSqy35Slx96XOyNfUS2GVY+hFeVzuVRxnKQy2ip
	 wXLpCKvb1YfhIsauWK+keRxgE/InE6UCyhB3mASgofqxrRltTg6mrvSCq3I03rZORJ8j/
	 gyrimnbmAnL/Jh7yM11wcD8pWcNANvGOVNyG2153SJ7ce1+wk0QnK3zj1OM7hZu/p47Dn
	 aGhBb10YtNNI3k4LROlSPknjjdncBvBOP80yn38TuYMsrxC9D/xRyiBYpSN5WxRHdxnUL
	 zn3zOQbfSQv7adcFWHa3dkJzCd6Wc0AyBb7Ai0ILsrIhrgy0WH/fZ7hS6xxNOixZvDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PfN1xX9k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1603B606A31C;
	Thu, 26 Nov 2026 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PfN1xX9k
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795696880;
	b=0giCUYlg4+PRXuKfluGu/SL+E+qi14URCwSFc+H1PJNkevCfTwe5XRD38F7VwcmIgM6y
	 S1z1oN3tzSN7AHmidxBx7PcOJRP4ICCrp7RvhasKDfao47CgsUF0CzanNpd5XtS0pWOR4
	 cUteVzTRb5/x4mDbTKmHaOlE622v6JdYWLTZAusYSxzRr04Re4WMJyxQpKRcbPkRpW1IM
	 IlW1A/wAaMRHKt44tOL1XzK8OLliY7XNrXqnOCN1irHfq/Bb+U5XZpsZ5moSEOlax3/dD
	 NbhnNrBFK9vEqE5C2yxYxkP85fAn8+Ia4v7U3gBJA7KKsfsvR1qE5zptun9H4z2ZDTQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795696880;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4KBHPFKj2qwMwwc1Q5EeyKyjx5sRcICnCsSXsgsl/EE=;
	b=JFhwhBVW64vefDob9oI9CwcwEtKTBuiABfeZ/Y9b/ObTBtLiaSI2VYJ7vJ1E6tJlJjWu
	 Q9C+GIr64cwLA4XoAcdyAkQOv7YOoFn/EixiX99ULIxKzdmEgHKtpZvgxRdmme+ERpBiP
	 u9kuYOu1KnhCZqSn3yg91fIOnGp2qnJbCn6XlnBlLTaJSwX/IbBbx5nniTmIknvzw4wmi
	 Ejdkfu2x05BMrfBE2AvjXTrZ1eii1XRGb1fQkOxWQHjE53LIdjhGKFCB9HepebDCtrnXu
	 75wNT91jcik5dtx/t7Eb/d1pc2wRh64n7ag38a+WHLmZMuRJkADpJ+8W30eEAzG5NUQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 515B91F000C0;
	Thu, 26 Nov 2026 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795696880;
	bh=4KBHPFKj2qwMwwc1Q5EeyKyjx5sRcICnCsSXsgsl/EE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PfN1xX9kd5AqWKofZh8IYqxlbUTacqnGLFw1493G/odWB2yawRI3jvJI6Ej4zxbAF
	 5LaZELBYfcsJQAE8jXTF2uzMsIugkP63jMzs8agCkJ20zJMo4oI9be+3aqywq5Al0D
	 YfnjuwC2rmUp3URdLqIaHDlPIaFJ0EIFihpWaFWnf+Ltudm/1XqQWYEH7OaRUZL0P4
	 eHnOBsaWym7TmzhmbtpHpf+u7/W1Lk1h1ab/umRoCPLYHcEWSH/1/pQ+mF9wIJcRlr
	 /zjj85Srj9+u/slWUe3VxNUq6DeButiVDFp8aGvrqrylCmHKYsMOrgreLIuRABVOxo
	 UfFMtJXsE/sIg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 99CD64D4CC;
	Thu, 26 Nov 2026 12:41:16 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Thu, 26 Nov 2026 14:39:55 +0200
Subject: [PATCH 2/8] dt-bindings: serial: mediatek,uart: add mt6768
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
Message-Id: <20261126-6768-init-v1-2-abc364a2447e@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795696875; l=876;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=E3ForiWHUX2QUXzzHv/US4eQykht5PXx8WEv7OuTHPM=;
 b=t+TAPIl29ebfaMD+EKRgGeR2Otx1pnk2948kk4fZJ5YjA3NtG6E6FVSNFQBKjzT62Vtu95jC3
 cMizYbY5L5YBYF2g3deQVFwO7mOVPdyY3k/c64IUaWPRY21vVaKdWrE
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

Add a compatible string for the mt6768 UART that is compatible with the
mt6577.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
index 5bd8a8853ae0..1ef0629c6015 100644
--- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
@@ -31,6 +31,7 @@ properties:
               - mediatek,mt6589-uart
               - mediatek,mt6755-uart
               - mediatek,mt6765-uart
+              - mediatek,mt6768-uart
               - mediatek,mt6779-uart
               - mediatek,mt6795-uart
               - mediatek,mt6797-uart

-- 
2.56.1


