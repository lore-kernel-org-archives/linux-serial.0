Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96A4CE13;
	Tue,  9 Jul 2024 03:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495235; cv=none; b=L0BapUGMakrRzrlcQTTzQv0wEgA5l+ZN5PkEeyCfpt9Jru33qtMcK4a1788LtqJw15qlPhebZyLjPP/E0e33Yf00hWJYu/+pKo1QABIwBP+Zm4eKLTk2B6wT5LhkGv14h+JUO4f7bv9cCjHHAWqOH8N/t5+M1cWHpXIrNfS7NMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495235; c=relaxed/simple;
	bh=5e5axpOVSop7tU9RM2+kMzY3QIqZVpK1c93FNqEco2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OCwhglPZcbzW7fh9zslUGWHxOACjaweyxplpDCa6P//89Pi5VkI8FcybrlGm8ND7K8Qcz6HWboHTiKESedcaG0pUWFAuX7cn8xWQhIX9hMHn0dCj9BHo+1IYNahZXA0xoeBegecG7bHj8wrARI5GgkUuLZ78wwsf2Gv6MROpxok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 09 Jul 2024 03:18:49 +0000
Subject: [PATCH v4 06/10] dt-bindings: serial: 8250: Add SpacemiT K1 uart
 compatible
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-k1-01-basic-dt-v4-6-ae5bb5e56aaf@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=965; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=5e5axpOVSop7tU9RM2+kMzY3QIqZVpK1c93FNqEco2I=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmjKwv21FRkk5FkIYocAXIKY/maxMvJHKDmj0+0
 ppH2Lb/LSmJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoysL18UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277d8/D/9cmhj7g51nGosQSm
 pjoPG7rr9IJWuIEGgX6fVTGNhwQtTeILUZjBSc3X6MA6PBWSsLTIS4kgySSPPiv4irQY13Yp/El
 tqi/K7X9+4s1ewiWBPVI6yUzyHJiTi8iIeIOcOSMRT4bOP0nuBvRQopYf925i3e1N2bW/xqiaxf
 5CpNQWYNrDRxCv4FKHCwY/Znbwo/yaOGz9fy3hJmlrPGi2NgGVID5JwtbfriOY33jTtmGc14ZDQ
 XyMYoSHi+8Lusga8qyfGoUAfDL33M0wAMH5LvfhBclPI1jMPnHhOCnYKQaNoKZ2ZRQytDK0/2Ul
 NruqK7pH68f3lXrVMZr5IAofXR5kozl4/aDDrSXDFexb8L789vnH9X4Bk+1yEnADDeBRo27Ev/b
 IczxFjlxjnf4d/RomXBae+gTLSAe05PCDGyJP7o6Ap1Or5FCKHXLzFSD+wLaZVY8O9mT/JXZdoC
 YgWGvNaQ4cWeck698uauzFNGZMHW32MhH5QxXMCAz14jzDbVSEw/y54PrlvTl5qlxNdOR1lAh8c
 t+ICUnmOJeEiuZpjRRSfOHjIQbQGvLPNVcM73o7fx8Z60tFXLzrjq/GidIkp4yD2yIDGn2oflx8
 +JI/T1NA7yJRHmyQaIOav9IvCtC2zr9XfODTiWhPEZhbozU+3SElZZvIZiS26svlXPdg==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Found SpacemiT's K1 uart controller is compatible with
Intel's Xscale uart, but it's still worth to introduce a new compatible.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 692aa05500fd5..0bde2379e8647 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -111,7 +111,9 @@ properties:
               - mediatek,mt7623-btif
           - const: mediatek,mtk-btif
       - items:
-          - const: mrvl,mmp-uart
+          - enum:
+              - mrvl,mmp-uart
+              - spacemit,k1-uart
           - const: intel,xscale-uart
       - items:
           - enum:

-- 
2.45.2

