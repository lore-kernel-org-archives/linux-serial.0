Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649335;
	b=GrSstDbLrNMg90lxz/PjXrSLSCqclWYoW8h3sU0/47AljkQPrfSqyDJDcVvFthzvs2XA
	 fplXMylpRYAcGDuhLnptVPQMza2KBzsCMiA6NdMPTN4bFpO5tsgdDaYm616zk1euIUijO
	 IxH1+O9HOHUetwzb1p1ep8Tp4+wO6ZB1SHl3XTuMYWcBOK6D5yf+Y5OCQJZSHqQuCLubj
	 5dhKN4bQmsYfGn7S+Thr8CrqlFN5NxozndlngTFj0PmgEvZwUB8FI+zEcypYAGX6Ihi+b
	 +9SPQXyUTmKC9S6AReNA9vxfGi9Ey1DWNv2eOWDyX+KhAOL2MX05Oo/VdPBGQWVIQeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=NCqbgiCveDVRhli2P2PmmtvKmmMz/nrumey9OJpxfP4=;
	b=m8Olyz4NbJ5dLfI3tb19crFJRLz0BmupbSZC5o+vNZPfjDq5JMAGwWH/fIdcfZPaxdxa
	 djEoG9wXORSP253PJhqucXGHvcVwujy++qHMcvfmUVzpUZn7CLLCbaEijNAX2d5BHjZsI
	 fpeUA8OaHOTvngoq46KcbaggJel0OoGMe2GNKi7zxhEikihiUbfxKrURFmu9zgGL2gcGf
	 lzvrrEjzvpc4HHdQ4mujaQCmWOrCPKulYxiwcMLQ+dQHKJqEI9UjimCE2i6eGN8LHdVaG
	 r1yBQH4vM0O7bFZkM6eYGCmUUJTWzOV7ud3f1cVnVtuBIuAeOWnUngCi24LAMH4ybeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n0v2zrD2;
	arc=none smtp.remote-ip=209.85.160.48
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C0608362C
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E51C0608362C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n0v2zrD2
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-48ed0b68895so2392694fac.1
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 11:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793649334; x=1794254134; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NCqbgiCveDVRhli2P2PmmtvKmmMz/nrumey9OJpxfP4=;
        b=n0v2zrD2lqLetQ6g3G84j20Rrtg/R1EP9jN/aHEIfgZP25z7gO2ZiQxGvXCAE7GDlB
         61uXlfWq0KeXatPXZrGQcxfx5KL+qjl8Ea8WM/L3qjtgjFdav0xCeQmqtuo+ejzDfhpx
         ZOL8zs/i0qg5II8JNtCgUXbfm5Jm2IJwsRRbNHAHl90VZxkVOlJVtM8GdtM6oMynlics
         0uFSph9+DjaLchzU0sAY4XQtKaKLVol7oUBYq5ozo6dXkvpkhMWXaTyvLOU+BTE/Ze5I
         d7hmoEYvvJIvxp8JvzIee4YiwllP4XOaLmYYcacxwt65DI3unOeBTyBdgIMxk0iQDoht
         vlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649334; x=1794254134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NCqbgiCveDVRhli2P2PmmtvKmmMz/nrumey9OJpxfP4=;
        b=pxtA7wASW5CS09n/3V/94f19EWWNqxdUYDcyJUnueOxxT+Kea7kus4ifeZB9ezdH6C
         uVjZjsN9h2l8gltmRbfyKsH0KomIySkF9J3MaPZ1kTlXDf5SB1BeJTE4kHGhiNz37obF
         e38qdwpIoroe2Uj/RxTn4MkMzN5RzsNCEdsaTArWJ1SH/29bIYZW/luRjglJU9THY4Y2
         ADAJD7aIM1g7rKxLQYoweMiDIu+88oaM3nuC2z+0sgeDiAu/A7TuXRZDT9URpXVZvadh
         qi9a3Z24b18ACh82pPRAudVtt/uPmQUErSqfSGK80D53I9jYaWJlJ5igsOtinXTE633B
         h+gw==
X-Forwarded-Encrypted: i=1; AKwUvBxYWFrPIpZnLRSX1QqZlZqHAU8ON0ru8uaNbRx5u1mJ/2yvaxMl2QXrj6DrEfc9hYWPqQO59JDB3pXw4vg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8F+NdEeaO1K8aCI+BvAZIIW8pC0eJTJnmsLTYMsnHGiDvvwzbs
	kYvnlSXt+brV6fzzWCz6vLB9nnz6IIsjPijWGgpPY6VOVK1BPmi/MQKTLKFOZ1gE
