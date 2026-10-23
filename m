Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790377;
	b=xylNYte00ywaxi/YIPnKVzSUCkuaZ7/fH8OsF3c+7zblwmUMMNfW64Y5WWvWt0yc/JjC
	 8xAijylcBNCMUFgtjs7Zdng7FjjGUDEV7ZTM6kdmAy98hNPTa2xWG3npnmGkEST5wxjAg
	 KJbsxTiZAy4ga+gS3I1E4SxFno02qqup4AEkhiVu9fJ07xTyin6NKn9q5kWe0FlbkNOV+
	 nhVV9pg8O+HETlJosGNTBUwyuSOTXmId4kqTwroSDU95m0ev+Wvsh9CAa2vVU1t1LMBTY
	 csRPoGU+ZQCfkYvSNgb1nef32V9i8YShi8vXqZ7tVg0wx1NyZU/cJccEsBAiTY9y3AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=mVsOr+ec2L55sOlcfZggstu7WJwFcYb+XFa3A0v3Vtw=;
	b=aFhjodQE6CyIwGfwalwRJ/5jIVmlGmpIY9JB0PSIrXL/m2/OK5bdiH96hIUfklx56ey3
	 mgZJtuRCxo7YBF6yty1/XKyeF1l+d+Uu6EMclRGPsAvsznluzZGMaYTxAHZN6E9gXOurZ
	 mdvfsy/JgJsDbJd5grZpdQBddU++FE47IENw6iRQC8/4Zh1i334GXoxoCnLesKAo8C6fY
	 nzYoEg9EkH0hRTtDEjCU4nhhFuaopZeQdW4uep2URBZA8C/QcZKKiFHC1Yap8grxyVBF8
	 fKJcqiEw2pzXmMTRM5rFJFWqX1LkohiR9KPy+s1/JAIZ+qqfPknrKXWfjneGhx0WIrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s84EnQUw;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E48606A335
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 21:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26E48606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s84EnQUw
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7f84a55e31aso839759a34.2
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 14:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792790375; x=1793395175; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mVsOr+ec2L55sOlcfZggstu7WJwFcYb+XFa3A0v3Vtw=;
        b=s84EnQUwh51TN5JAgndhoT5KOgs7U6N6XwybtUOHCnuENP+4Bfe6YjQbzPG8sQOAN2
         beWfQi2nybUsKw4r7MRV9hgxTFMkRoMvNECYToehWpfrzilR2AYpg/x8bP2kr1jxOkKa
         mo49KYtmW7X2mzthF58JQyNvqzFkksImrrDnGdCqW+Lfl1tKy7lQIXyn+FryfmvU7mQM
         h9b4NzJ+/PY9soGIaEP1g6u+DfvsZJikWsb9yBkmnwPNCi/7CLCqqjP/PGIkZcTgguQ1
         tyPIHy+LB2e2RDXKV1VtL1LPRmeWSu6f2daZ0qqMiAf/2UE7ZfP9eItUxBYZJdAI3Y9o
         HHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790375; x=1793395175;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mVsOr+ec2L55sOlcfZggstu7WJwFcYb+XFa3A0v3Vtw=;
        b=BNowA4NTC9cHISoBXcNGPnbF4kzQNTGBp0jeam54So71lvIlLOoTPN07+yKkXSA2K7
         At0799D2TI+OysZN4EnbkgT15IZW+P3xjveW5onXlCr/Y9P4YbFQd7/SllmV4F0Ndu76
         +IRDOQsA8AHrJfUJIHfx1Pl3C/B/wL0APPda8IZXIT2oFxP5tqFTEX/lXhYjDeaHXshV
         ekKxMrH7L6aRyMgjkHJg7qmVUhIUWoWzqF5XKIo+9pokIiBbv4DA10Wj9Q+UY11SvQY7
         X0gzKzKhtZEtd3bamTX1EM1Kv6G/zYiLzR7TgfyJV3NFlI62RwcJy18VHPMC0ZEJyumt
         Zf5w==
