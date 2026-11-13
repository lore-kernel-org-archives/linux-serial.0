Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596869;
	b=rhpKYy+wP0D3RMm5lNytCHlsx85g3orpzkgi7mQQMJfz8sl/tuvim/M3ns28GKqUrxHq
	 ZLN3XFn7KbF89EtPRTQDvZ6+ARLaOxBQgBfqgk6Ybai7x+6+mMz3sK6zVod7VyqWEBnpR
	 tyCKl8WawsVoOvtarhPSb9JZUF3y2nGylEdC5IjG5HwqXRg+wnrOeC7qzm0Xw38QjQ3Oo
	 +WCSJhTcoabEgnnjkIci0Lxx5kC+9YACvEPpjnMCYVa1GDpVznCquyQTNplXS/2TZAJt1
	 /7+CFiO2+2HNxHtD4Q1+I9efeYcdB15ohxNcpXqw+Ns93/ARkLRkEFOo9HRDBh6edYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=EtVDEEY+1Q2B+PJRdO/nFO/tm1fJ8wXwnQSpYA2WKh8=;
	b=FP72Py/slq2UP61rHGDrn534OYKBQhc/Oa7v1SKnoxFxs3NkNOGneM0KEVArZ8n6HYdv
	 NJSrUY8YcZrw34zZ9trYkqjZOYG2RwMJ43MUqZWQfSXh4kzMwsN6AkftJjE3B+xcPw3/u
	 5ghxPJAOmcZi7PtemUcScxNFZ9M4BSHpOmllyXDeHwqMsDHhmlZX2A/3fSyjtFPejdonK
	 aPLqLLlnzhpsVyfU1bur0viBt89P8roOGpxKhQGbtvTRPsjqttmyR4sXDGO0Jq5+TYqQF
	 wIDDlBtgFg8AZ1nNwS23dWIswRCpkJ6KtYvbD9FLfewej6yh2ypCNa+r6VP6hslOSRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rE2u3Ig9;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BB8606A8A4
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37BB8606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rE2u3Ig9
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c50aaad19fbso62950366b.0
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 11:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596868; x=1795201668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EtVDEEY+1Q2B+PJRdO/nFO/tm1fJ8wXwnQSpYA2WKh8=;
        b=rE2u3Ig9QQmvYdO4meupm38R07509KcJIbOAEE8bkGwjMEOVzVv0JJLzRE37Peidsb
         smpNCeOpTI7ROICLLY5L90EV6xSGREQ/ui4lN8ruSeUYnNG4G3X9tiX6tmBDjD4S+rmA
         EJ+gM48JWQjmSoetmjwKebkBu1/6kW1rn3mdQb8JgRGM1t922TkimGEZMcSERFZuIPXi
         452eL4fN1PQASGBc2YGLxX4d6X09AtHZIOSnl2GtlrSWA8UO0+oSOyfyLdzIXzzzqMTS
         vEBgWlzFFtez3312Bw35huiUspC7CzTPnn3dJJdqQugkUMAD1AMnk+Aob0x4KYw0XNBZ
         gFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596868; x=1795201668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EtVDEEY+1Q2B+PJRdO/nFO/tm1fJ8wXwnQSpYA2WKh8=;
        b=I4BjbNzyUk0yqChTKa7DjDwvlY6nbMX7OAyeGQQazHpvv+74ToaSwLhJry1fT4k50/
         aab46ot8Yk4dB26QWxEmXNMzsJBetJpXWDWfNFX5A1VjpIzInT/oP7X+/RTM3eUWovRG
         GIwVmsmHMz1fY2fPA4rz7x9WVRWbK/3IBavqJTIqjTnQ0xa3IKfpnSMYuYI5eA0dITGY
         z7ZvnuyISTm+vIzrVFo9q0HYd5dHLixROojgc3v7W8JWTHcWbQ8/hLxfKYazC8Zn+Yi2
         Bt6jd8U1pqDjB4ezdHeJLB+JdzRdR3fSQDKYx0GJpvhEi3O8eJun5fHOy+SM3p47hU6u
         G0YQ==
X-Forwarded-Encrypted: i=1; AL+hErH98zmbAPccUxmAiHKOgZM5LmzFM4zmRissEgAspGqjuZUluCAfebXZlS4Rn4wkVEFwbmFkVgvmZp9yOOk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/K+AeWlvKeqQnkticban3gi3NYlBfcJ9iQvOviVLA65BgFxndg
	qupDqTELVRoPupTLpTxS2co5jbem1Blk/YeNs2WC072/r0GzUzGmuLkl
X-Gm-Gg: AYBFou1QXWLSyBJ5vLCWDrbk5/8c4pcVCiyGyJ00ihMBt3sPznWfZkdbpVfvWIgrrqz
	WCCERKqcqKx/IbkQFjoZp3Iu12rqs1Gzist+gARi4wXRzUdkmhyUJXSguYeWeV/r4jEHt+1Wte7
	iD0S4tKRWCpnmoMnfYX9RmCQkUIQCnn+myOF0ZDhNUiZ6cRasJzFPXzQ4GQjjA9AI6LIReqxZSH
	XBd5yK3DQtaEkHjkk0rfRhB/efjIpftbnjVxc8PVQeS4GB2NNdtEzEkS7WT0Nb1883khM0r+Uqb
	NcHyFxQMyRj6YZm3ZhY8V1FWqo62/Wd/vw1cXkOWAqNAuScVhxolRwe9xndmJcObgReHyfzgCPZ
	B/HxJ+QsirgJwf+zlpOmXfh8OFyUSSRJ8in8IuGC7y7h8H7nBLQJyZx6HVD2xNkKnIVzPazLaT4
	MAjA7k89wGptsWWPdfJhN3v1JGpL9NT6WyVURhB7jmYFyJy+WAHUdjoswYLZS2KVfEhHos3zVvt
	wrz4Cy2sma+56ROstrcVcvTlQM10GtgmGqjTY0M1UhrH7lIWyhvnT6ueJDr5Bi5MH8Gc3jmbLe9
	8UJTfMdElL31ZoYuMnsv6zLogE+SiNUuRLuxWahVBC6Ci1CKSTdXO8gXCBRtcScO
X-Received: by 2002:a17:907:2d8a:b0:c40:cee7:3918 with SMTP id a640c23a62f3a-c509683f389mr411823466b.44.1794596867571;
        Fri, 13 Nov 2026 11:07:47 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:07:46 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:04:58 +0300
Subject: [PATCH v2 2/9] dt-bindings: serial: mediatek,uart: Add compatible
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
Message-Id: <20261113-initial-mt6895-v2-2-4ab0aa9fa391@gmail.com>
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
 Conor Dooley <conor.dooley@microchip.com>, 
 Alexander Letuchiy <asalde.le1@gmail.com>
X-Mailer: b4 0.15.2

Add a compatible string for the UART of the MediaTek MT6895 (Dimensity
8000/8100) SoC. It works with the existing driver through the
mediatek,mt6577-uart fallback.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

