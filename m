Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740843;
	b=yEf5CWktxmOK6dscDJKh53MROdkQkNVowAJjqpyeza65bDEqOXcgd1L5LjWPiyvPneoJ
	 g1BQsyEHDZQZptAL2CAF6mp2dyQMP8ZngFTqjkTVz+aCAgqBL/TIXQI9+mnP0k5mky05S
	 XtZMdXoHVD+UNgxYS2gAinVQ16OC3Wep6ogGgyde1SGAZCJ7sMLiHeJ0almCqvroaOaiR
	 yQu69S8xj2fm32RjZqpN7ADk2tPLeI6JTTJYugTyNCksG+p3Q5T4zwi+FP7pPwt++u0aM
	 Q7AlkrH7acP4IS3lfp3cGmrMYuOI/s7ESJfIlvw0QLxaMWoigACHpexru+LnZG89sPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=hMLYY/97Uq9CVtG7QdmP7izisduGXF/upTM7pDvQJmw=;
	b=mMIuxHBsi4G1yzI6OsVg6KBYySQFhvOucGfzODg1oo6SWDfOytcZFaPYm/48I2DLkkcG
	 6wah+7NTPW8Z5oN69IBNu1Vho6Bn11YgUnb7iC4GhliJTLM3j0GaXf0Q6W2fcyRiQUfyN
	 fvW3GmUcj13BKsz6EJDU9SpTM2DMCSyHJdcrbFpAiLhNsBGu+I6by6eZZAcFY3D2akuKy
	 KpR4rUHaA8fxrv38zsQ6PgQ4NoYBTn+TWgpsHNOj8RxhjcepEvASVf/DL72nUBh0tUzXc
	 xh6FKoEY47FfJvjrl9YfCwkvIWH+5gFxRU8gT0H2oU0HwAxUivFFwFXn89Ewm0fc4FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AE+5UgD5;
	arc=none smtp.remote-ip=209.85.167.181
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3074C606A33F
	for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 07:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3074C606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AE+5UgD5
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4af81963f35so446658b6e.0
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 00:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792740842; x=1793345642; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hMLYY/97Uq9CVtG7QdmP7izisduGXF/upTM7pDvQJmw=;
        b=AE+5UgD5XLmund89M9O1VO1HJzardo2DXQUzwyptN++zcMGy12TXIXqAxCCwIvBzzJ
         Dp3S2aCqBjIDQhLAMjRR1ulBCzqKMiiAt5eTeaAvU3ky6iB4k+8lR5T3wQmcdUTzuu8D
         AIwf/du+/mq1+p53YUS7iHJSK2hPdd5Yj0ZJnjTvx+hxwSv39IsVwJYS+B9Rf0zZ7I+u
         nV9eL8e3upF+441sry0/P9AN8XRaJFlsoL7dnKjLnMerhUHWSPwErL2YRlNSJUscRnE9
         FP8KDdo4TpKlvJBj83bJgD33SXd9c/LH8lhMYe4U9b0njue1S9fvNQZjSEUJhqxTsKZ5
         zUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792740842; x=1793345642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hMLYY/97Uq9CVtG7QdmP7izisduGXF/upTM7pDvQJmw=;
        b=QmGTTEFx8rdsfIJ5IKLAITHCpbzG2ibPgAo1V7gXQr5LRQVRuSBBAQOXqC3O0GjpIo
         zyxjnK21XsNZP+T5zcIrODZdIORr9zdNmVaItg8kJEO6sa7wo5mqCRjaFEqhvHIpn/rW
         rhFOc+v5FM8IH40Xs6lrER9et3m/OXS8LO2Rw4kVba8icY0nTaMyGDWVAxZs0YxZkVmG
         FHbQVisNZIAM/psZzeNSqSfqhq9vsnCXSPZ9L/jZydqPJB7XyaHjB3u+F6+xcbeJcEiL
         koIYPclcYiz4OMCj6tOiyf/WrB37HxWloDZiN8cym2pOP+8pe9lC+5aTrS5ZFa7xcmP6
         WehQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmxm2NF3H9J+W2FM5w6YPmL8qw17l4tsBze2hrKlVsl7wfGV7wgHrdTQRdvCOh+POT6LkFq6qjGMA8NVw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5conOM9mhDQ2jsmH3RcWgQrlqDl0Jo7Suv/j17Ez/YrPnvjaj
	SU1fNCRi7ZBtIvDXdEm/jD9LiDzungtPqKKmfVLVICBuYlHIIZWRtFpK
