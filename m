Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C78313E04
	for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117531; cv=none; b=um2sTtkVp6RgZSW4oerdOYI4pfupQusr8Qp6hRedouixiGD7d+WJ7ISc9KzKuTzE2aQym2BHx8852HVH8fEJ26c45hHzbuj7n0MFBuonWfvFScr2/PeLOwtkHFPBdRr4WriOLUPNuUvomNZCemYKCSQ9LD0gEiz1WIkek+bbMo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117531; c=relaxed/simple;
	bh=lhrbj0OcSPih2hHSQIH0J0fKDkHISmrd2RLvWhH6Nyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6eV4HJG7oIw3nTi+h/0C2cgyV9/9NJ5Msx9jYBFG6c0N18P8zeqil5KJlDqXraCt4hWuXyDftq1sCcW4GWS1sjZYIzrKAuNe9563a9EBvHliJ0Z/iHqCRPoZpKhFBmikY6nrj0oDHcXHJV37HS73bnw8tCdoyBfF0AkBhEl6AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngKpl8LO; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngKpl8LO"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so1751393f8f.1
        for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2025 02:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763117526; x=1763722326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYpxnPtlPop5alBk2PoZYH1TzJtgTomEZwrKVEB1e8E=;
        b=ngKpl8LO4KYDtsy6reYHYXl3iRsGoqOiQAtFGJ4sqQRlSOxuXtbs2lndWuyNqRaPdL
         ICxsEzIPmt9D3qjUnSikbhp3bNozUjR5r1RvVNdFTOT8+Xcn1rTEQbfnHCDNLhhGtXSC
         hwDpbXMmCnNIaxGotcR5kF4RoThxOxjeEYaNWO1hV4ucsAa1R6cnizii0jOTq64exqOc
         Y05EjDzCoseDh+xWtn9rSIAfCmaKBVnpH6EWsMKCATpEtXNGhYdSPMjKvNrC9QuSx26o
         CHygOdyRcA9n89dvQNuby8vwshhBt7ze5unR6izS/IOldqhFmQkYlgmegi3+gPTjS7TL
         UF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763117526; x=1763722326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xYpxnPtlPop5alBk2PoZYH1TzJtgTomEZwrKVEB1e8E=;
        b=tPub0S+6VLS21HDJxxOcR6U2Cq57+UQMa/1GDgbCD2qhrCtzj07/wZY35CfW2VjNyo
         lGzaELz/sF3HXV3pkeqQPOy0Uf6rraQTHrjxbVMG7ym2e57SdNFjHJCKGW53589nQCop
         R5DGLngKXy3mzlS6eJMvgaKY6l6jeEhC7+cAedj2vMT0rRX1L30uDOraFkiYKXrPIkTY
         uCggn5nMhiQwjp8Y5aWyqUW0EI7HNTmeLqDZgipyR1RQAG3RWVOX8Yq50HjbuuRTnbF5
         6Z7g99GJhgeRR2Be3/PWg45TDtkHa6OZrUnf++cl7OFjn1VwuwrWhhu10CvbMRKzwkge
         UnlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF52Mzpn5JGR8t26pOWi02S4v/5mriPmRLvHtwzdtAHVEvVpGLNwG9y2207Di8bCy1CDgrBzdwd6qG8Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOxp2Q1KWqjhCH0JxOqdcrEZIh17w8pyjuWfJitOtHXXmwpzcL
	q7y1qpO6hIqciHv1mf3Gpm+JEUVO3pPZBqWuLH2aX9u75kETL2MukE+K
X-Gm-Gg: ASbGncuKfYafso+6q+2faK50Y4mzf7AtyIk4CjAXnJ2zGsUYntf7i/KYmuCzG3e+TRp
	J6+XXIueQlkMFlBywTJpV9TzW4Sg90ug4t+Z+1n+dna6611LJuq6utoF54xq4zm6TcDi8PnYIIc
	gycfh/gjivdBaxS7XUdTfVZ16IrGoL1aGN+Hl6fCUyYE2K3oq5IRA6284I78IEYoYQTnAyAy5tw
	l1l/n8l90o1Uv8Nb+vPl5Z+PndTvGDBB1g4NcG5Eg7ixxQVo5z1CdcfOtw2X0IKXN3r3kqrMPLw
	fsvABpzU0yYK4EkUWh+20EZKr08wfTYdu56Z4iela/08oHE6g8bWrkmxrMx8fS+Wg4LU/hAQvBl
	0cjghadGTJsy0VZbWRELV5AcHvjsSy6rjWJrZh9tU7tkvR6ksa0kE1BiTm5zrFwwEJUAh1KwbfV
	oSjtZyKKkjbPChoszieqg+oLk739ZYhNLbvwwsYNdOID+/hG74Zc1qxK8nTHuI1r5Lv3F1TqG3j
	ev+hn18gHWqzlfq
X-Google-Smtp-Source: AGHT+IGOR8QW0xb98M0JpE1UwFVZnxmTMEVweqBtK/qFgVR6+iALWh+Xf1+2TqWQnP+jdt03f7/uHw==
X-Received: by 2002:a05:6000:40dc:b0:429:ef72:c33a with SMTP id ffacd0b85a97d-42b527955aemr6201873f8f.3.1763117526404;
        Fri, 14 Nov 2025 02:52:06 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f17cbfsm9031255f8f.35.2025.11.14.02.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:52:06 -0800 (PST)
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
Subject: [PATCH v3 04/13] serial: rsci: Drop unused macro DCR
Date: Fri, 14 Nov 2025 10:51:13 +0000
Message-ID: <20251114105201.107406-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114105201.107406-1-biju.das.jz@bp.renesas.com>
References: <20251114105201.107406-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Drop unused macro DCR and its bit definition.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * No change.
---
 drivers/tty/serial/rsci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 9681e8ef4bfb..9fa5d387d7db 100644
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