X-Forwarded-Encrypted: i=1; AKwUvByyfvqBTjFVWTp2DuoHPvVgPQqb4wuXf2TZWaAi2nX9CNwuwsX8RngQhgni1mFE1P/MbJ/kLPEJN4l+Tqw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSXt5V5MYFYjO/Tyzd4GEi7oyUffMnnvUREV9F2dJPT8Qjj8oL
	BXpEfHclc3WITjLiUqr9YWLjZW+3CbPKgy+NsGJM7hCBxkedNZeLfuqi
X-Gm-Gg: AYBFou08L7r0x8KT1GoqgMOgn21TxZefokAk1E/sHsHcfp7rT5yd7JXqxoag8+nKazd
	gcuLwCXIGgOkTwBy/NyKgf2mX64EIy0QUvDs4Qt4Hesn8jD9MhC5n/U0ZiedI4K6SaFoftRzm87
	kU7wwEsAjLWc7vAFXusE157av7NYDNvM0snGPDbJ5HOCUh2BvoJt+lDAxx4v4s/kn7LbQ6/mMbL
	M/t9OPBa66E07dd8+GPRvdnx7Dm6BhLNKzpd78cUnx0Il8T2iyWrTNUpq6VEgTEwo5AEVz6L2Ai
	bJrqp8F4UYP8crObYgMneW6c21c+N5LtuNU4f+9BaexdTGKRjiZLjNq3GBK5XEquNisTrtXC3FK
	phRZ7kiwkWH/YJDdFLLTvvzKGDl8pAPnaxBXrhw9XMoapkqj2ECFb/t1G6fXcCLtnWEYVM9b7qq
	0PnobN8/As0ZqPkYUU/JWQ2ddcWbZthjRpX4WJPyloJTjULj/+ulMJvrU9NMbwz/DQDIVPj1XSG
	kddUcp+u5UVwN/v/veWKN4JWOXw26aItfGdBmZ4pGwuXsl2H6sBmaONxhN82zYF3GDjI64kRsi2
	9/3JLJraaLaLjOYPHhw4EEB+PN4+ysi2N7BO9cQtkMm0nWUmsKQ7b080SCL++Pn8jrvWwn6PKii
	gniQCikzBgbukr//1hkXbl9izClw7mXU8zMiKU4Q1sNUeXGb6pU5rfvpJcfdElyrjux71oyhikA
	HaaA==
X-Received: by 2002:a05:6830:906:b0:7fa:5c49:523e with SMTP id 46e09a7af769-850fecc32fcmr525089a34.23.1792790375055;
        Fri, 23 Oct 2026 14:19:35 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850f8458d8esm565721a34.1.2026.10.23.14.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 14:19:34 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 15:19:29 -0600
Subject: [PATCH v2 3/3] arm64: dts: allwinner: h616: identify the UART
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
Message-Id: <20261023-submit-h616-uart-fifo-v1-v2-3-af0593504635@gmail.com>
References: <20261023-submit-h616-uart-fifo-v1-v2-0-af0593504635@gmail.com>
In-Reply-To: <20261023-submit-h616-uart-fifo-v1-v2-0-af0593504635@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Use the H616 UART compatible for all six controllers so the driver can
select their fixed 256-byte FIFO configuration and register layout.
Retain the generic DesignWare compatible as a fallback for older kernels.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index c6b3a3f8359a..b4b2f85726e0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
@@ -550,7 +550,7 @@ mmc2: mmc@4022000 {
 		};
 
 		uart0: serial@5000000 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05000000 0x400>;
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -563,7 +563,7 @@ uart0: serial@5000000 {
 		};
 
 		uart1: serial@5000400 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05000400 0x400>;
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -576,7 +576,7 @@ uart1: serial@5000400 {
 		};
 
 		uart2: serial@5000800 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05000800 0x400>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -589,7 +589,7 @@ uart2: serial@5000800 {
 		};
 
 		uart3: serial@5000c00 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05000c00 0x400>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -602,7 +602,7 @@ uart3: serial@5000c00 {
 		};
 
 		uart4: serial@5001000 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05001000 0x400>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -615,7 +615,7 @@ uart4: serial@5001000 {
 		};
 
 		uart5: serial@5001400 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05001400 0x400>;
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;

-- 
2.53.0

