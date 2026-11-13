Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596880;
	b=M9l2z4t3u2dii0/wxoZW+6ya27dnaIYK7JBg9NHsL0cy1Wz8bhzOYprMQoPfR+zyzvRi
	 GQLTccNn70u3dXP5+4ton3fmelNSG+kFapf0AlbuysxATSLQYONv0gCKKNPryO4/mNgt0
	 hgkPnrQWOxeoiJEManCZBuEhcOZho2Nt7Agb6gfVAgDQ5SNkBqdNesl84ldvgRDZ4clXj
	 RMZrfmzC6DDNxvXYTBnPVlDwP5QscDkshXAV9026ZMUPmJEhrAp1ivpPEWWAdEKS71veK
	 Y9WJEicLkYEl0sQPxOZJum9mgt4jO9Rx1e4dsP53oiOMyQjXNtc1ZPvI/Bv4TmAFfJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=XeIdUEn41huggshJVY5dteXJQUSowVHL3L4Q/+1iZEE=;
	b=cD8Sw9X2bBM2z6mYziB1tMLhxAou6FadZ64Omf2sFH4o3PM73qusNQmLRc+t7+K+OTFd
	 BEQ6MDdPtNZUTJKEluNS6VxvdPkInLsLYH0hjuGBtyrRfEvkNMiGpDE/STS8fwJ6C7NR7
	 aEC+iIeZevvI6CdCjppNPE7mAN8QQTYi13mma7l+xhHrtLRVIKm0uuXPQKCPpvLMwfq9c
	 6bUAPTiku3dXlY331RPTB/Kbd5q6ZFRAtt5MhwAc2ssldj3E2zGf/051VNa4xxvdBNW+/
	 Q9G5uswEfDq7ytoWnxFXT8Jsa7kAX/D08NOZc9CJj/Qc1yxVvVxEnSiyTCY3L5hRmkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=abdJekNZ;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F6960A3819
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:07:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9F6960A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=abdJekNZ
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c247f6687dcso323062266b.2
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 11:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596878; x=1795201678; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XeIdUEn41huggshJVY5dteXJQUSowVHL3L4Q/+1iZEE=;
        b=abdJekNZ8HxFrzNGohRBeEoTf/523bitcDzqsMoXfu/U4MopGkOP+b8MXZ5tWxql83
         +H4idS6CeHAz29Ea3I8Yr8DkY2D1+ljIBctRuNZ1EQHnxCBrrSzbgBs4xgLyJVibQTIQ
         LYPvOHevrIg4Xv1JpSAMiLR37kb9Qq0S0VvubHWWazdzfJLS1TikFNzYi8HMMVqCOQbI
         eKti5JdPJe5aXqzgfLGy8UYM3/T2YWQ3JRtjF20hkIhmgBcvDm4bRhNg46dcYztv2oc6
         BEcFEfaaFNumUsm4LprF9aHBwJYDZeY8ItR+D6Dw/wamqL2ToslkaAQt7JXd/JPGbXXY
         Xx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596878; x=1795201678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XeIdUEn41huggshJVY5dteXJQUSowVHL3L4Q/+1iZEE=;
        b=C+JmvDKD7savPqY95uHt7Sn4yT3WXGWQeNBi7WDVgywFEXRc/7yea9vwA98vVg4W2p
         D74wGCPd3lvW8EJxVWcNOASr+AC1EdyonqS2bytkWk1+3Uh/MMc7IU/Zl5hcfj5NgLkq
         AGTHzTCdS1NH+XLmVghnU6e7z5xujBEvoUPAaZEbWSH+Z0qIe+PkGiet1bR/bln/0z5Q
         Hn76wKmc9aT4RnU/57Ui8uNg3K2y6kvGw3kPfqYChGZPYKe2RwPYq8zJ5LyvbT8o8I/P
         O6G18RVOvI5oqQh+PZZOmP5g2VIH9E+832dA1jOaxkpDzTOCB0wedKwogt8e8iLrKO28
         nDmw==
X-Forwarded-Encrypted: i=1; AL+hErFl7PshtQW+D90XVlZHIJk4MnFOHuI1JpYtwoVRwff/57YKml2MuDKtVxGMv6bVbpn4Ov4r6ynIoUG6sxI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yC7AceYW2eMkUQAN3gcBPfM9t9YGAU9hhW06iCQDA5oJPZB5u
	p9IxrDbxFyH9em2KTel5z0a3VEZVHEwShqMUTfTefob5T6qQWpp2SPy1
X-Gm-Gg: AYBFou0StUPdrz8/xIx3hqfs8NJLV8i3r0EO7zIPORZRYj4hZiToXsMesFnSi8qR4MB
	h4INVzSV0xwn2wZcyECiQpftZicO1m7Y08pz/cwS3xr7jfsO/VuHdQdVfQJ9v8CDZQ8kKQbP15B
	tpmRmAENkW+U6QtNvq4C/SJXmFO/KxVTENMAFo64YHsOTd4nKU27vPDpy9YQEGuomhgN3cv0W4e
	UxJq/pf4dNmWMK6fFRtUD75sqG5XSqW+GyNW9mQDpITOol1iEdwv1fok3q+0G/n8g2fQPmMkJtc
	yYyfQwRepRET2h6g5PqzZE/3v3ZAO4RkOs+cBt1RzrkHs6VF9g5K+CxWIEIHWSewui8kdd0Nbeh
	Q3plBBQ4P7g6VRXcGmkHurKZtf/rkY/mi4E913XaUJ5krEgsaWpTomoRYVSv18hIzfeTMVZMbMa
	ohq6BkfYK//gzJgdjRJknoTVsBJ1DXlGRgLmZiOknOyRQJuWO3hNQE7u3+xkjmZPVRwtSEVCRPe
	EAGcaRN6oaIj2QgNo536yoRIgt5/awoBqNCVLooVNl0CI6WM06rl3Ybdg2E66do/Df1nkpTb+qS
	bgrMrClwWPSF/6hFLYjXY8YEui+w/PT9TTPN9gvYVF1ft6LdBvW2NvjjAaNX0Qvx
X-Received: by 2002:a17:907:2d89:b0:c46:8063:220c with SMTP id a640c23a62f3a-c5096398047mr303416966b.11.1794596878270;
        Fri, 13 Nov 2026 11:07:58 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:07:57 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:05:02 +0300
Subject: [PATCH v2 6/9] dt-bindings: input: mediatek,mt6779-keypad: Add
 compatible for MT6895
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
Message-Id: <20261113-initial-mt6895-v2-6-4ab0aa9fa391@gmail.com>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
In-Reply-To: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-input@vger.kernel.org, phone-devel@vger.kernel.org, 
 Alexander Letuchiy <asalde.le1@gmail.com>
X-Mailer: b4 0.15.2

Add a compatible string for the keypad of the MediaTek MT6895 (Dimensity
8000/8100) SoC. Its registers are the same as on MT6779, so it works
with the existing driver through the mediatek,mt6779-keypad fallback.

Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
index 9f0da1240187..9a1369c9ff4c 100644
--- a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
@@ -29,6 +29,7 @@ properties:
               - mediatek,mt6572-keypad
               - mediatek,mt6595-keypad
               - mediatek,mt6873-keypad
+              - mediatek,mt6895-keypad
               - mediatek,mt8173-keypad
               - mediatek,mt8183-keypad
               - mediatek,mt8365-keypad

-- 
2.56.0

