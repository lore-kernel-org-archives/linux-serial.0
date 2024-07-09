Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F2C12D1FD;
	Tue,  9 Jul 2024 03:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720495271; cv=none; b=QrjfkValdDlNuauilb1bdreRJletsH6PI0fFKstgg2J4Q8nPvObiQIqkGSFBklySy9wJQtHPQdmnyj3MHEQhktMH0Sz7a2gVfpYEXdXv++QwYc+EJj1dGktnVCRV++Py0iY5iAs/bCG++7JNgc7NZZYpeFGhYaw44YGhZdDlZA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720495271; c=relaxed/simple;
	bh=2BAwp0OEFbYn/qc8L0S8pskWpGRbFBkbPzjK5+UTi/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LdbaQB5w9/YALI/B34ZUmW44xdGKAVsNGdbQvhdNzfmquVNx+z3SJX6jVuGAI6X5MpI2xtcZz2EOJvoUclhqmJX4ZmfLFjlJDXpn/eEaYCWeQLprllMngX4mTOaug8AMQmR6yOknSOQUomdgrpbXqa/NKvEqoFTDniGHMuiVxn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 09 Jul 2024 03:18:53 +0000
Subject: [PATCH v4 10/10] riscv: defconfig: enable SpacemiT SoC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-k1-01-basic-dt-v4-10-ae5bb5e56aaf@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=795; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=nL3b7ahT6PV/xD2KFpmUqqi2YSsxtqrz+nMpwZze7nk=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmjKw8UJeiNWb9cOf0HFjpYkqCDrFZNYSjTbzd+
 tu3iV1QfX+JApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoysPF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277UG9EACH6x0kZ5oN0KPPGc
 JZC0huaCNkqUkLvkzX3zhXIkvTyZX/wLcOxTJleNI0GTR+wAII/BfL04DOkhN95b+6jI/5OtsF9
 k1bG5cUaj37XpAxGwJ/r/ryD+sq2xzzX2m9FLfSLBu7jjtt5Jn5xjDxGQH+iWFQu6JtVk9ff01A
 L952+9XIP2idSo8j8BhPYksc68FqGEvRDnQfwzCqWEb6ByetyGgyeOcBpwz9UQyalfkzHihe4am
 1y/Noo39uDoVcV1pdjCrbG3arTtYnKn6efO390QbP3s2DHJWTqeclgwns+nMKQR2MLSkVWLsG7e
 LAMDYtfEQra74OiE464xz7M89R2gzLyoWbeVV25iYvoEEq3F1YP9Y37o6jNG6lOBqbe2XC6KAI6
 /EY7XtghXBkBCzTd6uDbVinMKRZfc3QaMa05j7THgNBehSvDbpQsckI6lKveEanl2CFeECLshIq
 8mktzRHbRlApRodX5PMEkZ1hMWrRCWxsz36M5UX2wFGM/OUDZwApdu+wXcDOICXViZEkIjB3lVi
 XFgFjgiIZ/nvqtE7VWkrgZDBQSQFL2dGeLS0hGErXSuDZosPzEEdpF+1f7NG4RqtIoF3cUsEzXm
 njmGDohjJYR7vgsIEJtkTrCeRVzi/YcGVPoty1rDoGd04XM1Yy+5DGTBxbLo41xqeNJg==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Enable SpacemiT SoC config in defconfig to allow the default upstream
kernel to boot on Banana Pi BPI-F3 board.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Jesse Taube <jesse@rivosinc.com>
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

