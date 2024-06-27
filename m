Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1001991A4;
	Thu, 27 Jun 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502367; cv=none; b=i81oZU7r7eGgcIrQH7IinIfiBleMIX1W4gXMn3zqSEnQ71TeO47kp7bfgUZWegJGa5MzuOSrqVqsjZ7gixN3f+A+FTFFpoisfuY/t72M+0ql2VI3OzonW3u+CLIT4hQV+3AZ0PhOjxv6w/sYLiu+h4QLM5bIK68I5d63paEGD1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502367; c=relaxed/simple;
	bh=MorS0V5oojZXAcpztqtXzmyXhOw8QyVHp6j8OUOcVGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hg4ps0sYYvH8VEI7OWk0255I5HThAo7onAtCp/adtBecxy465QQuxGbmenf+7ASkpELEX+jSImNWn6Pi4IUmaUxtL6xM8sjm9WdNRVJ1dx6tF1ePVpZUiDSezKaWfsvaSUa+c37GkWle9YzZF4RSnNMH7/KOCMb3e1PgOdlTWc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Thu, 27 Jun 2024 15:31:17 +0000
Subject: [PATCH v2 03/10] dt-bindings: riscv: add SpacemiT K1 bindings
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-k1-01-basic-dt-v2-3-cc06c7555f07@gentoo.org>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
In-Reply-To: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
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
 Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
 linux-serial@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>, 
 Meng Zhang <zhangmeng.kevin@spacemit.com>, Yangyu Chen <cyy@cyyself.name>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=0ZjMf1/zFz8nSN0KohGoIaKW8DB3sA+2dQaSsEZNxvA=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmfYXmVyqk3XHGF18KdlOJHjwS1qLj2fyXfZJNU
 Fgq7053byyJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZn2F5l8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277WVJD/oCNQBiPOWQ7vhCKY
 1MLVFyY1/NHqG40hGglELdn1zaG8shgO+/g82wa6bOGZl36WH4iZ1RlrAb/6jfRZG3oxa8dz11R
 AqyQXaFyqV31Qr3wN/jgg+fpS0HE3Q8Xui0LNfSVlPwHXIBezAPAQkvCrAuI/cyKJfrC71LO07q
 OaGKskyYMz0b/bsII1PSc/kfiXb0YgrbZovc5+Y5gJ7pArvrJms3KtT+tC9hdAVy6Pwj8INGSDB
 QjVfyjd7GwQjULx72lqJYOsK3bKPgyftmqd3a3HfCP3NSyTJo0lVnj50D3nO6ViLYtQJ/FRSgQ0
 jcaLj4GJCfB/kaJGbiGKLskgW+jc0t41vl7dxVcrnkF/dUjPgDgoLfW5ivX3T10Xtt5qF95mUEa
 0jlnG4/GkDmkXqJVI7+9hcylkZqb7fdd7QvP1aWT4qMIjf2x9wptuOSSXcoE4fWVhaYfpbRGi+F
 YC/hx080WgRQ3EfSzxq+AaQh2jD1rdMEjqiUqXtfSls9izSVN0F28gyTcjL/pH5Nx5yeuZfqzHc
 atbQYL7avYxxhRXWjEV0yUi+KBnwKiRGWXx5fbslIThSOh0BCbbja1GaJ3U1nYyFadDT8x1PHj6
 qUFM7G6ba1rpA8wTe6joV3Xy/GzF//f2DtCTTa8/Ju1qWJ5NTIXFS2IN5kFmaKFZ6FPg==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Add DT binding documentation for the SpacemiT K1 Soc[1] and the Banana
Pi BPi-F3 board[2] which used it.

[1] https://www.spacemit.com/en/spacemit-key-stone-2/
[2] https://docs.banana-pi.org/en/BPI-F3/BananaPi_BPI-F3

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 .../devicetree/bindings/riscv/spacemit.yaml        | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
new file mode 100644
index 0000000000000..3b151fd02473e
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/spacemit.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT SoC-based boards
+
+description:
+  SpacemiT SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - bananapi,bpi-f3
+          - const: spacemit,k1
+
+additionalProperties: true
+
+...

-- 
2.45.2

