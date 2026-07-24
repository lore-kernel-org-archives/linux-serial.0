Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1EB44CF56
	for <linux-serial@vger.kernel.org>; Fri, 24 Jul 2026 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917827; cv=none; b=QJgLsOdbuI2/zvkC2OQK7nsXc6iyFEffYV0acfEH/zrPbWgYCwsXGd4Ar+JFMGNOyc0eTci4pf33w1+MEvV5nQF+srOySgIS88GoP05gzQSfiQVmkk4Uc6ddB4BfXwhMSKYz7OAlUldgUtMCkIzvOysj/M+VJOOVmJNSn1YKS2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917827; c=relaxed/simple;
	bh=VT2WkLbrVHZk/VBbTj+r4ElGw6wpo4atU2roVry+mzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=At8Jy1JxPBS0spQCjHOUjOSyjCkjokeZxWMV3DcwXCDZ1Q00V7EyhP21MkBoKkMXT7K/R5+vqCEILZLwugAOQD5W9BZmMRkojtrzWXZIgIYUlgzUjnMR+CT5/+82V7S1unbNvhYCNXjnBmk2rXDnEeHxw+zgtSD7ing6F+5OS8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RljqhWTK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RljqhWTK"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f703a9d05so520404f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 24 Jul 2026 11:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784917824; x=1785522624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XHSgNIqpIGMGCDb/vwfax9xQeZ/i97RAydBRvL1DXus=;
        b=RljqhWTKE2xG8Z5KhWFe0sKd1GJFSLNYTQWJcfqGH+Ez0ZX4Vu3VPhHWjKb9kvSnoP
         F4RJgji9sY/ELKj6fyMm7S48qd9h5IVuuUuVYrBDH58hsa0oE7z+41wAfeUBRIHU1jkK
         3ah8hIHz4Lh+l/NfSnDVHfkQ/4zchze1qFmdmMcXJl9Jcr5c9o1AR2d9qoCifDGVse6z
         Ah60VPwLeVp7tHDVhWNuMHqPO7nXDMb4t746JFpvsWgHC5c4VxRbSfSvXHmMaPgI2PMj
         upx3fXxK6HPmf+WRbTHM4K3ScDzW4CPRgfcCAJAPdNYbN98L5XX+IqOB7GKxmNSUwqkV
         FM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784917824; x=1785522624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XHSgNIqpIGMGCDb/vwfax9xQeZ/i97RAydBRvL1DXus=;
        b=EraNBVH9KgZhpPpxiyNEOrPaC/WI3Ye++Qv6Hs1hUQbs5T6Lo6vBvWv8U8jMbkbs1w
         P29nF31HfG/wZAG8v09vX0jTbtWq3MchikAPP+CgBqZAL773526/C1H2lNjVLOhBNbyL
         sNpcIAJq8wq71QszrZGwLpJTUhLEDV4eAyuBjOoFvzh+nCMFTFW5befhuntIQYVEW++4
         nFZjth+nBWE9Pw2gd9nK9miuaF//Ym3jQIJRbdPNl+xM/ZM4Bh721kIcObAIqNjU9jxx
         z+OnF++QLTzexfnZLB3kaug3E4VLe9P/tWk1Un66IsOw/3J/0KgSCPRVhPk2uNIBqeK6
         s9+w==
X-Forwarded-Encrypted: i=1; AHgh+RqDEBI1VYoZlznyJa64RTTDKzPGdFqv47kEMM1CTJvcb/+ubLOisiPAoDjdbpJYDsq1GUdolJbHqZI4Qag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUYKqLiEqBRfp7665m+qFhntMY9CnbSHsOOvT2ZQGAdpPMyzIC
	Yk4vkUIghtQ/1QaowMySdlZA4V09zxEpMK89FzM7ho0/LRtB4qVjpFoJumS1FA==
X-Gm-Gg: AR+sD1043IVPY6i4Rlbbf9DRJIHrKuPKKXp3QF/yA28DjUKONZ0FkxF4zxsbVVON6Yx
	DKzs9hD7QhsgpELVOKJhQSuODGBdwpkCdjCifZo0ek0rE1p1fhgRZiE1bHRbHNb0+FRpofEipV3
	7D9kKXZCyVUnMFGH/ClvUIl2LDl+PR0yiXWT0euNl5TswIBurkyJRDheWpm6k+Z/Pv6wOC4crzW
	6D5QVnX5/xOpJ7bMz5w/VLzcMP3F5OVdbU+i0UD978NiGHik/Vabo6yMPxg9H1DpNYUwuIG3BlU
	65BMEI5/B6LJaWNpfJByaoGi6cS1ubjrArL5/VZekEmQ+5Dk2EzmoEgaiheOaqKts7pCdi7kilh
	ez6nP3fb9GhwpDRQSfCUign/fbFq8zjidPmC15uTC+uM5kCqU5evGN3n1da189shGWeDjnolO+V
	TXGr5OGQyBnHydG2u9sFBJ5/ZaZmb+7Q0K3Kz+1b4MDOBDhgiAG2P0f4QtADw/mWSBddm3LLnNs
	XA=
X-Received: by 2002:a05:6000:2993:20b0:47f:52e9:3716 with SMTP id ffacd0b85a97d-47f8dcae427mr8922729f8f.44.1784917823418;
        Fri, 24 Jul 2026 11:30:23 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-3-249-180.retail.telecomitalia.it. [87.3.249.180])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f85c531afsm26396571f8f.24.2026.07.24.11.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 11:30:22 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Christian Marangi <ansuelsmth@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Jacques Nilo <jnilo@free.fr>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Gerhard Engleder <eg@keba.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: serial: 8250: Add Airoha compatibles
Date: Fri, 24 Jul 2026 20:30:05 +0200
Message-ID: <20260724183007.188172-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724183007.188172-1-ansuelsmth@gmail.com>
References: <20260724183007.188172-1-ansuelsmth@gmail.com>
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

