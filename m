Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796682EC541;
	Fri, 22 Aug 2025 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850998; cv=none; b=NnZIz5nFcHdWi6YHCJPHna+IpV4HhXvQIhFKGO7Rl8KJviyC/Yq4GYYIH2gufUCxTIwgyGNiJHw03xpX+2zIK9qeE3GSXaYF/li24vbx5idSqKnxUHHP+jshPnM4744wxu2pmMg3bowzk22AZIk2WhzkBFN6Hd3EI1jXDf3VeT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850998; c=relaxed/simple;
	bh=SLgXpq2Fh983VVrX7UDWoLI+l75KftJ3fX4YuMu0BDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PHqk9o2LB4KmuJhH4wNe9VlshmYPAA2FBwN92V5BJmZofbCXim2tv//9jvnsREHmVVuoH1+dE0vtU4v13afnU35lscs0dsQphdVenAZkJb/34OS6Rav6C13mBaDWveTdch6lH2cCfFUe8Cbsz5+WTCu78chIl+gaJQkKdCfvw6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWYOyLRU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWYOyLRU"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7a7bad8so263988166b.3;
        Fri, 22 Aug 2025 01:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755850995; x=1756455795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k2f2TsuwTC/XCi5X+heoSLXvqjGa6qy1ak2QsJOLClE=;
        b=fWYOyLRUN7fbOweewiuVN8u/FCfgTuu7JXrhnG/sUIjNp5B794yQTzhHVTx+OCSLfK
         5UZNROwwzIzGca3JSHRWfVKbs83dgXkoIXKL0UaushfbvwvifJPV+DGB1gnbb9V0CetE
         FLU92wGUi7LZJaEj+W/IMqRW1lHeozuIwq9Fxksy4kb4FXKAHs+nr/fZNue2/DOHxrtP
         ZKEWkgJ+SEMFVl2fVpOIy7pT14aje2MGXpnXNKPjijpbDZmTqMYpO+INtz3S3KwBEYPl
         /36mu//S+Kxrsu7pRNGg3eqnFtfiCA87EEvP611FzEDuGfIRvQVkC0awOkVEuJVGNLdV
         AJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755850995; x=1756455795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2f2TsuwTC/XCi5X+heoSLXvqjGa6qy1ak2QsJOLClE=;
        b=rLnHVMht7o/edEMeIVO+bIf5HtWZgOlup4S3Ns/udodEmT1+AKbzV8po7NDpYppJr2
         u4vzklWgNLs2//f+FohB9kdiV8ue3nQVL4BtzgqNupwowFRZm+0wBUf7vyuSCkFC2VAy
         OqL5Zilgu2svWWwbO4gwBifzJheNPpY62g5wW9oSTTYkIIWYOKEei8N++vfk80rWzDcJ
         oOl5W9AHa/qMgiodvctRWKRM5leA9czkaB0NOfMcjLI3CECKwY3BG7iCVyB9SBG1/x0s
         rssCOOcz955KyVsPiiZllmcY7leb9HIAfkfvTLiKSyQhgeqwgTiGP5m4IlWkoPiiWRM2
         ds+w==
X-Forwarded-Encrypted: i=1; AJvYcCVIgQwnX0dlIA1iapZw244/+aPDf6c9yccoIcTDYYMwJQjQ1xGnCLVlq/Of3Kt3ogvM1YywHjmUwPlXOuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKRRbMBIV5zLoYjlZU7JzMhsrgTLBNtOX5Tf2lGMmStY8dZqNK
	Rs5Moe2xJuuOnYm3avgCuApLKaTy6g4Hal18ZJEl3JBbjb9xvGNfKSgU
X-Gm-Gg: ASbGncsA/7P6ORAnWMfIByCDx1QC9I5dzvr9DuOypgERSQGSHZ2o0jtDjLqWmNIIRRc
	Wz10pNmw8Mx1GiqmnXxVS1xegJ0NpoXp+C6ssCO4eOCekmcfJdHDEGFBnyDnfoAFktsUXbC/Nbz
	vDNFDCOR5sB19KBWcBAmC60HvZznWAqp+1DNbGLd1twLM5alXSFw012mxWlxC5jEcQ7QO6Dbqna
	kSMKNecH+DOfWF9KKLhSlXNw1bg4QDtRNZziCDNzlYFGckBMdfeYPauwxC1CL2ZyD9iizxrkhNz
	i/FQHeUYTpMtI6DkXHJmJ9bbJEEe3OtmRle3BeXhpmKscLQDZaU52W4iI8bzzg1lK5GwnziuZnL
	g9qIsDQ0ekyz0OI5ZQ2Qs8/fqfM42hnVoXa71aJyZwuI3ws0Rq6mYGy8ZZBP2QeE5778HZxm8EV
	TLA+II
X-Google-Smtp-Source: AGHT+IGVOs1bMKRgKKgKJTnfgaApw/Pvzew2Qv+Xsjmv1gsBRsbJR3pdRoNwx0YUIXhnxIOq8RPDyg==
X-Received: by 2002:a17:907:3f88:b0:adb:229f:6b71 with SMTP id a640c23a62f3a-afe28ec5a6bmr184432566b.5.1755850994661;
        Fri, 22 Aug 2025 01:23:14 -0700 (PDT)
Received: from XPS.. ([2a02:908:1b0:afe0:dad8:d30e:64b4:faff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afdfe05ace0sm405607566b.112.2025.08.22.01.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 01:23:13 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	mingo@kernel.org,
	john.ogness@linutronix.de,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v2] serial: 8250_core: fix coding style issue
Date: Fri, 22 Aug 2025 10:23:10 +0200
Message-ID: <20250822082311.16501-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a coding style issue in 8250_core.c:

- Remove redundant NULL initialization of a global pointer

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index feb920c5b2e8..225bb7e4b89c 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -307,7 +307,7 @@ static void univ8250_release_irq(struct uart_8250_port *up)
 		serial_unlink_irq_chain(up);
 }
 
-const struct uart_ops *univ8250_port_base_ops = NULL;
+const struct uart_ops *univ8250_port_base_ops;
 struct uart_ops univ8250_port_ops;
 
 static const struct uart_8250_ops univ8250_driver_ops = {
-- 
2.43.0

