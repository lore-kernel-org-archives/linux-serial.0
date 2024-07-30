Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B633C2107;
	Tue, 30 Jul 2024 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299347; cv=none; b=tUl2flWtTvbeE7pnsGcCwfRDcw6lBtuDS6eNBT38o9c/c6wSqHXF6/yrHhbJzO4Nzw90klFG/iGTwJy91XvUyy3cdP5lYKojJv2MBOX+QY6hph2wLwbfN5AcZxP9qbLkMg8Wl/D2ihu46KR6SzJ6PZ6ogBs+geCeJBDIaagTQBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299347; c=relaxed/simple;
	bh=D8Vc8bnpgkyz8PE5tcYDo/0KTp9d8FRxFRIpzBFCTZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I6hTHlEoZQsbaqmgC8g8rys78fjfTuZWB1vQqsWBIsb6w3eXbs3YeDoxvfIRd0EzhZi3C0/OvYckII4LENqett22rRYyYeP2v5UGsKNOlECJ5LWw0y4puWpVmR5dH4/2w1WByucQpWB4N0iqxquwrkvdfHpoqYyVlnvWX+fhuYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 30 Jul 2024 00:28:06 +0000
Subject: [PATCH v5 03/10] dt-bindings: riscv: add SpacemiT K1 bindings
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-k1-01-basic-dt-v5-3-98263aae83be@gentoo.org>
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
 Matthias Brugger <matthias.bgg@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1434; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=eh3cgKtPldxaM4wTA1wLvLcQHYcPOLfKDPjLj7ob40k=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmqDOkRooYNpIMy+fzKp4BO/bbbSBxvjlongWc9
 wu1V9FknL2JApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZqgzpF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277TGkD/9A/byF6YK3FGkaSd
 ekdv+gI6rdUm2DRoKDLpz95EsYV0VEi6fN778jw0QI6VozcmbzEqd42uiw5hwC2Sgig0RRAuAw6
 eCKo7xrfiJzGyUXBEuTxVCHl+z2nsk2JJbVJR7chCCrWf5EP2lBOK5SoBDodNOxDJzLVghe98Sc
 D5k3FLykwCTE8OQIVGGWcfSJdIfFgaczyKx3RQBtNh+rL8pe9SEGlWpc0sOgfsdijj5RABVrv0O
 9PRj+gWgQbFNEJg4//AumkRgiuSOmHjxF8+fjovyof5O++dBchisqRe6pzM3Ses4wRVFVNBUJVh
 LtFApsSEymBbNNBGBLhEODtYlovsEdFbMlexr3Pt2EQ9S2eI2szV6eaPLBdR2kQ6NV1Jr/wU7Fb
 cukMqfvaLCQcyE8f+kCQdo13YLWvpw5WiG08MBFRtH/N6pHCVhz3Jq1Syq+ekImKYHf3ehQfWXz
 2VF1yJBoGhPgmN2hCiJuuNEm1C6b/oOyd+RwcqJ+uaNLsB//KxYAabpROIZLRAZkRlmrZfQr90m
 fz7k4SN4YqsiYQlCnLMqg/n3/QO3Kggc+tOKv019aAOeCoQNoZcixloZNmmwYvAssr0EUmTUYQl
 6vYlQFWv5B2DrxlKeRchKY8GGnxxCDlCw0wbgCaUasOVYlCGdcE394G6odg6yDD3ICXA==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Add DT binding documentation for the SpacemiT K1 SoC[1] and the Banana
Pi BPi-F3 board[2] which used it.

Link: https://www.spacemit.com/en/spacemit-key-stone-2/ [1]
Link: https://docs.banana-pi.org/en/BPI-F3/BananaPi_BPI-F3 [2]
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Reviewed-by: Matthias Brugger <matthias.bgg@kernel.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
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

