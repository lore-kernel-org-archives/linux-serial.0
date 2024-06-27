Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BED1990D7;
	Thu, 27 Jun 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502395; cv=none; b=el7N3AeUFK9AeYRy0X9EfZBrt07w7FcvgfdAH/L3ILbUVYfNie9MagmNOFsDqcK5a/2dyBsqvDAxfUJ1sndf0Z69ZI5SHOUMj3K4dznLO5UmHy8nrdNc6CnKam+vnUOrJ9P9asNHrfD5la0uwDkoDhylW61LkVcE9+T1/8HumGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502395; c=relaxed/simple;
	bh=CAL0vdt0flm+CxBpNXo287Pud+nKkSL1SkpFxjKhTbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h2j9osOgdDEWLwYqSWp8uMxWL26u/zmGxDavA0VKQj6njZNKuslocJuXmCpGvVygDVCRYfV5ReaMQbopUA07+f3WzWq4phTaIeaHKzaz+Ol+ykihJDDri57SBtrWQ++aDykpCzxi+IZowdaTD0hKZ01xav2W4ezR/+r24C6C+2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Thu, 27 Jun 2024 15:31:21 +0000
Subject: [PATCH v2 07/10] riscv: add SpacemiT SOC family Kconfig support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-k1-01-basic-dt-v2-7-cc06c7555f07@gentoo.org>
References: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
In-Reply-To: <20240627-k1-01-basic-dt-v2-0-cc06c7555f07@gentoo.org>
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
 Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
 linux-serial@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>, 
 Meng Zhang <zhangmeng.kevin@spacemit.com>, Yangyu Chen <cyy@cyyself.name>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=803; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=QhxdebjQDEUABfeb5LjQhHiNUi7MTwtATrqBh8H66dg=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmfYXzmTS+2JpnJbJvoOONQhD++Wfb8XmCgGE/+
 sYRZ006SfCJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZn2F818UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277R2XD/9bCRE0TdkI2qNV+6
 EysBBloVSrobHMW3LIZaChi7LyJbMzgp9FdMj5100Ha55aO4k7tA1k+Qpqb72fo5DmUvglFJrnC
 vGgFNiZPaN6xiXVwmXc41KxeecKuCkDAbt2CdhOE3ASyQIBBb5bltniozZps5tTmoigI3JsRELM
 OaN/KbI0Hp0Z0dwQT7XBLeIdU/uo1dcPR1neRyrp/xNFSwlsFx5q9jIgmfRZ5Zcu0exIFi+Wzl6
 +bJsCc8VfLMNJkGKIekTEUZtw98eC/YYSEo1Bu0lh0G3pxLleCOTKD8wd58SDU59NXvot6orvxy
 s8nRqZU7MSmDVpcTc19vvUiECXCvGYtMRysOrZnAt8C+DWRdUwHGLE8IAkgnlDNJNTLqzWqmcDd
 9CPY2wXpmItnKPW1aNFF8a4j890wvTlb1kki3nEvePjJpVAbqoSqUOrbtPX3RI8oiy8sMTx4Tth
 rjApkBWRW+K36NDdDncoe8ZUlXYqExyaS3iVGFLM509orSD1/t8yD5eMpsveflwClJMSZpmnsCw
 /HEhcMlUnD9KmZa3xVHZOMzylQjKEK8RVyzjhMKctzY8n/S8Zd1fRgNsDoxli6kJUR6o9tsRHn/
 blu2ZX7wab3ziNdvbUBp++B4o/jn5BRgicz36Xy1s/wtjrYaEqvN54afcu2FeC/KBlVw==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Yangyu Chen <cyy@cyyself.name>

The first SoC in the SpacemiT series is K1, which contains 8 RISC-V
cores with RISC-V Vector v1.0 support.

Link: https://www.spacemit.com/en/spacemit-key-stone-2/

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
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

