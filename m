Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432748;
	b=o7OGOPHTuT3oWnfISnYKdSdkEQ4fGs4c4JvC0mN2XHdZ+kut/HkdZfOBQOd7q+WBabxy
	 I5eP0XE2Bd7eQj0r7xlMyAjp1LmXcRgFkTPuyNh+HoavtHJFEmrVE/sn7W3cZd/dyZnJu
	 RVwUMVETjAlm8YGZdFNO62yD5QCNbH8kjVdbgxkVhFDDX4MRzEFZnsZvFaEvSMPmEe9D+
	 QeB2kCJqC7q7+HkbAncaoMHwvjfyIdRt02j+gXsZQcYZIiJcm7NYyqvcUe8midjkMIRJF
	 PkvLnrkTu5Obbt0fo5JCAwUCMMyiH9G6tcV/QkHypTjO7gw/IRjhROtEPsxwbXCYJNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=fhdQyf6FbFbh0WyyBUC7EygAiye6PpyKpdmvafidO2U=;
	b=IiC6byDbff51Vbd/PaXy9N3o6I0QcaPvx3X459FMCSA+2mHUBiDtbtcVABU+N73hPOJH
	 FvaKUxvsdSOZz2IPetW+It4cHcwG/cWHxCEC93j+fAV6IVO5/Q9P6/Jt6AJssN35S2IX1
	 eDh38oQOtnvnwIk3S1NaO+0RPYuJk+qnQL+iyof2RwDeRiB/ImlDPaYJJ3Q66hAED9VUO
	 /Di3Q1/TPG+2V2uGgEIHpeRyNu3OKYBytNm7kDTZxZxvwB5qx+YsQsfyzZJnn0C+oWTc6
	 ZKhKsJIaSMGQRCpZNXRhLprxiwK2vpoeiYt+Q2RItqgyBiH2S9pX6jIw1oSxwxT0b+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HTqjUcY9;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D5660A2616
	for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 11:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85D5660A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HTqjUcY9
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c5127c7abd5so502138966b.3
        for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 03:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795432747; x=1796037547; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fhdQyf6FbFbh0WyyBUC7EygAiye6PpyKpdmvafidO2U=;
        b=HTqjUcY9hLartbQ+wDqUUWh+DYA5uBQlIQNY8L8c0PwQFxlYvRUmqcKq9vBHjiWlIQ
         ZEUY4IVw5jmJePNOlSkdFejLPzyC/gnES/8A9mJHHXOsB8T5NCrWqcjznvksBUyFj8fX
         Gdoirno0KXw/7rEQXjyZtluV4Rd+3+z/PNlUakMZEHUQWIAO721PWX1/mvJ6P8xawItb
         ysROTquAqd3jS2dFl+6sDSphM2xYXtslTN97/hpIFiJOGhGv7AuWUlk/hK1ubkcgPaD+
         nmyLdRZ7rePh/oqb+a8G6vq0onwln8KbWQTA7ew4HWiVbD2Xc6bis5BHikU2+BPy7iLp
         b87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795432747; x=1796037547;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fhdQyf6FbFbh0WyyBUC7EygAiye6PpyKpdmvafidO2U=;
        b=jOsZ7TLK5W/mCnbGXMd5W+zdhnYtHZQT2SiActHl6i40fiMPh/+hWIgbOZd9RsRNIz
         jvo+IxEh1paYDS0OioBrk0L4Cy8uS68FVljohWYf1EFkARRFE1sR8mdJXqia1VyRPQka
         Rsp+bwNNGaGC5ak3KOQz5+ukShtXFEWBqqy2vCHJoB9xG689OSs8wJmjFNcFYaapmhLp
         ZTo7cFEAM24/tGmD9utIXI4/gVeRo0ebwh7hi6GjdLqlKnZaCGPj6rc3/3QCVzH1RRNm
         /ZqnNFrkEFqlC+cy+Oyrp5o0qbXsPukKJn/3GuWDZupVFsLpzIrtKzrtehas27Nxzd01
         u5pw==
X-Forwarded-Encrypted: i=1; AL+hErHd75RyKp8A3d6e4kIG+Lv63KXN824Vmauup+iCqOwhmTVkH1af0Smz0kw5RsuyJQSHQ1daUwMO+yIqZlQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xP7khpouSDZ/JrSRbfVcMY3gbVmPw1fhBz2FjCOk8e0KfKS2u
	VrT6tpIrkBHFJAU5XCzXrDzqzHxXEtRKqekMp11Wickl+Ts9afU0K2PF
X-Gm-Gg: AZFdTZd38pcWYUdJt2Rtp2qNOfo8JS3XK0d3CBUisgqwmECLw3LJnyS+s0G/AWVTBUU
	9zX2QFk64f1QJKMONjIA50WDFW2pUE2n4E9ta5vapaxQa2M4w8FXrZAggfBmGREK4KYUR7KMvD+
	36fjk2v+ojSOyylHLW3dtehPhOemiSHMESl/LoW7LOmitsi2jTYjYQ3T6G6/GTsl0IOBCMNvqre
	uhfxzGzTI9qPcv2+MDaOSdsQyLi+wc9htXCAnx3cPvayEQrtU8ZddroTetTkt0I/0hYwGTgR6ni
	PPnsqsLLlUEsYv4rW03DtL9BNk1zJ6uHkOis7ptiQQyZzNc/MknYo42jq/7Utpe9t4nFAdjLvY0
	uExkKznVjp7f82qCS/VcZV4mww826s7ZzxKO1sq4sTtoK4NCgZfn0t/+3ylquWFqcVXzNsAOFyc
	P0P+N6NVaptkhcoBA7Es9by5uPQOzA8LFwzgvGZ3PoGK+m0GalzYH+55e3nXalU56CT0132YUBt
	+eumgC+kGq33+7XenmBQEywxzVCchbQMNDuS5p+qNl9llWmuC2AsczhumM7mw/NdBVI09l2U7PH
	YGJZKdLPwYiQ/7JKIwDXuY+kdtxsdhqHYqGbBbCKQdGx0sdFYpfLGN7vabFyMNoU7A==
X-Received: by 2002:a17:907:1b1a:b0:c46:7ec3:fde2 with SMTP id a640c23a62f3a-c513a5ea1b5mr863152766b.11.1795432746902;
        Mon, 23 Nov 2026 03:19:06 -0800 (PST)
Received: from [10.120.183.232] ([50.7.123.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc679bsm392442266b.63.2026.11.23.03.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:19:06 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Mon, 23 Nov 2026 14:18:36 +0300
Subject: [PATCH v3 3/7] dt-bindings: timer: mediatek,timer: Add compatible
 for MT6895
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
Message-Id: <20261123-initial-mt6895-v3-3-95c46597e63d@gmail.com>
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
In-Reply-To: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org, 
 phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Alexander Letuchiy <asalde.le1@gmail.com>
X-Mailer: b4 0.15.2

Add a compatible string for the system timer (SYST) of the MediaTek
MT6895 (Dimensity 8000/8100) SoC. It works with the existing driver
through the mediatek,mt6765-timer fallback.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/timer/mediatek,timer.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
index 337580dc77d8..ee4af54c29b5 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
+++ b/Documentation/devicetree/bindings/timer/mediatek,timer.yaml
@@ -40,6 +40,7 @@ properties:
       # SYST Timers
       - items:
           - enum:
+              - mediatek,mt6895-timer
               - mediatek,mt7629-timer
               - mediatek,mt8183-timer
               - mediatek,mt8186-timer

-- 
2.56.0

