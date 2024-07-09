Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D764D8BB;
	Tue,  9 Jul 2024 03:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495196; cv=none; b=HMhB6zU7pLDTkbYXOfZaif7ykYxOBWMR7OMD0qLJs6C5AGNenem2/VP64Z1SEXINgD0gkvgHCUniWoO5JFyKrHy4qp5leZh9Pr/hmog51/yKC7n9h12K+IdPYAfA+1pldLM3FDd3iKLPtgMI8qCfEJ0EdkQx9pI2yycyBE0kPh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495196; c=relaxed/simple;
	bh=72bJnK5OkxGeVX2TtnufaHxre6755qvj76r1a1oE7nQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kPZDi+rt/lHnh9ibi0HI3vhLe1haLUFNm2hOIijkn2VgMu79RSA31YuMBMNidbtm7VVZmEt7v8Q7la8a9W54qYe49f5uF1bfTzcV4A6DKlErPrdz7mQ6CgOCfl9EyoQPQmOFm2s/S2QZGqqt7JqW/1TL0Am/w8X1PVR+0H18Ju4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 09 Jul 2024 03:18:45 +0000
Subject: [PATCH v4 02/10] dt-bindings: riscv: Add SpacemiT X60 compatibles
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-k1-01-basic-dt-v4-2-ae5bb5e56aaf@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=93gTwTFhHhqvEXaieSxNaeTfBJ+zIc4/WjCpYTUJ8uU=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmjKwib36Jxck8gReE9KCGoyorfO9cEOVEDCeox
 KLRxP83v/SJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoysIl8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277ei3D/9hgvzeJzgcDjzeWR
 qEhM/Xz5xzgc1XoJcCKPk5mvGQvdUq5LEpNytHykOPHSBAAI9VoBBdQ7IWeB0LFtKoTOk9+WLiN
 WNjRyezD4HDf6a5Zf+eD0kvAnh/1T+8YaGu82lxmhPX+qvYhvxAqb18UODGoraxP74hcT27vOhe
 1ykQOM5ue9A3IFgQ4Hf3gKmDUth/aksQeA0/IP4xSl8QgdJX12AD7DGZR6Y4vTT7/aXLPTclVX2
 ZzGI+yN6xFdtKAAZHDOugD297QpoGNjjyA/kZfzFxRggZebOwb4ZnrNTym7M1yaWzlDe0kC5oDa
 RziL+x4OMYRIinadoaZCLHpNbz83t129lwD/tgPnTFpMVlSSwQqfrPLgDXTfcY3vFPFGXP2GGAH
 z4hAy0alU5roPhDrbRDq0tPAI7A3qPTWtmxBTS/lop6Ba5mAyExDDb+2KlgkjGBWOjHBx8ozxLU
 vg/RdJsIjZfwDQAKflFv3sGDPYdYF2Sxd5G/lAHhhNjsdVUlh+6zuYCvTT3epX5FGoI1xuaE1DT
 FlmehtJahjixeGR/lo9xHf5a9gAJdG9uXWiGC+8MmJHQEe5ig460sHxjA6vaG1ho9J1i6DJSiHz
 LAN9L+snFVvTLFmrwZlkm5WjvnwWn0ULtig6WUdzyaKuuDgGnkMNL/8ZBPB/A5eJuJ7g==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

The X60 is RISC-V CPU cores from SpacemiT and currently used in their K1
SoC.

Link: https://www.spacemit.com/en/spacemit-x60-core/
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d87dd50f1a4b5..5ad9cb4103356 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -46,6 +46,7 @@ properties:
               - sifive,u7
               - sifive,u74
               - sifive,u74-mc
+              - spacemit,x60
               - thead,c906
               - thead,c910
               - thead,c920

-- 
2.45.2