X-Gm-Gg: AYBFou03pKW5jZhJMer6Fv2Xemp30IT1A4Y5SCnCMhkMw9xN8ZPv4M698cRvocC+iL7
	9jhrUCb2VmXPBGIiTGoUpUKd1+ueMeUQl4fyQubzqOGcAYrriX54c1cKDP2rIHDlZ8yKBu1DGl6
	xNflC9pfEOn1ajUSHSDIS+gkAqluJMxY/cDQ+lRCbpkttyNOojiOXD+A+m1+rtUsicoC9Ks0B7e
	pp6vr0JPrLujW2j/0Z/7qusgvcyCy+79XxWgvwQeho9cWbz5FpZz3e8C89t6JHOTtsyL1FLy4yu
	IWKEm0+FpiYd5SeNq/WThJMSPH5Rcpum8AxDo8Jb535mJ27pNKr2PhJaGfm6mymv7vFuwx1Oj3F
	Gp2eB9xwVP1YQF59VRvVmUxgT/3atbhwt9unS/wBocz5ZRUH2krRGei0HHqNXTrDhLmafpZjQCp
	dPqML2NVPiPOYRufbX+g5ZZAE7FFVH3QMHgMALhO2S9Qn7z9aFh7uwrOn3pO7VkrsKnerqGgQxd
	ZVlJFXrk8BsqK7rAs+2nbeHVfBqAiqTsN3oj0/OXVJdF66YBJsZKe+d+nnUorvduJ9Fkp5ul7vx
	a9tM/RWF/upyYhTRB07c5lBpQWwSXDPPx1fb6pAsNfOMtIlqAGj8aaeIPaiAEZXRRqzLvhXkWX/
	mEbk+/99hNuEAXUXw2oCTrxIFtpGrWNU0+KUYdsDew4FtpbTMTa47XUP8xUza7ufUr/sPAYSHHg
	X20vrTUpe4oakK9Wd0t3at7AMvIS6BLw268riW65aN5Zr4wAhqfOsnERMMTE7pIt22vzwJI056
X-Received: by 2002:a05:6871:6687:b0:439:a524:a29d with SMTP id 586e51a60fabf-4a9072ccffamr6663890fac.1.1793649333719;
        Mon, 02 Nov 2026 11:55:33 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a921353dcfsm7809249fac.0.2026.11.02.11.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:55:33 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:55:23 -0700
Subject: [PATCH v6 8/8] arm64: dts: allwinner: a523: describe the UART
 integration
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-submit-h616-uart-fifo-v1-v6-8-25afcb346b0c@gmail.com>
References: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
In-Reply-To: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Identify the Allwinner UART integration on all eight CPUX controllers.
The specific compatible selects FIFO-depth discovery through FCC and the
Allwinner receive-trigger mapping. Each controller supplies its own depth,
so the same compatible covers the different FIFO capacities.

Retain snps,dw-apb-uart as a fallback. The common SoC description supplies
these UART nodes to the A527 and T527 boards as well.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 85ef492ffeae..23340b9f58cb 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -390,7 +390,7 @@ wdt: watchdog@2050000 {
 		};
 
 		uart0: serial@2500000 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun55i-a523-uart", "snps,dw-apb-uart";
 			reg = <0x02500000 0x400>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -403,7 +403,7 @@ uart0: serial@2500000 {
 		};
 
 		uart1: serial@2500400 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun55i-a523-uart", "snps,dw-apb-uart";
 			reg = <0x02500400 0x400>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -416,7 +416,7 @@ uart1: serial@2500400 {
 		};
 
 		uart2: serial@2500800 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun55i-a523-uart", "snps,dw-apb-uart";
 			reg = <0x02500800 0x400>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -429,7 +429,7 @@ uart2: serial@2500800 {
 		};
 
 		uart3: serial@2500c00 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun55i-a523-uart", "snps,dw-apb-uart";
 			reg = <0x02500c00 0x400>;
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -442,7 +442,7 @@ uart3: serial@2500c00 {
 		};
 
 		uart4: serial@2501000 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun55i-a523-uart", "snps,dw-apb-uart";
 			reg = <0x02501000 0x400>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -455,7 +455,7 @@ uart4: serial@2501000 {
 		};
 
 		uart5: serial@2501400 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun55i-a523-uart", "snps,dw-apb-uart";
 			reg = <0x02501400 0x400>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -468,7 +468,7 @@ uart5: serial@2501400 {
 		};
 
 		uart6: serial@2501800 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun55i-a523-uart", "snps,dw-apb-uart";
 			reg = <0x02501800 0x400>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -481,7 +481,7 @@ uart6: serial@2501800 {
 		};
 
 		uart7: serial@2501c00 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun55i-a523-uart", "snps,dw-apb-uart";
 			reg = <0x02501c00 0x400>;
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;

-- 
2.53.0

