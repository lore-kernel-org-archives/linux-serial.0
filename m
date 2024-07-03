Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ADB17DA3E;
	Wed,  3 Jul 2024 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018651; cv=none; b=Pnc7dr41YAXPADnPCazhqIY0YsVOMBV5iYjjkDR8+RKi20xN9c1fulUzQ2lcXO/vsAXt2m242GV/H09SnKW3SyZKeCFXDhseFOr7e2xgN49lsaIq8MTWDn7NdphTMrJUwflk5ag1HUgLwY+DEwMORYKBhDO7xTJFdqo9UvL2HPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018651; c=relaxed/simple;
	bh=hvyPJgqOc1tCMh8R7+h8EQB5CPSRmBXWv5/zDcNO2j4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DcyCUIe1me0wOhE26iQajFbWCpoyjEjAsk/+K5d7q5LAckSVem55J1Fze0RTGpfD9vS6/C9sWS8Y8R/Jb2e6iGb4rm7lETjEZJUPLLaXtX1K3B86+ae7SMQY8De5zBIwqT9n7GIz8GDIr1HMdSPijcWSjn2KMcDxqCcTOv9F8s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Date: Wed, 03 Jul 2024 14:55:10 +0000
Subject: [PATCH v3 07/11] riscv: add SpacemiT SoC family Kconfig support
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-k1-01-basic-dt-v3-7-12f73b47461e@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=857; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=TZ1awhNq6EKkublblFnuZdsCVGMYEwJa+AbJQ5WzjOI=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmhWaL0Vk9GaOtkAZTL4O7bVWSsJPW24ebsFPh9
 KQOugsd2gqJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZoVmi18UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277de/D/9C5KHNsyrSizjVeK
 0Iqug0ujH8tUvvpgfSiXa6T2o2UzdTiPGnGALLjKMCGYd9THx3K2WNzVg9J27BwXPOOnn2Ionzs
 3oIRMtmBI7SSpIpHgpRKAO3R7QS6dwN9DDNOzca9h518OgOgqEgZgTlQAnu1FvdzLAhAN0ZrlHn
 OsXy6OKQgZKgJL8H1qsYVK/jE0AbjAxrp0Kg7RY8mSjfNIL7148lUAEYYCYjZTvnLymUTN1RExI
 3b4YJ4iynTkDI2UoaxkvXc+w2Yk1jwqR50DIkyK4tTzHqzd7Rc3kyZ6Z+GO/DYF1774apsk7d7Q
 KtVGGtTsNXfN8/tEcq2SBBo/TTz59MnCLlLbC50geuMQ2zarQ7EOoJDCalhTuBQ+S0Zf+wWJbtS
 IGfgxj4oJsiOOGvgSdgfzvKxFDnauNOfr3VbQmUUxYQA7aacQsaWI6XuVaSy2I+VtcodnGm6fFW
 0CnaaLfS+YCAyfAEoGkf8nz3CC9qpFmPbx8ipXWwO82VZP4pLWlv+fOxkF8aaZjNs5YJ5cnVYd5
 pFVQgMMDPeAi5WEiYmmu9v0a6TwuPPKW62hPgIXSDr3zOkEJE3omAJZbSbvdOPEZCR1OkknUZUw
 42dYL9nTojHm8f412XksZ+p0M52MqJ8VjdnO0PiXSPi23V+0GbyGNh8vdLTNVg0oxcXA==
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

