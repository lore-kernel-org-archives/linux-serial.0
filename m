Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9832EC086
	for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766408924; cv=none; b=JucYuWjnz+y2IEyz73hyqZ7YwD2Fpqmlsl2rBB3r6LfhRM6WDULhxKkfKvOoYQfe3woJl9iy9mQaYHzJdVZICpqVaLnDJxXlraAoJArBDQK8vxqqH4W58oOCJWPnwtZks/eBa8cuW3wIlXErIiq0QnT85k8jZKcXhnYX45jdnpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766408924; c=relaxed/simple;
	bh=BDrE6CA1Qn9fgNQNXNAcSn19sHUGzVo0ZZdQlJwveko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QkjuEkzB1qdx0nIp0xY0gtaDloVAviHnQNiMLcGwXFHJx70n6/i57M1GvY7Uy04Ub7sCaucoFHcpZCRRbEY+F+UPwrV/bJ/pldmiyqr1fHzb4/xL571zSA8KvcDr1MqYvHRDrjlxzg1gLhHzWQIsPZjomx9JprXeeDXBasKprYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=xyC++OPr; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="xyC++OPr"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c868b197eso4124111a91.2
        for <linux-serial@vger.kernel.org>; Mon, 22 Dec 2025 05:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766408922; x=1767013722; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5UDvIvaVjkkZfBeEFqY4CPR1+ruUJV7ueKVcAIMjEo=;
        b=xyC++OPrm5cxcHCSi219vKmwvgY4D7FFV9f11zbLQX1i621pxRHVUW2lNMpudGQQJB
         lMmw+hyXdqfp0meUjACsmKQL9u7eyHg5l1jSejNZsR3hcvsLTkQKEFN6FTrEsAXGc+kt
         Bvh1jFa8Ri90sB9OGQ5ei5Q65+GiKggRILpOuWnC4R8Wg+lxf/hfbxLq2kn5LUmpyHQr
         HKaPu/UqYHE2WLf/gYJjSsUNl23MeUaXtyn5wJjDgRocnVvirHYQPI0YXI1lpWAgzHQi
         v1TfgSqQt+cAXnpAPj7bYNR73ooknU/idHhEU9QSakwCN0yAyqcqvcM6kwsL5C1d6Wdr
         HihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766408922; x=1767013722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y5UDvIvaVjkkZfBeEFqY4CPR1+ruUJV7ueKVcAIMjEo=;
        b=mgfhcQPIgM+klUv0t6+jUBwFdbwfK+GYosmC7fP3Q3D1UpFxxsyvWMS+dmUWLUPPfE
         AcoJVCpBp31JI4iE9MiHQ53HoRjV5kPQSE4+3lNPnAQne2kuuZhiCI2SeQpHVXgiywRD
         1yqk2k61244Pdn7uQAdAKsRGQGTL/JD/t18cMvObaIvHnNs2F7p0vAtfMQz/QCcpiI99
         GEVHZh87YNgwFHv7I4eh9up9wf0GkkzNQ/P/fchGqesbiErVKUuSS8MVD194AtD12lFe
         qOMlycq/4R2H6/QnoUq4mgQfDDXmp8d5JvX8653FDpqM7WSfFbd9W3ZVyNZCT3tMs2E8
         7CbA==
X-Forwarded-Encrypted: i=1; AJvYcCXWM9CGp9HOR3JOMI1x4pUGDuiWfk+Iq4M6/Q79jFR5CuGTHDl5gCoXayEJX5BiAe1r/iatHN4OofTgvJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9dLaAqX89QQRbaDNTNUrHna8tAW7NQVnYZQ0TDIMEL0wEox/f
	INK/R2O8QK+0FJCEZXmVi10ne5viWv/GiqAQa60amBtHctdwK/x66DVesneYWMq/6uo=
