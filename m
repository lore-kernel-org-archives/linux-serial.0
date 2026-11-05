Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912860;
	b=0BqZ+GnI8Fjopwc5ImOI79sOIu7+P/Sp35XhZ4c/eyLXt1kJc4BbkFCobdpNy07Ph5Dx
	 PWDc5DZVEdHaZjvcal/V2mOotafNBPzg3m3uvsmywyx/TMRSPC24M0vup1xKrhNBr5rXg
	 pEjU+0Fr9/gf0FAW2mgILW49zPVinutlXJjUGHpWXCOeo28joPevXLvB8i6RJpzu33hfe
	 quQPSIdlgmSyVM+j9WxQB5aZ7r2hXaLTmVQT3fUVhYncsaPMavkNbED7afpVsZiGak3wS
	 /Ua5r99neE7EH7wGZpbHvSvNaOfvaUNFkG+188H94KvfHeYiQZ0Gxpm41QjIAVX0VTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VS8ybXF4DCq5tAk5+ls9haIcLFew0SWRjbxVZMJULQI=;
	b=TA4WU6nFxTjlOftauLesGZyNJGi+QHhZoVoqkzKSUgSaw2LDzD8wcuJU8USqej3Plvf6
	 anaYK31Abvkq85rJs8MSLfwgtVjROVL00bAPp/XX+3S9a5l0riNi7uG1V+CRaHTJVFLye
	 Lp2d+8F7O1txW9SV00RBOCevFjJwyYGythagDD/Xf4KYK3FbgTajJTJ3PVf4yI0i3/UVE
	 nmOVGYdbx28glTfvnpY14XxhBXdLNZoGcw7gKUY8qvfHfyw3cCXVBh/s0C9G+7G/V580S
	 fTPMu8NjENvQfx767SnIEyvPVF7G/ivnHGvo+si3rpF9u4uAoF27hIkOgUmM+/Tnekg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XZy3YxFG;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9831C606D81C
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 21:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9831C606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XZy3YxFG
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b596afb4c5so374241a12.1
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 13:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793912858; x=1794517658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VS8ybXF4DCq5tAk5+ls9haIcLFew0SWRjbxVZMJULQI=;
        b=XZy3YxFG+3cGG+T5kBozOquwkPWP3VH2fwBdqQQxzxYuGgdrpjF08edZqheGfhnGuh
         0fFYkCy/qhZ2Z8DicM7RnnBsCqCA0jaowux1UT/y13rrnImGvwrPcGQIwcL7MrNJUBPB
         Vo+dszNzN+Rfm++Al6+X41HGi2c5xpVymDnhJwyIH4RN9UpPWpTU4Hdl3ohDcsfSJtZb
         ZmGeJPnAx8UZ8xXnw4m5kfjHTN6++SVufTEARK4MGGnlffuE60tDYzNY/KXDzasUM5vC
         /uFiuLLJEYafCuP5bjmBsApAB5G0LviZ16hG0Foyov66PSiBU9Kcy+GoEm7E+QyI2Tvw
         /dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793912858; x=1794517658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VS8ybXF4DCq5tAk5+ls9haIcLFew0SWRjbxVZMJULQI=;
        b=G3WtawUlDayZvIvOafmrpSURg3J91kNqdfGcqqd1eA1nOOSDYMoufN7xWObxa+w211
         5mVRJDVZZ6xlwcQBcidJ5KIT3xWz3ZmtlPOt2E6sYPk+oTWPQUKZ00JxipOw4TwOIEV0
         JOp1dHow+3t+x2+i2nXjnloy3wEF+mp+ZFsj2BiYfJGXsDSl4N4qrOtnIVWXB+hgdKXt
         YS6+QGm3KuN/pOhjEx2zRw0yhlBlBSNxWQkIlR5MxRr5TvlyoG44iojG9a8KJ6Bao8BZ
         SIFk0QcGZEk+hMEzhADY7Vd39cQKUDtihUnwpoLajb6FTllSqEgVqHgmY11tcd0zvyOf
         75ZA==
X-Forwarded-Encrypted: i=1; AKwUvBz/p/yG+pD7Gg30qluPY0H7hIMtHIAgY2XIRR0xxOx1smGvtF3k8dZeGmu117WvFCDbINyp5MuO9vlbeUU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+l/lh5ndJcxdinZLulp68MrmVFjX/A4xv//fNiLzoWHKdOFPI
	44Zcj/6ttTW+0GlOnBvtysNsoqAhWXx4FJi7MV3GppyGvyr3yOj0yRHj
X-Gm-Gg: AYBFou14pA48ixIULpf3QxkYRz+yZHSXbEJdK4sTFvWAa5DgZaiqdT57EpoTQVYmYOf
	U4TRZptIVqE/DySgia6ygBXACyu8dC8r7FMkmGIGPUOb3pDq855iHKdqQFG8tF1WzSNJOh+dJwp
	WpBAE8IxuiaQOA2licC5Tu5R6L7DHgIhQ385cfVK11KWwqtforPME4RM7hiHJjuf1QTXuwnuHR9
	EuXanoxdg6WmB6HbThu4MCJjvcxATM0MHMVgdWyYZyAFPXa/SxITn4uE/w7u4PTLjl3RuU2Rzzf
	h+SWZlgSxigPpN2wTZ2+a/SvtVfjOxMPiot80pI2PFb+eBLs0zpqnZ24IrhyHXYk7uDP20LUVQb
	kfh/l3RLxrgA8XAvRtE8DJ2rsPuaz+Obx74QokIDybsi6/6YW3XCYLfxrITEFbrnaAXjG47Vlk+
	OFvW39LsTnJIJxs1UD5KBGezgafwu7FmaGykd1uTN5UCGqKEsI0AMZClnFI2LpczRTwbDku1+/f
	9uIvgy7tgvUIB7TOmpdZjYOTy+bzsJMSc7RQGzjICrHsdoZPlOx65f3RsY5qLweCziNIHDS6/pH
	xlPLECLfqEVwEGfgRMtzQoMYzECCwXBEVmTaAtvTUhTTWbM1PA==
X-Received: by 2002:a05:6402:13d2:b0:6b5:63b7:5738 with SMTP id 4fb4d7f45d1cf-6b5977ddcf6mr294137a12.10.1793912857834;
        Thu, 05 Nov 2026 13:07:37 -0800 (PST)
Received: from letov ([62.41.24.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b55ac6d032sm1966949a12.25.2026.11.05.13.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 13:07:37 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
To: devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	Alexander Letuchiy <asalde.le1@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: serial: mediatek,uart: Add compatible for MT6895
Date: Fri,  6 Nov 2026 00:06:00 +0300
Message-ID: <20261105210622.523747-3-asalde.le1@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105210622.523747-1-asalde.le1@gmail.com>
References: <20261105210622.523747-1-asalde.le1@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible string for the UART of the MediaTek MT6895 (Dimensity
8100) SoC. It works with the existing driver through the
mediatek,mt6577-uart fallback.

Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
index 5bd8a8853ae0..a3969cfdea7e 100644
--- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
@@ -35,6 +35,7 @@ properties:
               - mediatek,mt6795-uart
               - mediatek,mt6797-uart
               - mediatek,mt6893-uart
+              - mediatek,mt6895-uart
               - mediatek,mt7622-uart
               - mediatek,mt7623-uart
               - mediatek,mt7629-uart
-- 
2.56.0

