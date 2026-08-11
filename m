Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6B0411689
	for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786435806; cv=none; b=TbRo+cXtEEctkisqd58KPB2hBm38gHA+5lTj86G8guEkF81TZjljCLa5TCckZEcRYvsQ2wYdkrt19RGoBdPKvgAYIZJJXjz0/ylLRD/ncg+Ndp3ngsSxJQPLzs98mtRfR0q65BeOC2tmQFRl0QwvPOFi1c/TowB1JdA8CgZHbOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786435806; c=relaxed/simple;
	bh=NXs1HeO/pBJziwD3M7Zetj+JP08cqnGqJzklwV5SGqg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7MOseeiEWq+ppcfgFm/Ylac8AMCDcFtLdH972L5l7qf9OoA31i1WvWm/GJX3l5+DfpLd8L/RDncpqQkMwEEZzpT+p4mu8rMRlRMECCy4Sch67CcXAaVN65IZt2CbyY8Q+LzT2dlP4H8qvA5mLDcqikLXNLvSCcQ3uzpngDt0Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwH6HUgB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwH6HUgB"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4980dc26022so28262355e9.1
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2026 01:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786435803; x=1787040603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=udZAkm1oxDo7yBPqbOtYYpIHCvzKK/t/xyTiusa5l20=;
        b=DwH6HUgBy66s4CooSeEcDIVIa+/FDZoXJB8jvGNacFHJEYpYJ/m//Equx8zp5hD9Xl
         Ud5veVDS5PBpYRuw2YExK00r+m7EZ5GhlKsdw6aKF06DhJ9tmze8PFFJ0J0QFsO+eo49
         xv37fnx5e5iRLw/trNnPRSQcjF1X2IAKMgHZjfdTD42mit0rQYmeH2SUiqh5k5b33VQa
         z7xqgQ0n/kkV33EFkXcCQE8jFqWPq+7RivcVHBbFfCAzF6VIi/uLUPpCCXRVyweT2ZjG
         qBArK45j6oJGx0cYHbqIYr5nW2guiZzZZxziCjRIGWijJhCHijjMgFAbHsDPyXEOwXW4
         CUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786435803; x=1787040603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=udZAkm1oxDo7yBPqbOtYYpIHCvzKK/t/xyTiusa5l20=;
        b=oBW5vKA4AKIO0yg71+igg7ed2T8VaCt3s47aiFEk+84seMZTPJ1QgRbVepTBqRed43
         3jiK1ClUJOMH9QSTCMzvf0+UKxMnbBH33wU4neGHWwetFm2B9cZEzDT5yxd3g4ktuCzJ
         pf7X/MNiD7sPcOOf8J4mZRd6VXldKSQOb2CZOJ3jebXwRrEpnuQtTi4nftP0sLShjbLG
         Q8zvwdS/H/uqUq5I2O5i6puV6EuqY9KJTDXi3bwFUdsjsWl3i+q79Zyac0HTjEuhbKHH
         3sBrM46OBLxllTckFhk5ZmNmeiBq4P5ngOEW6/vQsOGChACHCbqrnJnNNaPL/1VKTeNN
         ZBhg==
X-Forwarded-Encrypted: i=1; AHgh+RoUxqRitq9ReuoIaReHdRZSveqHsMtPXr5VCdD7dTJ1G9Q/s5EqDVrl5uoicq3kW/7PEpPgSHXXiwGDFJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQBOmOueqSR9DlhG7+G2j7l47E9EQMFsKp/Zin4hbaBSAr83r5
	+pr1BgrvTt531/RQqTFsvjfxOFtE2HqqqjBIFnP1WBTsO0NcImgXMxoKZV0XLcyn
X-Gm-Gg: AR+sD11OIQ4cEnDq2iiTL5mDLIoOxRotglSfJuYeH4lRmW+EcegrvoBYPcY7rm8sHnm
	jtryJXs9fgq9vGvHnBEaQknNtW3kHd9dRwwQfRiXMj1aHiOY4MX7WID/0MH1nFl13db3YEJpzE4
	wD4EjTR2CwEe4BeZxnTXQgc9dqGl/Itc4PIiQy0QgwxApUdVjJapajbM5ogyd7EhA8DVSqPm8iB
	P66/Ple2yhxDOh3pSeykTIVGTxtqBGSpmW5bf22XPO9oTM5F21etmARP2WFRGJhnim/mHMX30Vb
	/ueI23tJTIgrqCTDaM8VSHvExslIouOE8RouT/VK8sUKH2HqJc3KMQ8b/cZxAfTfad2vGyDL+sn
	wZAFatj3r2LpcgTAEKAKsPeJuLN9OemIJK7TKUyoK3H7wyIsuoOzUtxDhR84lrdHhe5MGGIcJYg
	zqUtchG7IN1tmX+qD/IgTVUx5VkDD4IU/fd+92ZHq+BIreufzYKxRlUdnGpL0jjHyskndH8SKlX
	6pjJmwMLLmqtMJtXOg/0G7IOrKOOeDYiqbd75/n8wK2GK1u1XTa1Vsg7E8=
X-Received: by 2002:a05:600c:1c07:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-4997845f6c7mr19665115e9.9.1786435802820;
        Tue, 11 Aug 2026 01:10:02 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49977df9489sm45336675e9.1.2026.08.11.01.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:10:01 -0700 (PDT)
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
	Manuel Lauss <manuel.lauss@gmail.com>,
	Haowei Zheng <zhenghaowei@loongson.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Gerhard Engleder <eg@keba.com>,
	Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v6 1/3] dt-bindings: serial: 8250: Reorganize compatible to single enum
Date: Tue, 11 Aug 2026 10:09:46 +0200
Message-ID: <20260811080950.664379-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811080950.664379-1-ansuelsmth@gmail.com>
References: <20260811080950.664379-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of declaring each single compatible string with a const, move them
to a single enum and reorder the Nuvoton compatible as it wasn't sorted.

Put the generic ns first and then follow alphabetical order.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/serial/8250.yaml      | 27 ++++++++++---------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index bb7b9c87a807..039bd392f876 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -99,19 +99,20 @@ allOf:
 properties:
   compatible:
     oneOf:
-      - const: ns8250
-      - const: ns16450
-      - const: ns16550
-      - const: ns16550a
-      - const: ns16850
-      - const: aspeed,ast2400-vuart
-      - const: aspeed,ast2500-vuart
-      - const: intel,xscale-uart
-      - const: mrvl,pxa-uart
-      - const: nuvoton,wpcm450-uart
-      - const: nuvoton,npcm750-uart
-      - const: nvidia,tegra20-uart
-      - const: nxp,lpc3220-uart
+      - enum:
+          - ns8250
+          - ns16450
+          - ns16550
+          - ns16550a
+          - ns16850
+          - aspeed,ast2400-vuart
+          - aspeed,ast2500-vuart
+          - intel,xscale-uart
+          - mrvl,pxa-uart
+          - nuvoton,npcm750-uart
+          - nuvoton,wpcm450-uart
+          - nvidia,tegra20-uart
+          - nxp,lpc3220-uart
       - items:
           - enum:
               - exar,xr16l2552
-- 
2.53.0

