Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE54D17B51B;
	Wed,  3 Jul 2024 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018619; cv=none; b=A1Zd/nz0KqVciFTm+9A8Vcy37hP3BnzyU6lu0safaf4x0+Y3CsWIsTJUaCRQDwO5wkLCcAfCDZR9ZmHWp2OOv5/ZVE4Ap0yHNpX8H6ivMU97ujddDtPcr4ZFEHNujRkFWfs+6nPQOiz331IxtC+4YIL0mwhwcT6YmBdTgxPN3oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018619; c=relaxed/simple;
	bh=xC7pEPT1owxzQR4k3RbfRKoPX9pym4wvJhcF0pFnpVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u1AvCjpViuHzmCo/kn4LMSEAuKLQzwMSbwA5gC07cIVwvBnl3MteL+N0bJIO9wRRQ6Qx2RHR22SGT7HDbkM8JNTDcLdeYobv+fjr/Cw/79AGQ/9plzwVKU3AVpsuEqyptbVIlcw+6ebJrpzvr9B9frQ/gqABk+DH6tOKB/kd1rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Wed, 03 Jul 2024 14:55:06 +0000
Subject: [PATCH v3 03/11] dt-bindings: riscv: add SpacemiT K1 bindings
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-k1-01-basic-dt-v3-3-12f73b47461e@gentoo.org>
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
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=K5sE2wVpJR7k92B9EpfKt0IR4hvNzMMCnPoGl9Y98+Y=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmhWZ+lA3bVNp6ejY1YajOTksXj5zgdJtwC4MDA
 WGfpR1mlVWJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoVmfl8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277bDrD/9dRvIZRevTSGjiMB
 f5SU42FLX05TrUTE0a8KDI/DiBNNBLulm2y58uZ1vaywc83gTMA/Cujk5JSAfBIvFjnfkq2+8TO
 MpPemOQ/5AbOOffTXDJ7Bi53Mz0hWHtQc0QU1If6Dkr15Sup9uf0hYRHZg1YgcPC/jnB+lpulbG
 SJmx7E4TEFN9VBYSlxfbmZkkpx67Ppg6yNVjCtZeXhSVRvW4Q6ikpW4RB3afLm+VgVKMyAYdCIR
 ZNZPi4SkqSD8KyVbTEQm9qgN2tE6vDFkCiTiZlieTJThBWc+0nzwKoTjQST8RsJPK8/6XwPk7dt
 lSb8Ql+vOwnURXhtzPNGtYqsVmkZLACCEKiWU2UAVbYtw+spIOYuenCRhtKBUYRLzdiPCouemZ9
 LDjG+7CJmRtZcqAIdw08vy+VVJBX/F78e0vhSHRkNqevGP6EOnYQyjtzrMmwNMYi2uYiftGnLAU
 U03XCHOT3wPpyEhysW3otWxaY8i4ukF9gyJOJvDf8lLd4C8sXXo7/zMsEBiFordvYlTQKnK9hGS
 UPHZM7fDpz6YiQMuZcQjMxFSSjW8Xa9t0qVSw5kK1+VGAVYEJVr8w1Sexe0BSO0LfdPTz8hmbj7
 3aiNCZAb2mnv1/Zyv9YT9vBIm6Bv2R7J1AVmraK41dYyBh9/Y699Wwp5zSU2uq5Am9Uw==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Add DT binding documentation for the SpacemiT K1 SoC[1] and the Banana
Pi BPi-F3 board[2] which used it.

Link: https://www.spacemit.com/en/spacemit-key-stone-2/ [1]
Link: https://docs.banana-pi.org/en/BPI-F3/BananaPi_BPI-F3 [2]
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 .../devicetree/bindings/riscv/spacemit.yaml        | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
new file mode 100644
index 0000000000000..52e55077af1ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/spacemit.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT SoC-based boards
+
+maintainers:
+  - Yangyu Chen <cyy@cyyself.name>
+  - Yixun Lan <dlan@gentoo.org>
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

