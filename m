Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D903101A7
	for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764434618; cv=none; b=d6nWA0zKPynUnTveG6A5GIfmMt8iQK03ivXk2dAbHsM1MK8m0wY695FQWkXrF+BpfFcK7lL5C9xE0w3dm8+VFoFnzyRvMvvWhZzruA2tu28bqW5NRtMdu4pT4TqTcBCithxVBi3R1J9UI0aoroVITGEGt1cO1hPNICXYxxqg7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764434618; c=relaxed/simple;
	bh=Si3eRxLMBsIUtypstPKo4gg4caXALQjMtjyFcUYFaPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TH7lNpfd3pgyBL7+V3KkLvKvYDDNY6e+y4X2sF9yTGieddIFtuBPDdJUX6U/kMKNZu0F882KiIIrqkBeXi0gYM/N3yDIwYK3QVI6QaLZxYTkeGhoLa3AFVanTfw7phG4OfQEycxCqn87VxzS8WOYDuSRt46XNV9B5PlI8UODNWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDyg1B5W; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDyg1B5W"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so27076685e9.3
        for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 08:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764434614; x=1765039414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8llTcmCK9a6FD/g9xdGfc5pfkCOk7WP/ST+c7y3cC8=;
        b=XDyg1B5WK3oxrcct80mVABe/Lmbb1VwZzyOlDdErvRQeg/F4R2UCfWWO5cQ9rNVbQv
         9XQRBnYqn6u0/xSO8NSwJBs5z+RTBXt3ZDM7m3wgg+x4+fzJ/4CoPE71u9WmSUXV0LDz
         jed5WUXD+Rqqx7G8MctI/KlgMdDc6P60+CJk5zvj4epWa/pm3ylKMg6rVpE3kxbYIm4d
         qkTFT9Fo8zAkHyOaofO6kMHfqlWgz8ywIONqEOk3NDC8YA6k+D3Mrr2Ae15Au2/sVp/D
         ffI72kdSSLTYm8vsI31jh90UJ+DZY87RhdUSpseZHwROxLfHb+ewaH32KK5B+hTKv9Fx
         P+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764434614; x=1765039414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c8llTcmCK9a6FD/g9xdGfc5pfkCOk7WP/ST+c7y3cC8=;
        b=R1fXAa1ZghBseXGlUEIehCzbqwxwLmsRqYvEVgBTlMurkM8NGncYF+OUiT8laESErX
         +z8GidX39das7NFMoGJ8njQsRZOurElEmjhbBYQIQoBu+igYDkR6REymbR1JUbWEV6Sq
         q5ir2MxoXWxuplox8Q9skJraOoG6uWGzY7h6Izht9SQb1vx7KiAIQXN4ug851azaNdQa
         YXc8LXn7ay9PG4ylwB6UP9hVOh9Ab1kKDaYNaL71FXDotGDPqso3WKurX81z0+FmMLjU
         oDVEvaRS7+Z45lA8tb5bljclV2AkqlIwtJqeCruxRdmoCyMK9PF5Kbfuw1vOBOBzHN9O
         cGHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo+qsf42og12XU9RWvPgFxl0l0LhkFvaAsrSE5vHeexJxGZY2Eu3o/THx8bQSCtOSSLxJrSMGSj9iW2BI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdw6Ch2bkvZNYIsXydkbNUWvdDmeWvuHRuURkXuKEnZV6j1Azu
	uVWLVGWI1A7Z2AsMUHvTnBGpp4/kLtNsQ04oFQ7aQENVipLWhrwVWe7R
X-Gm-Gg: ASbGnctTz7JNoCCvlyKxsD++cG57O3eglh6SKnt6GscQaZxAhKeegn/5Xz+5VgjfKNC
	SFQtRcAMD8u1qPW9MwSchuLIleiQkJpf7w5wIO7HBtR00sA+dJpQ6Lm4RcglylqVkk/WBGD3aF8
	6N3ohG1v0hAvgJ8Tm4dPVsJX85ZdNcMa9/+qSPxpIjo1TrLwqymClnPzMgJXEqmO/I6arqZGnLj
	CBF6NGx5iv6/1woPSyFdCqV7MQaWP6331klUzW3Rd7XGhwsNS5PmXp1NKb435LhLC+L5tkfnd0d
	h/Y8Xs9FZDwMe3RswvAIHCq5smD19meK9m69sV5oJ7Q9veH046fc7jjyNxNzoVFNATHMMO6DSOS
	N7YI57coHobxP1JnWZLIOWusL5RNOwZi3yqrgB5Sw6aNk03GOxQuFupswHTIN7T4oZ1Nk5awekP
	2EoZBrp2pVDBQg4NWBCuIzWNzGEG6fXxYLN0mE8srrvKbYGhDuCOAWV1F1sco0lX04YASn0Q7Zu
	apQnP0NRJkT9E2r
X-Google-Smtp-Source: AGHT+IHTGtxytaH7ZoRJ5GETUyYKLGtKoivIoyHmUivB/QIKqPw3rHB30Mk+K3Ls9v43O/H2Ao805Q==
X-Received: by 2002:a5d:5d12:0:b0:42b:2e39:6d45 with SMTP id ffacd0b85a97d-42cc1cbd047mr35853301f8f.15.1764434613887;
        Sat, 29 Nov 2025 08:43:33 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca4078csm15970060f8f.29.2025.11.29.08.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 08:43:33 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v5 08/17] serial: rsci: Drop unused TDR register
Date: Sat, 29 Nov 2025 16:43:04 +0000
Message-ID: <20251129164325.209213-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251129164325.209213-1-biju.das.jz@bp.renesas.com>
References: <20251129164325.209213-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Drop the unused TDR register-related macros.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4->v5:
 * No change.
v3->v4:
 * Collected tag.
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/tty/serial/rsci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 15ed6cf5c6c5..5a58c783fe8c 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -35,12 +35,6 @@ MODULE_IMPORT_NS("SH_SCI");
 #define RDR_FPER		BIT(11) /* FIFO Parity Error */
 #define RDR_RDAT_MSK		GENMASK(8, 0)
 
-/* TDR (Transmit Data Register) */
-#define TDR_MPBT		BIT(9)	/* Multiprocessor Transfer */
-#define TDR_TDAT_9BIT_LSHIFT	0
-#define TDR_TDAT_9BIT_VAL	0x1FF
-#define TDR_TDAT_9BIT_MSK	(TDR_TDAT_9BIT_VAL << TDR_TDAT_9BIT_LSHIFT)
-
 /* CCR0 (Common Control Register 0) */
 #define CCR0_SSE		BIT(24)	/* SSn# Pin Function Enable */
 #define CCR0_TEIE		BIT(21)	/* Transmit End Interrupt Enable */
-- 
2.43.0

