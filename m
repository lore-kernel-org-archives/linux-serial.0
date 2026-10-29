Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299657;
	b=nZ+qVD9Kq5Jn06ywaK4Kr5eix3i9yJ8sks7iWlGsiAhfhvk1A+dbFOI9binbzumsq8i5
	 e/wqXdPbcNec+yxZ/2b7byROglagbCN5NF6X9TR0TyhzZQlIbRe5P7giz736iKosGfN13
	 bGuvG2r2hgoSm63PVlMIKY27Y9HiUFwWRoICDLCeDgsj62ci3fMvX74rb3IPxnV7+1owd
	 bM7MTrjfdA1M4ZmqpVjgjwoPGLVHDdSmSO8K7C2aVOfCaV2MLqpn59WYnI1vHl2+x6oCe
	 V1R0ZpqdxOyRWjTD61WZ9H8Im3Djs22SRJvJcrAMpug6FTxPkcs/m/VgqHLJBvGMurg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=HRoIIA2wpujQ0+Dd3LKXeU40GCpk4ukouOoolwO0ux0=;
	b=Fq0md3XGJbiFxY0A3mYaKwITyQApzqWtJt3wI52ZDHEtaT+qg9C+fmcmdTEuatdnUGjo
	 lVEMI51pLyUASv0a3bTivUEMgZF4wkl1R/w8pYaUvIgGcStWm6PsVIwGNo+IKMhTgllKw
	 MLP7OQABHSeUHWcLgnvOJsvT/5uM8PiUuGI/DcZxIYQFGyh+XcgrBqG4fv+KByVqaPbW4
	 Jyps3O/8xb/yjlCHZbfAJzd2694vMVlrjSk20nY4V2hXPaoVLs197lmyUXih0Pk0fDED7
	 qGIJIGV9puH0f8skWU0J9ymE4CyoHDYHEPK7ZDeUtxs58TaQWLon3du0Kc6mMQzyXpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=urFX1dBt;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA85E60A2612
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 18:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA85E60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=urFX1dBt
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-7037daaa820so1160610eaf.2
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 11:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793299656; x=1793904456; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HRoIIA2wpujQ0+Dd3LKXeU40GCpk4ukouOoolwO0ux0=;
        b=urFX1dBtAkSRh7CaH7uplo2mLheuBgHF8ZvinGqgnFBzci/WpFCZ9ZYTt6/TJeSyVu
         mgKRy3jk/MADUQg/ZGVbD+1TSSkvgfbAA+qQBDQn29skTwK/7k4aWiaoYukBC+6Q04Wq
         FLNl7OZUotk/GIqVoTTKVTCpDEfiehKeHSwTASTVd1auo5eFyeN+04mpV4OE49HsuAUM
         lh6ZedEmWOHNG92CjahHYITeNSozDN7o9KbvPDyx4WzCIi9pz2cD495A10L7RUaPN3/S
         Loj6/aXPj+CvFH7lJcbJwYsLWKXlpUAMYRmCgRaBgprES1G924LHW3E1EAn1ZU/WjBTF
         J4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793299656; x=1793904456;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HRoIIA2wpujQ0+Dd3LKXeU40GCpk4ukouOoolwO0ux0=;
        b=yuG8fW9s2TaE1gGpS4y/gXCm52n1uAMLTBtz7CVg2g+N2I8NoQirMvdhbcniGgf8SK
         r+oJ09tds1+tBFVsBuz1YPJdJF535TNVq6sYIsGc6ipV59AOaxEYalywtCba6iiBYU9F
         /FYStjWKAoiyPX1IX76ceZD0O54jTXYNC4GqeHQowQIyRnhifzU+LE+pzNF1WMb5GXPD
         8BYksS7nqt589wXur8WQwZ2n7KWPl5jAFuZR8PtjxNfftWfA3mofPHnT7fKJNUNZ/yCX
         Hms5jonddmlrCJLWJ/SWUuGVUJ1fg+ttCrojRBCaUO2opjSInaa3FSWDijkoKV+kwQBn
         yx4Q==
