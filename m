Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596872;
	b=TWc7/Dg+bQbzD8yGaAio33oRChH+DT9ih26dX4JDuQwLGJMxWd0iSaC7vRPtiEkqG0to
	 a7MnWViVOY6soIiX2mZX3PS5+Ph+aEdH9kypigKkkAkw0KNPTth/hf6HGaKBtebqZ41DX
	 aXMiEIRNvZAQXteEUCLl96znV6qpRIsrLYxsVNNkyXt0PNvzlYKJUdYCJcv/vTany4+av
	 kCwI6wq7mtcQAJa55q3OGj8XW1TlMXEW58El3nJDE8JO14vAu0lO1tt1xR5irWJF7q9/b
	 bbTZ+dZEZsGnSo5LC3SrZgL3iap1a/bi1oySvtqsWRK3rSgVorjxKgsLT+xOXwYzLKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=498bVPav8qEVV2GYaYtJAWa131hP7OjDlibTUA65Q0o=;
	b=0fYHH2V2+utWp0MdphiFnBLngorcAnEsR3oKPxHJRZUsLY/LEeDCIut6X1bP9GyTt5mv
	 HRREEp1TvD9de59o0NG0BJFolzmsO+gGgDkY5aF0gqIHKVEnflxx0SDfCfuRT+g370IA8
	 g6Z7qsegreRtzMIE3euX/IBnk+VWleEBhw+TSCAWe6p93ypock3oUszAotPjzkbDpsOPb
	 1dM59ApfVHZMvEO9xSyJyZKtXjhdnuT7z6RvdMCiMDtGMXumoQT+1967OREdTeLj2boFe
	 DaMCwJQqEHJfCp2b0JtgfPef4RMgxQht/XOR8LDIX9XBdyJPbH76sKW3ojR/hZgplVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HePccj35;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74F560A2610
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C74F560A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HePccj35
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b571979178so2683521a12.2
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 11:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596870; x=1795201670; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=498bVPav8qEVV2GYaYtJAWa131hP7OjDlibTUA65Q0o=;
        b=HePccj35FvhTjvXwtdVBJgEGNVeh2KrOUDPZqigubVdBbr/KLsuRN5y64YNXHBWId4
         m5z0PK1xgJg2mvVjc5PNTWLFyq96goUIFhvhIPhZLDaMHVwkfH1EPNEemnp6vzvRPKLg
         Yuy1HRPofIJAEzZc6kSFJD1IKjUzSort9TdQEdO9ff62aiFdDCjMk7tpoNy2qzHJ8s96
         YMdgBD2K4ZYcf0zITt9tCnTJE3UbVZJCXEo3J7dmh0cYnycfUhsDbPWzieA+Tru3tD+O
         CE6bH2un439G7EPfZMZmwydwevOgw046xvR0kNIjHzWfD+tp7t1hWAKcpujb0Shia4NI
         mV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596870; x=1795201670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=498bVPav8qEVV2GYaYtJAWa131hP7OjDlibTUA65Q0o=;
        b=SybvA4mUCEBJWydYu8uDrEorYo1rIrItlEpIihPIsUY14AWmjuU4nSOGjqu3dohSef
         EroybynDWz8xjbLBG6P0V5fKHthwpMa5W7lg07Y6eKG/il6kHAhkpPDgbb0UUzVMSpaV
         FGNCq44WHkz6efqkLCAWsVCXdOzVAvxjt8A71c/58Ek5hlZvRUlqeyjRbgMB30TPOeQ+
         IOX+1IhdPhSlwl5xC2cqEap2bP6jAg8d7On6jVqnQbgje3HCJMONTGMhKw4hHCLKiP07
         ykajaK/Q0zLiKa/32MelAMfrz4rNVn/ZmCLfiVQR3KQOdB0PZ3FAvAikON4Lq6UpzXSV
         835g==
X-Forwarded-Encrypted: i=1; AL+hErEffccqx1EW/nrScbC793UBJr6B19y1BP0yGZA6ieTwhcJs50th74o5mhY6uipBCZMNFsy9qeE0BaIt9g4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xVw7yawU9cVgHBaMcZLovGO1DMtTgz7XrD6ZaoEySc3iN0wKi
	PKWFSyNk6LoDtodLnNtMJgkwMB5kT8fQm18mBhEiU++/r8mpB17qfKPG
X-Gm-Gg: AYBFou2x1k9OD/ICbEAUAkixFUBH4YHQMV4zRAOnMjEo+LHXL67mMfgN2rdXGDDGaue
	4Ohkv7mqREPXpxGBtRbRrWjYrWjazcIJ+5f0Vt9dCgaKvIl89I0sixD475B6/65X8l+1xcwV6U6
	Gn94mzm8xDINktP6qAqyY9U665bHT5Wu7kaMgcyQZSAFOXm2KC/ovhNAwR+XVqRkvSrNv+sOAEe
	hE7ANyGHnogOigvu+uRUp9EWJXYXDrCS+g3sdMALvvAfzLY8kQ1u1bb1vn0+90HlXwwHmgqtQkk
	QMwunxpuohCqgTO+xIbCEtGAia0JUU2pJf+7CWasJRWs5x+ycV5A/r6q1FXfARGv9Egq5SPdWS8
	l++0ZcfWgRZdtu+czNd7PmXlyyrudAOEo5nTj14wo9TyosoXm9hyRCq1d27IviAltkJx+R9Vy7h
	zoY5bAa7TabeZZfCrl32TOLS2KUue3R3Acgpuz8fCwdo5qKN8Fleo/a3CFVfn1o5cjq2Cota1nY
	jWxQQMWQD1JRB4siUDQSi/vCaQLTVzMObGDU201ERugSZTVnL3YgyY5uQKbPFAkflEX32KNZfz+
	Opx5roppP223X1AFDZY6eL9rxRzSLuqzZY7bWsODhcv5nhOdBCrLb+06MOW66Zt8
X-Received: by 2002:a17:907:3f02:b0:c50:5186:6dc2 with SMTP id a640c23a62f3a-c509636b5f5mr389984566b.24.1794596870123;
        Fri, 13 Nov 2026 11:07:50 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:07:49 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:04:59 +0300
Subject: [PATCH v2 3/9] dt-bindings: watchdog: mediatek,mtk-wdt: Add
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
Message-Id: <20261113-initial-mt6895-v2-3-4ab0aa9fa391@gmail.com>
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

Add a compatible string for the watchdog of the MediaTek MT6895
(Dimensity 8000/8100) SoC. It does not fall back to mediatek,mt6589-wdt,
which implies the MT6589 TOPRGU reset layout, as the MT6895 one is not
known yet.

Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index 8e8991ac95ea..d0a73b9c81d6 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -24,6 +24,7 @@ properties:
           - mediatek,mt6589-wdt
           - mediatek,mt6735-wdt
           - mediatek,mt6795-wdt
+          - mediatek,mt6895-wdt
           - mediatek,mt7986-wdt
           - mediatek,mt7988-wdt
           - mediatek,mt8163-wdt

-- 
2.56.0

