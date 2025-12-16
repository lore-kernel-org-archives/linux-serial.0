Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7258A3BE541
	for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765892033; cv=none; b=ilp0kVrCmKPA4qEyYcaCd78UyBGnZIX3ppoS7Yko01Ukt845pVJfVPHiDcoO0k6MlXv3Hk4LyU9JotsDh5XSaW6E7MdMBzF+4dpOwGqMBFQkNNEob1MuvcI0E25M9Gg0oCGAfG4Y+9ZvNWAxGNQL3mcQDRB6AjshshRge7kCvoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765892033; c=relaxed/simple;
	bh=Zbrgxl7/8K5204RAl20OAm5sZDIuaXEuvin7xFtImFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCRZrXGP070neHcSl3qWLJxRJPA10K7Th5FU0e7/gIIpjLxfj3i/DmfjPe4gYgKb8Z+ebGKgoakDObFTERzcc98i5se/NJqr5//JEq0Roq+klwWVes8jN8sAcD/qMerVXpoxWxTSmVWVYxksh7aN3vRoLDPUpoDlf++GEJJa7Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=G7/xe8F6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="G7/xe8F6"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0d52768ccso28558725ad.1
        for <linux-serial@vger.kernel.org>; Tue, 16 Dec 2025 05:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1765892029; x=1766496829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+gFWCwRiawMnBncXcTO/PvxprCNgSOeAOdslKE2EFs=;
        b=G7/xe8F6GiUblP5jre/i2Dg6Osl+ZyrtSHWrV7Msb+D96YB+AvEIOwyRZXe/36TmqP
         7HBZGOebu43UYvNKNC1JUe+qBYjvyF6825mGJhl0yCMGMr4uyBbzFi92z3Xfn3eH44zI
         wRTpeF3fQ3/Wsi4A33FrF9gSvf8+8bbxOm0WCvkIknOVsjflNL0MdqNAIzxKIeV62Th+
         xxOqRTTqjmbwG0FRhXlwtRaRReiax9fNpO+3DxZO3d/t2BKv9C/JcEFHl/dO4tiwiDzX
         lm05d5sXy7k5i5cXe/O+3WBCTrFqKIfK3s/dEzpzKYNOb2NzDtJRSXfkC4UocuLxo8Mv
         ea8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765892029; x=1766496829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L+gFWCwRiawMnBncXcTO/PvxprCNgSOeAOdslKE2EFs=;
        b=U3XiCIw7BQCTjenlFa6W8u/HagAlCCYG/P/bMkX4Po8W4u+Wr08HwF+rxrn8JWNOIe
         sK37Q3Go/ajhnJyboyKWg2i8bL9DJkgYoFWfBdc7vat6plGRV9LuSpWj4wQnvyOpgi7s
         bKHRyMhaOhvrF0BD04A82JPtwq+RIzRmnuUhgaH9nMO/jyIsTsONQkLhuZsNHQOg9B27
         Pst7apbuBxcyepVNXTGqvo/mWDAPn8+3lbuLF8X9MrDxjiUX9X5AluoQlR77X2m0ib8J
         9t8K2cSBHemWLHWD59qA5isbkqVzx1E2xWFf8aYOgkVAHJPNYwKjXqmWIL5GI/F2gIjH
         lk5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5KK7SN/cAhxBlObrZltMaCl1obWGAJTRLCr2hqmG+8hf5j2frRi7b0lkIMQ8KGxPxn6gCHpJ9ALQGz0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9MyFIQmAwc7AEOpnNEc4zBbs5Galws1FTd7ZGeUy7RLnAxs7G
	OsmENzm3QHz77uEJjEyWBA5VPiAvT+vEQOHGP7wkdSSLVWlTEcxZQ46ByFwvGsPgw5Y=
X-Gm-Gg: AY/fxX7vbwNMd6W4ruGvm0eQnW7cb/fwX3jUITsT4rOdCBYo2RfoSDZdtlEAfzS9+ua
	CU/N+tMc6eF1+1NZikFS8j/kkPPyZGre5L41MWn8pwPqN6WdeJdtxvnAluSgVAME13FGuUgaSDp
	n5sPtXDAwmIZC8lYxKd8YC0RvR3sg0xY8ZUZAoc2w94iHUzujMriIdORuZjZOTx3fGuw459Jetu
	P1pFXIVzNuaIifg7UdU4y4/hRGbqqMl3k9T4Q93GOrZz2QrvTccxPQaPXX/a5ZvfCq911KElsUw
	ZgnEehbeQwIefLbUYxSZk2+3o4VWeyTjwBF8akN1RvVwKfVZRWWICSrPNnYO57VMHh7RX+SbjtM
	dAxZj8B91juvnmtoAc9iquhzzi/ESc3xyhhwwmglNCasMYtt70a1tmoEnOj2s8ZqG009ujLGgF8
	ZmwrOk03xc163omGhMTwRQWj/wmxwP8Is=
X-Google-Smtp-Source: AGHT+IH555BYg0W02DfoN/1AYodPyeJqWymKTxAH7DEgGh7AGGSGr1M1vruhKc7CF1NGnjMT2M0bUg==
X-Received: by 2002:a17:903:48b:b0:297:d697:41e with SMTP id d9443c01a7336-29f241515b7mr111102665ad.37.1765892028806;
        Tue, 16 Dec 2025 05:33:48 -0800 (PST)
Received: from [127.0.1.1] ([2a12:a305:4::4029])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a14625add8sm15829525ad.61.2025.12.16.05.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 05:33:48 -0800 (PST)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 16 Dec 2025 21:32:29 +0800
Subject: [PATCH 5/8] dt-bindings: serial: 8250: add SpacemiT K3 UART
 compatible
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-k3-basic-dt-v1-5-a0d256c9dc92@riscstar.com>
References: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
In-Reply-To: <20251216-k3-basic-dt-v1-0-a0d256c9dc92@riscstar.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 Yangyu Chen <cyy@cyyself.name>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-serial@vger.kernel.org, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.14.2

The SpacemiT K3 UART controller is compatible with the Intel XScale UART.
Add K3 UART binding and allow describing it with a fixed clock-frequency
for now.

The clocks and clock-names properties will be made mandatory in a future
patch, once the K3 clock driver and device tree are merged.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 167ddcbd880058b6dcea9ce33bd814ff8ba6b0f6..73851f19330d7f9fc254efcd32b5977feada0b07 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -160,6 +160,7 @@ properties:
           - enum:
               - mrvl,mmp-uart
               - spacemit,k1-uart
+              - spacemit,k3-uart
           - const: intel,xscale-uart
       - items:
           - enum:

-- 
2.43.0

