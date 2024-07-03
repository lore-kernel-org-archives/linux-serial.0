Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D77A1802DF;
	Wed,  3 Jul 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018672; cv=none; b=e5njaa+d/f5KcDMt0KCqwXtG7QYNPlpjSldE9Qs3Cq/GRhPg1AVCO6L2UlCuTUmGLp6tUxftn0GjpNwaHGBuWu8eEeGRipF1zeMRErqD6HaAYHgOFFPuwgZH9pRGoXdfoCmVEwOCpfMgN/jlo7BAROanVgBt/LLycKhvW/CvPKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018672; c=relaxed/simple;
	bh=2f29bqoZJfosWpZrf0L/4Iu1sMTs4fvkXSadX7IHMpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lB9IIb/xNDWck1/yfPUhUF77C+skbzg5P3VX/24uvdFlyCjH5X0B71QPdJX/TpvUz5IvM3fBM+/LSFK/Ipdt9R4TmcSUqvhth07YndCAhRX7fDyRQMJ8De/fgtipRLMXleKx4NXL2Li/TMNxilWtBjw/HrQ85Z8YrRGqyFBcveA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Wed, 03 Jul 2024 14:55:13 +0000
Subject: [PATCH v3 10/11] riscv: defconfig: enable SpacemiT SoC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-k1-01-basic-dt-v3-10-12f73b47461e@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=750; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=0Z/hU8lufpDC3bNS6gDANBAxUb3C0VZ+rOZaNlFzgAc=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmhWaVu+0ghizB0jAfqPMoCqrKBWbOswgvQQ6YM
 ipoKFieAT+JApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoVmlV8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277S8qEACdquJhrCpCrqi+ZG
 TqTXCTzTd0TrgGFczcCYM3RXTFKO050GasJlIbtdsLPiTde16mDThHZE2M2v2PNJbH2lxtuJwtX
 DlkZ2slMO0LoLRsHSjEDYDXBODuuJ+cxrMPo9Ew0vGa4hW0sC9BoLSe7eZYJ0MWBtsVVSkVsU7x
 FHbqv4fmOWb5wv/fAjmhdi7/1fkudtclumwY4IIB2XqUYIrfQzuu9CNenf0Dwf4U8iuGxSgGD3Y
 4fkXLnBpQy/g5x60dqhyJEA8jX83ubRQuwgaD6Obfp/DeZ64O9NoLmtWanT8izmCvLz8Vnh7sXQ
 fsWiG+vNByI/LXz9fZR4e7tMyLTfDSwVlx5xLi1DIhjVv7FkAunLESWEJF/z5v8F6U9556KYnBt
 eS3FW6VVJ26ifZ1p7tQeGYhhcyrIeGc2SoMi/zHJmZXZxnH4QqfvMT2sz4xL00IOedc0wlHQ2E2
 3xJBN/k6wetjULaaCLJlbRDt8kUewA4JU2kxrd3RwKodKzykgL4QBVI96dYOjOxDdfQz9MWH/b7
 hHrehF6KrEJgH3AVDTC7uyOfWDbzWg30eRKo3vss0RzF4Xe714FYJihg1RJGPafncLTu11+fFtG
 lRK9xgSB7c0rYjeGRlkfQgbYTZz4KmWGAbYM1vhU80IPjq2AC40KwE1d+rgEowSiJy2A==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Enable SpacemiT SoC config in defconfig to allow the default upstream
kernel to boot on Banana Pi BPI-F3 board.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 12dc8c73a8acf..5287ae81bbb78 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -29,6 +29,7 @@ CONFIG_ARCH_MICROCHIP=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_SIFIVE=y
 CONFIG_ARCH_SOPHGO=y
+CONFIG_ARCH_SPACEMIT=y
 CONFIG_SOC_STARFIVE=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_THEAD=y

-- 
2.45.2

