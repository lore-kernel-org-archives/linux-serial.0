Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF292E03E5;
	Mon, 21 Jul 2025 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113077; cv=pass; b=p+vmaST93ho2Pw7Nkm/KOF6kque1vJqV0hliAcs2wux7eS5DqvXJ6OTZsm6/OQioGrPcy9zk5wtQlJyfkp6w+bbfV+oB+hU+FC2bjz0t4i+YbQKyYpiCq0GleqRJhkJtLjgetrg7XLXOJEbh9soqfsZy+7j6UTBvIRqvo0/gGXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113077; c=relaxed/simple;
	bh=fD77Dtieal1yj/QDKz/fzPHcRp/irc853ylwKF7CS+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mmLuYF8gr4c/sJpSdxyFz+vYthwegrSxPXg7Asr6WAOFLaA01Yrsi4+w+PnxHVoQ06XxrPbHNCbmTE/GNBEmI8zIwJWBvvZt3/YECgnX8XvCw4ztQFu914327LiYpQxhTdX/w6r7D0T/DWCXtlPisc9crvXPJJuOa2fsSChpRu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=gKo1oJCY; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="gKo1oJCY"
ARC-Seal: i=1; a=rsa-sha256; t=1753113059; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BKPt3FToYiO1v5QZuE3uu66eskmgYbtsxUsZbM30IyLTsQyPhUz5K7+TrN8KiMQ0kWIpfdJ72vX9EUHxVcsZYENgdvi1n5QlQAPJSb7MFx/dMt5auU6y/zK0KGfOUamZvl5hjFxWECcvmMKeusbCYEoeHWTc1oNwnaX9LXWP83s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753113059; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yDAH2e61IfxI4LTcJTlVZFktJ72alhOUm+C6wmvSHV0=; 
	b=NqilH0NrHo5dJMi+iWidH/DX/Qyl2lpydiLyP/mAmba6vRzmL51ODMAsY7hZvHh59vNF55cER4t7KKipQVjTkiwRj2P0gC5Ekna6TKhh2ITAlHDKB2Fg1GH2rlDfwfyYgSd3wsJnpWVRm4ox2dpzMgIfP2JRgiI8Kaf8lbA/PGQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753113059;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=yDAH2e61IfxI4LTcJTlVZFktJ72alhOUm+C6wmvSHV0=;
	b=gKo1oJCYw+/aVFqPbiCgKU02djQJJzaC8ayU9mgRSAjyAVATQXObl/qI5kRgXo/p
	otaRGBudrqLhnO12gfeEkn5qULjIuWUgwaXGQu1ViZmxJh+A0xK9V0xMrAWRYPab0rL
	WAQTvB4v7qvQA4hNcdrXq1w3ZETQO9SprvNBD8IM=
Received: by mx.zohomail.com with SMTPS id 1753113057868788.1664943815517;
	Mon, 21 Jul 2025 08:50:57 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 21 Jul 2025 23:46:10 +0800
Subject: [PATCH RFC 04/10] dt-bindings: timer: Add Anlogic DR1V90 CLINT
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-dr1v90-basic-dt-v1-4-5740c5199c47@pigmoral.tech>
References: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
In-Reply-To: <20250721-dr1v90-basic-dt-v1-0-5740c5199c47@pigmoral.tech>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753112991; l=895;
 i=junhui.liu@pigmoral.tech; s=20250507; h=from:subject:message-id;
 bh=fD77Dtieal1yj/QDKz/fzPHcRp/irc853ylwKF7CS+I=;
 b=2dnClXGC9O8i8C2zM0sQSFrz5RbvcKcwmbyw+pNZBjL0bfYVOoxTf0MT5J0pOF8R9IdF/L6lk
 kF4cO9FxLuICoj8rA2IZg68maBT4dK5DmtKdxu3sjZqtOJ9VLbL9p/+
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=d3i4H2mg9LUn4SQemoLAjLRQy0nTcyknIv6zgKMwiBA=
X-ZohoMailClient: External

Add CLINT support for Anlogic DR1V90.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index d85a1a088b35dabc0aa202475b926302705c4cf1..16b8c0bdce82a55765046cfdc8d1f85a8dfb3912 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -29,6 +29,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - anlogic,dr1v90-clint    # Anlogic DR1V90
               - canaan,k210-clint       # Canaan Kendryte K210
               - eswin,eic7700-clint     # ESWIN EIC7700
               - sifive,fu540-c000-clint # SiFive FU540

-- 
2.50.1

