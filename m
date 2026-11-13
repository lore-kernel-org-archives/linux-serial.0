Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596875;
	b=WNNA5Mbk3gsZYktc7moaH4zucvHb/pHTHOKsVedFbF9eypWJmfR46whYPIABjOv0om8K
	 UBfGKpfBMe+kRuXTyWfCstHZ3qKqR0icdMnCZgKiBW3mmqsLfja1lxoPrUUeuV4kpiohW
	 QpgimymfE23ziug0CemwNuTHFevrmtpQm8urG1j69BxqQYxUq8OyvjS90oWv7ycxA8Lwf
	 lofWt6wlCzfDlXXrtNCII2/K2Rhwuop5c/fIsq7PPg1Ay07gkXkMRpKVp/DE+ITp6GO4a
	 h5xpb015aS24QpWUg3VDNq1eecJJHsZZS1PBPRlBd1sGJma6P5G/+ppszmMbMP7WXvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=vksi6xdBiN572U8/PprSF6T1ZcI65MaLXrT+W5UPb/M=;
	b=FJApMizxrs4umKgBZXMQ3j9dbJNRnVYcqLLPOJ4oYsh9e5JCnRu0pnsMFUyA9iSy+XBT
	 QId/Bybsb2WJF56innS12E6sWf3TXCVTnGaF45tZjxFBZiE08dts+G+B5nIzgh68pzJSk
	 zq/pv4lSkIiixOp/rVvri7ut8HS3lr6dDVvUj2CDNOB1Qe0GeOoFqFjWm33icaCEFX+0G
	 i5dSWsh/n/IQMQKx4rA3R79PeayBtE3ZUk/z8DTrR5wwGHBW/hyhucTVKmO4Vq3bJExMR
	 2Jkmr7bzTP/y/6D1X0GXIcGI3JXQhHauRWXF36F3tffdygjC5yVU/hsNe/bkx3gI0CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bFjkGDON;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CB160A262F
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7CB160A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bFjkGDON
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4d58c50743so237599066b.1
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 11:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596873; x=1795201673; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vksi6xdBiN572U8/PprSF6T1ZcI65MaLXrT+W5UPb/M=;
        b=bFjkGDONSYnmUt0iBBDN+sBDopI7ikDsKpWVytszNlJgTae66dMDCiRZOAt5mLIY+s
         q1LywO7q27xilrn7scZ4dSAsbplZ1ghm5uDWf5LME2ful/5VEle53jfHvSJBkhpAjd3p
         O+9nm8RHUCbu6LNeCr8PQpqG9uY8s9AZpF+U4RMTeZsdd8Aov0vSFzmueef7+1xwzMpN
         6Q1jCE+2tveXveOZTjlik8Y4wllQipC/oRz/uHHKlYJH44dACS1fR3Hp1oUj628Pt94t
         uRP/PJpDgm9b6n4MM6qAaeWG3cE/6uJDdbnyGzFix+pPxfnA7fCUeAz+2RvCNZu8cGtk
         Yexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596873; x=1795201673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vksi6xdBiN572U8/PprSF6T1ZcI65MaLXrT+W5UPb/M=;
        b=vGL/PUJZUBOQyv4lPhGZJAKgwJOXAQlNF+mvYF/6iz80/4KnhWnv7oPLvfqwTPX1TW
         cxYYCsA40asOI5LbMiYLx4h53nseZ3jTflGV54pbL3d0ITiai09aiEH2tMe9AsqoJswj
         VcW4w8AAPzZaILIzAJaV6bpIT/PoaBKHEOGzFgj2j9UMk71p3igyoZM8TPtMjU9VhN4G
         1ZKHhla6MnIwY0F57BQPxskoa8tQg4N+5NDL3HNnWidzmJ6CCaxEbruZ9riYvMsVPrri
         +2KOh/NhQhQZm8SGAwXIY4zEMi7xYLDDpnV93AilxlR+F9JSac8FBQOvaYTu0LbRkHem
         eKpg==
X-Forwarded-Encrypted: i=1; AL+hErHc906yXP7bxsXU27uWLq9QSlE45nl3erwRu+mRkuAL2vzCzKfrIYtDX+fk8Q209Gtb1XPqALS4WY0QF1M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cJMCp/b+o9ro0KPysyJG32UudXmwd7TbwbsldryOLLeuUAc1r
	pgJu5DuAAOFFoAYACUq2FHdzfwviOe7Fup3W77SDSgmIFabd2tvGkrzn
X-Gm-Gg: AYBFou3+u7j/IBML7314h4XKNBSrzdk7hIZ+5KOl0QNPInxUvqGEUqFZ9ASUjUjJ38n
	NTWgltk+Rv59XBgRHFfjD8TxiR8Kph4nY5axYGrWBQ/69xUqKij7U+HtWLlrfKTorOBJnOeMGhW
	ouE6x9+1sVqIf/c71H+HnWZpUHexHpMRFwrcKRggbfOMtjPRuDIUdhCcMEAdwdEEfxHuy5tgwpF
	QHKCXDqIxsC0Zyty5BT2fw296CnHtTeoTrKVyWfv+ZvqxG4aeaJT8UnZjkBet/tEEBPCHbfDXoh
	VZ5NrY8NyOczHylZCtvi3uwGs0ZtbEaNktqSNs3bMK5sIifbIzHnnCj6bs3fOlrd2jnaXdDZnWQ
	mctDaNNvGsVlUjvEUa5JQOFLU0nevaNmpRnVI6UmY0Z2AslcSTM8cCBkR0xb2mTLTbzWvt3fA5j
	4AMgkt6p7pR6HGqHkN+Uca7iH1N4m0+T1GEIpPlzDzYprpMn6LbsFSUZ1zKGMSoHfC3SOGPvyTr
	sam2CANydMau18nMWzZiQZpB/suWjYbi4E95Vm2o9dYgtLZQuCyR48Dho37rRSsUFZ64SlJZmuo
	dvuT73E1S7XzOTRbGZ4hV3sRf8IKpm4ZBqxMLHReG1vdzDrfL7d9p2SmU9RHvGmvBQ==
X-Received: by 2002:a17:906:9fcd:b0:c50:9149:48e4 with SMTP id a640c23a62f3a-c50963db437mr297220766b.11.1794596872956;
        Fri, 13 Nov 2026 11:07:52 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:07:52 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:05:00 +0300
Subject: [PATCH v2 4/9] watchdog: mediatek: Add support for MT6895
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
Message-Id: <20261113-initial-mt6895-v2-4-4ab0aa9fa391@gmail.com>
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

Add the compatible for the watchdog of the MediaTek MT6895 (Dimensity
8000/8100) SoC. Its watchdog registers are the same as on the other
supported SoCs.

The TOPRGU reset layout of MT6895 is not known yet, so the entry has no
match data and no reset controller is registered.

Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 drivers/watchdog/mtk_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index a210fe1569e4..d8755979021b 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -607,6 +607,7 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
 	{ .compatible = "mediatek,mt6589-wdt", .data = &mt6589_data },
 	{ .compatible = "mediatek,mt6735-wdt", .data = &mt6735_data },
 	{ .compatible = "mediatek,mt6795-wdt", .data = &mt6795_data },
+	{ .compatible = "mediatek,mt6895-wdt" },
 	{ .compatible = "mediatek,mt7629-wdt", .data = &mt7629_data },
 	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
 	{ .compatible = "mediatek,mt7988-wdt", .data = &mt7988_data },

-- 
2.56.0

