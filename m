Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87847548F7;
	Tue,  9 Jul 2024 03:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495244; cv=none; b=HN3WEKrOhTWE+aEEjy4KqW8mVfmpVqr7yyFrS1BepjyPPRPHw/M0g1uT5rsqmX2PHF+RUeGEoDzarb7EDTOojSs7ZxsJtEKA2DCber2+wb/GN9owU0fEQEpmpZDnrhWFQ1CHRcHlwj6UEhK1lUrWfp38JfJmQ9mqsPQJB87tYN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495244; c=relaxed/simple;
	bh=hvyPJgqOc1tCMh8R7+h8EQB5CPSRmBXWv5/zDcNO2j4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jX4heZqT5D/0eB4lkDlyZASf0kymWMWn4qElWX4Lr4ydWPkSWE3INLTgR0VfblAeW47SXa9FeZMHT4G+mdsPqS6aOUKpXN2fuMQZLnkoml/tiGi1XHPNBzZqJcfRh9DxuJPWmb17q8o4+WcM6toohd1JQpq1bQzl3bTLeU8H+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 09 Jul 2024 03:18:50 +0000
Subject: [PATCH v4 07/10] riscv: add SpacemiT SoC family Kconfig support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-k1-01-basic-dt-v4-7-ae5bb5e56aaf@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=857; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=TZ1awhNq6EKkublblFnuZdsCVGMYEwJa+AbJQ5WzjOI=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmjKwyWHRKjqv9+VfOYY+IDPu8L2fFYb0E4JUMb
 XMbcx8u9pSJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoysMl8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277fKtD/9gqKue5HzySoVFsY
 glHTZTUCPfgoXuZz/wuh2aFKIAsiotbB4LR9teG9/4KoMWjr3jfOqfMZ1X/AJVi9l85OPzbY/VB
 RMcXeZPskoKN1uPIC4/UYq92+nVrH03GFDAQzXw6VOQ13+iY3nwuYIDjb3FxoQOfRsKsI0Hoe+1
 boEo3mmyWRD7wu2GcgUijNccgykByP4J0wc9VbycxJJtM3Do4PxAQyS3aySoPhQmFktm4SKjWUJ
 +yl/Mr0Ix1auEjwSMliURg9Xk4F4qxZTpjlTvrUyPrDkjwUqv82HBv8Rd06TQ02Cm7NrubtUpVV
 0K3+MpdYh/pcOhOA+KmckoanfBEFGHrs+wRsKwomvhB/cmaX5dwMOB+Gu1dAxd0wJCX4idNdOPa
 6MmTz67sGQaBdaZyuQbT53+rPvL9rAkLR36KuI7Xbm2w1RBELgRhBigQpZQTp+IqTepUAtDYeSp
 8w9ujTU3vY/P0pd9lk2ZmGG9DfsTBL74zUBaEN02A2lahhWf+MMUvmF8gQciQA4ip00vfeuCh4w
 H7g2cFrUDCMC936U7luR6E03TgRlrOmWoyJEiNhT3yjrjq23NimJFF+0yIB7P2ovEuz5DsPBdib
 qhhzatFyLODbDDlS4gt0Ugt2MdQpdiTq2xfNAoJhGsmYCI13J6l9Odpz7wmBxCK90lIg==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

The first SoC in the SpacemiT series is K1, which contains 8 RISC-V
cores with RISC-V Vector v1.0 support.

Link: https://www.spacemit.com/en/spacemit-key-stone-2/
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/riscv/Kconfig.socs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index f51bb24bc84c6..1916cf7ba450e 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -24,6 +24,11 @@ config ARCH_SOPHGO
 	help
 	  This enables support for Sophgo SoC platform hardware.
 
+config ARCH_SPACEMIT
+	bool "SpacemiT SoCs"
+	help
+	  This enables support for SpacemiT SoC platform hardware.
+
 config ARCH_STARFIVE
 	def_bool SOC_STARFIVE
 

-- 
2.45.2

