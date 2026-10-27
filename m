Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142353;
	b=rSRgZf6lTGpFy6SzLpmXG6a5joLVE/w0o2C3OfC9AEu5gN0pOU8JJnwFz7rw4N02ldbs
	 VBW+gBdA2uHAjYr0lDIrOp/cdoXEcSs+PidPnAWb2GhhPC7taHcG0nhSMMO2VuKQxdiUb
	 kX6yUXtC7ZVDebzhn6TZ4cLVMWQIMtBP/0Tyb/ZN6XQl+IXzRcGzrQDB1UBnWKhMCq+jd
	 mWWwn7sOG89R4w7DPOqpA7rNHMBhQ2KigCq+yu6bSTyT6UuLwW9mQuEqsRtCJz/S75zFA
	 8oBzSogZeUOKLinwVEz6qFgxJTCd5UVexNv2DttiHBhQaYa4OcZNzaie4egNw3jT9qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=DRBWX4J/Ak94TbpMM7HoAnpLEmSCyB3p+1+fdXZAg3w=;
	b=ZoUyjpe/f2XBAvVVtHsRdMurrlqJiewYhB6FQBK9PzPS3HVcskjuNCc8/NMytEQJO21Q
	 /uNJ5wJn3nV0esG7Nr7wtX7HsvfEcT9NGG/l9xMLaFYKYJ3rWSg1PZPNc2FiCGc+d5hE2
	 8xPpRTUkN1QyuQ7zZC90dI0rEB+yMonv30+qDP0oSpyjtB5B0IPT2aY2kir6wVwPXYQ7j
	 5RcVdcXJdAyywjYJAfUX5NhNUktZTVa3fWNepO1b79wcVOPVEUFq1DnNvvnez8oqjJsNk
	 8rLzvFyzlbdHlVT16O5/ULxRF1ut++eFyekrB3LH15OJ+jGFIALpTTY8exV6ArzwRHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BTwMwLy7;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A060660A260D
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 23:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A060660A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BTwMwLy7
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7f48c750afcso287436a34.0
        for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 16:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793142351; x=1793747151; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DRBWX4J/Ak94TbpMM7HoAnpLEmSCyB3p+1+fdXZAg3w=;
        b=BTwMwLy795IxvCyCky+Pk7z72sJK4KBOeoJ42+6BedLYvg4oYFf+UuIbuHZeVxfPV2
         d7qDMlLQwwJoUyXj4N4SloDAXHaD/sMxnFnnHwmGm5SGzsbOhk9pSkMD7+EJaAF2meNi
         ZglQOSlLrUTmTSi81d9XrdJsx3nUArwdyvaQvpbEBTKEVuFpX8bSgEu7zf4SpyPw3O3+
         /blqviH0NHF55bmYVE8NceW8P+/Lw26dSFz7Nh8NyTIn6LKYBUW7HbLtXkjvWAcLIR72
         CrcNuhoX55IZHiBPKv85D4KL4Imuphy9RddAMviJkZCMvYtFNbcXvcF7WtoqvSK+qCnn
         GP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793142351; x=1793747151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DRBWX4J/Ak94TbpMM7HoAnpLEmSCyB3p+1+fdXZAg3w=;
        b=kZ7COd2HBTF3g92UdMpbc3X713Ssa7kuX3WOTvJeWxqb+pKgEgFHnzORXI4+4+0gqh
         rJORhP/YLvdH9d8XmcgwWjThj1CT+nBhAOQCGh2RZrdfOK+am6DB82MGS9Oc52ckEUGn
         NobPxzx//3d9jrux2f66RWFIfxjurxixMK2yF8Ch61qNU5K6ybKcpOSZ8/qOuQ0IkzrC
         i9U20LheJYDu1ONbRTGf2WVbjj2e0Xp3cBOboMQ6rRXipSAzenNs91JbswSM3p8jMejd
         LPd8Idq8DX30lTzQeFEoQCRAd9SLfkJfcp4zdV/3NLdsXka+FgdwA+Ne2OGG0Y0af6/L
         HEMg==
X-Forwarded-Encrypted: i=1; AKwUvBwa7ia/AAbdp1qUgIssXAbVqNEvIkmmO96+VhmmvalFkmr4D5x257DQyrxB32PjC5nlWoYDlPX8jCnCMQE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKnM8qzZ1kN4eQwEDh0MAcYZk1r0nzKmDw7d1LhRl0sp8DMCyL
	tsxjP34B/+BvMHoV6CQUklxCniEwGk8OJWzZ5NhLd9ifk18QOwlrWptd
X-Gm-Gg: AYBFou3jFmO1D7MN+NhQi/+FjdMDd6oI/+Ure3d1NXlaeGLh1uFYZ/YzvV7c7I6Lzlj
	8o7viuNww5r8oTc3X5q992F/FHti/7QPvuSBl+IKGq4Vi/QpQ2o9pUwKY3rh/bcixo9lvEnF5IW
	aXVAOUhIGDkBKo0aiCPIdgSz0c8v/02TssrslGjfVZ3JMZSiCxjKiuIf5EmdtdSRn8r/I57M+02
	m4nAE1Xd+s9KlPBNz8NqIEmpcx6uBkOyslxLOFK0VWgPSIDMaa/o6YXOsx57BQR1dcIgjBHhVYT
	j8Ao4PcoQq+saOJMh80EUVy5UftilxcMkNF8MXPYsJ7T5D3cYLg97QIws99mHIAP0UoKVVLKrDr
	QycXRLIVR0KtIs4AdjKwnFxpH/qTJlBZ66u04mk8Y/86ndFPXjadNaWNfyW1UYInTucQuE8J6Ad
	wMb3FzE0YBLfo/4ImX4/lB5OiQuuoh5YIxguKkgzwhPNsXv+n8rRHzBSKPjJevCAXaCo64e5QDa
	i4FEgNzVND6Lsbvz0lbIczXDwb92pMJcpPt5dnMb0WecqyCzHSHWqLASL/QKQv+FocMSnuxeqRN
	4xkultJl8e7mGs03up6L6tjBcLGjz8jihWK4QLzXA85GRUmacEkF3XB7ahYqSYyYnehSRBLbQUL
	FTksIzPTqdCdmHb/VwKDESqzijq7SaUyOMf+s98CvxOb7soZPYU1vEz4Z9gOjCvVK6rzVidhcfl
	T8IA==
X-Received: by 2002:a05:6830:2406:b0:805:8b7d:d8d7 with SMTP id 46e09a7af769-85abf964f20mr834577a34.7.1793142351612;
        Tue, 27 Oct 2026 16:05:51 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fb0741c9sm12093328a34.10.2026.10.27.16.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 16:05:51 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 27 Oct 2026 17:05:33 -0600
Subject: [PATCH v4 5/5] arm64: dts: allwinner: h616: describe the UART
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
Message-Id: <20261027-submit-h616-uart-fifo-v1-v4-5-d37e018fd0a6@gmail.com>
References: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com>
In-Reply-To: <20261027-submit-h616-uart-fifo-v1-v4-0-d37e018fd0a6@gmail.com>
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

Identify the H616 UART integration on each of the six controllers. The
specific compatible describes the fixed FIFO capacity, register layout
and receive-trigger mapping.

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

