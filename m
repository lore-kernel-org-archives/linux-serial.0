Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3211A291;
	Tue, 30 Jul 2024 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299351; cv=none; b=qh8KxuPG9f2nBrWXafvxK1QzLIfHK+tpaFiQB7qi1FHEiEO6q52zS6I+8S/Ky+1+mouIsy1ouRK/VFCkmzydUs7BLPFMfXY335XDLpUWhOIaJ7U+DBVEbxXka+f+6ll73/Z0ZLVxyN8t9jviwyltYX5XB3nAuVBsBPIovlzHS34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299351; c=relaxed/simple;
	bh=vMDmmDgzRdWXl3NzJaS3PmNN2NGm97gOT83Z9RpJGaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pxM10FHd8j8TKZKas27vNgW0ha/6O7QG5AHcbh0+tCfYkRJqGKzEEV9E8J9SSa1D8+o84e5htNJi+71pKIEba/xHKBx7C/zBsM8xKDa3lsxxE3ojgczyIR80vONnmVNPNC+bffDQLlCycXOz2OGaGKXCaxiHKqLLrLo6Y/+YJyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 30 Jul 2024 00:28:07 +0000
Subject: [PATCH v5 04/10] dt-bindings: timer: Add SpacemiT K1 CLINT
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-k1-01-basic-dt-v5-4-98263aae83be@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=G8BK6D9+YiBDVaveYkEZ4DtFvpj1iVXn+rNymf77fpM=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmqDOnEhV0ygT96MAh5y2z7oZE5HmxY8sHw86XP
 3un4WrhWCiJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZqgzp18UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277dkmD/9gdgvA2CjooJueVf
 i7RzHiNaPKfCE6ei5R/ssBZ5rkE8zxipnsZAuCXqtHmpcxMVp85xMiMzpTR68HeRaJHDhwi6GqC
 r651A1FykZKtXSfZD+MX0xu3zYKhu/QXZWb6CJBlYt/R3MI/BVw+t0+uW09nAP0vEPShGt+UJSo
 I7lC18QohWnnKZ4MFPAwg/1+Qzz+lzkHXEOU+RaeVLvXBfGwwHb4vOhqiI+s78EMDruoxBGaUK0
 w++A0aOAWiXj6f4mBoGfpXYSvRDFcOGSnTCMJ0BC6i/lPi0g1OVEIvoRD7XWeItAAalT7LpYHOi
 PwZ/+alkssP9eNcE+rwXSMkKIQxdd+pO4Fnqf9axNdjYg+7rtaJiQA+0bZcFiKWEjd17qVgXmJ5
 qzFdwW5S74AAWrIrptVmdgzwK3+QaMhT2JMLugh/ErLd1DCjZ9tLJMCS4BA296NK0oR3h59GPyc
 wYW9qFOjSf4Fq6ScY9ok5UC32jyyaiFOZhTD1XBT149q6exgFh4EccEug2YxKqTBQNLNWOvbxtr
 LWsM+OHETHI/afF+fI/ZI7eakACZOWjjy48ndx6yP4jV6YD3AtDSONTGKXxWk/oE+p6Mh0esv5P
 Ol7QnDdldA3EVOEBHCJNsdYpLHpLO6cJS91tKIBJ+Mank8gLMXs/EM2TikqxAPAfhjIw==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

Add compatible string for SpacemiT K1 CLINT.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index b42d43d2de488..76d83aea4e2ba 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -31,6 +31,7 @@ properties:
           - enum:
               - canaan,k210-clint       # Canaan Kendryte K210
               - sifive,fu540-c000-clint # SiFive FU540
+              - spacemit,k1-clint       # SpacemiT K1
               - starfive,jh7100-clint   # StarFive JH7100
               - starfive,jh7110-clint   # StarFive JH7110
               - starfive,jh8100-clint   # StarFive JH8100

-- 
2.45.2

