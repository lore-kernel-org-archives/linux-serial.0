Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2BD17D8A6;
	Wed,  3 Jul 2024 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018679; cv=none; b=aIIv2XjFnQwRwl04xOiTJ05MMjURqOCx5zRpa9TpeEv8Cqy1gSrpCm/DsWj9kt6C8H/Ad9ua7RQbJqM5IptHulGfOU/dEyBh20+ezOgSmQf6MjcJHNRBs22TyCDKe1q/zTGWGnNw31eLQjFfaxO0XvkQNT7RiinLDBCVMSbBzrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018679; c=relaxed/simple;
	bh=FYb/IeaNJbgi8XBjYSx6fcoQBA5pfVX2DSvIBY85iWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=by8dCl+Wmqe7WbxwvjieGxnpJcGPXrVRHd9jAsjcdAX57GQ05XM0tPmp9S0P+baKKOpegRpYbKJrlSJ0Xxf8e6U5vtzp/B1m/aZ4Fa6eB0ogHHZhwLUmDz9Syaf6mq92Jjiblw3uP0amCUQYgGKFBKhSj8Z7yOlFIRQbrlou+u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Wed, 03 Jul 2024 14:55:14 +0000
Subject: [PATCH v3 11/11] riscv: dts: spacemit: add uart1 node for K1 SoC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-k1-01-basic-dt-v3-11-12f73b47461e@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=FYb/IeaNJbgi8XBjYSx6fcoQBA5pfVX2DSvIBY85iWY=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmhWaYVMojX7yGUCMGenZ/G6Y12xM+vfgob0zGX
 oDH4tIc8fyJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoVmmF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277RQ0D/9YAmhX6GyKQ4NyWq
 w20Cus8MEtiGSC59i2CPEuPyRHQJwZAbJs5Sk+bGc0jFd2Qv6Ag0N9lhypO+7iljgKLU2xvasO3
 HlePbBJXSNVziW92BkVPYhRgXGK7nZtSX0cO4y4wfy3100sWL8Z/DkRqemcCB+36PMsJ8novdex
 He+lVXSjMNnwG+LxaO/r+PLABcxM0EZR1VZM1D8AXQPgxASkcryBkQV6mZ+RLf0s0Im0HXiOIDK
 Jisdxq2uQ4gQpjimV71Tijj2T6xqE/iTMXfshPAKAIMKDsqAtPmwN+dOHalMRXdmfhvHQL4OJ5b
 /t/A5UuvO5VJnAPOn9sFDLoonhCw/RZswNfMAN5M4/BXZXB9/+xyZkqAogbdqfCpYSI9j8U+qqf
 OzH4x9U12KA7ty//rUhOk67rMWclum5lvhfDRwSlSaOEKTi8Awde6yb1azaDQK0Ig5rmVpZoxOC
 qhla1d6lByRDxb1MdSiY3JxJ187RAOuqrryjqKwj8o0qZ8vl62gRHXymRD3uLTtWnQAr7rl4w9n
 Zq10wH039wIbCoXdMy8qQhzYMLKiMApHpK4b1h2KUo2lrJFUYB+mBiPm/cJ3KmKpwx//htBgbF9
 73tkA8O799TBR0S8L49RppoScBvnV0qRfTygcVZFJ8G2P5s/PY7BiE/y8zfIbPZmA1xw==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Devices in 0xf000,0000 - 0xf080,0000 are reserved for TEE purpose,
so add uart1 here but mark its status as reserved.

Signed-off-by: Yixun Lan <dlan@gentoo.org>

---
This patch can be folded into "riscv: dts: add initial SpacemiT K1 SoC device tree",
if maintainer finds it's too trivial to have an independent patch..
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index a076e35855a2e..fee8921513c1f 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -372,5 +372,15 @@ clint: timer@e4000000 {
 					      <&cpu6_intc 3>, <&cpu6_intc 7>,
 					      <&cpu7_intc 3>, <&cpu7_intc 7>;
 		};
+
+		sec_uart1: serial@f0612000 {
+			compatible = "spacemit,k1-uart", "intel,xscale-uart";
+			reg = <0x0 0xf0612000 0x0 0x100>;
+			interrupts = <43>;
+			clock-frequency = <14857000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "reserved"; /* for TEE usage */
+		};
 	};
 };

-- 
2.45.2

