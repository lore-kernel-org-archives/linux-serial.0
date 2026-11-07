Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794054124;
	b=I76RhMbOEPPKGFR+i4wrHucvB8k/1w/vT0FzX8ECmXZ0rtvsevQudLrFveUmVpzJ36e8
	 JWTrjyMqZUd8d3ykt/aHhAsXo2qtM8siAXlxc1ITv2WInUResUZ5z/pLORT6WGvGwsGEi
	 yok4AEICTdMYPaBOCjd9PlMDKbTFRUyS44KD4p1bgSfuRgXo8UtPkplhWrkppB6SPjZpb
	 wUqbCg2auuEOkA0krWab8tHAnDxxjaxN+hsyPCf7ZOJ31WJqYHxPih/c9ke6FjaEDCfTj
	 3zhiUpAHP1cZbbkwfbDGg0Uw2tk2XNy/BOGvnjXt3BdRDwIm7ucGTNV/3ep/UkUNaRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794054124;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PZLHsRq4EbmlCXf1Lob3CFtquTUkwplBAvByFh+39ZU=;
	b=sJHT/OEez84im980BlMdvnNQ+uxLUdabiaOtIi6jJ0hbYKextY8WQ7PoJ7AYxcUC/1U2
	 Qsvjh4O0tbhl75rkStB1kDPQaiog6Q4uIwSV+MsvDZ6uUmIosLiK+Un5H6zXffszdtaO+
	 kL5g9zocJSlZ4AcGNEYT7PNdDOgIewu1VIvJhwen4mZK1XPtNMwAu+rsmMm33Sk8zVdnj
	 rHLyp9yUq6eW34pP1QWJZwMy0/2M+G6gpmS0Yf58Oa4s9CG08Iriq2RgqEsYLpT4GoJZo
	 FNXWpVq9DgqpE+B/K0+i4H8/uYWdDZ1W4adaHNkKVv8rB/t6v9JFwYmH+n3HNyOU/xw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1A215nt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BB6606A326;
	Sat,  7 Nov 2026 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1A215nt
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794054123;
	b=xgx0E2VFqtwDynfIPrOeh24Co7+SucfsOxfsCPPSGeTLY6qWkJsihScCiRaF6rANVTVJ
	 wP8fkHRRpwxVBvmGbpcu9l0CdnEmjoQ71E6BNe6s+t4f/uj1nMyR9ah6DwrKd/IaTu+3t
	 mYH44pWYc8DCSwE0Op13FnSXZAAyRi13Hk+KMzC2Em++xnNfO4PGiMR0aBsF3jAFUy+sm
	 hoFGy3QC6wAMqwWvOPHUO2t9js3HYNnhTB6GhFLkbJGfZDi314tiwNRUtUymqVqG9F5kt
	 aw71yLLCEeRXE2zcJMxz78RbfduKLsZ6o+zXPengLXIndMZD1T6vKWhGcsBdJZOf8Lg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794054123;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PZLHsRq4EbmlCXf1Lob3CFtquTUkwplBAvByFh+39ZU=;
	b=y2aYWR5uu7l9dPp+LxPz3VZ43nn69uRoNLVSgHUuNDXa8mFyZuxDG9jsdSFFVFWTpP7u
	 TbhxuxU3QDYGSwTwFqsrD9LrAJiPB++2+scPgiu6vCrg2NLgHPYz2L0g1MUXoQHZ8/iLd
	 KQX/S4KNOOJiifoAZpBhb/c4MCZoSdYtIV0DGp03QcFdKRUVXPqoQWLssNSBAUSRhu5d6
	 amlHdzxgTARJtJmmwifBFWBDYhTh1sq43srTzQSKO9wDb6cQ6bQaS8xajHxXVKD6WdbA7
	 9fgh4vMlIiexjECLfiEVLhM4OVOhss5wa/mTpnlJB1nprEpiPm+UpypH+z5ShIGm7dw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 525491F008A1;
	Sat,  7 Nov 2026 12:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794054123;
	bh=PZLHsRq4EbmlCXf1Lob3CFtquTUkwplBAvByFh+39ZU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=J1A215ntz+CsGwWRHp3/T/kJRm+toIxAm6v4Mgy/kQMbfsmkQDwMkvx0VzVbEq4Fd
	 hn/8JWqQWVHEWJ1unfsbBqI8b9MczxWxotWJIEovxZ9tZjG3Xft/IyFipWciLHN5h5
	 XMh8KT6c69zWNf+mdAUkM6pMc48XFq2NVYWkP84k0+DzNNflyjxnm4/gIe8dy0j/9v
	 X0Gqj2rYWevX9iQSktJ98p6WHnKk5puXNqnvk0qBk4Q1EpcCBkzWpNaWYJCnyRr7Sx
	 0YFmD0be8DiSgQq/fovbGKLIrcELmKTG9Go5woZ6PNPyyYMk6iyrItGsZFCIYJ9O9B
	 wGhBWdOEkcUHg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CAA2E47BDB;
	Sat,  7 Nov 2026 12:22:02 +0000 (UTC)
From: Rui Cao via B4 Relay <devnull+i.udp0.com@kernel.org>
Date: Sat, 07 Nov 2026 20:21:58 +0800
Subject: [PATCH 1/4] dt-bindings: arm: mediatek: Add MT6833 and the Xiaomi
 Redmi Note 13 5G
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
Message-Id: <20261107-mt6833-base-v1-1-bda21083e9f3@udp0.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794054121; l=875;
 i=i@udp0.com; s=20261107; h=from:subject:message-id;
 bh=uNRP9WqNOZ9uVaqNn9d41dwM2xyX/yc6xIzymdwBqLg=;
 b=0UOOOfIfHwIQKYbayAqLFyPCAGDYBveCla4WK1KIfCJ9GeX3M+2VuO9cJQCJ0xAXcyRe522MB
 qiM+rDqx3wiDC/m8t3Uq+lQWZbO/Bhd7KZPE0pYxz38Xt6ebC7l7Uoi
X-Developer-Key: i=i@udp0.com; a=ed25519;
 pk=XZJKcKgnUUjjyw8KuKy7u2QeIX0JLY/L1Fxzwwje41w=
X-Endpoint-Received: by B4 Relay for i@udp0.com/20261107 with auth_id=1443
X-Original-From: Rui Cao <i@udp0.com>
Reply-To: i@udp0.com
Content-Transfer-Encoding: 7bit

From: Rui Cao <i@udp0.com>

Add MediaTek's MT6833 (Dimensity 700) and the Xiaomi Redmi Note 13 5G,
codenamed gold, which is built on it.

Signed-off-by: Rui Cao <i@udp0.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 180e6e4948e..900f16b57dc 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -72,6 +72,10 @@ properties:
               - archermind,mt6797-x20-dev
               - mediatek,mt6797-evb
           - const: mediatek,mt6797
+      - items:
+          - enum:
+              - xiaomi,gold
+          - const: mediatek,mt6833
       - items:
           - enum:
               - bananapi,bpi-r64

-- 
Git-157)


