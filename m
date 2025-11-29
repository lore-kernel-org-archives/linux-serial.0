Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8123F30FF21
	for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764434618; cv=none; b=mQLl8kDR9vsuBgkvLFN12YHk0Gth8NAZ2n5M3Es7LlCLHAPmfEhRgSpRHnZP0odnE/7zIyfVMVQbvvJ3OPu0tL7Nx10AaT8wishnAfuX8adr2DQUlmVpjLFRvIpwYAglril52rNjIsxiOmDiM8glHS38xjUZj+55yv3YsEXLxV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764434618; c=relaxed/simple;
	bh=rQpDIU6guW5TisAhVN1RrekmUcn6qvG4tAu7NY2Kzs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pC8QSCNW3vC673yB/UakQDEaf4pm+LbNZQscMO8A3B+s31hPGMgNJrRt1GY9sUxcZya1i7KRa97kW9Z2jZU0TfBEKk2N3hp5r0lriim6CcwaI0xsGvtzP8LdK3Vu2+DXlcnrWoaX5EjYw6iPjYcR0j8hwEOlzyo2MaIWgrClGVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+Ine2No; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+Ine2No"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso27403595e9.0
        for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 08:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764434613; x=1765039413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgwVwBYKZhPFgsmAEFQqqtyF7p4aZUluwhsWNQ7hNV8=;
        b=O+Ine2Noht1W7ImlGptacEUwwSbonkIWDqJUQOJ3YHOgrQz6nMszR3xOiSQH8cLuJO
         jhFK3Qkj6693Ie/oj05M6e3HfZKGydelsam7X419oHXNir4KY6M0aFOOIY8SZb8ha9lY
         qLmcrXXMNA8gMFOlh5WeNtCNzMcaH4hgtRewAFdCjLqnXMW2zEwxXvslluiMGNMFP+p5
         3TrfBmtIjn33t6u3arwcKkZ07edaXB5ycjg92pp5HNT1++dPVPtEY54wjjzsKfc1Q6wn
         GF09wVBQCOWOWcq/9Q2Fg3EIVPdFPHfzuf8UpCjIfj3QcUhajsgt6rO9/c+VAf9fDvSE
         mEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764434613; x=1765039413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EgwVwBYKZhPFgsmAEFQqqtyF7p4aZUluwhsWNQ7hNV8=;
        b=cbBI9GIt/xEihBJUMePg6Kny0k4FvjhZUaff3UrBXWKBK2NNzPQoxNbn94ADHHiGUA
         rbjCKQUBlm12KOmePtQ+pey5zrVM3NFlbal3v8KrBDRZorhydzUzS8syeRHegaawVSZD
         H9HpTZwwAQflzdsjdkYd+UnpRBrM7twIsHH8pHxZB8l/EtezVxmXodbpUD5WOHsD0wU9
         RGsvkqiRHip24q31XfoFEmpim8ZSWk2V/JJqY/+bS8NjTAy36Ic5MTzzYvwTty/lPYVt
         aYap4/EUITSP7FD89OaiHQKkPPS+tURIkxdjE1XQ0Vr+wb3n2//oFPAfimzNf3NGluKW
         WH/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoWUTtMI9wwDx92GCT8ro5PSEZ8jaJVEoW2Jq9oKZvdbgFl2fEe4afr3RYPF6a3sjtFIjyF1rEzQL25Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6VuaI+F/rHn1FH+z6MfERHNXMydKhLp4Y6/vbTwgzP0mVkSJI
	8J4D4W+zignngWCUeg2iTiDWc5NJbIrlTTnDFWaAIEJ3aWQBxmIv0mDV
X-Gm-Gg: ASbGnct392udNh8rnHbLoL5tJEjugXFTOD+Qd/o+vvQ2wrIgA9enMOvHLDdLGhzzOa7
	EQFLoQeMe5CGh0diYkOQKA+7itk1iWOoXLefXxWhqjOSmn/qc5FpBeoNgrOumw/IgnahNzGp6yT
	uXKykGXIt9tdWgG/nghAS9M/ycikRIDaTgOyroCzjrxaIfPYYKx6J0q8DQq46J/E5qnkbw1B/SH
	3ETNG7Rwnzebp89VswY2dTSeNq8YFiGcKmpOx6uYXVu4Gme2H0XjPeqSd4CqUoHqoepURwC74H8
	5I53OnhgWqzO0n57f+TmtklzBF3HoQMRigvFZWxJi6lf3ANQhmoJMS2NXFSmCXq5gyR06C3qdyd
	1O8a5zXsoBumew6hEvWI88nuZfisDD6lManF0NCzl2313Tjj7Mxvmbc9arpvrumGJs+3DdO4ikt
	9S2oZWzo0azNKxzf6KvcTR8vLI/qcc5N6h7WntbkDUCy/pcTsFLYOvoHAXB56crPS6gxGfMBvzX
	9WiExHm7Z/IJQiWhWxMsl2Qk5k=
X-Google-Smtp-Source: AGHT+IGaZAREtl6NXRyEBHs3whc3cv9+Ie6xWn8QQTMCAIyc9I7Ia0lzjDPmCBCB7fkXaU5WpwDQ8A==
X-Received: by 2002:a05:600c:840f:b0:477:df3:1453 with SMTP id 5b1f17b1804b1-477c01eea66mr306351795e9.28.1764434613285;
        Sat, 29 Nov 2025 08:43:33 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca4078csm15970060f8f.29.2025.11.29.08.43.32
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
Subject: [PATCH v5 07/17] serial: rsci: Drop unused macro DCR
Date: Sat, 29 Nov 2025 16:43:03 +0000
Message-ID: <20251129164325.209213-8-biju.das.jz@bp.renesas.com>
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

Drop unused macro DCR and its bit definition.

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
 drivers/tty/serial/rsci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 158173077c2f..15ed6cf5c6c5 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -24,7 +24,6 @@ MODULE_IMPORT_NS("SH_SCI");
 #define CCR3	0x14
 #define CCR4	0x18
 #define FCR	0x24
-#define DCR	0x30
 #define CSR	0x48
 #define FRSR	0x50
 #define FTSR	0x54
@@ -119,8 +118,6 @@ MODULE_IMPORT_NS("SH_SCI");
 /* FFCLR (FIFO Flag CLear Register) */
 #define FFCLR_DRC		BIT(0)	/* DR Clear */
 
-#define DCR_DEPOL		BIT(0)
-
 static u32 rsci_serial_in(struct uart_port *p, int offset)
 {
 	return readl(p->membase + offset);
-- 
2.43.0