X-Gm-Gg: AY/fxX73e9qTG5aABYIJVXylxQw+KAT/qthjOuapzt52ccZhZKnURtzPuTN5H6TYU90
	26hPHo0HD+uyG+NFULIRGvbEXOItlm770V4Bb+E6MsFDNgo1GSctWN4cCXZu8niyheAST0V9EXP
	DOsEzH7nhlDtsTtiRZkBO2YqhQFdGlGg6d+qCoc1EP11Qs1E9Jz+md89QNeuJzY+B94Dp/Wuepp
	onFVWODYTWsFFysv6ljLm4eKV0RB+eh+aslGuFTu8quDRrpkKK1TvTevH3y4vMp/FXLmy4mHlO+
	uKlcnnavzr6GbOH+WP33LWhmB0xEmZ7E5Z4AU7PutQV6O9zaLxrMWoK7yni8GYDT2AzsOTDKqvi
	rT0cr5vVFhyK7V0P6ylEC9pVO7m1Lk5cnpbjsHn6DFQgtmrMu73HAF1KshntjmkFikDsMiteRVb
	WwOLJKUEMiyaioJrUGFF6wrX+nylNLUjc=
X-Google-Smtp-Source: AGHT+IGmybiO9VXGvZFmDwf5i2jOPeKNvQUkXJaS7Qo1wDtRYA343Aqy0CAvztutucUMXstFcLQIPA==
X-Received: by 2002:a17:90b:4988:b0:34c:2db6:57d6 with SMTP id 98e67ed59e1d1-34e921be64fmr9184464a91.19.1766408921894;
        Mon, 22 Dec 2025 05:08:41 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::402f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70c932casm12970405a91.0.2025.12.22.05.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 05:08:41 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 22 Dec 2025 21:04:23 +0800
Subject: [PATCH v2 13/13] riscv: dts: spacemit: add SpacemiT K3 Pico-ITX
 board device tree
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-k3-basic-dt-v2-13-3af3f3cd0f8a@riscstar.com>
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
In-Reply-To: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 Yangyu Chen <cyy@cyyself.name>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Conor Dooley <conor@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
 Anup Patel <anup@brainfault.org>, Andrew Jones <ajones@ventanamicro.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-serial@vger.kernel.org, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.14.2

K3 Pico-ITX is a 2.5-inch single-board computer equipted with a SpacemiT
K3 SoC.

This minimal device tree enables booting into a serial console with UART
output.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2: Add aliases node in this board DT.
    Update the memory node to reflect the hardware truth. Address
     starts at 0x100000000 (4G) boundary.
---
 arch/riscv/boot/dts/spacemit/Makefile        |  1 +
 arch/riscv/boot/dts/spacemit/k3-pico-itx.dts | 38 ++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/Makefile b/arch/riscv/boot/dts/spacemit/Makefile
index 95889e7269d1bae679b28cd053e1b0a23ae6de68..7e2b877025718113a0e31917eadf7562f488d825 100644
--- a/arch/riscv/boot/dts/spacemit/Makefile
+++ b/arch/riscv/boot/dts/spacemit/Makefile
@@ -4,3 +4,4 @@ dtb-$(CONFIG_ARCH_SPACEMIT) += k1-milkv-jupiter.dtb
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-musepi-pro.dtb
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-r2s.dtb
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-rv2.dtb
+dtb-$(CONFIG_ARCH_SPACEMIT) += k3-pico-itx.dtb
diff --git a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
new file mode 100644
index 0000000000000000000000000000000000000000..037ce757e5bcae0258a326ea6265185d761f2b52
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2025 SpacemiT (Hangzhou) Technology Co. Ltd
+ * Copyright (c) 2025 Guodong Xu <guodong@riscstar.com>
+ */
+
+#include "k3.dtsi"
+
+/ {
+	model = "SpacemiT K3 Pico-ITX";
+	compatible = "spacemit,k3-pico-itx", "spacemit,k3";
+
+	aliases {
+		serial0 = &uart0;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		serial6 = &uart6;
+		serial7 = &uart7;
+		serial8 = &uart8;
+		serial9 = &uart9;
+		serial10 = &uart10;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	memory@100000000 {
+		device_type = "memory";
+		reg = <0x1 0x00000000 0x4 0x00000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};

-- 
2.43.0