X-Gm-Gg: AYBFou34TTRwa4mGl1O8UqMGyA2da8m816YMtFI0I44aWHz1Z5Lg+rP/PBK27XPg/s3
	vc0/4Spmd3ZWd150k+p59rRHCRfwKTfA5LXJpy+WW1FDIPrS6E0XenBfn7UueNxEfsUY5weoHff
	q0tGIZiBVGYS/QlGGwq83YI5ssysoJNPI0O8s+i9CNy94e2h9xnjy6YD6j6HBtTl4/KFzRmYmbV
	/btXi9TbqIvGUX7Id+07xdH1+ntwKbevJKuySHsa1f84/Z6O3TglH24TssgbEpMQBtkMYF8iiLl
	gvzF6RH/r36qeWDhinxE3tN2KX4F+SDmoZIJkH1eZUNjs9a8/j6LIlMPXYetDtoUBIKUNYTnFP1
	Bxv38rY2PgbZ2vJwLddz9SBkrmLul5mbiu4S4pcj8fzzFwpL2jllJbaOpdR1KY8wUrwzraK9glt
	Hg/Ktz6zVdOQc/qAp0sTPsPs99+WvtiJHUUMucIw4x/edIJLHVkRHHuxKri3enyQn2fPwDgtq+b
	Yfcu+6KcCsmQ1YLBjGynqyP6IHt7Es4wxa8vu5l2gIf8wUCbXnlTQvdS6I0mIZ7hzQHyrzG3kVl
	Cb6ILzwbw23WqkHSpHXbqP7+edXRpLsIqKIqa3X64h5Q7WVzRSX5ipHeiu6GVShUnf/wWdpjz10
	32sbbXJRBwEU8CazlQdUnR9nLyfRo+2jk647bb/a4+6LlUeBTrqw0DtDR0UrQ3t6fCuzX6BXqHJ
	LfkVE=
X-Received: by 2002:a05:6808:5092:b0:4e8:3707:d4cf with SMTP id 5614622812f47-55be7a45f4cmr859576b6e.0.1792740842142;
        Fri, 23 Oct 2026 00:34:02 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55be9880a99sm909562b6e.14.2026.10.23.00.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:34:01 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 23 Oct 2026 01:33:51 -0600
Subject: [PATCH 3/3] arm64: dts: allwinner: h616: identify the UART
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
Message-Id: <20261023-submit-h616-uart-fifo-v1-v1-3-e4a3bae2eba8@gmail.com>
References: <20261023-submit-h616-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com>
In-Reply-To: <20261023-submit-h616-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com>
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
index 1598e86259ab..6905c9eaa249 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
@@ -538,7 +538,7 @@ mmc2: mmc@4022000 {
 		};
 
 		uart0: serial@5000000 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05000000 0x400>;
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -551,7 +551,7 @@ uart0: serial@5000000 {
 		};
 
 		uart1: serial@5000400 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05000400 0x400>;
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -564,7 +564,7 @@ uart1: serial@5000400 {
 		};
 
 		uart2: serial@5000800 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05000800 0x400>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -577,7 +577,7 @@ uart2: serial@5000800 {
 		};
 
 		uart3: serial@5000c00 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05000c00 0x400>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -590,7 +590,7 @@ uart3: serial@5000c00 {
 		};
 
 		uart4: serial@5001000 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05001000 0x400>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -603,7 +603,7 @@ uart4: serial@5001000 {
 		};
 
 		uart5: serial@5001400 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "allwinner,sun50i-h616-uart", "snps,dw-apb-uart";
 			reg = <0x05001400 0x400>;
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;

-- 
2.53.0

