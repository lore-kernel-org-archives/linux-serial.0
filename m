Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795696889;
	b=hDT9ql/3bhfmAoKd6Q2Uq5IvSftYIeFAu9l+Uo30tx7RslTk9iZHndFMHXlCuXNok0wR
	 CmeQewCxWlhsAxrmr0LlxGrhBabG8xpRe/C9RJtrkzNLWRCVpzHCwddnFsAPnoVk66sf0
	 u/87I4OndSZpLIcl3w6nACuN3yWcfo4oSBTQQADQ6J7hgwLg0i7qkbp/G00WdrLjMrmTO
	 CzP+J07zZscRQPcd3E36QvFremjhJYI4VTTqychx5YPexuHZYITrJ+4PNUa45EGhKofO7
	 8OUWiuP+zxrlM7vsX9F9zgWEmyLb+34chbJ9D3cm1B6iCf3SS90mKAbWo29bAFWwtMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696889;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Bx+gebuWvdDvenp5ww/mcPP2uIDCBl2be7uQgah9rb4=;
	b=1QNUi9Dq9nXMtmpPcxmrLSxFQugneixh4UrTNkmZlQuQdSJIoSPps0aP4Q+TFlx/NPle
	 eoC0Ya1/EU+1cxygLvtq1cx/8IgRc4DBu2j6YN5gRkryCvCUHHXm6SYrr8vVPKqhEXYnl
	 uZUJ3RJndESvN5kJrJKvX3jgMkejpV50DdXqLKhkEKUPA8GanieHgNMLnO3LJdxinzPEs
	 i1XpABzk3vSA9XptY9zUtjmXHszCZK1OT4jdDl0NBlRp7q81bKtOoiCcJSj6pVMD2UNiv
	 vlVqFU3bxvhowgukDglIGM4QiHjNwzrnx1iyGAZh3uACWf3zsXCCIh0nscpSScN3q7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ai20VcS3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B685606A32E;
	Thu, 26 Nov 2026 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ai20VcS3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795696888;
	b=LhjqzBervFkjBwdmAmbd3s2BXEmdQwbj77MPknr56DuYJvQw2mHRdgbG/+1EXAGX4eeG
	 kbR7AulA7MC6+r23qdLaOux1d/or/e+R0BpE0lDyjbLcr51xeNFNJpzZHXtxm7ttb1qMK
	 CHLxzfTDEtRF3SRgj8vqtJUje25ibWxqRyb4bbOjaPnSL9YZ5yUiNjLR4xVRfLNG8NZQI
	 EvPMXZ5gpQocdtyA0tGUrtjqSXKRYe0wlz3SU17ccTJCK3C+85iUnOi2M8SyjXsXz6r7T
	 QFk48bOsmxM+jcjPu+6vw3D0QjkltfhptPk+MwGsdCgGOYnF9x5IpizgZXFJ8rALdyQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795696888;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Bx+gebuWvdDvenp5ww/mcPP2uIDCBl2be7uQgah9rb4=;
	b=0LHiY/ttdgidikq1muNt1LZAldRQEjy1xAqIUItYwIE+FHdx0+Pt0IA3E7ND+YZuws59
	 UUMM/P+8XnThWzxAkCFs1PD3Ff2rcPE7NYyChjeAeuf7tYsug3AoBfIut7LdsUhzn6P+3
	 l5mEOB1M73IPdN4cm6VyOZwWBBWvfc86lkTXVr5ojWKrMjN0o5TcduzSy7n02F+6DvaXg
	 RkX5YH0isKBTu8TkURGOrVcksmxYW3VkDNjI66P9gDEOFOzXBEROlh80cM3elFjVBvjBu
	 set0pkS9LnCkXFY6BAT92FpW3KBcnoT0Dn7qazttn7OlmONWFFqbdLESHZzPmNzND/g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 528891F000CF;
	Thu, 26 Nov 2026 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795696888;
	bh=Bx+gebuWvdDvenp5ww/mcPP2uIDCBl2be7uQgah9rb4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Ai20VcS34okP63nNsTVx8H6rGlQco7/+hQ8ufhITFXAcppPtS5jAlAjh1CvxfPKJr
	 VC2XRo2p3gcISkNXrbVPNW+dhZe2URzciRwyfwH9NtFdv44rF1D8esPIhK1ynFJ1r6
	 +sZB6NlIcug137liwn8e0d+YcOpNUiDHPGR75y3yt/A+h/Y6oMlY+7g13Cr8SyJEbb
	 5x5+P24/hWctv60S/4tCdn/d7vKqVNZJwYwrJYQvVI8NkDDu6GkZauljdY+fB8Wm6u
	 YB8fQPtPtQucwr6p/cCRZfP0C4rBl/6ONo6IL5PYlEzQeZ5Qetfoh7HucyaUEmcWvl
	 +5fZLHeaCx3Fw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BB4F24D4D0;
	Thu, 26 Nov 2026 12:41:16 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Thu, 26 Nov 2026 14:39:56 +0200
Subject: [PATCH 3/8] dt-bindings: watchdog: mediatek,mtk-wdt: add mt6768
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
Message-Id: <20261126-6768-init-v1-3-abc364a2447e@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795696875; l=1885;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=aH0siMLM19GbpIna6FTZmhfIkS4nKiHnuKEgLlr6TYI=;
 b=bApZzV91JzAk9Q5+fVhxb13HvL6/TMxJR8PEtOAHRZiqj9drOyY4gngo9qfX/7d18Ip6QK2+O
 ANBx5cq1zoQBiCjdzBKOqPQwsVW3aN40hoesqPYsu0m1HztotDyNajp
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

Add a compatible string for the MT6768 watchdog and a binding header
with its reset IDs.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 .../bindings/watchdog/mediatek,mtk-wdt.yaml           |  1 +
 include/dt-bindings/reset/mediatek,mt6768-wdt.h       | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index 72abc9cdc007..55e687b4a6fa 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -23,6 +23,7 @@ properties:
           - mediatek,mt2712-wdt
           - mediatek,mt6589-wdt
           - mediatek,mt6735-wdt
+          - mediatek,mt6768-wdt
           - mediatek,mt6795-wdt
           - mediatek,mt6797-wdt
           - mediatek,mt6833-wdt
diff --git a/include/dt-bindings/reset/mediatek,mt6768-wdt.h b/include/dt-bindings/reset/mediatek,mt6768-wdt.h
new file mode 100644
index 000000000000..d5af8f106ad4
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt6768-wdt.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_RESET_MEDIATEK_MT6768_WDT_H_
+#define _DT_BINDINGS_RESET_MEDIATEK_MT6768_WDT_H_
+
+#define MT6768_TOPRGU_MM_RST			0
+#define MT6768_TOPRGU_MFG_RST			1
+#define MT6768_TOPRGU_VENC_RST			2
+#define MT6768_TOPRGU_VDEC_RST			3
+#define MT6768_TOPRGU_IMG_RST			4
+#define MT6768_TOPRGU_MD_RST			5
+#define MT6768_TOPRGU_CONN_RST			6
+#define MT6768_TOPRGU_APMIXED_RST		7
+#define MT6768_TOPRGU_CONN_MCU_RST		8
+#define MT6768_TOPRGU_C2K_RST			9
+#define MT6768_TOPRGU_AUDIO_RST			10
+#define MT6768_TOPRGU_CAMSYS_RST		11
+
+#endif /* _DT_BINDINGS_RESET_MEDIATEK_MT6768_WDT_H_ */

-- 
2.56.1


