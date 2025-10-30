Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5CC36CA8B
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846934; cv=none; b=qm1oTqVimuUaWYXFSKFFjwz1u5aYcG+E2O4zHRa1RZ3+OHXNeTwTS+9aCnBgp/crkFfd9BZhT+SUgkTv0xsf/zCZio6CNuQsp5CGezg/D6RYCGtOe/anSYm9kTcN35H9okA9wPKkV1/6SHDeaMM2ocFagKIw6DGR/bLOFTwIELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846934; c=relaxed/simple;
	bh=CGCGb9V5eBipiJiyKGzWDh8EBRU+yWeR3nCYNAfd3C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dM5N6fFFI+hwCJu4Hw/L2Z3hn+XRSYu1yyShAn+uCNqv58PFgPYCkOwhaXfrkOCSBqXe1Dtc4cn6Ihki0pqt5vuW/1S3jGERk8B/jDJQR9kd/g40iqP6jcr7FvqbFxdhppy58Qi9nYcIdLUw+l3C14WH0cfnvu4LCjahuvO5vY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llu4AxCb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llu4AxCb"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-427084a641aso1123957f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846930; x=1762451730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yttjZeqTXK9cHrnm5+lJ6shcRMBRq57/tMzXtPds7Io=;
        b=llu4AxCbYEFeFmperq2HYGcElsxZtbHyCqW0L5UMacOds+BzpLFfE4RaM9nkFnlafC
         Y5dbIK8ueAplhvdOH2i1GZ5vKwa25+YQiWMmKClCg85yeRVGmfXhe+leyIyi4dOucgEb
         tRsMsgdQYAgpb4MW2eZZq7TaKNG/YraYHkzJBOivurrCtyiunJlirRb3a0kJT0q+/unf
         c25eCHAyf391GeUKNcIUpt9NNUUeFJnaY2jn8oA+qDoGA5nsFZXzyazAFa3JNhFC+XgX
         VMEL2EL89IAl8NhQ3wRS1bpZn/RpTUQEe24TnsLSIKnoKOVJNowktykzuKcAJZmN4JTA
         mY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846930; x=1762451730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yttjZeqTXK9cHrnm5+lJ6shcRMBRq57/tMzXtPds7Io=;
        b=L1XboB08M2juKA3956KiROgNHfTmQ2jN96TOolaXBx6AL59uQxcRC6eZyRC6SuLkSB
         QkpOjqrBmRlBcpyN+RMnIgwN8TwPnTvKVPv+3Iznb4CqQYbD9mlSIV5TVULwJH573sZv
         mBQW+zTGcV6i2ksm1JtaXHWpCOndN80KGptwCThpzlbrUb2ekURjrWT0O5Ulh3cVTxEK
         3VdqlFYYEmZRcrNTp9GwVb3VClZCA+/Bt1rDXrC9D1T8X2uMq8tlxGuCpUHeXBbT2lK3
         EVG470XsQzujNlImLFN+o3Z2lCGB8nEqa20gUcULlVNZX54qxvTJL93F2qyAY3F+F4TI
         w11g==
X-Forwarded-Encrypted: i=1; AJvYcCXRQl/UfrrvtOR7EZjbn7d6m2c776J/NJV5mN1m3bhJ6xdoNvgoxTVxH35jRtrGj/oBWRldTPArnFZCNXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuCw1bAkm0N1sC5PbjFVQvpYygW1X68Tgf5tWWX7JG8hkZIH8c
	ZLUZ7vg3q7jyXOKhiaUDVW3s9awKNw9T9qmUwbs5koRNKZ3ZZXrOzpvc
X-Gm-Gg: ASbGnct88TmWKdM6FQtFt78hSnezHwWQpA+Gc9tPSvqWdQs3nwoi1Oc9UVY6GsDYgOt
	tEkQGgru3jGOLQ9sRx3a6fRnjkiXQRx7GSfsdcHR1aqrnKmOjmI/UGD/xtrSL5nDKXFOyAkNtaT
	02WuT46tcuG9LOY+SeodElMH9VmOi6D4IroSD5Ao0n1BNTBW/y2aulm+XE51p6lUHyKP9/mxCNf
	FaTxQbsQ/hF+rilC+T835DonInfTNLvcROGk1ebLXwT179krWVBKgNuQwxVzffqcuYJUWIP4LyI
	7he2DsXmp3dbciRALF+2XE5b4xZqZEeFhwDJGv0IOE8r8PgFVUPwMkjsCyr1kCHXrz+cjJyFZUh
	aa83D32ymv9x/6ePtGLm63AsHrQYoipPslceS7Jy3augeiiceDPHfK8QVg8jPpUE6CtRAA9/kYi
	Y+9vhadZhmAPEmjS87csnYWp/QW0aO2W9RakTf+HdwF1wVs/6vLZBSJcpOPYw40T6BxRRbUfs=
X-Google-Smtp-Source: AGHT+IGYIITVqCReHtNAX7+uLzQsVs5gAndiYBJ77Fh5G2SnarCvdls7gc0J2+Oyf01J33C9+PqrNg==
X-Received: by 2002:a05:6000:24c2:b0:427:6c4:f165 with SMTP id ffacd0b85a97d-429bd6aa1c5mr412181f8f.35.1761846929744;
        Thu, 30 Oct 2025 10:55:29 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:55:29 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 02/13] serial: rsci: Drop rsci_clear_CFC()
Date: Thu, 30 Oct 2025 17:55:06 +0000
Message-ID: <20251030175526.607006-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
References: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Drop rsci_clear_CFC() by reusing rsci_clear_SCxSR() as the contents of
both functions are the same.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/rsci.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 3e1f4b3c4e59..504361ed5ecc 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -199,11 +199,6 @@ static unsigned int rsci_get_mctrl(struct uart_port *port)
 	return 0;
 }
 
-static void rsci_clear_CFC(struct uart_port *port, unsigned int mask)
-{
-	rsci_serial_out(port, CFCLR, mask);
-}
-
 static void rsci_start_tx(struct uart_port *port)
 {
 	struct sci_port *sp = to_sci_port(port);
@@ -275,7 +270,7 @@ static void rsci_transmit_chars(struct uart_port *port)
 			break;
 		}
 
-		rsci_clear_CFC(port, CFCLR_TDREC);
+		rsci_clear_SCxSR(port, CFCLR_TDREC);
 		rsci_serial_out(port, TDR, c);
 
 		port->icount.tx++;
-- 
2.43.0

