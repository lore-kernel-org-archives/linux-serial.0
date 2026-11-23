Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432751;
	b=DxNu3OdKScI/nQLH+QpwkPTgn/1tbHe4IxZW2RaIiS0DmtDxec4ywfoL4g+V/Ouy0dfg
	 Nb61IUg09RSDgj2PPoXmmEnoGaAch3zhIYQ7Qj+lUr9hgpo6woB6kQvzvUumIazWUkXy7
	 nqAORHZvb8VpZf0/c/agtrUjjn6ioNMtYWl95+72pxlv3tkhSeiGSBtxbia4CK3s8vHQ3
	 LZCYKO78cYUoQ0kbwkqVZw/Q1QRyao8xZTLRrpoFranE3quP936HAELK0yxzMbbbdOKQh
	 IxMapGLdPRgwraX7IbGgWWEQAzHVbGwUlI2/GkO+ncFAEZgx8yecWaoNqxVFU5JecVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=IOrxHtiCHWTIaFRLN9a3XE1Ecmglqu0IREj6XPQBmDM=;
	b=I6H4oBq2FnIIJ/NykHMcrxE2Nh/FsNIxb/gsVUnppHxl9WJz+chzOHKnhjLAb1zktGP6
	 u5QXdIW7+CwMRozVzJ9nKFojst9dZPIC2xeHOqB6TVbjUgKKwP83Mycj4B+zMsRHAXGgs
	 g0D3IMiEQm2625cXA5TgGnZieCxLHwblmTSkZ9vfNviW+/TY9qrHlkIktXJxkdcatmecv
	 RXQkB5eMjDFFImc62/URQW5Rb0MdmuMWedplsLvbT6mbvXy4lPmHg75zZ7BIJrvOgR1ih
	 ANt5wzm3EB2qCS0sl7q4FMkCtx2ipjSxBN3/lebFGa9tt+8xVO5uX2nQPbRzkioEn5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JcoKie5q;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5EF606A6AC
	for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 11:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C5EF606A6AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JcoKie5q
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c50e26763a4so577887266b.1
        for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 03:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795432749; x=1796037549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IOrxHtiCHWTIaFRLN9a3XE1Ecmglqu0IREj6XPQBmDM=;
        b=JcoKie5qcPIy9VJGNJOeooy8iE89M63mPT4Tj1eTTLSnqtXq2b1lwRilTuF8Wo+w30
         2mxiL2i3Kgv1GdMK5qHeDH7IacTvYGU6YHektDgrSNsjjnCE7wnipEghpMjLc55Zi4Hj
         kgzPLiOhYpRTUT4KP2wf0Oo6kIWuFOkV8cF6MluV+qhv6OhNdw5ZYUmNc1PDQCzxjgcM
         CV+RTr5c85OgIHVnYYn4g2IuTNj8mjnugocu6PNncbEOYSkWeudE4IVx9G5+bwbOTt7i
         HgpA9vdDoDQCptPRtZwyqsw4GEVjsXpuOQPBTB/cDi2VXoVWy684JhnOA2J1Ipoh5CfY
         548g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795432749; x=1796037549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IOrxHtiCHWTIaFRLN9a3XE1Ecmglqu0IREj6XPQBmDM=;
        b=wFlxavRJqVzDW2Yp4dHATCIjLARfn5ZBvHvJsTFk9udqOER3LZk5lwJG7lxvMlystW
         QMX3hatwxsZ+QdxEee1RlMYH4p8yZDLNTf9RRwEnk4m5+Nmf2EsZHuX40j5upISYlj3b
         shJvNlYOf0tEGBuDqJl58PyXzFzgjUM6Tjt2qza2Wo7wk6/XbGNDYPBfQzPSA41+2gXo
         86Ec9l/+IKJe4t/Hj2+4/1r2akqCuqH3wa+KcknEDFlm5u6+4PstavDW4L+8D6E0icnt
         3Ei/k0LKOwVYGereUDSPrg1helpG/BoY0SXhzO8v0tnHbODTjdZvQTMQo4bmqoHmCY0H
         gmug==
X-Forwarded-Encrypted: i=1; AL+hErG3T/L67Qe7IzJKzxBOLcdW3M1XFxKPoll/he/yLWS/RoqHAxnhxfzE7Qdi3R7u0Sm9+YrgXuA5G/+bdtI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8m2JCM4goC09GGVB5uLyvhAPsl7TLh0JBGgejNbH/etnIyVOKa
	5DyGeL3VEv08lXDIxdWfR4NUg4spXOXJMax6r3ytnJ4nGXrelJRXL+h8
X-Gm-Gg: AZFdTZcmJJvIgV5X4DnaoP3AXUUIO9op2m1UBb36h8n/Tjh5SV3LCTEbyjtmvW+d4XQ
	upNOQDYaqal+S9LwJ4PLYq7PYAYDZj8bBQW07lhv9HHzwjNAf9MwoiFqds3GQKcobzfZGk8ahLr
	qPaf5mzNzV8UQrj8gEXXQePnQtR0pKLzZpIUD09/jWsdYOGqLXvSy0STEJNg38TtCQ/pYhTD/Tq
	P5FXdjSd7JbShPQzetxUoXYMgwwsBy4q99vd5jf+WtA1a+7cdUsz4U2gzibyGYslYE6o2b86F6P
	9LpsuVoKE8mbbWymNlWj7UaVOk3rZsosU8T1OvMes8EdFEI8mlw0rMMl17SrcAchaYF0fUwrMBC
	csqdMyruHXBcDcsPseaNAxfYs9BqR+JpfT9nfZQDiHqQSpRtdlqvpsP9Sos5ULF1zP8+95tYSw7
	qalWXaPWJwWjIA1WboTsBCot/TKDWUdUZeBEN7VJST386Oy0P1Diy71cQvLklANNoX1w4End1cW
	UOWu6kpb9aQ2M4GqNSBRgYGudyIj9LP4xCH1sx7uXTRWeWN9uYJoL8m0DrEmV81p+6YqWvUKS0V
	3ho+c8GgQ0W9qsRg8gftg8zpuI8AKIXW0ZarE/1xDxJCcn+tdARNcJB/xRiGY7wUKA==
X-Received: by 2002:a17:907:84c:b0:c2e:63ba:1f90 with SMTP id a640c23a62f3a-c513acb5be4mr952960766b.48.1795432749405;
        Mon, 23 Nov 2026 03:19:09 -0800 (PST)
Received: from [10.120.183.232] ([50.7.123.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc679bsm392442266b.63.2026.11.23.03.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:19:09 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Mon, 23 Nov 2026 14:18:37 +0300
Subject: [PATCH v3 4/7] dt-bindings: input: mediatek,mt6779-keypad: Add
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
Message-Id: <20261123-initial-mt6895-v3-4-95c46597e63d@gmail.com>
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

Add a compatible string for the keypad of the MediaTek MT6895 (Dimensity
8000/8100) SoC. Its registers are the same as on MT6779, so it works
with the existing driver through the mediatek,mt6779-keypad fallback.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

