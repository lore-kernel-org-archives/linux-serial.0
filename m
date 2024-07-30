Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8498D79DE;
	Tue, 30 Jul 2024 00:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299364; cv=none; b=d3Ky0kcSx9EwI+Qnltn7KzyO8yXb8W8Xz5apnZg0kEWQ2QI5RxVZWJysyE08LQVQcWEkOHyYRQN8KcW0iK4rgnY9GgdcURaUtHqEl7Q2Dipz7DxIVRBjOWOwgPzcVDre0A8TNMpqYRcLNlnOeEv549BF+HAkbbr3wLKTD5bPwbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299364; c=relaxed/simple;
	bh=hvyPJgqOc1tCMh8R7+h8EQB5CPSRmBXWv5/zDcNO2j4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u3EYW98+LM60yyrBrtIHd3rdVF3Es+GIAkNzzRCz/S25NJimH8cFG71ARIEU2I2bWvd6KCQBWhyw5JV08pl5RTfairLDVy2vVFosLJpC1KeWmLSEnCHdHV7o70oYHcmlk+OkaL3WY3xv3GHgzPA2JcpBzL2H5fNgsUdwevKjlVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 30 Jul 2024 00:28:10 +0000
Subject: [PATCH v5 07/10] riscv: add SpacemiT SoC family Kconfig support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-k1-01-basic-dt-v5-7-98263aae83be@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=857; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=TZ1awhNq6EKkublblFnuZdsCVGMYEwJa+AbJQ5WzjOI=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmqDOxlXrjQ35yc+QEj2xiUXXXJUJmrW6p7WJ4k
 ZCFOZ8U9bOJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZqgzsV8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277VqcD/9W2TAjj+tuyuCeHb
 k0IQxn8FUa6KhbRtNBbL9kH2ujokaTt76xTJgzjdFKzUZV8jwhiWn9i1HOf+mIlJQfNDon28ira
 37q4DX4Ddmg9GapQCoos9ruDzzJTJSSROJuZR06dsMyr4JzLzitGowipC8jjTRv2I1HrVsT4ddM
 ZgVuFLynLo3p/iLbKnlcJNKzl1R9p9jyHBgyyB1zrtU2KZltsNoiQyDbSWRRiW/HC+P+pKIKrhe
 QpBd94W77ysFXF3R19IT47cns+4LuWC/rAUdvoVnPEaAxlW30AhPQc+9S/udI1uqVRYLY2kRWdR
 umiTfth6CqbfTpf/KqaxIL5MwhchvEpnMcZJA5YINKVcwtxmjrrWL5/g2qP4RJ94/Flm8/vJItv
 P5L2jf1z4/uNDQ9dSnQqRl0begRabAJytuRKea8tlX1B8AjwtpAMiFYx5lzxBndJtj4rGmTHuV6
 R58pNtPicGBTxEM0KLJx1u5N1q2aCP0WJiCBaeNhUv/7NIxOd4ZnV+sn0zlUiiI3v8dxLaTk3A3
 AjULZ7LIKgYJFsMDAT59tmwB/REpcvZz8ewvYNqt9bZ3TRspA6Dz/FUVp0iZFlo/RaFb265zI7D
 8Oep7QGxy5AWAWizyNXEYvIuRWb7IMQRyzQaLDv13CgwL4vp2/5dhklD/8r6yXJMu81A==
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

