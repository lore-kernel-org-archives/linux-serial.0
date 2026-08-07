Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A83E463B60
	for <linux-serial@vger.kernel.org>; Fri,  7 Aug 2026 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141259; cv=none; b=R4t2qd3KtaETDQpTF3uVM53c6TPDJUTpzZ/4Vcv781wrfS+LqR9YPYTmjoZQx6n093pOZAdqnevOUPgmd9RTtjavBi/Ua3b1/qfXgeXCe4/syEHeVywqgHjpWiito1veguk+OeP0n+X4lBphQZRjf6QVryACgxsZrcTn7VehfsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141259; c=relaxed/simple;
	bh=VT2WkLbrVHZk/VBbTj+r4ElGw6wpo4atU2roVry+mzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XShyuIFSimUNqkFYoWsKDW++G3fXMXDWdcOf7ZgYd1RblU9qA2sRtOGsxnXU+q36ze6kLe55qnWHnchxqD1tFW/HiHXsqNM7YsP9e8WiUL2k9nEGxQyoETv8uQ1Sx1rxNm2h+zK8KZWBrpOhXMMr7/wcLQ4raIt99f9QkdXol5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljE+knOZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljE+knOZ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f96c5b722so2423471f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 07 Aug 2026 15:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786141256; x=1786746056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XHSgNIqpIGMGCDb/vwfax9xQeZ/i97RAydBRvL1DXus=;
        b=ljE+knOZ/rimw899j8z6cUrYrNCeUhVJ+GmiKlCT1YwUkpWYgxNl0/G7Uea/iMSAT9
         gKz7IN9gyLMflvaU3KDUmqS8cwLs/C3uGTGWSses6XHKy1x9cYVL/q9p6Qt5vraRGkI6
         ArvjAYqUDu26VJVZ6zoAFLXOMy9kYGI+XlIxi0x4IihAaDrk9eiSa9VAwlRzs2s+aqjH
         l9oeZMmfJbIUrI8kMSV22NOu6yOCW9iFxCLyKFLEyyzCbVZ5wTvMYbmOrF7wIDiesM82
         WpzECeSCswLNAdZpgKDXlOOmbuM7J1JrkUWhkThqQVPFeMaqSmosYASCPcDutXIxEr21
         4CCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786141256; x=1786746056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XHSgNIqpIGMGCDb/vwfax9xQeZ/i97RAydBRvL1DXus=;
        b=eBvkuc1gL1wKz3kkKZ7fy7xzd/YKvzjGSTITo2XcU830TxWcx1q0es3vvL0q9f3Duj
         Dvgpq/Ds7kM+GH9GyC1LKNewF+tO/tpCiCrcWwlmW9JWAOo+HZOqytEid+5caYoMj0Ih
         9DZB/Zw+/JpF4Hh4sa+Dx8rLmBFyLNHK/A7zRdWc0AkbjfiKZObaP9kheY7ywdRusgZn
         QuHTkG6HZdhRN1aJF7PtadD9mXRLXBHmVp8q26OkUMbWA7CR0RCi5f9GNBvpuuNlJFsq
         7mer7u3PX7oXHYI8M6aibyu4Kl9jXQQTZv0Gf2QWu/3tSHsRnEezOC468SFBuT3maMfL
         zEtQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr1Et917ZyyzGX0LttqcuOangNAevDxk8IFO43IqiuRylWNSKbv45SgMHztsOnM4bXpIO8nmsNYg9CRCPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4aqjYRJIywnsGX40eS0UNPqicygJEyi0BY3/wb6/KeviIegAW
	T1gSjosZXye78t28Qycqpp6sOHNvbxK4xukBtUeTrUPt5MYkKQ8CmQ1y
X-Gm-Gg: AR+sD11/7Bek+7HZfEHuOysAaVSgOq61Ze9sBgKQOwWXFgbKggeASz8YrlzG6IYG4xU
	Cq4089RDls/3gl/jbaEFcg/FTBrYja6WuCVaxIlxBkh8DJr3xFBxhhU3UkPuOg7exVq1JWpY20H
	PjSwzudUdk+dykjLAyDRvMmG774qTLgCWRoIclwTGx+AiOFodrbTLH49mplsXjJxrinyXioQ7O9
	VRBHqhXMSEj6ubg+Qzxhuu4khojGJI24ClE5i5f5K9ad2EowGDLcOknS/pLJx3qZ0OljAm3DhDx
	dlAV3NhpNFCjTq41zvv9X3HVy11Tpxw31yize8giYExcq4mBNtvRZELJ+XczbjNwlR0hOvnu7sz
	wiv+cpho4dZG5Eca8gL4uz6trJpUHGzYZczlBSvrdORJ4lnavVhFZAHcN2nxerqZedp85O4ePPi
	TlmLu/Na31twiPISUuUzfuuwH44gBg74W9sUAegwum5o2cDzeMHYrcwgt2iG/45xfQNHPy2QkhK
	1HsTM3D9BDsAfsZwGN4gTjiHGfofDVNMt3xRgA30Uva3vjaGwT7H9npqEIMgGuJ
X-Received: by 2002:a05:6000:2997:10b0:47f:7b75:9dfe with SMTP id ffacd0b85a97d-47fec4f5f96mr32499919f8f.8.1786141255693;
        Fri, 07 Aug 2026 15:20:55 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-19-255-168.retail.telecomitalia.it. [87.19.255.168])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-480021f9182sm9581519f8f.28.2026.08.07.15.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 15:20:55 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Christian Marangi <ansuelsmth@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Gerhard Engleder <eg@keba.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/2] dt-bindings: serial: 8250: Add Airoha compatibles
Date: Sat,  8 Aug 2026 00:20:39 +0200
Message-ID: <20260807222044.208056-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807222044.208056-1-ansuelsmth@gmail.com>
References: <20260807222044.208056-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Larsson <benjamin.larsson@genexis.eu>

The Airoha SoC family have a mostly 16550-compatible UART
and High-Speed UART hardware with the exception of custom
baud rate settings register.

Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index bb7b9c87a807..b6f7e093d8d7 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -110,6 +110,11 @@ properties:
       - const: mrvl,pxa-uart
       - const: nuvoton,wpcm450-uart
       - const: nuvoton,npcm750-uart
+      - const: airoha,en7523-uart
+      - items:
+          - const: airoha,an7581-uart
+          - const: airoha,en7523-uart
+      - const: airoha,an7581-hsuart
       - const: nvidia,tegra20-uart
       - const: nxp,lpc3220-uart
       - items:
-- 
2.53.0

