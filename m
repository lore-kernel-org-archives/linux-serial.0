Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794663670;
	b=AcxOH2QyTxZNTdcpevIikOBuA+AUO0e+HJx9+II4BBuYRmld8OP/+HGUbcOpXqOOt7Kw
	 kw/qcktXPxUF/ZXbkQ9uE/kBM63gNhvHJNHG4ny0+vSBmJZi0/bysPlyoA4uoobnxTszg
	 fm3uEagbbnxCZgRcE/zSCzl8Bf3ARRvb4/t6Yr6spRAugo1hn18p4bgEjLWgM+CcP/Yye
	 bRFBrrSg+jNm5CGmsTL922clN2itBah0zqtKEYS3Lfqk1KTQ9/J1ypr5k7yRbp6gMbQ7L
	 R0mcvAzY1kxmF8SShJx8W/4wV4H6SlB73zIDkm3xBJOdJjd3m9/Dneiye0KLehanYCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663670;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vxTe7UYstr5zmWrUwGezYJ045qR2VI9dQROuNPPuSTw=;
	b=mddyN2PloPct8ejkfsyOzY3zOe6jfyFYc4vDKlxHZVYypAnXK8U2HGTZjuoVVtxFfxkA
	 wL8rpFxZV1DCPjDlO2GtaEBXr63uX16Az0kaTPZy14jIoLDMxuKBD1q9RDoD2CzTq4iUy
	 4RcgzGrcdhw98hdc6+E+g9iviSto6zE00xHXzSbeq/ljHp2J5heMVhH3Rn6zuL9cksU4g
	 Gp+fbwVw6q89WR7GdR8tqkRiMsztQnalQi9ZcMXH+L1fmhFXPxdgMqLcf6kE953hsdIlf
	 Sg1k4g3ao3gKxonSl6w+X2f/y0XDLqG9wfwyieHDlUNkeEGkhD+HJnZkb+hG5hsrZmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqkMqVnj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6BC606A32E;
	Sat, 14 Nov 2026 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqkMqVnj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794663670;
	b=mMBaleVtJTcTOomBUm80y0FKHTwEBSxqtSHgL8bLuoPeipm4PWKFx/ov6ImbKGMgfgcj
	 Y+sfhre1GYep5P6iErSXLVIm4xY6E4/6CreW/vU3U2bj7rM+QFwOFJNm57nK4fPs552N/
	 nig7zK33vrMbFiWy3FBAnB1q1zysgAM4MtzBGVdczcX7ErVNFLmWsGs6jU6cElB1LA1Pi
	 XfT3O+5JYB+q8y/FVxFjI/ymFxx/AMlqd/Cu++sM4m8RjIkuBSf2cOGkhFsqDZYHGveB2
	 +JQ0teEi6sVw7SiZnYYRRCEQ/40mYDge3jpTuLj33jc1aAJZgh+plVyerCUqBgoHzSA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794663670;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vxTe7UYstr5zmWrUwGezYJ045qR2VI9dQROuNPPuSTw=;
	b=Gvo4awAMpFd3s49/XGvhS2eY1wh1EMshBmP0tbhOiJ97Qwh5JPZJu9e0hv6fjHKyBwsY
	 urWmcJj5DrL8GDAMeAZHRUo+wHoBJRF/YbIw0S2atOFqwhO+o4E1lvViipTLd7rNp2TNe
	 BScRU05fpqESFOrF4+QzSN9hx5X5kozVvoowOl9Dsb+NBuUVQUKmnCMkXc/8Cq8/24Mon
	 xovN3X0ivB5U5wMe731p4Mx+p8CEcQ7qA0bqqQoutHPoatWJIe2e2VEoeXi2DfXzRgUCr
	 DMgCVw3omPLq1KeHHGQEjhSZJ3pm/Mxbzmkkm509XweE3eSGt7FLB7I2/NQ6dflDxtg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A6F0A1F000C5;
	Sat, 14 Nov 2026 13:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794663670;
	bh=vxTe7UYstr5zmWrUwGezYJ045qR2VI9dQROuNPPuSTw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=oqkMqVnj6H0oyQLn4Z0XZmf2UYI7j8/P3d1vU+GPksC0k665LvlcBWUe4dyyzcDk7
	 M/BFRSp66O7XCd5kn11sELfzKDQeunk2blZW3R2cQiCROxZaSeVYPu+eLxvLoHzIke
	 9/f2ey6XAgb5nMNwdmWJ7m9Dr0AeGSM5/CCQI0pWSParseCnxOKpyYea8tPxZ0nFs+
	 jgq+K6MPkbudPLTPQRJku8vD5ETkBUTdZe0Zp9Cxyjf4aNPPX9oVv1fGVDFeCmY0li
	 3IjeAmMPiAw4Rp4LdCA4bIaM+aAfarA4SGo9qigIHghxMy6MA+6zLTvPWkKTm7UpD9
	 tt8ld9phze5FQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1F9BF49DB1;
	Sat, 14 Nov 2026 13:41:09 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Sat, 14 Nov 2026 16:41:06 +0300
Subject: [PATCH v7 01/10] dt-bindings: vendor-prefixes: Add Securifi
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
Message-Id: <20261114-b4-cs75xx-v7-1-8f17f38821b4@gmail.com>
References: <20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com>
In-Reply-To: <20261114-b4-cs75xx-v7-0-8f17f38821b4@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Drew Fustini <fustini@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Jason Li <jason.li@cortina-access.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Fil Dunsky <filipp.dunsky@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794663665; l=944;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=573roVKzdDYFuCfGNESYptLR9xpcGKVT07rDsXKZwOU=;
 b=osQRAw34EIeIqPaHCxOrvakpZLcesACv9TQr7r9bbOjSkVc9wpbxHd6F6OijkPShGTRUkpP1+
 35H+hXXg+TaD21ZSUkQL0Gll6BH6uxheQc0gtP7pucqDaXGDwJKtedg
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Securifi Ltd. makes the Almond series of touchscreen Wi-Fi routers.
Add a vendor prefix for it.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5471a06f9..f1f764ddb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1499,6 +1499,8 @@ patternProperties:
     description: SDMC Technology Co., Ltd
   "^seagate,.*":
     description: Seagate Technology PLC
+  "^securifi,.*":
+    description: Securifi Ltd.
   "^seeed,.*":
     description: Seeed Technology Co., Ltd
   "^seirobotics,.*":

-- 
2.53.0