X-Forwarded-Encrypted: i=1; AKwUvBw/MNfyxHFKX7ivecmM2DI2II3hp2MCBeueMR0tlIEStwSYegGNu/E/9LPsXjMj00l2IHFc7EJ9OZT9OgA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLb7CsC8yXxo5r1aQFxA7CYFPTRJjuocirJv7BFoUcgJfgWWASn
	f85IpFgxQivNxDpFyoQXCXrvHnABN8Gf/dX4MWFHKl6dH3pRJXAi7XZG
X-Gm-Gg: AYBFou04fE3vJ/OUs/s32Tsr4TYw0RFtGIe+lVJpPBJsGG8xTXJ/+kJN/+993an++nH
	nvo2uD+dVJTmNnUGqCPQc2OYoiuIRYBXmcajGWTju1bmWrAxK9yY02FboMJZci1YrWItkyHjKPA
	YlRBPXYuBsgJMUGcr5+ZAHTnksxRw7GdawT5NlYD3S3MpdMC2gX00xsybMEo/SY1W+CUc2f2XFn
	x/W4YE7b3iMEyLjoA2BEjgod8nfL70V97wDwfNvHHSdOsLwXvG4xVdMbBaxg9j5toumYkRQP83/
	TqW0c2UYGJ65F9qnuMR7SLb6zt9m1ZW6HfJTdgBO+b5peEekg177q4TnSSns7VriDTNVSJQPqW8
	JSjRCQk7vlrFcBX8p+Xa92F/swH7W2XlTazBwlFgIGdJRWD8wAjyuZ1H6qRAuduZNcx/Kmw1nUH
	VQOrqpL2QmF3mjdvLhgDlbrD+3zc51Ys1rp6hN0n8Bg4DW+s6wdNVelwAhnmzvsaDFz/M6FFDNI
	iC4KAEVjJCpsQ4P8YmUtX5xwGnKF7iWCCqZ1jpBwYt1eKaVryx1zSe+YPUokPcpr5j46g99vGqR
	covXpwbxOC+zyO+rKZbV17LDfszjRaeJt4tV3X8zKjnqx9eEXJ0sMnplcszD8Sh67+eQ+Yi7C+q
	xwLCOwNc+Hg8U0f8O5NO1wigbnnqKr2sqmE676zOLanWb+VfICeiTPD65+LTpkFnih2KRqoxmeg
	NhQFByNIN7LwB5JepWELRhdeftJm9HwSJg2/IdWLoKlAwbhipFL+k=
X-Received: by 2002:a05:6820:1518:b0:70d:9be9:5351 with SMTP id 006d021491bc7-714f29c23camr97099eaf.36.1793299655746;
        Thu, 29 Oct 2026 11:47:35 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354cfb83sm221871a34.14.2026.10.29.11.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:47:35 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 12:47:24 -0600
Subject: [PATCH v5 3/8] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner H616
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
Message-Id: <20261029-submit-h616-uart-fifo-v1-v5-3-53b433aebbf8@gmail.com>
References: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com>
In-Reply-To: <20261029-submit-h616-uart-fifo-v1-v5-0-53b433aebbf8@gmail.com>
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

The H616 UART has 256-byte transmit and receive FIFOs, but its DesignWare
component parameter register does not report the FIFO depth. Its optional
register layout also differs from the generic DesignWare integration.

Add a specific compatible to identify this fixed configuration, retaining
snps,dw-apb-uart as a fallback.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index e2ca126d58ba..fc1289073241 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -60,6 +60,7 @@ properties:
           - const: renesas,rzn1-uart
       - items:
           - enum:
+              - allwinner,sun50i-h616-uart
               - anlogic,dr1v90-uart
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart

-- 
2.53.0

