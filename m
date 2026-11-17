Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794906699;
	b=n0tLbmpzNOZby8cB/uf6F5dnXuqZc16z9pl2vE4B25Z5IMKELgsOdizT7G6saq3PZRzl
	 Efs7qe5/lST9uf0CkjlLfxIIuLbm7ANwS40X5Ae2mgZUaZQQvoeGWMVjgIsfeOeXNLrul
	 Dh5k5JOIumxKCp597/et26pVncEfEZ4kO54qhA5Ld6ylwPjUCMYjKMPVBJzwAt4tt3i28
	 Y4PHE/KgkRtx1zgV9LhuPGa4oT88TVB4krZz2l8GMasTooZQUpQ8PjjpocDjTgksFFkhS
	 k63E6beck1i/nW8WzzqXreyvCQKUS855tZcE+WSvjT4UZZ5Jsl7ntfzZqlLM4iyMJPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906699;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sQnkF5f7J5gjzIigPcwvePLDA2RiyWZPn2x/OhMR34g=;
	b=xriXbDuipSLMAsI68YuDuxH2e8Ua+BA+kFIvCGkJ4eQNTeWqtr02HnEdbAByYdRodsB8
	 E4sMtBBzT1pCRdM0LGeQUtSBm8wfnRvsxg9FKJvSC2/d/KpvuzP/O6LIeEXUU98Um1bCR
	 CUoQG+Ag+elyn0QYxKIQS72uQ/h8O1i8vhoAKY9DgB/HFGfbXcx3ER1sQovDQtqd82lac
	 cRyMSwbrwhqxtjKKpWv+Q/G69hI2RGsUf8YyQcw5NcT4r/fssaD3sAHmKM+8YzpE6ijvK
	 Ja8f6bnq3Unyu9pKgSKlYxPpIUYbVPbH+GOyAGzDt9acHF/jmMJYZQQv0+mqv4mh1IQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HqBtOb+f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C85606A33E;
	Tue, 17 Nov 2026 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HqBtOb+f
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794906699;
	b=OMh5ilukyezPuxzyok3rCv17xArYJdG4LoFbNwmKOElf6WGkl7gFT86RM4X/5pOEEawo
	 vnC1l5Q2xOAFv3rApNrUWkWoCm2/HyqI3av3FuwyO4PPkIhpsJ/jDYvW/UxSF07lRDtqt
	 7sc14wcPCMxuiWnSyZsJJMamELPwTNTouleMhpAN6jSBukk9huWJnFBQfC4ZdWWyM7Li+
	 Q9iP+GqjKNDczsowSwOZg9zFy7mVpQHJkv/b62Nn0RRryaQ5JyMUSBniSmDrTvLbIRyyI
	 /8cvUfofgJdulIrfRwZiqtKL0k1eDs0dGFMjBtEF/I/q4AfYSUPDJXnhcwNfgANUF8w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794906699;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sQnkF5f7J5gjzIigPcwvePLDA2RiyWZPn2x/OhMR34g=;
	b=tii5P3rZ2JaCVrUVLWafRMCauI3KJE5F+N6v9ANd60SLP0km7O2n23iJ8EXcltGP2fcR
	 dIiL9b+KQzRnBg47x2+FhN4X7n6CfQZcJQF7dAq1FRViHhwj9iWAkpWSUa8nWlt+/NwjQ
	 /DSEPTEiUJAeV9n/dXuvtAaOP19vV9awTwpf7OQN3z3uFYN/HLjIVTYcwMOVqaFTsyyUC
	 Xl9gtuSy77mszbe2lTNWkXjPGtFolw99teDjkfLZezB8loFWbbgeG5urV53Aj5nqsdpQS
	 ewgCFxdR7hIHgchWEB6ItWux3Yuf2bamMObanIyV6ZvGNE5JlTjiue/7XaAiDzyAMLg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C17F31F000CA;
	Tue, 17 Nov 2026 09:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794906699;
	bh=sQnkF5f7J5gjzIigPcwvePLDA2RiyWZPn2x/OhMR34g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HqBtOb+f7+zk/sCku6p5lGrGlTJMvWjSILPJYthaRkZCE+kby9CmmVsfbjPLxI89g
	 Cl5ToKVnRQj75AVPZsUqodNQHzZn4NFU9MOCs+8sUkq6yLekTzP/In/gd0Mpty9iX6
	 BfaHLbXBTUIiDHSVbMCzTAHpcL41QMVnA3eGz2vk2dB4Gkvo0HO2jjBdNJ4Eib9Ibs
	 MJjT6LigUIBPlbdh7haWxTvfsuHdaiWnMLaGK9NgKRjCgx4YYe9qtMCnwUNIIgtk1s
	 8pAPab/uwaG+hmaT1GdDK531YDLnQ+rlU8J3P6TdHN/vfdeuZc0kpAG+DN/o81NXLh
	 rAOmYNX70VaPA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 473B54A777;
	Tue, 17 Nov 2026 09:11:37 +0000 (UTC)
From: Rui Cao via B4 Relay <devnull+i.udp0.com@kernel.org>
Date: Tue, 17 Nov 2026 17:11:32 +0800
Subject: [PATCH v2 2/5] dt-bindings: watchdog: mediatek,mtk-wdt: Add MT6833
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
Message-Id: <20261117-mt6833-base-v2-2-058a0685c40c@udp0.com>
References: <20261117-mt6833-base-v2-0-058a0685c40c@udp0.com>
In-Reply-To: <20261117-mt6833-base-v2-0-058a0685c40c@udp0.com>
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
 phone-devel@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>, 
 Rui Cao <i@udp0.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794906695; l=1098;
 i=i@udp0.com; s=20261107; h=from:subject:message-id;
 bh=jjCiaVOOht+RI3oDkxUaR1YbdSwCNgqgxnVxINfl9q8=;
 b=9g9D2itu8LsARvIWD5fHnn7cKiJ5isx3uDconLIYrEz7YNX9M/UaO365a15DHPzjWzin6dTNu
 DZmZImgXlCpAcN2Vn/scwDnZx8pOnzCjHOIz8kc7gqYD/GgVyArpBpA
X-Developer-Key: i=i@udp0.com; a=ed25519;
 pk=XZJKcKgnUUjjyw8KuKy7u2QeIX0JLY/L1Fxzwwje41w=
X-Endpoint-Received: by B4 Relay for i@udp0.com/20261107 with auth_id=1443
X-Original-From: Rui Cao <i@udp0.com>
Reply-To: i@udp0.com
Content-Transfer-Encoding: 7bit

From: Rui Cao <i@udp0.com>

Add MediaTek's MT6833 (Dimensity 700) as a compatible of its own.

It can't fall back to mediatek,mt6589-wdt, which also describes
MT6589's twelve TOPRGU reset lines: MediaTek's kernel for MT6833 resets
the connectivity CPU through bit 12 of WDT_SWSYSRST, past them, and has
no full reset table for the SoC to take one from.

Signed-off-by: Rui Cao <i@udp0.com>
---
 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index f9b725592c2..5742cc09a74 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -24,6 +24,7 @@ properties:
           - mediatek,mt6589-wdt
           - mediatek,mt6735-wdt
           - mediatek,mt6795-wdt
+          - mediatek,mt6833-wdt
           - mediatek,mt7986-wdt
           - mediatek,mt7988-wdt
           - mediatek,mt8167-wdt

-- 
Git-157)


