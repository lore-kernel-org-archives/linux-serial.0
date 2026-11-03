Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742015;
	b=OK69SP/XysVZQUo8UYafINNnOQr2i9TQrGOzL26el0E6I2G1MfiQhno5hLGPO76UkS+D
	 9T7T3DEYQksYrAbcCYLSCllUhltjnrjcKdklCd0ZQl1nBbQUi5fS3pXnspCR6h5ZUcjas
	 VpdZp3b7S8iCFaRe/hGhMfAawLIBlAJl5cNxMvpJf4xO0lhxIiTAGuRvee+ng3Zf1esmQ
	 UqWjIkMgzNDzP2xWNGOex9fplDIA8SieNFEcQwc4PUlVo/JeKs5itoiqvZofnbWeqX62z
	 iJNzeV1yft+x9QGSeR7HrIMO8N78/5l9N7whhS1K1XjgBwjgZA+VyGuDJ55l7dNTvWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ZsGYkHSaF8D1INVVG7IqcJD0MRHplG6cSUzvau3umEk=;
	b=EI7zSON2nruNbx0smbe5H0PzTG8i8pMXwdppbXaZsESMRN8pFLnyuTxBXf9sc/4PymTu
	 X+TQdmzq27HjpeSP+jj5Q0qSrE+sIUfDMpf4fjKEro79u4665XSLeoxx0BnxkEo8cVckO
	 x2kz+KhSvzg6erajXO3hTO27uDzsLk3IsofvhFDMo8nRQbIwkwuozvKkt3HJI6J5/TguI
	 jrtx2gasK6lZvdvGFoeOSdE9K27gqPZZKymb0mRrsYuZI+lYHn7LYoIWXy16pPUrg/flL
	 Xdbu7wI/HngTgXzwqrApeUzMExZqSQZOixW8vpPFRCXANg/OOjEAXBEuJ/E7d48C10A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ezFzqB2p;
	arc=none smtp.remote-ip=209.85.160.44
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E12E606EE81
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 21:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E12E606EE81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ezFzqB2p
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-451a49abd8aso102905fac.3
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 13:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793742014; x=1794346814; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZsGYkHSaF8D1INVVG7IqcJD0MRHplG6cSUzvau3umEk=;
        b=ezFzqB2pNszwv2nsMajwEwrlsXnChTPseu0ngTqhGbRKsfjqRzQDp+73bjr+lA1ARJ
         NNwz1/qfrk5c59LHztMRDIA1vsRyM/VOCaOcGEOJb1GYnWqHoQ/4H1VK6BB90Nd+rUrv
         1YXht9wxF8gl0I232NhMFI94NrdVB4kLpQQklWN0eXedK8Ey50KG20MgcOT9A8Sd484c
         vPeXbqDSLSIvPz8mX6pLkGxV6RATZ/kDccHR8alRRSZ1vyAhCwtoOnZP8FBkX0vMCMAY
         nJuZjNarJnEyQCW8yTnVfo0Q9XkFRZ4Zx2Eo32tcvDwo53WnuMmbEExqyOv/Afdp16VH
         Fa6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742014; x=1794346814;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZsGYkHSaF8D1INVVG7IqcJD0MRHplG6cSUzvau3umEk=;
        b=O+/xUlIFSMupMFkmUqTzqsYset3DmISU9pjBF3yTIAaZFr2yyaG2LaREJFOuZENFCq
         nSVPRuLjjVyuXeQdpI5t/CXPQJysjAskzFqe5JqrvUCvEUNTr0MaMyPpdt4vcElNOKE3
         Ef8O0M14jlk3oGjPG+vmDmMXyUQPPVHlivZosZkiF5tvVEl9rU5wLTfOaGSFJ3Fcx0VN
         vL0gWiyWmB35OkRRqI9/ReoSf06OVJli+CO+Ij0571+txOFvqFkXxNlq79x6qlarw9qc
         GTlSAMyahi2R+rxlq3J8tqbk9offEhYZJK+1uJxwaKyy5AJGtenBMouzOPSmOST59pyl
         dAPw==
X-Forwarded-Encrypted: i=1; AKwUvBxOAXvO8hoxvz/ViARpT7xAGbJI5+YvO4b9okukqOHw0btlDhDAPbRCjOOq8HIvV9PDf5OxBTBJTjzAU7A=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KCHHsqFAJ25B+JxO5QQXKNWkXRbxwk2y2kaRBmdrYNwkqXb1j
	YdErN42ARYovgvnLsr76LJBbbU+/jxXTBM3BzT2jvjdaPAALfHiX+3iK9bdqRclA
X-Gm-Gg: AYBFou26KoLafMH3PByDQ5/ljksF49LJ0ubvpVwAtVfJMPwL0DGIPYib517ljyI0viC
	t2sro1WnW/2luRczFe2JIoHFzgeVHDBc/dUxee74eddXA3VdfbAzb/tV3aiICIToRoacvuPyncT
	ebkd9xwHTetB+FXymOvsJEO4hn8ydlCXiEhR/YRanH5nc6C1QFXmoG+BAUGymGdEwD4aH5gwmuj
	aiUiTAYF+QzK/RR3wK9ykf8aFBTd+gzTCQuA+0I376eX3BcVl+xImMcuidCmH5ers8AENyKBvYR
	RgfaMMkbssRNfBm3qP9QTLozpb9V8L6fjGQcj4cEvscvAcx3l725GrwqyipCxSd7/TthwWJnCvG
	H0ifMTjvUraJdpOUv2BFWz8VxcD3YGWA86ReV/3g+mS/aV7yinWfCD/nUIrwX+R/ZbktgaR8akR
	lILa7JDhpuh0PeJLpx+P3swRTgoR8G2dlTwLRlfo1H/7dkPIF5SQL4SNXjoqX+DZBCCt8xTDgtE
	wJrrVSK+PMMPwoXG6AN3NFfxn29lhXHZD7bxiyNn014Blb69qF11Hnb6rBeaoeu5LZ3px5Ng2TO
	U5zh/aD6QlV8CWeNe4B1NBZ+0Cr+ywjxqOMxH2HFpxmnZEca8kDtAHddTdp2K0MwjAT9K7RMfR9
	6wx06OO0iR0k+HIYnU57JsKxO8v28sm3wh9w1mw2kLa30IhaEECC9cZl+9SDkqKo9hpdlSeQB6N
	06wE+3ihbl02h6wyR1H2fGJruKfffgF5QOlqoHLF+kGLBegduohYDU
X-Received: by 2002:a05:6808:148c:b0:4b9:e65b:8c36 with SMTP id 5614622812f47-5640dddd764mr9603574b6e.36.1793742014606;
        Tue, 03 Nov 2026 13:40:14 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9f9115csm27060b6e.11.2026.11.03.13.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:40:14 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 03 Nov 2026 14:40:02 -0700
Subject: [PATCH v7 09/12] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner A523
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
Message-Id: <20261103-submit-h616-uart-fifo-v1-v7-9-c9e248d685c1@gmail.com>
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
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

The A523 UART integration has different FIFO depths across its controllers
and reports each controller's depth in the FIFO Clock Control register.
The receive thresholds follow the standard DesignWare FIFO-relative
mapping, while the optional-register layout differs from the generic
DesignWare integration.

Add a compatible for this integration, also used by A527 and T527, with
snps,dw-apb-uart as a fallback.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index fc1289073241..ea6ce99178e3 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -61,6 +61,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun50i-h616-uart
+              - allwinner,sun55i-a523-uart
               - anlogic,dr1v90-uart
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart

-- 
2.53.0

