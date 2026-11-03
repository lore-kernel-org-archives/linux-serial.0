Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742014;
	b=M7dwpIWEOV9jJKv+dJL/77RdAfHUD7U92lK5Swh8F61MrnQLEtQQG7JmoDFbPfb7Aqdh
	 HL0CH6dIU8TLeIzMOkA6HVYEBfboD2kaiCGcjz7LtGbAcTcz9x9WjKw2WJr7yxxbyiggX
	 EVA0Iqmt+hMiBWihF6IckeOFnY7G6ysyYaYKPnzOsWYvK4Ctf6syUdIaigVqrZNjT3IM3
	 GJOzdgeZPIIzSYTEJ4mAIxkV9XnxcgVcAFJde3p7e0ZHgjJQhBsJaCzLzQ2W87zYuCjLD
	 Odsugvcc37vavnixYhzdGb599Vx/W0ivu3uoSakISsfSIx3SXEyRqqb7MXiD9Q/MBzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=0g1OT4dACORpc1EFN+wgx+XwdWT726Bj1M4N83rR7xA=;
	b=46c1LQNOUTBfxdxWRxHcIepsjHgVST+g3IuTLq4FbqaHOi3Yl4/7ozlMKPZrhACw38lG
	 6ThV2vtl6ZZanM308EqXZaBDlfTlyXX5cOXRFJj5K9pTvcYPTOu400PY4jJRWkAr6tP5L
	 YCK51GIdkab9+6dljjsZvoIgOEt9Akb/xs760AhrV0mcBQFPhvcP2Nwyu3lvb5+aEp4iB
	 fCcaw2wTTfP0qA8beL+i44D+k6tMmbqOrN5NK/zQz9sY6dS8uaQRq7D/ZJoLYA49ma+dG
	 RF4hRJUp2wNZJ2HwrMLIeT8pgZz6YGdKgyGORP41m6sv3Ja4rFeWbQK5fsHBtcwAnaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h2UYIqFd;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7832F606D83F
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7832F606D83F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h2UYIqFd
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-8451a619da7so18383a34.1
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 13:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793742013; x=1794346813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0g1OT4dACORpc1EFN+wgx+XwdWT726Bj1M4N83rR7xA=;
        b=h2UYIqFdlkbGXb8r+nRW7RUmVcFRGiuDeXRFkUkcabOf2xlyGIjS5PP0NCfs0SA+aQ
         bXfoQ/SjRVyC6Q0jCOHP6+iH+xk5yrC2F3Z3McWUQ10v2Hnsb1owzVqSGpI8qwZKVj3S
         ROX2njaoYLCgQrLywZgtPhG0JRStcOR3l6jA2qDXpz2Qhgi9oncRmd/ZSznchyuUhtMg
         HyEDpsLu1esInU3k7O6wdgEHDnRTT6KmUc3oh3hc73iRE29kDnOqwwbZKoCkzzWso6nS
         r5CbirMIiHBG369IEALegsgH5pQ5qZmuJPDQONYmhlDIrqBubi+zzJS5SuGFh18wi6tE
         tWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742013; x=1794346813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0g1OT4dACORpc1EFN+wgx+XwdWT726Bj1M4N83rR7xA=;
        b=anivRiB79ybMUMi7/+mY7DKNhylAWf0xdML4fDeu/fXghl1IT33rrboeJ7NSxbCdv3
         ZiAxHaKe70fw0BrNrmubg+JNAV/7bYEJc7uyETBMuYS0nV5cipqTCF7Kt9DI+stF71xj
         FXjeuAL3Il1LOaxiJsTkd2TqsztfCkZcJhFlqnA863RZI+J+lxkp0M1+ZZujHgwCJQ1N
         d51MG4yFRZIsQoYIV25htTqyS078kvBfKIuB7TJUyXDDC0Nl08qIgpjZQyCf49tGXlwJ
         f1KUciG5LX0qKbYOdjn4avgIfOXXvh0FS9P9RFWBOlsUk1UfA3V/cEKR2wM0er0l04iR
         l8nw==
X-Forwarded-Encrypted: i=1; AKwUvBwbdBVtG1zoTGk8mm7geRkRcN23rx+kkRlfoiyWsTwNQ9vLFUyncxSikiwuTOTe6BhuvSo4GvuKrnCLLmQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gwhP/dn5yX+ZHA/oy7KwSVFB5fngiWWHfBMqYbYiWVjKH5tlb
	AWmGdTotowU70pwbpwTRJFK7rvVOE21OlNNN42OhzoOGO1OxznyA0WoJj2jmY0mv
X-Gm-Gg: AYBFou0TaXOBCJJZJ9K1VfQcjiuSU33uTUnXLPbgc0Qaww3jLp2ZRSzal5Axi8QE/0+
	zJUGfRJVqoaYb77Nic4bBOGXlX4ndJIIZvg7KwMG0wNiLfTfuc1gECIq6KNgpvs1A0fVeEIscz6
	ooBNvv6qPhnLQm3EdpoRnZH+FM9ADL2KHyVbRtrFjdva867SpthfBzdMFgRTSs2YbAFWoz6N/lp
	AmeqHiaHYasz7UE4QFw/Wdq+Kv4BUS7XTknyAHMtTbRX7hUIVbeOpUSHLtfx8J32CKSWnSrBjTj
	Ecdi9Kvwv6dDrY1TUTdXKPcnzJf7HUEfVJlyrHCYtV24KG7jteI7YR1hhYb1gE8MNEV1ixOEA/u
	rIPRe0B/v2ws0qay8hyamEIoZsjZ+morPnQcPUKWftHD85/O+lCNLmsJc3yZYHghs8zRpj9xDQ0
	NK90kzbtBNmPyNaj7cJx44uG+e/gR5A1+6jvpFyWwokzKQZtHXHvDaN26Z3fnIvzUyE8RPpzjLz
	TFfm061i9hudowgrRfFu59kj0QeemEh/CTDo1jvrcXDlp1G+iQ0x8uu2qhFLZzBhh6SoRelM9ae
	aBoguUhzbAzZiwuMQAmujKbjPY2qBoKpXFb4fgpqazAkrkSHLiFqyaAB8lR4WMS+EIj1XJbjTri
	o4Wb5nMzgi9o/AwEH3/bgt/V7eAjpR4yif5gUBbTr8nnz17KoxZiEp0rbHZZ4KrJ8ueiWSzvZLx
	0WholXJe8BJ4Qkjkk3r5T8r37XV/U5CVXUc1/lwFgR2tzdE4n9517e
X-Received: by 2002:a05:6808:6f87:b0:55c:859:adc with SMTP id 5614622812f47-5640def4593mr9802652b6e.55.1793742013486;
        Tue, 03 Nov 2026 13:40:13 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9f9115csm27060b6e.11.2026.11.03.13.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:40:13 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 14:40:01 -0700
Subject: [PATCH v7 08/12] arm64: dts: allwinner: h616: describe the UART
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
Message-Id: <20261103-submit-h616-uart-fifo-v1-v7-8-c9e248d685c1@gmail.com>
References: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
In-Reply-To: <20261103-submit-h616-uart-fifo-v1-v7-0-c9e248d685c1@gmail.com>
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

Identify the H616 UART integration on each of the six controllers. The
specific compatible selects its fixed FIFO depth and integration-specific
register setup. The driver uses that depth to derive the shared DesignWare
receive thresholds.

Retain snps,dw-apb-uart as the generic fallback. H618 includes this DTSI
and uses the same UART integration.

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

