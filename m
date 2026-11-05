Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911947;
	b=xHZEclKZYFuF+OQ+nMJzI1P6yA/HgqoXACBC8O8Ui94rU+W2qqsxcI9N2vuOBybCI9ia
	 Y1T3tYAjnja6PX1kZaqGggcI08VJ8F0hxEB1V05arC07wIcywPmo8/F/zbbOTud3iNzOT
	 UPl7jTlv535hUCf/8OXxMk9i9LvS4IxWeOXpUQCznsAa/EFLOvz7jScXKqsoy6solXyR6
	 1O07i7EC0M0mDs94xqMmPDkrS8G32aSeNYwEQe8CjTk69t/ZPv7u5vHWV6amiqE1cSGuP
	 OsnGEuYxzUqJz9x+z4fEyEK8QCHbcLN0H8vj5AL52mHqHAMynscLUiESVN3TxXpZM2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=HRoIIA2wpujQ0+Dd3LKXeU40GCpk4ukouOoolwO0ux0=;
	b=vSI5Bqv3I852YuxsDFlvN78SD5ERAiMqVoVQIJWpWMu7Pq42LfRPcEbvk+pJUpP4jffW
	 8l3oMMQhfySTS0q+HX656m1cDuahhbXTd2KmCxW8IBrTd7U/Y+CSl3FkruzeUkPNMISdi
	 8VrAdx9VduU4DdXbNhp9OY9i5uXWpWzfXEOCmc/uODGsEWz7xALeIAnjtkHLEaxEiyvf2
	 yglK4gZrUjIemKJ3Cqqj+yRNSdzxJY5n1Ew2r2fp3fqUwVqfzkejmmlbvunOL3OrGJqpj
	 FfhCQsYW95lnjxAaB15p0h2vwrL65zIQZFhdIY7EzLGdSDV3TQGi3x3qlCTeJxl1RRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LbaBlWLS;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DE1606D83F
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 20:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89DE1606D83F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LbaBlWLS
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-846566246e8so1143807a34.1
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 12:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911946; x=1794516746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HRoIIA2wpujQ0+Dd3LKXeU40GCpk4ukouOoolwO0ux0=;
        b=LbaBlWLS0+aIP6CHgi2/Vmx40Up/uDbYZsZuAE0S44vPJg+AA1gfDWBpnRrBsXiZ4O
         7TPKaCzdVjiw9lgUjwnFYStS2s8avEYvnkFpOaOJF3OTg1Gn36Ay/8sBLUubkOBK9Olc
         omLf+hRaxeK1gDcLFaEfEaL3+FystFirrlUDs/iXE9Hri4DyAudzSGbN3TaMhc9ECCyM
         7R+lagwDVFhwjbbFyuMLIkW3MN5UnavHOnLi4WDp68VWTgCVStVSKeJxKQEDIRizrOyN
         BWcLIZUmcM0PbDFN+6ipsjqCksdLQ55mB2ayk2z7QpXEicyOJ52Lp6Ke6TLtYy+kkiHw
         KnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911946; x=1794516746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HRoIIA2wpujQ0+Dd3LKXeU40GCpk4ukouOoolwO0ux0=;
        b=KUb6a2VVhISTIJ/p6m0of8HWlOH4lJZElUGZhKDEBkDYuxKbKIWArsr2bDiCQX8UjF
         Gw/LtGYxWx8+UBA5UzA1Yh5YpCYqTGKhXTC02CDQ0ElC15TriWX+l+UG6L7Ga6ZjFLSc
         c2Evn5tmwoJqeczpkhA9qRfl5vF9ppDvgVh16qNDqL5jFjG2plEZfm+BMxjNcAck8FtM
         A058+k9HawzbBCNUXJ4/ChaNUw/keVkt3OXatZJGoixzkCUoWYMk2q5or/rUzDBQYsoT
         BQLT5EwESLC7/fMFXKrpv9+DKt6LIhmwnES1+Ok3aXvynL6SdJcyw4U2uiVJlNQPNIMc
         SCcA==
X-Forwarded-Encrypted: i=1; AKwUvBzWtXoraHSQp7ziH7Y0q3EtMwy54rCYyAC5FYY3nEwQ2FBCTq1gRAfEhues+kFoDS3sRaOuTigkvZnsJWo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IYLOWFfqJyQGkZLoFoog6WX2+4Zl/DlaAY+kB3lQCuIQeJ5R4
	uelEPf0xPDY/RA+0Xhsr0A0qeubUw1jdE3zi3Zp67fsXlzw/ygyVKW31
X-Gm-Gg: AYBFou2NgQUL/T4v/ijowPu+I789IJTYcUSQ3BFrhynb2OidqVYLIxYrTHhLH3kkEkZ
	UPugpXrb5whbkR+MLl9ssFnImcJ+d3i4HB2YOEFf+t3PInvyT63LGffuY32dFdDeLKAT69rg/Bv
	r6ldY0+sTDPafRaF8OH9w8kwTvmT0qD33i3658ItPvYx6oxJYKNlWAeBvCnZ5fY0i9wZ+K2xmVC
	9qJATdWVEB0GRDottvDVs6ursuSjMadZd8nGeeg+Flh2AlKA3jJM9sDq53HmzNEz9z6DyXcgq1b
	+Q3Gekc3okvS0ZryLo/pbopLkWlAOonbilPlW8+c3HT2HgggVOoZImxXl5inSR4rd5y3O6GQqBX
	XheXQgTln13qwPHbEJciV/TxMokdERuAB3Scrh8+UstK8p4aUXgayGWuWEl+yMuNS7vTAojTh8b
	d2VuNlwj6SAlQ+VkgpTgGBM7bdMkyFNsMhrNzzuSnDDWpgO0plQJBt+i/GwQ8S+hqFndMOkrdxA
	48EUOJ503TsjlpVuZGY0SpDX3WVEwliQ6axlu4W2503Qkal0u6gkDJ/pKS4XXKaE6TyOtQWTCeH
	UQz/vCi7E5Si0fSPb9Q2yIBacykdevIwjBFTGthEVxT1ISL9BUrZ/NAZgJHkD5kd2qQcRRwpFqE
	kDGrw9aRsj/orkuN1gYf0XXwaLsfNYj0DElPxshb63Ab8WcltN1c66giC6ym1DIGFCR1ZfvIIXc
	Nemrdm2JU186i+VlhygoEo7keCH78rCZKTS+8DUShdZX1tbtLgWrE5x4knoPVceqBSSOPGgilS
X-Received: by 2002:a05:6830:2b0e:b0:81b:9104:5ad0 with SMTP id 46e09a7af769-85f052a28b0mr2500096a34.0.1793911946474;
        Thu, 05 Nov 2026 12:52:26 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f1dbb298fsm292276a34.6.2026.11.05.12.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:52:25 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 13:52:08 -0700
Subject: [PATCH v8 07/11] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner H616
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
Message-Id: <20261105-submit-h616-uart-fifo-v1-v8-7-14024d2b184b@gmail.com>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
In-Reply-To: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

The H616 UART has 256-byte transmit and receive FIFOs, but its DesignWare
component parameter register does not report the FIFO depth. Its optional
register layout also differs from the generic DesignWare integration.

Add a specific compatible to identify this fixed configuration, retaining
snps,dw-apb-uart as a fallback.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index e2ca126d58ba..fc1289073241 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -60,6 +60,7 @@ properties:
           - const: renesas,rzn1-uart
       - items:
           - enum:
+              - allwinner,sun50i-h616-uart
               - anlogic,dr1v90-uart
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart

-- 
2.53.0

