Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344368C13;
	Tue, 30 Jul 2024 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299378; cv=none; b=hGwaZ9QtbyVL4RcbUBb29LvcE3oj+RZY7+9/sTWcf0MsNP77hSSLK9ZYIxtWyTl6jM3kBdh7DxxfveihNmVQwxUnVK3cfBs5ZVL+gNqoRhRIZMrE3FMEjcO6CjopEV8WtF3tdZWHS4agu7eBbsJFl1jXI+w3tF2c8YaN0Ps7gQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299378; c=relaxed/simple;
	bh=85Sg18FPr/xQvWLmNfyhgjMYOMqh1EoGbwo/TA4OgWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbn8iTS0jDkf6tDjfYKY05ajxybX127LdeTRMrgYk9YNDNHQIVe94dnskYHnGAdpJ1kr64vUSeFnJpFZIkYJGalcAl1YGzKNWRlxoomBUEGBkcvbYE0QSkC6OY6eLTva+LY2i1EabYy/giiFTGmOSlbmb8LudLCpZWPDXJxBlkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 30 Jul 2024 00:28:13 +0000
Subject: [PATCH v5 10/10] riscv: defconfig: enable SpacemiT SoC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-k1-01-basic-dt-v5-10-98263aae83be@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=795; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=9N8TKrCdY7rbrxOHcrLT0SLycg8GX9M08nsuS3f+YnU=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmqDO7rgtgINr+JB8e0BVYVciQ3xAulX3KY4dzf
 uMplniCQIWJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZqgzu18UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277afLD/9/VNEHfzNxkgCfEw
 OqWoylFdhV6U8KYrnno6ywHt+okATJcEGzlV9RqkmXPbEk3heKHAg5+iJbVTVTKLAoGnvC1C0KU
 2L9aFJn9abUCz5Ez+dXt23jA9In7kyq/Ar31XlUH+ok34z9/bWYTwFM1GCMrO7aro5kHCN4/uoK
 WPH/q4OJppFkAnBjBI/JKE6UNJmYr4sl4QcaVrEL0GWAmDpBoYkhSwh3L35P8Lt0BJQ8nCqoJ7f
 E5klJ0btdwP77OPlDNEw0oZZUPNafkrOx6zhgaTs2o3Q0Ew6JzbMIG6jiSJBb9qMu3VkSOXwtdr
 nztZqCVYUJbyYKX5YXDA9+pmPB9ltZUhTarwtPRHminwlM0suXxyp+d0Ao2kfchszUKTvlQuTCn
 SWfEO2BCYqynU/kXqK5tcywtAyzIgA3NqhDBJ9fKnYOcjWH6tYVodjVbsrWHANzJpTW5URhcWWq
 YwC2oTNmncnQDJ+bWCOaTiZ9UzxkkGUEQ/hh2k5y8HtxFE4SfXXaHo1I9841mBNnLkX0uPX2jvQ
 zzk0r8b6OWtYZSGbTbof8LsflJXZzq5u3WOBTgE3TIU0LGBAPGmYdqBAKUtu4/Alyt5YHAZ1TZl
 xPue71c4AcR7mZCFn7DclfKsN5Mqu2GBsiQZ66phAghY52B6bvgXU+TPF8R7wsMIuEGw==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Enable SpacemiT SoC config in defconfig to allow the default upstream
kernel booting on Banana Pi BPI-F3 board.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Jesse Taube <jesse@rivosinc.com>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 0d678325444fc..f9b6ef4da589f 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -30,6 +30,7 @@ CONFIG_ARCH_MICROCHIP=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_SIFIVE=y
 CONFIG_ARCH_SOPHGO=y
+CONFIG_ARCH_SPACEMIT=y
 CONFIG_SOC_STARFIVE=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_THEAD=y

-- 
2.45.2

