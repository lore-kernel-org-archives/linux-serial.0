Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7072D804;
	Tue, 30 Jul 2024 00:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299355; cv=none; b=b6MmtiY/VecJwJZ5Aix/c4gcnfS16RNV8xiEvzF5/x8QlUdukr/T3hYr/PetOjQlhuf1ww0e03dfHLoDqk55vyJwJ+DRjaJpaeRd+dt7kEtUP0nrxIrz+w/k1c9uQeiwKsiWzawXA+OK8JYsIw7EOXwSbWZ2zRfGBR9BIv96fT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299355; c=relaxed/simple;
	bh=KaVNf+l+Sp1bJ7NI/f9O19r9vkAzuFGqmjcJN1OME2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WSZwXcMfRo9l6uHBV0lA943vFy1oO5IydFgIST/eJcY2pJ5G9lMxsJBSUSo4GfbLscTZkJQ3gjGCr324L2QTQMbbc4Vh3q+k1GoDgdu6O6WsWFdl5OuigiI73IiE1uVXqYBZCuYeqJQqXi+Gllq8XwdpW6vtiyoDxODShOFc99U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 30 Jul 2024 00:28:08 +0000
Subject: [PATCH v5 05/10] dt-bindings: interrupt-controller: Add SpacemiT
 K1 PLIC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-k1-01-basic-dt-v5-5-98263aae83be@gentoo.org>
References: <20240730-k1-01-basic-dt-v5-0-98263aae83be@gentoo.org>
In-Reply-To: <20240730-k1-01-basic-dt-v5-0-98263aae83be@gentoo.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Yangyu Chen <cyy@cyyself.name>, Yixun Lan <dlan@gentoo.org>, 
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
 Meng Zhang <kevin.z.m@hotmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=uv26Rjh9IKMB5x/gGwi/qL4b2tY6fy8LbhopCFjMJXU=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmqDOrebmKoNBdTxSBFxluO4fDpviSPs+S/+2/u
 jqPBBmjndaJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZqgzq18UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277WPGEACZQzXm0k3JkWpRaK
 ve8mnvNuPwSBiJ9QI5XuUfUUml5ZHbKO5kRqv53I7mwjSIpakbREPRZwUQIxXmMb/wCrm7pf02I
 KYdfjRhuQ7ZS6zlhBYibTW8tf89B8ryXNyOLMnkpKveyyj3U/idclJpSjGzXaNHhtfggTp4a6Vt
 s8ypKGFvGc2wc0Mf/q16N67HBGT/s09gUy0QygqFa5v/xwkU8aUt6cJ38Gxn7LbNpzdnZ/Bl1qn
 KRQsxOY6nemWph5Knc+kGRZ+lEYRJ0OaF5SH7+82rGSfeJuQJ+f6Ykk5O4ktm8FokLhzCP5Gjzh
 i4Dq0scBbS4ZqnctDPqm41uZMem4hQdDe4ZdOIwzAT36KfoTF+fIWJdnYl4cKr8mvNf897zBaRs
 MIuf8aigBNixEAuT9ZwsaIg5Z05Vct8NOEUDtS1lWjfS6UPU7iwlWqmlNHr8Ue8lnW7keV7ysDS
 SlGCbIbD1v7u+Kg1WuDBPBsBYdSv7bFuGdlfo+S4fUgflxaSL3QTAmh9hZkx9ovuK/jW9zde4KH
 /uSxP9ImJB1sJC5lfQAfBC6/N3BTUC8IjC3fXPRpUzQa+JJZfEs22zynHeIN/YLxww/bfuPjN0q
 dHIjfzLgffsuvo2KMOMQ84DhHiByjHKaPhFBITwFDYSD9G7vJwE+Zpdd1FXpUBLbsyBw==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Add compatible string for SpacemiT K1 PLIC.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 709b2211276bd..f473ca3479efd 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -59,6 +59,7 @@ properties:
           - enum:
               - canaan,k210-plic
               - sifive,fu540-c000-plic
+              - spacemit,k1-plic
               - starfive,jh7100-plic
               - starfive,jh7110-plic
           - const: sifive,plic-1.0.0

-- 
2.45.2

