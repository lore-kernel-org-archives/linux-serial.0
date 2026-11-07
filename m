Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794054124;
	b=rUcEz+/d26g9/OwJGeMRfKXvscenOu32RVOlalCAOMUZ522r023dpxE4dztiX+FPkcsK
	 GE2Doeg3Ku+G0LhTZhOoINknnkFE4iQCSVk6BhPeD/K8+DiNF+2DQi+qSYLOrCgVfXPMX
	 iJwf8IFfyMKUkhUbifuYICgYk3GZqn6h1zYs7ngIOE+5ddZwJnuP3pEEKssXB4HBrPCk5
	 nvmbmKtmziwhFHiEIYeHekzgFACjtWdIw7azdpVddEIERj1I44ZVrlUzTDStfuhILazxP
	 yL+lSQEtpr/n7mCkccnu0Fv0QgiUtDnlzLddESxe+RS3KOyl+cFlvBLM3MgH4xNyjzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794054124;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=EO7R+T49bwB8v+cw1KxuhoaSRsFWSxfXrC6vOceJYnY=;
	b=AyXXvUV77NndGm95cOWdOWSL+aPIOrM3SlYr8VeVlvRF3+gdPqXIVC5sFlRAXIK3N1zO
	 INRyyMm1TrLxTvqbbwLntm9IIomPizqzrl6pe3zdEil8J8Brccp1OI/e8sHX+kYJozBrb
	 q7dRtSULKFNj/p2TLXYFi0XEJcJ/eUUXCakrv4IpIRQ86kfb1h10U+w2nriuHkvHAbKkC
	 +dlOWqteZ1JR9oYWI2llKFUt4YIQxL+SUx9G1Ehz+WsnyXzutWfjZz6BauTTMryOhqAPC
	 lMsqXPkJs9FjqBRh8mhnbN1pRruGhbNPNHo1irmRzsRP9wiOlca2xfpWlN73UYYIx8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RUDqoKYN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA99606A32D;
	Sat,  7 Nov 2026 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RUDqoKYN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794054124;
	b=IvoXO9lEW5xp7iWn3EQS8+QJnGIe4U4GrQGYvwE8UsFL43MVHETi7Bd20wZW99DP5LvJ
	 D2UWb8RaYTH6VT/Y+QlXA/BDetC4+FNY5q83WYx7mgr5YAmnrwbjli4ZyL7czdiYRwcm8
	 sK/vCe3Kc2qgvUwfsyYJkthaHGPqmKErbMMtOZmUVNuj5eCMeqLnsQhvYBCcAPIZ5+eUY
	 3dk6hEHs8idScprsdjmtr66I4Oa/p1V3DXwsRj0SpvDOyjznR9VPcFvEhsmDukye0dP2E
	 mdhuTwSz1YgxePF1Vw/ErYDxzfMm2I9awVgKFBsUUQPMqxB/RCXqSdSEikBeZr52wgQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794054124;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=EO7R+T49bwB8v+cw1KxuhoaSRsFWSxfXrC6vOceJYnY=;
	b=knISGpdkAIfYkGMYO8fcOhVcQ+NQ/q33gvDBI7D4H05v1EF1RStBDl8/RDISuoDMdy9P
	 uVhyuVyNBNhfDgf5Mtpk2coBB4u7AIPJlvu+VxTWrMoWvkTuPYB2MUZ5wr1NVgNu3mUNy
	 aycc2KJJQSEbOM+nIEzBMwFmW+s0/XoxUugy4NEY1NPTWL3yEk5KKBo5E3I8wP+VP4xip
	 qUsXYkEzMqyfJPZPZcvzt+pOH8aENbtg/jstmrxeMOTiBOD6rQ9W3jkS1JzmOG79rjm6E
	 Kn5gixcSIIKGW5nHG7mJs9DFC8g0EU0ZF701mqJdTVn2RQByfx6sw8XgYK4IjR6agbg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5ABB51F008A2;
	Sat,  7 Nov 2026 12:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794054124;
	bh=EO7R+T49bwB8v+cw1KxuhoaSRsFWSxfXrC6vOceJYnY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=RUDqoKYNqBTpBDwdF8ah4CIPVv0GjexfMdS1VPExW6hhnhRhB99qgxn2k1v7bti12
	 3PaOFzrhAkfUr70VTPSFwTyvD8o9FK0iqBcFhOPle0c98Zqww7NaxDAM4xKsfHwg4W
	 GiQD/zZQggEcoA1eCOSyjZL937cdDlA/rGGzSwsuGhR8wuta5nK808dWN6Y2BrxGnV
	 r8TE7HmgTGQcrzpqqA5XitVjPQIOAhyHcIS7X+cyV4D8BMqXDOlEHSArinPy8uwJIr
	 Xr+eHgYp4GLfOhxUE2Oyao38McGwBuzou5iT7F3elavD5n+2cb8ZC54cc/AW6UJaxX
	 aqEzSJ+gzcdRg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D966747BE0;
	Sat,  7 Nov 2026 12:22:02 +0000 (UTC)
From: Rui Cao via B4 Relay <devnull+i.udp0.com@kernel.org>
Date: Sat, 07 Nov 2026 20:21:59 +0800
Subject: [PATCH 2/4] dt-bindings: watchdog: mediatek,mtk-wdt: Add MT6833
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
Message-Id: <20261107-mt6833-base-v1-2-bda21083e9f3@udp0.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794054121; l=892;
 i=i@udp0.com; s=20261107; h=from:subject:message-id;
 bh=BmzvMDSSGsZ+iD74UsWjZpukUgHxSh4ohrYyIUhF5jE=;
 b=F57GxYhOMBYbveCONM116XPFb4pK0L12+SfnY49y8GXm9fBg4NWCDOdE9k9AtF/ZThFPv++p0
 yd0LKdZEn5wCoZw8LDCNADha3POq9r+6aEPlO5YwWRiGrxn6mZG+eXC
X-Developer-Key: i=i@udp0.com; a=ed25519;
 pk=XZJKcKgnUUjjyw8KuKy7u2QeIX0JLY/L1Fxzwwje41w=
X-Endpoint-Received: by B4 Relay for i@udp0.com/20261107 with auth_id=1443
X-Original-From: Rui Cao <i@udp0.com>
Reply-To: i@udp0.com
Content-Transfer-Encoding: 7bit

From: Rui Cao <i@udp0.com>

Add MediaTek's MT6833 (Dimensity 700). Its watchdog works as MT6589's,
which it falls back to.

Signed-off-by: Rui Cao <i@udp0.com>
---
 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index f9b725592c2..dfdc06c758d 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -38,6 +38,7 @@ properties:
               - mediatek,mt6572-wdt
               - mediatek,mt6582-wdt
               - mediatek,mt6797-wdt
+              - mediatek,mt6833-wdt
               - mediatek,mt7622-wdt
               - mediatek,mt7623-wdt
               - mediatek,mt7629-wdt

-- 
Git-157)


