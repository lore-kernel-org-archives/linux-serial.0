Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C373214;
	Tue,  9 Jul 2024 03:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495189; cv=none; b=Zvr8Deded0kNlEFIulHHhBnOZb28H+nWR0H3dRdsYSoyjd9qKbLFfEHYxQu2+qTy16TFGItavhqJ5nTWGtqFBqWPwKv534lPw/Mk2PaVSjYGuB306UimHw+xmOup94XzMqQQ7HyCoisDMUk9tls3HXl7xdGHge7eOL9+zRYHT3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495189; c=relaxed/simple;
	bh=0HnoYwpV2+reJwf3vWpzmil2uVX924w6SgyIWBkOVgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5HRP3xJJnnPrxK1j8nzchu0ArWqmtzSLXY2TZZsKqwMwxmWfd4CGZTM4+VsDqlV0M1148AQqyYfji50syn2j74QTY/mOC4zaiyvG9Y8qKZYOjIcVJV8WXgChZI6rJ20zeTjZpDRzWBSaW+/M6vVugAzj1fkwtwv8AH0DhFEzyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 09 Jul 2024 03:18:44 +0000
Subject: [PATCH v4 01/10] dt-bindings: vendor-prefixes: add spacemit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-k1-01-basic-dt-v4-1-ae5bb5e56aaf@gentoo.org>
References: <20240709-k1-01-basic-dt-v4-0-ae5bb5e56aaf@gentoo.org>
In-Reply-To: <20240709-k1-01-basic-dt-v4-0-ae5bb5e56aaf@gentoo.org>
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
 Jesse Taube <jesse@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>, 
 Inochi Amaoto <inochiama@outlook.com>, Icenowy Zheng <uwu@icenowy.me>, 
 Meng Zhang <zhangmeng.kevin@spacemit.com>, 
 Meng Zhang <kevin.z.m@hotmail.com>, Yangyu Chen <cyy@cyyself.name>, 
 Yixun Lan <dlan@gentoo.org>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=S6L+lb2i5tfCPntQqdP469atY/fB6iYa1pxCzasyD14=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmjKwewnlnCkqnwBREmvoqSxsKANpcVX1cKArvE
 s+PIAZtT5yJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoysHl8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277RMyEACZ3uVCfGIltXdrI7
 gesBVB9wQr4FM5xlZqd2tzkwkiOCJdL12btQSRLHikgO0h7sFBM+vXNfm2LXhOkMWKCKMeCFmvN
 qmObUGoGM2UjdLcrpk3yw1oh+Ch6SalD63IKuDZiGTjVGiSkfVpDn6ySYx/HeGeNqBxEu4xgI9Z
 dEhaXzc0ripF8tpAW+cEasZvpFWSE9r7mPni3yKoUt9NVkJ8iDR3+7LlDoEJHI8Yt+Kc/rN/Iod
 0Kk5vgyslG8s48RLjU6hEvnTpTauPBa9TimPiXa+SSpBjMHI18a/QSoTtkcU8+oi8Vuw7F68OMn
 3rHmwGW6FI0K2wbV6jeXAG72ciXdwUBwlGOQlU8Qq3PeMjRJ7lxgAkMiQs7DL9+/W9do4FezmHv
 pHE630bxsu4Q+YcRqaSUTOq9uq8TLkKIbMP1Rb/JP82+mWVRix86z0k2saU1lMZo/c7/JXgKAzD
 g5fG37a4qr9gA3zDRog8nMOAswL/dakvTfJ3U/olosAtDkKCgf+VD22qt/qTVAVRSUGxUe5rIJZ
 kBLJUCc90izZzQp20VjZkhNjjiRmOuB/mSqghNOWYSh7XmezAXl7b2EECbjuYxQcLyLbE5QPvs8
 3Mc2tDXVslp9BNuNP32WMZbCztax/uTIcC2lU1ylroprPwBOEDoVp1ZyzD3nuLH2W5WA==
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

