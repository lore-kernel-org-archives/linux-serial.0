Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E605C3587A7
	for <linux-serial@vger.kernel.org>; Wed, 17 Dec 2025 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979888; cv=none; b=Unia0+G0vijUdpc/2Nbh8JQDbDj2SC2BpzSxare72PnBvRVq/r2s9Z21xHfCljX6dAjFpHGS9oETMjdpplURvBjQmK6zYC4LhOv7burr6sYQ3LETc8YIOQIAZTDzKEaeVqFleEvjsHoeD1clU+kW/QDpslYXlyPhU71JDeYEono=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979888; c=relaxed/simple;
	bh=QpvGPI1QC38ns1TQ9emS39EWBDfc1X1yaD+QfJzzSr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QF0VH73tSOIr+VFXYyYXE7o3MR/c63XUjC9+uP9FXVxPn7BjmF7IKskVN9sbNYdESgSlqP+rpnBe10ejtNp9LQQK/3U7cBLzsryCNelQhmHiJp3DohaTE9i3uMUd1gtwph1VmgHi7CifZtR3nifHlsBss+osEsjkTUZEEHPew00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=fJSoMrK5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="fJSoMrK5"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so3347399f8f.1
        for <linux-serial@vger.kernel.org>; Wed, 17 Dec 2025 05:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765979883; x=1766584683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4HlZloNFFx/UivoiHTkjRab58Z2MwleM1jMI43+NTNY=;
        b=fJSoMrK5Pyhta0KdCvvzMlPiINFDstHf5ZcYDwPP4A5GYTdzEvnhU72c20pN1PG/kh
         C/trYoGTiEL1KDeA4mUsA+sM4c66fn61cLSUFnxbkZH8zYxr2FelVOX5WeGkszCbflcj
         H1BmfBGddERO2WGXUqB69Cnx3d8zjpFwnRKRUYRgj2n63HLhZ97uXuSgpDBPx9azV5Ui
         w/ozPgMby2XV3C3VLNqJj5I4TIcHZdx82uuZzrPBZw1O1yZtc1PFDOeMV+f6LneibvER
         1cCvdH+3HQwHG4wC3h6VCE+XVm/AEmOexXn7k+1fEkEVJlkx0G1BofxmeYJl27JO/AGV
         C3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979883; x=1766584683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HlZloNFFx/UivoiHTkjRab58Z2MwleM1jMI43+NTNY=;
        b=iDuIyl5GY+QxGDvNa2m9RZmnLPuBu5a8Nf1jYF3cnwtPgPimf9PFz3+JkUUlZBmLoH
         gByKUzRnU932egTGwG3ZXgY7Ns7jzKO+mRTmKg+hvbTVl0lQXUDpovpx49tR0N8j0Gpo
         N1bjisQDLgxqjwKu+HIlHkn0Lqd5lBHvtPNFTeEnBvb7QljLU5JYJAT5zWavCricIU28
         zouUe/UHuorvIKakaT2xWS4nmOJRh9Ks7PvjemIbCOYVKs6CqtZhACkpH6U3otjhtRQQ
         hViC5/AXkffLyf7y2s6q9wE3fYQFrjMLQnitEMMkti3YnN/6coaiGc7GRiGWrc6ZFVGn
         IdUw==
X-Forwarded-Encrypted: i=1; AJvYcCUDyqwq0u9mv1xPP0dJ8i9LVZiLQie2sU42V87JD9AqJRBlCpfnu4S/ZR+4zHAJiBLOk1doRFEvhly6J+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXYJaZbsOwjHJpUQGRDparSZ8sAhKt32rSkoBeTXHWK47FYAti
	0VR5G1MTgHd0ei6TM1qAUH1vLZFqZpdluPnmEuQGvC8GNf6AK93fX8D7o3QX6fTl0gs=
X-Gm-Gg: AY/fxX4iqVLvk5epCb+KJA8tXNEM2eqBbu8ZpmjMx+Wj2B2rldZDnifzTHnZ/C++MMn
	lyuXp351V7mJQCpNwhlQXmtyzM4leqeNV63h4Ccl75kSG7scR0GVDwzbZjp0HN/JApHCNHnp2a+
	oSHEr0GMmLCzDO3nzLg2xvkYmiLEoIa4JEaMTxdc6PkoXPFYHvndWjC9mxSglwdhTEb1VdyGQ1m
	jQtJ46zCdLXUaTzNLqrMbTzRbOZlpWZP4RXjQK1BAIB05cB4mwDkpDhoUm1MM7g5tiWauk8PYW1
	eM6ZVYjiz9ybtq+YI6MZiQWEi1XWt5JRlDeucs07plCIpB3xh+jaWyxycaCjbSEmJlwrUbSr4XS
	duWGlECaK7B6D+nd1eU08wA1QwvnsjJWSDlbOa1SyQOsLKxhS6pEQhyux2LXjNKElXNA0zBN57g
	PgihQdnmRvDllfvbeu3OWb/2euzK5xlgbnlJ3tdGEW
X-Google-Smtp-Source: AGHT+IEIS8MqzIfRpyVv3TKeZOzBwWHNPpXl+C09WJPdJfQdbR31Pfy1vU+QJIhIB6+MFCKEcYlCGw==
X-Received: by 2002:a5d:584a:0:b0:431:54c:6f7 with SMTP id ffacd0b85a97d-431054c087emr6315110f8f.37.1765979882987;
        Wed, 17 Dec 2025 05:58:02 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310ada846bsm4852976f8f.9.2025.12.17.05.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 05:58:02 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	wsa+renesas@sang-engineering.com,
	namcao@linutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH] serial: sh-sci: Check that the DMA cookie is valid
Date: Wed, 17 Dec 2025 15:57:59 +0200
Message-ID: <20251217135759.402015-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The driver updates struct sci_port::tx_cookie to zero right before the TX
work is scheduled, or to -EINVAL when DMA is disabled.
dma_async_is_complete(), called through dma_cookie_status() (and possibly
through dmaengine_tx_status()), considers cookies valid only if they have
values greater than or equal to 1.

Passing zero or -EINVAL to dmaengine_tx_status() before any TX DMA
transfer has started leads to an incorrect TX status being reported, as the
cookie is invalid for the DMA subsystem. This may cause long wait times
when the serial device is opened for configuration before any TX activity
has occurred.

Check that the TX cookie is valid before passing it to
dmaengine_tx_status().

Fixes: 7cc0e0a43a91 ("serial: sh-sci: Check if TX data was written to device in .tx_empty()")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 53edbf1d8963..fbfe5575bd3c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1914,7 +1914,7 @@ static void sci_dma_check_tx_occurred(struct sci_port *s)
 	struct dma_tx_state state;
 	enum dma_status status;
 
-	if (!s->chan_tx)
+	if (!s->chan_tx || s->cookie_tx <= 0)
 		return;
 
 	status = dmaengine_tx_status(s->chan_tx, s->cookie_tx, &state);
-- 
2.43.0

