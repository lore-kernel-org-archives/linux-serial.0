Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3A9433BE;
	Tue,  9 Jul 2024 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495208; cv=none; b=hnyL7/ZIvZFaLmUeckwffyVCtREXD9Snex5MImDXCID/yAqKYvJS6R8nPY4VLoGArTR0XNZdZJme/Vxk4+syC5uRC4jrB/NeoVVZru7lvBTa35GCaUFM8Fbgh9clFNXAY+gmzCKGom9ICqnmNulQImktNILuGr1Uh6AmoBSjY6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495208; c=relaxed/simple;
	bh=WgQEVpfwfr3WH6qhi3ZE263ZglXG867Ahbr5kPZTNtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j/f0y9BzhYt4Zhzz1jzwS1wqJ0/VgX23oKu9y2pgRu1egeVJAWTvMYks5jma7HvdoWCKxBKZgv6U8KgqApSk39eFYjUMSziHxGUxVmNl/TDVYUihegkO3prHFXbEOhBzfh9u8+/bGRJPjDB27mpmgOnXwzK1JWcTtOUFBkQkplA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 09 Jul 2024 03:18:46 +0000
Subject: [PATCH v4 03/10] dt-bindings: riscv: add SpacemiT K1 bindings
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-k1-01-basic-dt-v4-3-ae5bb5e56aaf@gentoo.org>
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
 Yixun Lan <dlan@gentoo.org>, Matthias Brugger <matthias.bgg@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1387; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=npfgDVRP4ulLNRkxF5xAkZP/Tlf1HQh6E5OWv3kLTAo=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmjKwl1olP6PkNb09RY9R6a+2b6KcslR6rjkpwo
 XP2Kr0Ocp6JApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoysJV8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277axbEACYHwqAIGjSupXIEa
 YeVXp/alZzj4lL3AWjM0bpIYiDp9pKctWC9ra5sF+ueseFyBiqW7otJ526mRwyBiAXmQm7TIXRT
 HmKpcXB2l9MkHIJCqSTL9wKWpzjX9Ry5H7VRzM8vJRm9z2JlFaPX1ErF3h1i8FVzxcuon0/Qu6O
 0ank7l4qG8xMvcUc1WzcWChrkQiBPPjbX2MSPDMlDbktPawCLjCAXdeUaLsOHOFIqwG4CGPUmRL
 1s+yOSHYh1HWQzO5P3tFCZWg0i42uJiGJmbM/YAbsnktULf880MYaRQawwOGrIut8bg1EhQMqBb
 tO9rQ7Utw1G0b164D6FGHlKJOeovmRVg9a1uyAV16EJQxnXzH1sX5Bvxneo9I8lfTHGqRzyBaR/
 Zjzu5nhGyvlvv8Ie7lM5vYLDB2zR2PjvtOkscYAVq2QOK/MP/NK1p/m5q2SxcgUmwVXeLKbAJUO
 pnMiSulPGJTY/+WEYDMrMR8C0mY2/cjvc/n5vwURVmmkxN0C/ulQYueOZ9jDwvPICnU4wFRuHLN
 QLhRUH4LUowA1yn/3jpw/NBPLTBMOZqw8viIQrCPViETC719Rcht6XK7/C5ekO+BOiEGUNFCvwX
 svEMcncFpiMsQmQkShS+9dFuAtZFuDl/eRyX3bbff2gRdc1NieasVl2TOxf5pQLTAi/w==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Add DT binding documentation for the SpacemiT K1 SoC[1] and the Banana
Pi BPi-F3 board[2] which used it.

Link: https://www.spacemit.com/en/spacemit-key-stone-2/ [1]
Link: https://docs.banana-pi.org/en/BPI-F3/BananaPi_BPI-F3 [2]
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Reviewed-by: Matthias Brugger <matthias.bgg@kernel.org>
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

