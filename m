Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C7C36C22A
	for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847099; cv=none; b=KpldlMwFIoRfBl0YvxiKMznEBKfGh7iHgeZZ38J6TG1VdppfEjuxH8nsGBjTYWB5d8k/9fNwgIyF/3IwpTtr6YTJEt3rQUyVPbB++QYP+9yfzzmBkzDbtH3ythMcKxlkzH+WC5hcDqiBQcdJy88xDc08nzRy4WSYufHCwFWzfAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847099; c=relaxed/simple;
	bh=CGCGb9V5eBipiJiyKGzWDh8EBRU+yWeR3nCYNAfd3C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9a603/9gNr1ebnHgE4Td2K03xCvUMzhODf5AL3UjnHvsBvDXEO8DpB7iBGIrmN0Z+H5Oq1bAQPdGkbyOTT4BKdjM+BWDW+QLcn50nUOzjWZyGzROXkxl1XlCI63XQ8Ux4GYYtRnY2m7nCH0wFfr5WWiSVCFtwsODOzXlXMsHhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArECC7TG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArECC7TG"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429b7ba208eso681955f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 30 Oct 2025 10:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761847095; x=1762451895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yttjZeqTXK9cHrnm5+lJ6shcRMBRq57/tMzXtPds7Io=;
        b=ArECC7TGGBErcGy2ngQS1TzpbESTXq2fI3lVCiD5EH0M9EB/iN+S9fqe1F0SDTvx+w
         JRDDibRt/I7TRNIG3jtHBBmgSMiBK1mC/xhSJhxy2LlVku908NFTbL0LYwp6wPTMe4NV
         xu4F9pLpC8XQmBG1yAtYQUow9hb12asJEJv7gWWpy+/pS5kwLPQACE2IsHeApihQDl5Q
         dB+JB7bA1zwxJr0j413pCoNUuAClLBR+TyDbYxitg1DPIFZ1IkrSLoQmCRWXgXmt+0wj
         k6o+3onn/EQvL4TBGCEo7mvV604KjI/OFQBx9H6nQ8N/VBKS/eKHUk3GCmRJD5DCEL3D
         hOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761847095; x=1762451895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yttjZeqTXK9cHrnm5+lJ6shcRMBRq57/tMzXtPds7Io=;
        b=AjTqbHo/r56v9nlCj8NskBePWedaXiwWtFFHdutck5RY2xmNGrQC4XfIao+/AQOo7Q
         ogvveyzFD7XvwjuHEAjZMTGlXbEZOl0Whs9oNN2P1luI6uabSnyMKcYTpnzSqPrIKBuj
         7SZlIYrfHVarNtIBookFyhi9LZwlLnYISjOW0vIWXYlaY41mzxAijsugMEh2F2PkZFER
         3CNVRbNlYy8pKXksSYfhpAuTC7zrW8BD1hivR2glptCZAA9l2tc7LLRqWvNpoQeRFiQS
         Ne5FDJdy9SVL4T8MWZhhXeMB+0o3lMbEXqDNlhKM/MBIDmMEV8882dmHR6ghq8c6QCZC
         nzYg==
X-Forwarded-Encrypted: i=1; AJvYcCWFkei/2OtKo3+i2K5Wge6vfHv7X29uc9y3KJzMW2E2I6PGjRGFlzt/I4JwjQ/5YNl5DJP9P9mpnXyaq3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5VWX812bzrcH49S8V3/E4TD/OdFLnKVy+ZouEibam4vBB1N9/
	G4gf9dCnARZbx7XHteeERNl1eV5RxA6x0uSpbX7Slz90B5ivJZ6V769L
X-Gm-Gg: ASbGncuNGNmmHrovtyCdCs9rAjG9SBIAAIfoycCzUBBnYobfVpWnoC+05bvroW6oFS3
	sxKtaMTVC2WE9ZTYb5o6SqBBU+ap93YOyWr9wHtjyz4bfV13HJnNHjerxRIGzzNyy5mECqLyot+
	Y1Ds1pSqhLatYiR6GjcB5g5Ws0vZvSdGPfqRWrCfpwfeEj6JK8OL1pRhLEHlVpJe4J4iOGfaLDO
	wJ01NfEX4rUrzmnaDO+i+t7qKbHrAic0ljTKylKeH8g0ttm4vaqn5EfzPMlCR97oqx35+X0e5oY
	waEl2qAZxYZzbV2SZRW4hTcMIwumsTz7ZAlJJ86rmFE9Xn+uJtSeGZN8mfUAhdxLqXJ8nvESJj/
	X9bizRvjakXHG2/FIhtbJKDI5KZLA1D6JYdH8VYdvzm5kHutcF5QF1kFvZ/EhQQ71RMa8m4iaLP
	UNXs4wx/9Z7AYb8DenwKtR91flRK2x36WwX3If1n0fhd858pvK7nXOrl2+Akko
X-Google-Smtp-Source: AGHT+IF+7U/wNQ0NpxIF99gi4U8nhseKBZ5Da8Q6VFYrm3gmjFcz96pkmQpTdIaTfQVb/63+drU5Mg==
X-Received: by 2002:a05:6000:1863:b0:427:4b0:b3e5 with SMTP id ffacd0b85a97d-429bd6ada25mr459355f8f.47.1761847095143;
        Thu, 30 Oct 2025 10:58:15 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772f53aad6sm15098055e9.13.2025.10.30.10.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:58:14 -0700 (PDT)
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
Date: Thu, 30 Oct 2025 17:57:50 +0000
Message-ID: <20251030175811.607137-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
References: <20251030175811.607137-1-biju.das.jz@bp.renesas.com>
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

