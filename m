Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649331;
	b=dMfxvc36fERO1zUVqtZMtxPIznDE00dIuMl0mvzYFLhCzQ2PMVcLH06QPgjt9MaI00oR
	 cCPXPJsS8Srj2OaFBpQAIwH6WmOIozmGPgA5yPVtQ28wksiF+ZRE7uLQQ1HFwJaOLioQx
	 WnwXaOAjqYUN+SleS7RbYde9sgttUo7eXeNS+pnDZVYyaiU3MzoL9FKF/HEDdUoZw9Ape
	 n1NcKoKsgcMAr+A4nFL+BjgW9J0dHcPokpmCM5flDhE8dOWf1AL8lh4lmbdHcr/BHkgww
	 /MovyxymJQKVrDxzR88z71kPDFfj1xaOzhFbkamWz5LftmoEw2cKniToBaRlP7puyeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=DRBWX4J/Ak94TbpMM7HoAnpLEmSCyB3p+1+fdXZAg3w=;
	b=R/qvihpEC6/dI7OB/SHCd7MBXhcMOU8R1aepzUOGcNASiXGxh9pXPb7BJlJKa3sZFzKr
	 38pkRHPn5g2/Izps8UNbQ7xXGuzkgJ5ej0y15vqlKHRwk5WZF1m73Dp3QbLmOnhF/BvSK
	 TAqq3Q+k/G8Zdv+IQ3u+hNinaOEVGVjCNBX9UumGq0ZoXTrBKGzdmhNzhtsvvcrrGQpIw
	 W/t1hmZ7bfNNq8dD25oWQSO79TXj/2iNGGVv5xK3JeUFOgNprTlCADthJwVyTVOHoZh1X
	 2LMM+BnRrLoAkBDvyE0W96nixp4wqcIGtw3EDU3QyV8e/gwPMi7OGTuyUmvkxTBaNrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="W/VHu2Zp";
	arc=none smtp.remote-ip=209.85.160.44
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FEB6082BC6
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21FEB6082BC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W/VHu2Zp
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-48eee44b908so1909863fac.1
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 11:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793649330; x=1794254130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DRBWX4J/Ak94TbpMM7HoAnpLEmSCyB3p+1+fdXZAg3w=;
        b=W/VHu2ZpXW2zipVHX/rXepXOiugOQtCaQnYvpUHnQkWjuFZfbFX0eq42B5jR6wADzc
         h4YjznTb2sYaRbl5uNBwLJgB4U9u3WReakR5px2gq0M3QEqxD/svXvEs5Mf9uvy57UYj
         H+LHqnhM3vq5WsVC2aUXbXX0dBeTAzRHCRxOuEdyQAYMdesUNkn3EZfYgAJhdHEsMaTn
         LJA82YROAkMOcidx5K75HK2IR0HUUsj/8aPck/+3giSmxK3oMKYmJTwjYo7/x5Wx6YUj
         DAGa+SiPKyMyxb3zgroXYtOYgayiHnZnrDCBWKLwFFLOnb/5yeoidrd1fMzXm8FfRxgh
         KB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649330; x=1794254130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DRBWX4J/Ak94TbpMM7HoAnpLEmSCyB3p+1+fdXZAg3w=;
        b=ERE7Vo+hv6xDOJ5NLWOdcpThYMJeK09wm+qr/KX4u/xplZomwxzC838tiS+jTs1CAw
         7g6kI6XFFxgg6yRL2qG0hLpbzKpnz/72+oZAJCVqd6rKtTMh6l4HZ4SeMfSJs/a7ReS2
         Vh2BxAj625o7WMPBK+9mJ2AGcqX3gUux1xRNIsym62wXB339Qron0G9nZ6ldt1kIKXyR
         aadYydjENeIbBQOvnYsArxTn8d+XM17vIRo18m/krIaC0ukHroZd7AVn12aVfrZ7KmkR
         MU1OTtbqq3wUN49fkm3n1hQB+sPK6nGor5Y8MpdrAiLaUUuEp9xotGkKlInLQ75DMRVQ
         Dh1A==
X-Forwarded-Encrypted: i=1; AKwUvBzqV9djHtva4n20DtUsnRyK2uZR1jIcysMpYMNriP90GeO2k7ZQScR/dxBPSqngU6Y8jmf7sDkhQKPNEhA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8omHsTHKXqiluSz4T7fJZ/+yvA20nWgJ5gOXUyoMg1bpRNNl0J
	/LTRvbBsjJbhn/errRy/AgHQxapuZKJTAw0Y8+PkutWaFOFnsmmMl/ce
X-Gm-Gg: AYBFou0iFOF3FdyevmTcb5v1ikVCPC+X+ddD9cDZgNFuLsRZisomlaxYV+909EwLQY3
	g97ipt6KUq9GcU4trXvwVMBk58JdDtmV64ThBwSxSeXteb3jj6qyBierKBN0rnQzYaayyHqo7ab
	aAaaleRWuhglsiJ7tZtpP8MOV7A9qlGnldIi65lJ6GDZg6vpZANZyDmGpMc8pHqjtU1MKCWneoF
	lodKTVCL9Kdw6EJyCZQ3JVTE/R9rQ+LUrujDg5Evej4C3UW46ttYLX7E5TbRonGGV/nJ3cvqfhl
	q/fEjqRZXmqbULLCpGgMaXauwF4p1L37oQfVkK+xoFmEgFmN4NH+u5myNarDkdPq4WRGoTdvQxo
	MzUt2LQFUWUNh9d6wmjkpe4MdE6iiQ0KxtuuWMMZ/ivWNzGJwodjrKfi3cuPTFcTDK0fnePZjlZ
	2647KOLdm8p6ZqFoJSU4iLVMfCIkwU5WZ+WGFTYIGH7GA4vl3oYPKn0mj4vQmyZeUgxqVlJUkLr
	bb3gJR6Ou8ZnHTEoGOJIt4M9LTDYAvntyoeqeXFWZymCnt5gVNNHyft6VNlTX6BFos0LJuswizS
	O/EPnulzo9ALxdrXmUXvcPxg33xpz1LmBJKS7biGpqQCRUEF4MgCHdQythX4cIHn9MQzo2JUD0y
	LYa5IyM7xT5cTZu7lJ57m96ipZph/5UH0cpYNwJ8NTp9dMeoZoJ6XHrDw/tEMcFfO6B7BaJf5D6
	Asfa2xvo//M5LqAfdHmAsNf3H/39DrcHOhgAIyGKEXyPF6dbpD1HSxpvCxUAL4o/SAD2OC+/su
X-Received: by 2002:a05:6870:3d86:b0:4a7:4cd1:6f37 with SMTP id 586e51a60fabf-4a90764ba69mr6695598fac.19.1793649330169;
        Mon, 02 Nov 2026 11:55:30 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a921353dcfsm7809249fac.0.2026.11.02.11.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:55:29 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:55:20 -0700
Subject: [PATCH v6 5/8] arm64: dts: allwinner: h616: describe the UART
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
Message-Id: <20261102-submit-h616-uart-fifo-v1-v6-5-25afcb346b0c@gmail.com>
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

