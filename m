Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792818995;
	b=K4lwQXQrbuTMME2N9LEYhAoL6ksR8YFW2GcsgSYMPgWYlAzkXFDEfXZD9CWLwFdmK1C0
	 WaHBQtce9XNcfqobetOg3C0zC7ga/u2ifYU+XTrjw68WClChi7ljhUEFYXZIx8cSvXTl2
	 quSWZnNIWzbPpGtNMfPe/10muf6HxVdo/wmBjDqXAEsq4Vl84RZiM3c5cz2UQqqNGj93t
	 w8MUaDo1VLAmprHOYBSYdvBufBBZLXClwudNqxCK6OEKzFKhOYaUVlFVcf3hKVyhpBJ2y
	 o0XNfginADIv3EJT4OqJs+n2ClbYsDSCQdY6vSkN0B0apqfTkNazUM0AKxhnuH/N1sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792818995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9+/gnD5T4Kmt2Ygw6Q5XDsq45pHCg8xCx1/EjyDNaxE=;
	b=z361rKwOKbX6oaR6ODH+Ky8TvhZzOMqoGAgjdbKqtBhQJy2FUeF0zpzAuduq589lgB8b
	 7Tru+1OJrWwXXatjsyqsCzfsujxqsf7+lAXxzCn3cDGgzipp2VE5xHUapeHjWVsDGq7RO
	 AI741iEslqK4wHM1yHxF2i9njR2i1DdQvn6yVLcy8cFRWRTng5S2TSnuTfm0y0RtK85fF
	 QzLgPMv27llP+jx98FsVZ5TGbxlx+Ex1RFwMtLnGYNnIdOCWakhwtrapcT0cF6dQVB50G
	 Zg3kWju76u3ic0PKwZPR4i802eYRLCNqaQpy+60JX0w5bRji6/lwQes0wJzbvDRkwrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Zpb9xE3h;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D72606A31D
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 05:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5D72606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Zpb9xE3h
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso14723265e9.3
        for <linux-serial@vger.kernel.org>; Fri, 23 Oct 2026 22:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792818992; x=1793423792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9+/gnD5T4Kmt2Ygw6Q5XDsq45pHCg8xCx1/EjyDNaxE=;
        b=Zpb9xE3hXNHuQ91xzOw8KF/MyOVXXGXvlmMaJHXkCFR1YRFO12S5FFNknzg2rWNz2F
         OGL2FEA1Cw7SZkQTMtjqF/a/5OwBTMC2E9ejXgl5qmRvp3+TTbHK2IXKr+789NaBnPvz
         Gu9YEza4izl6a/89OK9iTLn7/Jg0yOCl3+yMTgv77b2OgtcorSjGO5f5qoP2KoUOovMf
         72HP+M7hGdqorY3fLEseqhH8pJKpjR5bYkCwmabJPAOPalSZr7mguhggUdJPmUj+X5uM
         cr9PmgGydfXqgWymBYKn4+PhNd75n4uJF2U9X+VBwjdhQAKYg6B2Fu3ccq9FKaNmNzgH
         T1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792818992; x=1793423792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9+/gnD5T4Kmt2Ygw6Q5XDsq45pHCg8xCx1/EjyDNaxE=;
        b=1bcNvgiDQS1/TN5IibLw9J4RwNpxWXCY7xEg1OChAgRWEa1/C4m9mvt7KNEuHO/PSx
         u+r6VpTh9a2j/MtTIhwO2EmQiZEBAUx3JLJdG2I7zyeaJABQfQD2sXQ4UN4hcmoTTniD
         3NhYJkXWb3eQ7kFyyARmVt06FNkgrgY9X+cxzh7alHgHAIGWkwNi9GS+FL8TSok2PpuM
         jPNtvxWEP6RXiJhccQq1FBr9/zCTftcN5OSViIRj4bfv0fwwtRrlitYoqRAs7GrTWpu7
         Q+cDGTJ6kB57rS+Yo5JoFBdWNkgPhVrYzclOSyVvrLcCZQXyJYGZfTiJv70ZSFSaNAoK
         fwTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwzjv6BG4uGLC9jUCXz26M3lLOJEcBHrirsUmVy1+Te5QHkrU+3GXZ+7k3so5Y6jl99kdWbs4MZQYt1ulI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9cwJTjLCmj0enAW81K/2PLsSf3FwmPTNrCF9+oywp26aw/EAk
	B9KTtv4cTChsTz2eC8usWWIl5rV1EfZSyFdRuZaKrF47DHBBY/bLz70q6BSAXcgDI6o=
X-Gm-Gg: AYBFou0KWpPE4wGBpJkg1xTHpXyqaltv1H6E/czlGlba/3WaH4zdp3JGgmSQ3C1dVXn
	dOq4xVb3NWvuBIlmIWHnNRnLoqPEFfLPTPTj8fFNvv3SPqjxN7GgHHPt1vUxMXaCZ/b+1Vafn+3
	MJoi/WUzzSBTs00BcAU2MxE5gFJG2f3Sym2XP8ox7WbAp7YQnVkoM5HSpAeb+pdAc9CU9HxZ8UZ
	dIyN/L/g39e8HqpoT8ZTiyA1h2HKJPl06JQxV8a5ugElzRMla4U//Z2VrccI5ebxqQYM30hHjIk
	l/8EMw/EBCGRNasxLCuIlBXxDRHX+9QHZGm8zHDz/ZbXz5ov46hNmXEEDuxLbmH0dwVCmGlIKq2
	tGI+WlAaupFDjr4RYOzRCw1h8XLphBSyVXYDOAfeu1A5702ycoXvk9ptvhkRKejqkOatdPMivhb
	zwUhWHjLFVzuxYO/2KDQhwUJ85Yf2uxeHMNaQ3PkHrFjgr9O24tSJ22Mf2fU/LOGfGmdhxgRYva
	axOg6DRzN9xe1bxbLb0ZYt1ldORXAaTujRdg5+NnxDvXb39/4IlUlOGRT5HSUzbg1nLErrCvwVa
	4U8Fj2IcdM4=
X-Received: by 2002:a05:600c:a104:b0:4a3:5c67:55ed with SMTP id 5b1f17b1804b1-4a35c675a4bmr4907615e9.12.1792818992114;
        Fri, 23 Oct 2026 22:16:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9c3:9990:89bb:701c:1852:56c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a55e9aasm27604415e9.5.2026.10.23.22.16.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 22:16:31 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH 1/2] dt-bindings: serial: ingenic: Add the X1600
Date: Sat, 24 Oct 2026 07:15:14 +0200
Message-ID: <20261024051515.55639-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The X1600's UARTs have the X1000's registers as far as the 8250 core
uses them, but the driver has to tell them apart to set their bit clock
count. Add ingenic,x1600-uart, with the X1000's as fallback.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 Documentation/devicetree/bindings/serial/ingenic,uart.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
index d5f153bdeb0d..635342d43ddb 100644
--- a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
@@ -32,6 +32,9 @@ properties:
       - items:
           - const: ingenic,jz4725b-uart
           - const: ingenic,jz4740-uart
+      - items:
+          - const: ingenic,x1600-uart
+          - const: ingenic,x1000-uart
       - items:
           - const: ingenic,jz4755-uart
           - const: ingenic,jz4750-uart

base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
-- 
2.39.5

