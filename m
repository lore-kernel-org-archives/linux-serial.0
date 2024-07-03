Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B791EB48;
	Wed,  3 Jul 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018604; cv=none; b=ahnYTfFTwwyLQX3BD8LK4BKtmgfhjYGRiU5NngFr26Aa7yqh3p5L9L4ReeWhRxT4JUnM6mmvmGU470dJY7TzNZXbOPAeN2CeE9mBMqLe+qr6VBN29+zyDMJLO/6ar4JPGNaLUCSn1uETA7nuXqviKvehAMaNSZQJCI7pfxTPXmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018604; c=relaxed/simple;
	bh=0HnoYwpV2+reJwf3vWpzmil2uVX924w6SgyIWBkOVgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nqNiFs0hlqsy2iafnwgwWNjMXqFbbZ1pH6F0Y475BEU8Gyrlltm/LIDkyptQMquRo6TOwbJcvv3Euq2p5wjUpztRYQyVzgoeqBdsNRzwNybBjG2f5kaMJMeuKSaAQotJh0b+HzKfb9d1hrf3vJzIlyPNDRjM2/guU5fAIq0aY0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Wed, 03 Jul 2024 14:55:04 +0000
Subject: [PATCH v3 01/11] dt-bindings: vendor-prefixes: add spacemit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-k1-01-basic-dt-v3-1-12f73b47461e@gentoo.org>
References: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
In-Reply-To: <20240703-k1-01-basic-dt-v3-0-12f73b47461e@gentoo.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org, 
 Inochi Amaoto <inochiama@outlook.com>, Icenowy Zheng <uwu@icenowy.me>, 
 Meng Zhang <zhangmeng.kevin@spacemit.com>, Yangyu Chen <cyy@cyyself.name>, 
 Yixun Lan <dlan@gentoo.org>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=S6L+lb2i5tfCPntQqdP469atY/fB6iYa1pxCzasyD14=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmhWZ35K0BgZRCWeClcEq98CC21zonWvlG1WLyB
 GJMClbdDOuJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoVmd18UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277TG0D/48WTs5j9KUPRJWCs
 Bihq1piUY6xNskgbDJDzOvBu9S1CTxByFU6R7YnWEw6SQL6gsAuXbOj/FyiqzT9r8KBMlNaqMaJ
 AKbu8D2Tp3xyUB147d0VvfbFki+x2pnFlT772/TE8SSDmImZDbYmhlEDC8n168q/jv3zKOKYany
 ssyvBUJhCdTdazzpmtevhI0+zMtggBUkdz+nF59G5Tkx3+7UUNL5q5CfuiivOJMzGowPtK2rYzG
 g0QsEXRi76ioyMTMdejQMggdmRJtW7gBYa8ZTRvVvM1gCeUykWfSq7dViiuaN+JuZ7uP45uUcgA
 P3pGwhdoVkwwNvNGFWDVySpt9gdO4+SMwPW/OMpHt2g+Y7NhpwE8Xf2T71XfpX2IoE9ezRck0bU
 Syqt7D4cfn3SdJilMgD6GuDwrIUXIi7wddXnJT84otmMAEX9C8kVWy2y9Oma2Cfo02TATsGNwMm
 vgSE5SFmWUjz1/XG5JMkNc2UMk0NDxgYO7JmUkdbC5oWmmACFzwYDMFmuJk4x+QNL0neoLEQuak
 2i+I74J/Y631ASMHmPSPsLOb+wSRDF5treF617rxBxbSM17XF9ZNaIFbzJAuOyCSQdtiIWXMNJc
 AEtVRjC92G5WcGdBdQFHV25dMNpOYA3RwT+zkOdCkJIVXPk9mJFi7uu6Winb918fHEZQ==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Add new vendor strings to dt bindings for SpacemiT K1 SoC.

Link: https://www.spacemit.com/en/spacemit-key-stone-2/
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index fbf47f0bacf1a..7ee6e4a89376e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1362,6 +1362,8 @@ patternProperties:
     description: Sophgo Technology Inc.
   "^sourceparts,.*":
     description: Source Parts Inc.
+  "^spacemit,.*":
+    description: SpacemiT (Hangzhou) Technology Co. Ltd
   "^spansion,.*":
     description: Spansion Inc.
   "^sparkfun,.*":

-- 
2.45.2

