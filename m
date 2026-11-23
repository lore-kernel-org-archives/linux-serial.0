Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432742;
	b=N5yTQIl8k9wzbcOI5fSj0XiYJCBGBhaDHxIpNab2ut7R0HDCgEFekJvarH97kbLtDTx5
	 ReJYvdRnPUTeE/u0q2mUAzXYKG6KJmnRtX8GQOv94ncNoufyV9i8PrdukjJ3lwPqchdiF
	 ZpSU1LSDBvYx09lyCRTqwivHb+zl55c3GzBk73j1EzqA4xsVs34VG+MNyQaLFeqbjKGdM
	 28QiN5vgwaeBw58tR5+XsCKTqLPMaQInG9hQK9rmCdJMS77wfmejJHO1CAI+nYOOCcpKN
	 4L6iqMjcF5wA8xxiQm+aUOIT/N1IE0oPrADZrkICAZ5hzeRCetzlZkHId7QpveRBKxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=YQ8N9lrkCBm6g5O+8A22MhXclICDJr3w2WLdfhFanRo=;
	b=ZnVOyA8WnLlgTdeNvIlZkcSFLvO35u3Nl+wwPEApZqX9g987EQPSzwF/xx/cB01iB4uq
	 cN9th1X9kyTQNEyarCC2DvdXDPGVC+hUUUEKdfX+Ew/AOVMO184zDQuJ0C6fvI+W7+iDc
	 K6fgTolJ5VW094OP/LhRhlV+zMbAO8wVOHnNRILhB1pk581x0qwU2NHdcTbTJvetfHVE4
	 ki8pax1zt+C/xL+q7iGpdhu9Ub4GgtJsILnNafUtge643o+OtvBO1VffP4KkEVIEziwxI
	 QPIeDIn2xoFWwijpBN1eJonA2WAw9IDnLIcJmgGOm+Y3rCuVzKl7q/GjQoRaAV0NJvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JK7SjlHS;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87397606A687
	for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 11:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87397606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JK7SjlHS
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4d581da0aaso411972166b.2
        for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 03:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795432741; x=1796037541; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YQ8N9lrkCBm6g5O+8A22MhXclICDJr3w2WLdfhFanRo=;
        b=JK7SjlHShqGKrK0MfBGja0a0+74eIVz0GikP/sp5w8+YnuWmehFbl5uiXQUjtJ5tiv
         tW2CXRUpyk7pKWHsifd/MUE+XHb49uhymcmyVz5d7wqN06KCa8HiFfLD+tRWDGplid5J
         lnDwwrCR3VsKX3Yxc16haWUr1L//I9LYp4XX/wkMBgZGlsyBf84J4pwNww6hnyGnd+Hu
         zMOgQk4NgPVyI85Hy+cZCo3R8HqtGjI+EoM7xtjaSUqiTDPi9nbBeaWxE02L6A8QQC2S
         ZYtQ36mx0ABEdHAAUuiQiYaBuO5AlXK+BFvFoojQxooRVUvAtKnl13KkH7qn6sxgkzAT
         jJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795432741; x=1796037541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YQ8N9lrkCBm6g5O+8A22MhXclICDJr3w2WLdfhFanRo=;
        b=1q2wuw4YIWFgSWtrPv6eGlqrzjzeu343WPYkO5Pxgy/hf/Br/3hYftNIo1bz6XLXGx
         RdKVHwa9bKGtNp8ch+rZ9x02WHvQVqkwKMcz+mK+75aNLVHxZ+h5FGPdfE+6K/bKZ0DD
         KXcuRm8V5pvcRf94dg0PczhM/TMF5dlkFMiuh2vo0FPUZrwrsu2i33dxkcFi2TNlTsFW
         G7gSna6AFltDkXygGWA7ca5vBRriWklf67apwvmCOK4ChVTCUkPKGZsZB38gd6UG4gmv
         jXyicjRPw7dR6nAF34VNohFv3F933N6RJxjA0joqd+oq6Z3vWKFjWcbSy4QK9TojkSwl
         FReQ==
X-Forwarded-Encrypted: i=1; AL+hErGFX6yhNQm4fzObUfpsk11V8QMH9Z/nxhdXDKdpQzhNn1ECX3UjF8X63+Hktf4StvawR+3y69765UXMS3I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jOE4yD48rhsjntmvUbm492wqBfQKP5n9KPr/2UrFAVT1cTlkC
	ENU+7MJThOLFbo8EKNuI+ohPqGERxNswLoSbCwR5YGN7ZdyxHqAfJsiF
X-Gm-Gg: AZFdTZcGDtBiLNBsrsBlm3EotqWN8OehfLi2tqwkFUpSn7etpuuLRTllfIXsKAIdDmk
	Ukj5UcDeD53U0REI4joKwRf1GcjjDvxye6ACO9JNJCElUf+8JsJln1iMk4trzDy96R+DO1N0w5m
	bWWdkTayF9MgbeWt+TLb6r0nY3Q5LelGqPkGeYHzcnBkz75Q6w+iv/JQWknUmKRoI34Uqh2lxBN
	s+RfcPm8XAVHAkUpmFz9dOQCJp2YYzH0cWz1B8SO7PZuJ6REmuosD/O/WRVOdkNhceHVENN5LNo
	SRX8+fH4Do3QAI1e3CF8HHfFcxPMR66Mcn/fEXf8GoZ2NyO09MX6R2gvc0iNEUKpSYBpyXvxs1e
	TSrLBoaKNK32xpRCjJBmYmPO9LVh/pqQUvjyzYfP4fewjD/LU4eKlN+4tOmw98cCljQg95Bk6u4
	KODgFk2kRAzqoMDC5NuEkSlfxv9FM74kr/1AlsDh0Fxb3jhv3KpMtkildB+Pp3xYL+iWSojsvqr
	r16afMO7K8mqCq9ABlaZabtodOq3zZOxru55F4oI7HimbbfewJFAQ8inGZvJaLvIqFJcE26gwCD
	uFFmQ97jeV+9OOnt/5ljEs4ojUYpzeDwaS/ED0ME/Ac4wNoACLbvngEBsUV8dmRT1Q==
X-Received: by 2002:a17:907:3e1c:b0:c51:53bb:8d70 with SMTP id a640c23a62f3a-c5153bb8ed8mr586385266b.16.1795432740595;
        Mon, 23 Nov 2026 03:19:00 -0800 (PST)
Received: from [10.120.183.232] ([50.7.123.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc679bsm392442266b.63.2026.11.23.03.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:19:00 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Mon, 23 Nov 2026 14:18:34 +0300
Subject: [PATCH v3 1/7] dt-bindings: arm: mediatek: Add MT6895 and Xiaomi
 Poco X4 GT
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
Message-Id: <20261123-initial-mt6895-v3-1-95c46597e63d@gmail.com>
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

Add the compatible for the MediaTek MT6895 (Dimensity 8000/8100) SoC,
along with the Xiaomi xaga board based on it, which is sold as Xiaomi
Poco X4 GT, Redmi Note 11T Pro/Pro+ and Redmi K50i.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 26f096587631..13e5c31cecba 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -72,6 +72,10 @@ properties:
               - archermind,mt6797-x20-dev
               - mediatek,mt6797-evb
           - const: mediatek,mt6797
+      - items:
+          - enum:
+              - xiaomi,xaga
+          - const: mediatek,mt6895
       - items:
           - enum:
               - bananapi,bpi-r64

-- 
2.56.0

