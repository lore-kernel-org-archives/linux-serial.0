Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596877;
	b=fwj4RvXtfLJiuJFojCDP24TIZsxRGxBuQRZLXsx98pcm1t+leM2wfqaFKoA4EPYCyZIj
	 YbpEZOjblZDw0U04UeYtH1kR4Szm7Z4NSpC4AOqHfGXXco4SzSyoy0LTkKjQYdDybZHAN
	 njodgFFkvm1xQGOSCtwHhPCKR7m9pShQb0ldKwO7ay9JlVeW9V/+JW7XEZdxogwtALWgr
	 ea8CdOCHcVxLc92qr8uMxDRRAGTyvP4i9LEvBGSw7BbeD5bYQXPZgPoAIQ5soN9TUkruI
	 oyfnlnpe2OI2G4IMFB4M2F+QH2fiLR+fLhWmy33NcTy8ZK4wCcpraEcIo5QXzhetFbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=N6YWRmQiNd60ef4bLmQcLELuCtQOypOA2hMcEuSo1Oo=;
	b=ej4BJrmhMSaBhPZ1wGsAnk0+qxm9hK9iajd5VjqXv/gRL/y+WA3BFUO3sssM6T42F2Rd
	 G3ye/CrNSy1CELSh5hkbE0zZIAp39KK5jd8AG0fRy17g1Hsc+cxrbxrtTDQHRSfuMimlq
	 E3NtXjo+DIgzlzI0Qz7W9md+R//lvsMEREAeMsMit8o6tXhLg0tEOcByCztrv0KNBsnzW
	 4uRccrEx40HLxbnjcekhl6xuA5H6etNY5dNbFwn3dD+IMC+PHvhL3i9LMwTdVv+ckxdQ+
	 ss7LnGnD8GGEZwtlGsSRC6+vhTgW17QOXix9LRkuHhHtmFdgOY2jjFGwvb5Nu090NEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uwGcGaPh;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE160A3801
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83AE160A3801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uwGcGaPh
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4d30639709so246618966b.0
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 11:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596876; x=1795201676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N6YWRmQiNd60ef4bLmQcLELuCtQOypOA2hMcEuSo1Oo=;
        b=uwGcGaPh+BHfex7icC71WkfRYapSs0f9axsnDYJawncCBYbSymIONXbbByTOPA4Mxq
         +CThUvi39AO8kULxSYQr/f+xw1u6F1k09nzML4VhxmzWUWhRKrEMjgv2KeZZ3eAFw3EN
         g7LeZJ3AcCY9gsAwwTotWDvhn77KU5DIk0XZo5qBTBt4xvbvhUhhurEHQNLnQmTuKPSo
         g3wdA9Q4hQLuYGgtlW6F0M768H8c74wm6DdYrw8qOGQklh1OVG/IizczWWSUvUDEXMee
         U7hP5vy0RVUrnqMXRViuaOTkZmH1czb4EuZQoMFrl6qOh/lYG6qVAfp8IGf+Pu3RD8jw
         gxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596876; x=1795201676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N6YWRmQiNd60ef4bLmQcLELuCtQOypOA2hMcEuSo1Oo=;
        b=D1Tk5Yc41uANy1NJQZ82O72TVjMhAvdomB4eo5ePJxTCGw67joOtXOeMmTACJzlawE
         rousxMzo6V6hJueNd0oj/afPQo7UhwFY+Cel1XttLJiWlNdYPz8OZ1EInanwWVGXAeof
         Xc2iCyxaQLf+Rj62lof7+lu/Zrz22JhEyKPGCIhl6Gu/dvYaPHeE9adYKHOZf+8Mqvu3
         /eEBMumGa4FRJiquavdsWJvlPAmCekEshH6g01UA49VgXUKobyYVibW2rtytApjrJTpp
         uWn21jHIA7VSRShth3Dr/3TkA++03t09VoOQbeAePPpqja3taJpQxC9rlQ8pyLnPG3Z2
         kWqQ==
X-Forwarded-Encrypted: i=1; AL+hErGS2nN/EKQkz+q33rFUpHip1UnrTn2HQOEgWV2+YUU+6zZ5BV6s2Tw1Q94uPMjLv7GYmpOolPpZc25k158=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HOvKdclvOkP/1y+DaS1LT5YY0FL06GA3BEXP/EnNlAaeGc/J7
	M+9kXf04YvPhAMK9lWbmu30l+kCNMn78/OuXvLudDrJ6i/8CHLt58JgB
X-Gm-Gg: AYBFou1mkuQ42u8KljkCtOl5CVvxfLNGuhe3C8R+cGb4jncUMO0sv7C2b4gw/aO/WJw
	QzQh/1zUkYWxp3K6Ydl1kLXtU8Ie+95LNNqIox2SqV0XBD9l9U3jevbQEYzUVEoSAefvOSPhCkU
	z0r8xvmb7ohwXZd0MCeVJ6R000hXpkIK3qx04kAv1Bxeu5iYtcpNjruGbqqNuKmBJJZv24IjeZG
	Fd1jaRB+EHgbVC+fqeTSRIiLFNUXp5cEcSk3CnPeJuMZQABGvU2zCl7iutBUt8lBSUtXH/H6Pjo
	oE6bIRDFgtE3IlHn6R8bYX3TZG6E+jg7WJc8pSMU6ypg5Uh4oyI3nwP6FGfXEIpvRQghLbV7ztG
	cFqqkqMDuVhXGmcYtXbaftnQwXa6VmGI0IgjZFl9/fLQmSkAfw4z92/r8SW1fZdYSnBzES/lhGO
	79j/LcXezVrR1Wdz5ayBvax/KhJbWdoYo9ikNRM0ysbXlPWqM3Vz+1lq2R5jMqzOaemFkJW19Jc
	r0gjkGVMmsdwddB2/eP3A34wbTGep/ZcI//EfCIrTcO2gGblubCFwgJ4wu4dd3zFA7/5WD/Fu5P
	2gBeH9OmRdo+FzIxRManU8b2gQR+l64OzGTUciIDxuOFWaL1zrhrT1TF+uhnuJ2R
X-Received: by 2002:a17:906:4fc5:b0:c2d:c739:30e1 with SMTP id a640c23a62f3a-c509643c050mr336353966b.32.1794596875807;
        Fri, 13 Nov 2026 11:07:55 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:07:55 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:05:01 +0300
Subject: [PATCH v2 5/9] dt-bindings: timer: mediatek,timer: Add compatible
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
Message-Id: <20261113-initial-mt6895-v2-5-4ab0aa9fa391@gmail.com>
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

Add a compatible string for the system timer (SYST) of the MediaTek
MT6895 (Dimensity 8000/8100) SoC. It works with the existing driver
through the mediatek,mt6765-timer fallback.

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

