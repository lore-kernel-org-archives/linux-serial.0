Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280402;
	b=N5RnthK3ybtGofMN3P5kEe15MTljko312VVGBYo7260qYqs/wWMzISg6Papr8HohV67r
	 rXoPZrKxMzkmT/O7qpFu7MYbvE2Ev229x0t9FI3W1jI3UeHdYVTGpE8OMaaS1wniLw5vD
	 fKCfEl+k4tM/ne8dxgoLxAz6t0OhalhWEjmABtDnS4q/vXrjtLzRa/bhe/mTj3zGkRvCH
	 /llrdGBlXHU1rOtay58PUNM8mVXXi7kx023Qg+1kkm5DidTH5ebAJe3yppKKafvmP3UcA
	 wbOV1ZTmvXSL2KVofkuXw2Zser0LYKd9GTUrKlVqRddOE61m3c3M/n0e5g67LE0Mfvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=HRoIIA2wpujQ0+Dd3LKXeU40GCpk4ukouOoolwO0ux0=;
	b=wFa1WmNTi2EKtJztyirnX0sPSLq54qNCAnvPoVYPAt58z95uvfxYGiIT9Sr67rYo8OJm
	 Rap0EcbucikffW4h6uQ1k/0TRson7RYUYuZ1oTYqYirdWEofnq6btdCjj7WXTVP4qpLWa
	 9KvpfzJUEluEMsp+U6M4TTFow7WcOpd/mJUkYpUTjezO0xFSENiQkp5y8Jt4VD9kEVcj7
	 lKQja1m+ZAKqOfBQY/atQnSrO0Niq0O6+POTPlop5VNdIbHWBmlHHM1xBpVakRp1a2yY9
	 k0E0Z5FSVR5qnKCpg1GhgaOVayCkxezOOOkHKsNOK2OmbBWBPlNrSxKwCdh3boepzsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CIauULyg;
	arc=none smtp.remote-ip=209.85.167.170
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C5560A382D
	for <linux-serial@vger.kernel.org>; Tue, 10 Nov 2026 03:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7C5560A382D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CIauULyg
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-53ec9237600so754115b6e.3
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 19:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794280401; x=1794885201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HRoIIA2wpujQ0+Dd3LKXeU40GCpk4ukouOoolwO0ux0=;
        b=CIauULygZfljXukESwE5jALaNge3AATaYppoyOgZVuOx3CANr1AehvPGSWNFAzkYrt
         Wu493qoTV9jf4V+6gj81+dibzaE8I8XQ6BHVtA8Hq/S1nERFXQ6QemRVjXsIt3Frd3u6
         uwxscZYSnnl8LtPa4lwC5Jw2YE/S1k3HVSARy3a0Y3xE+jVNuOoF7iKWn5LgwA1MPkY6
         bCUKyDA2x3M5fdEnf0Q7oeUxsl2VkdMAgVK3hmt9aj5znY2hBC0QuOLAHmpM8xeJUAqT
         9of93ki6j2XTZLuoFc57Mx/AvnelSAkPXzvF0HhOijWwJuPjIDuITv3H+IywDz1/OjeX
         ggBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794280401; x=1794885201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HRoIIA2wpujQ0+Dd3LKXeU40GCpk4ukouOoolwO0ux0=;
        b=JoEYJq1rP1U/egxCsQzYuNcJ3DKMQtEYiUUhjGgPEBnzKkVb1DoVGr2LTS2Xz526+p
         TSPXZoOwFIqeNRdhQ4v1iUQfD20QHFmnHRv1kBt3OeM3u0ncNaaWII6U8s8TuHWMXe29
         B8dkqX7zpqsGRzDvlOCn2WMG60yUF7rFF9bgpZoxp/sme/pAPmACgbcN0Qw/Sf4taT8U
         b6MGKZROnArOXdJiuCaw0rqJo1+UwWeiGv124JH6OQwRrOvkQ18E4AXDd6DM6gbGBfl8
         WVu5Vk0RX3zH3QY2+W85PeRvmKap8dLGbMtCqg++wR5qUXVFjOF2wz9ASYCP+Vbwd9XW
         Jd2g==
X-Forwarded-Encrypted: i=1; AL+hErF2YfqehhzfeIsa85YBupDcma8S2TeSwZLu5uEaIpFJR9hk5tkYf406JD8YcYm8/LXUvs5dBJUPpDQd06E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FLm6FQVvhDU9we0NsSMHmtFKV7fAlmBbhi8by6NYHAonCfggf
	V9MJPcGkuCcGKF+iDDcjq7vP6RjnEoizN43HDlhhK0vRO8DEyVjWsXwu
X-Gm-Gg: AYBFou2z3+5zVE+7DAkcVKifO5HkFQM0MpoyJVC5jLGoqQc+eh2ht+ymxYF4IrND1zv
	4g7O8vbJXR3bZv2UEz+DuYUJVP80yRClscXZe6Jsa1L3gj+jCjo+vNeKOAUBQG2ihFmsmNYz+N2
	n7aOaCxA8rO0+oLZDvosYPeV97mUuXpuvPS/MLThYu/xYE6Mukyus5FtBZ5TQwni8eXzrEXTJW3
	LSOh73BGRJgp2BLqVj6JhcpbTxvsxj+Hk8+0es+zaC8IPKSrkduXdz52llJmp0DagyxR3WiHeiz
	eCtcrLGG+eNcD32wdF9S7iFKXfANbcYtDnxmZLvY8/GbzvqFZ+aJmM4rFj27tx+YZ5zX3N3l7pa
	wALQo9dcMFGWQZDzVC5Ir99mutFBZkg/L/0jUBAfRHEJ5lyglwoDbnBCL6W4fjRb65OnxPzp04i
	5zkksf3S+X13mp5Klz2CofCKoB1JTRD+J/ruYI2kgnbR2h1iKbG+uzp+D4x4AYtDq3obJ31i3z4
	6Eq2YV9sBc/ZAUaqzkUAuPsBlAL3vhvHcOsrx/GZqjtoSW6/e5l+WmgtMvPpqfE4ovQlAB91L0Z
	3fqO4TjLteW0EDDBcNJecmOPnO1lp48OtGXBh208hi8IYB0AJxru2RMvwWYJm+Jx6bBgUAKcyIm
	6atsmYF7F/Yx8BLPKaR/roUAgYGAwUeOooEPzIdsQtHWO8FPrqOG71c3uQ9xkSOcVcEc40i4AtE
	ws1cvgNqBFlp1HYMKlDfUbImZEI9X1d6J7KJ58gXR2cJPasg0W7jEM
X-Received: by 2002:a05:6808:1303:b0:55c:836:5955 with SMTP id 5614622812f47-5683ca2f716mr1299570b6e.44.1794280400815;
        Mon, 09 Nov 2026 19:13:20 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905736b92sm1019236b6e.8.2026.11.09.19.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:13:20 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 20:12:56 -0700
Subject: [PATCH v9 07/11] dt-bindings: serial: snps-dw-apb-uart: add
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
Message-Id: <20261109-submit-h616-uart-fifo-v1-v9-7-3f03961dae8a@gmail.com>
References: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
In-Reply-To: <20261109-submit-h616-uart-fifo-v1-v9-0-3f03961dae8a@gmail.com>
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

