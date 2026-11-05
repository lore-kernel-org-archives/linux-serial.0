Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793888944;
	b=FS+J1ku2fBOS3Z5iYSQiv/tn+FTzAJ/AwhGv6cfnvdzLd3TC9fsF2VJsJhqoOmepfZU2
	 ECf9eb9kfHlmPEGQeLF/7qtkDkeIjil9RTHmCx7dg9ZbA9HIDKiK88xAYh56g/7AAxrhC
	 Did5vtgqptgHXbYDT2u+AU+Z6U6WMlmH7G2ZNOEHH5fammCLpOr1thW6riOXgHI0AG5sR
	 zzHh6D5joALngtoiwMIN9kSEo3D1diHDWM/p2lE8PwRbWUDYa9+zRvl7j0ydmHgUPkjZi
	 rJ4ORAIIibwk3ESRzt4OZtSZU0zHUQZz13/TvZcXJiDGZYIa7mDxJosoqyTYVWMTYrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888944;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BTajmg9RWCNBoWlsLMKQTyqcM4v7/TvF39OQuP/nqgw=;
	b=roV2D5tAhL7WZBnn/MWsiTEVJnEzmo+cg573I0p+esrdYTm43tFE3lDNYqJdEOwV5AdT
	 1W62wL0u4rTkCEjFpOjxD938J4GkwDfGUYJDZjzFNoXpejw5SDKUT5naqZUbvErW5AuYG
	 5xHg9cPRHnly1dRbmCcLAhRhYZOWNFCrEhjLfKPJK7ooGTuObiwk1UhlwpO7JQBsAfv3k
	 BvovO9h9Q67+o4Is2DN34320B3Et52nEIq1sGjqukYh/ing0phWIUhd5vaqgi8pXVJ3An
	 0wum1qsnVHmx1Jmf+FrbVAmeZw2iqjE7n0rJnQkaxKRIt0FnuEeKDosQpoVyAyetkjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJ8uEU5D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A8A606A326;
	Thu,  5 Nov 2026 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJ8uEU5D
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793888943;
	b=bpu8HpTHgNAx2NNYssYswhLeCmQ38Kiv+F4rzB2hXOPzUMXqVpgdYgPdLhsSRdhRwwW2
	 zVC1yV3fwKcVeWoHHb0labmw6k8sNwf/PfN3s/htHR5+6iWr1KMsHwneYsWXVjUEM2kLn
	 KK2INisT5vjNkZ3Dl6RI8aj1KozvWptjBdrofgaLxMaNI5mgHvnFM3LiCr+n4mW8QckNe
	 I4mp0A/bDt6Wf39kdEvM5CnDQJGz4af5oFeW7IVb771MC1nmtfCMYww5PuDf05eBucV/s
	 TwIBoQfyVufC6bY49MRjkSxp9Fng4VZLOsWx/8aXaG/ovUUH9vBPIQo8IPXxTZnNxCg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793888943;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BTajmg9RWCNBoWlsLMKQTyqcM4v7/TvF39OQuP/nqgw=;
	b=1OhUFJOs9ldr9jITYXCWvDXunTPao+pNiWSFlKRqDqP+UyqePEWWAC8gq+4X20q1xQl4
	 mS2Ax33AQXyAxO1xc2fvAgL7tRnZX+jT/pVq1feD/1SONxlYRv4QhMvLNf/g4s7YAluxk
	 Kqu+Q1U0BsjmYbIQZPd5Ux9Oh9yus9QC12GQcLbXrSJO4wl4Ad3L2dm52D0xWuB+K8uyj
	 zRrprwwtcHLFmIXriCVhKNiMSEMWNl7oDuegpJt/z5nVHadjR0HGnSaxZgRetjpk028z2
	 9FLQlSPWW0Vb9IuqPTzJ58+JtvVkgUFU0KKBb8CcnMCEcOCc6foYb+H3zs7vbh/ppOw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C3D981F00A1B;
	Thu,  5 Nov 2026 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888943;
	bh=BTajmg9RWCNBoWlsLMKQTyqcM4v7/TvF39OQuP/nqgw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=fJ8uEU5DzHO1OqZpPUWKGNL+MFW7wm+pBDi4xwzDxgD4Fx/rLsKTktz+k91UYOF4Z
	 b7mWLDumvlCkTzi2iyg3QHLBsoQv8GINBgHWulMn6Cmkr9NcBPQllUkp0dvhPWtc9h
	 6OOx21slD5/iDucnvXYXPZKbfV2DvUxljyHq++TUoAs22bs8MGURW2IPgKpLM6SB9r
	 k0/+860bdgXWTgbB8kC+826/kAEjCyBcLL1dN6Ox2drQjlilgtGz59siu0pPebZncQ
	 7dpE6IB53etAgV/yC22tZe9AxrdG2+D202cJ1v1bXK+Qe/cnbWhla5cRz4xsReT0bu
	 8wIsvuNYXpo9Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 526DC472C3;
	Thu,  5 Nov 2026 14:29:02 +0000 (UTC)
From: Ben Grisdale via B4 Relay <devnull+bengris32.protonmail.ch@kernel.org>
Date: Thu, 05 Nov 2026 14:28:49 +0000
Subject: [PATCH v2 4/6] dt-bindings: serial: mediatek,uart: Add MT8163
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
Message-Id: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-4-e68d7d428f99@protonmail.ch>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793888941; l=987;
 i=bengris32@protonmail.ch; s=20261018; h=from:subject:message-id;
 bh=NhECQjtErCffD7Hrf6rEzEREzak9GzWgJW4fU0Mkz9c=;
 b=Sagi85f7uqdQx0Lk0jaevhCGFN6sjUpjC6RXRjngoy5jOckdLEJRPF7vSMWs8fxmdinu/7upi
 rcmByZmoZx3CLsBhfgZQbnienY9E6Gz1Al2eDJmZcD54tkytNttO8LU
X-Developer-Key: i=bengris32@protonmail.ch; a=ed25519;
 pk=4ewFRC2yNph/tXokHVzIDlgOA9Hxecf1AlBuD4eOnaU=
X-Endpoint-Received: by B4 Relay for bengris32@protonmail.ch/20261018 with
 auth_id=1233
X-Original-From: Ben Grisdale <bengris32@protonmail.ch>
Reply-To: bengris32@protonmail.ch
Content-Transfer-Encoding: 7bit

From: Ben Grisdale <bengris32@protonmail.ch>

Add a compatible string for the UART controllers on the MediaTek MT8163
SoC, which are compatible with the MT6577 UART.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
---
 Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
index 5bd8a8853ae0..11801b58f637 100644
--- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
@@ -43,6 +43,7 @@ properties:
               - mediatek,mt7988-uart
               - mediatek,mt8127-uart
               - mediatek,mt8135-uart
+              - mediatek,mt8163-uart
               - mediatek,mt8173-uart
               - mediatek,mt8183-uart
               - mediatek,mt8186-uart

-- 
2.56.0


