Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFB840F8EB
	for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375611; cv=none; b=psrSjTxTKc1JfyPBNx3EPyTEj3nUUbolZnBaJdNZEhM3eBZpgLUU+pngHv9tVKUMMtvOiqHNoNpQfHukjF5K0OFS+wvwbzLe+6ZojOPysgnbOAWXThkqy2U8LLWyejqcgvaAR/j5Xf6N5gWQ7q5SqKvleryC/GER3HSpRazU5K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375611; c=relaxed/simple;
	bh=AHmaNY7nawOxPlTyMrh+owRJ7CVGAzGmrCiWsozDwmg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYdZ3VfnkDBItm9GjYcfQIieCvtr4l9N5QbiLYVOSzxZzqbR+iRkCnEl7787Gi9Ij0eQc4857Z3RuEW8ahs4Bqnz2ROu/IsESp5Y6lhYkRrA6+W/qyr+48UbB4qwnjfj7UxDaNrsgBeGjmk+SFGn/OR/2Eopi1ScJzrdEefiYd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOK4MEZl; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOK4MEZl"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47362928f65so1663168f8f.2
        for <linux-serial@vger.kernel.org>; Mon, 10 Aug 2026 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786375607; x=1786980407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CmMtw0/76OA+jV/NNsKwfa9KgyRSKCj+2VWv5bnUCFY=;
        b=lOK4MEZlp/u58X7ZJ8qx4yjbnnHwRrcOLfSkhkg37QHO3qjO8PkbARY3tx+p0Cdpp7
         lN65qU5Bbw7ExKrB2qF7Qs1cW9BGZxXVXUZo3jtHWl/gE88FxsJjUitXgMySK4Kv7HZv
         5Zm3shqWf1/f+aF58VZbl4JKF4/CoycJzFWcEfRuJpGqfMuHNpfywcqOSkodLuOvolBN
         ZLZWlC1FCkLeOAF6NzVCtp1e25rpzpnti73JAVm3AWx6whtCIi+mZpx2pMjlM88MLVUP
         UAffpADKzV5xnMhCoUCU0yBXsO7PruwUdcLfdlaeKt4zNNwRjTZq33m6YqYJwA+wVm94
         DKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786375607; x=1786980407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CmMtw0/76OA+jV/NNsKwfa9KgyRSKCj+2VWv5bnUCFY=;
        b=A+bKH52ggk2LPmJU14JyHYdPtUgOEwxVc4u8GGMckgb/dCi7tltUHWVxWPgDaiIEYS
         AnVWOTS72XzqYYs7iwNeDhDlfu+pxtd+saJSpUTxg6H5C3BTSLMrOjOKGyLpIbr18GG/
         t6+15+psakab7c7nfw/LK0eCVAtnrgN1SKFUkbi0sSVI6LcdJxtcLR90Ls6LV9B6CNeA
         fjrmtuBYGQn64eTnF1K/Uun/EdtdR45SsCdIryUtWqj5HdS7Oz3YtFmno2eOvGl6dH5p
         h2Qu0XmOpJuN5bv63jFjAcHp1mKrLUIMXYnP1QDcEPAiDt86wGzkroLDaerP8fqnf0A1
         rE3g==
X-Forwarded-Encrypted: i=1; AHgh+RojIMaEND0pbu0gPGdugVFKFyIaQKTURekZ67996B+0Oz3g+/BCmq/ejmVkgEN44I8V44d8I/ePGQIOXOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqjxkOAfcH1t1dhUiihQtdfH2HUui2Si5FlbdGUskWyhW+MYmR
	Y8EXr4kybQnXDV7Xw8X44qY5sTLBeIjcQwvTXR/VPt/Z0nAinjsAPJ5g
X-Gm-Gg: AR+sD10e6Hgxe6dy8s/8Nj2o8i4YpX8Wad5+6D4/+pCbIBHfWYBAMDs8cjT2dlcR4GT
	T+hEH3wATBY8mi6Er1dzjXIpmpF0nw01iwOICvtNul42pbsgsahi1GYTYrieYkU2kHSWHykKjGH
	9Sk+EbkjZ4kRtBLytLozK80W15LRl2S+wCDtLZPEZDsTMuldtSR9gpFDAYrYw5lYhb+OKNhoSDX
	vcdkVM6Z361AYpm3VJdk4pkTB0VsNLUWDOKNRYj1P3BPxRCtZBD1DwKMkDrxPPCAyHWtzBybReU
	tD98uAVZcjJQEWZpDBJFyWubNdJBibStrERBFdsL3D85Biu3+HyltjeFpMIsb21iG2TWLwsDYhU
	tkpPYgKNUBYeaeNJjCvqWqEeWkj4XdJFBBs9IQ+5Wk2Ld0X4lqphGYdNYP6hC+Ty58Qeo1gkcGj
	vi7F8gkNdEp8t1ERVIGy44TbUdQf8j6lz/OqtevaKAuj1CwENC3zmHCZRi9EkRXGbL3KYxfl5s/
	new2F2itj21lBQGlr9pq7/VXtXtuV0pESzC4sOcVotc1AnL
X-Received: by 2002:a05:6000:290a:b0:47f:9283:1fbe with SMTP id ffacd0b85a97d-47fec475828mr65854797f8f.0.1786375607021;
        Mon, 10 Aug 2026 08:26:47 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-480021e8cd0sm34952469f8f.17.2026.08.10.08.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 08:26:46 -0700 (PDT)
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
	Jacques Nilo <jnilo@free.fr>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Gerhard Engleder <eg@keba.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Haowei Zheng <zhenghaowei@loongson.cn>,
	Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v5 2/3] dt-bindings: serial: 8250: Add Airoha compatibles
Date: Mon, 10 Aug 2026 17:26:34 +0200
Message-ID: <20260810152636.658955-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810152636.658955-1-ansuelsmth@gmail.com>
References: <20260810152636.658955-1-ansuelsmth@gmail.com>
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
---
 Documentation/devicetree/bindings/serial/8250.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 039bd392f876..9a3f596f8a0e 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -105,6 +105,8 @@ properties:
           - ns16550
           - ns16550a
           - ns16850
+          - airoha,an7581-hsuart
+          - airoha,en7523-uart
           - aspeed,ast2400-vuart
           - aspeed,ast2500-vuart
           - intel,xscale-uart
@@ -113,6 +115,9 @@ properties:
           - nuvoton,wpcm450-uart
           - nvidia,tegra20-uart
           - nxp,lpc3220-uart
+      - items:
+          - const: airoha,an7581-uart
+          - const: airoha,en7523-uart
       - items:
           - enum:
               - exar,xr16l2552
-- 
2.53.0

