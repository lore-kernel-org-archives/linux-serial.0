Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588399;
	b=tiuAoIat2y4F6FZOZa2PjSVUZwUi7DR4MpUFF7R8vqy2JUvY43yM91bSjB0cI0Qe5zLA
	 VHDdozVPKLUOkJ9sc30c8EVqZZUpoXkYunp01FNkt+8K9mUlL6tvJRcgUAvYVLHoo3vgD
	 1SsbrXwYjjUWhB4/T+38e+ZVrMy7Xl40G9oSUYuqV9zffmhVVSf1jYcvHyXA4XGV8TjwW
	 3MqhGbTYmOXAGKfSXSz47r/QmGqcO/+VPExDEocI9SJG1XsueY0NWiDNKhVhXQt1xVWdz
	 N7jTYe7wRnswu9LluD+6E/08mcBb6sotq20wYRUv/Nofk4qz3E3JfbgfByGpJ8GkyVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=XhDg8QClMZJOayDv8bj/xO5vbSdeZvK1hnpn/RI7Gj0=;
	b=x0GBFeFJr4LPEbjOnmWzUO8EMUmwNskUH0FMhUeaZh3Q1PcuKNS9HLtaYyBVNZLw7+6i
	 84pFnlntuNJFn+ZMqdVgXN3nYJeWW+KA8NAufZ6HUn+kI1elO2GpPrxACPvJwrzbLYzlT
	 oJypN1ixTWGfYIUqmXzIZj9s9LbS3xfjyS+aQoL4zL7p/1bJt9rftE8rEY1Dr5i0Iw0sC
	 TFR2PwbYrZ3ULeItgrP6WZlo6aogb7NZLsm+nFvLbO+UVDnBFwt7SGafJCLLjuxzGhYxI
	 rrSnKUeV2dHXWoApxffvHwMr12gRtvKMxTxychQ2ubVTdDz0ApWgExmg6ihyHa5xNow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FCEmyVSw;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A26606A325
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 13:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72A26606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FCEmyVSw
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e09aa5264so483407f8f.2
        for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 06:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792588398; x=1793193198; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XhDg8QClMZJOayDv8bj/xO5vbSdeZvK1hnpn/RI7Gj0=;
        b=FCEmyVSwyMIhgeTMCMdf9r23TjhNj0veKXSrM/ESw4hf4Bz7ZIqD1y8TaEBp44tsoP
         yRgWBIUPNTqNe8io8dF2Vv/JsYPX+h8UkBnn/pt7yV5z743+FGCRp89YZrZvfUoE9TZh
         8PlaYsq2kAvy9foYDpeD5OHutjRLZbCax4NToL+sI0DJYrmhPV2TvrHMoBvAHmn6DfnR
         9jWSOLCzWyT4SP8kWpzb/+q/rj7xtIf5tuJ8/VmA+MN9kvyJG09eQztgLD8TOihfKOM4
         qH3gqr0qt3XyfFJ4XJPa8aVIgpPxKl8eSlcvlUTGPSJE4GG3gZtaJfZoCo23ocXN+Ktp
         7KNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792588398; x=1793193198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XhDg8QClMZJOayDv8bj/xO5vbSdeZvK1hnpn/RI7Gj0=;
        b=Ezp4iu1FTNcIm0z4UOwKsyoOnZ+idBYRnc4PHFGCWGj7QSOb11ETEJAeGyNfVMb2/Z
         8L1l1bF2nJMCG8B79HhA2tu5cUGf3FNepALMx0gpDmF2CfsZiEWwypYeg6uO9XqC0uD8
         fMP6My+1HfnLQwtR3rrMkwCF4WVOnHzv5Ly5ObpviLQ1Vvv5TsSZIC1Ek07GduMkQBcv
         Wg5572jX05qr7N0zUxf0KfMJXHCFS11re9AX7XFyL1irYYa87uNXh2cIUZpDLn/G6fJM
         rPVwsIZri2seVzU2c3apb+js2F5hghIMcH/Qftj5PzYMbTafmoFEy0LW7RJQd/ONGrvL
         vL6w==
X-Forwarded-Encrypted: i=1; AKwUvBynARQ5mgXKx7aV11DgZVCHpe7+gQVdvOIanuUiHHZQzhosO5Wxg08X+kEbTlfiadQ4lATW68RFA7vDfmY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKosnAEmgn9lWeXbI62BIyEKzhemfpXqXnPBZ5zCs76QfMNd5bO
	U4Jp3sRhb5ZTqG8WUjACElpu+oDLQkmf+bPk7PoFn70S2wKz2RYp6qvc
X-Gm-Gg: AYBFou0bBa38+jv3eze1TEagJ62Sye740+eDWrqUx9FH8IWwR+wmoyfND7/RBePdNHW
	xQPriXj0+X4TFErnyrevjCRVoKk1hH11Hqy30yNKB8kTALwtIPIrVkaCkTVm9DXQzxZNNO39se8
	HdaUv+6t3RBouyuMl6peDDCOYd4tRP1ppTeFQjfjAtkjLNOZytmGoC83TP8i71Y0jXHc1UE3+7o
	PHJ8F6q1uzLXYEs7zaoH4UWAazc/Yix4fUajqrd6Vds7Or2rnTZaujk6Cu92n5ugPQqmtSykeh9
	Lky0IUeXGB62AvHjltX8NM3FqYe+JMvqUsA3ZqmuKd2OHR8xPMOh12fI5Qr42FAYwHahD5s4+3W
	EtkmBvAN7BQ1uQQvyXNCJJGqM1DkKRe2RAUk2oByHUQ5w5Zgsl/TbZm9O1tAVIGBOi82lZsDDxf
	uhAkwKdDoPA/zi2t1zAjgbTsUJhWu9/l0AD+IivHwmaVlScdt6oSJsx5E4rHraKeO043V5CoCLI
	XwTx7JOHFEayYW1QvJ2bYlyfFmqvLZUpkB3UgzcY1uGm84WQZ/U6PIy1gCt/7+BE0NgUPPeIf8P
	ySqxCo6EAgLyYx5S
X-Received: by 2002:a05:6000:178d:b0:48e:b8f:f7d9 with SMTP id ffacd0b85a97d-48e2644eba3mr4823249f8f.6.1792588397791;
        Wed, 21 Oct 2026 06:13:17 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:39f4:e118:e272:79d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258358c1sm5655560f8f.43.2026.10.21.06.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:13:17 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Date: Wed, 21 Oct 2026 14:13:13 +0100
Subject: [PATCH v2 1/4] serial: sh-sci: Drop TE disable at end of
 transmission on SCI
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
Message-Id: <20261021-g2ul_sci-v2-1-b4e038220018@bp.renesas.com>
References: <20261021-g2ul_sci-v2-0-b4e038220018@bp.renesas.com>
In-Reply-To: <20261021-g2ul_sci-v2-0-b4e038220018@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, x86@kernel.org, 
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792588395; l=1377;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=3weoth6w6Xdl5b6WOfiDQxw3Mye7WCDgh2tqKrLoXnc=;
 b=pfNldyHMgPcqhzkFa1o+cms2Op0v6z0MqVAr8fWkcLhT21/2XnwoWjrKs6qWVj5+gpFwTXWbJ
 sRDd6avqjMtA8nT5XfTmxuB80Ps12Jq+DvQdSjgwz9YuPZJv0R/r4sM
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

Commit f06c2a9000eb ("tty: serial: sh-sci: Fix end of transmission on
SCI") made sci_transmit_chars() clear SCSCR.TE and return early on
PORT_SCI once the transmit FIFO is empty.

The hardware manual does not describe disabling the transmitter to end
a transmission, so this special case has no basis in the documented
programming sequence. Remove it and let SCI follow the same path as the
other port types. A plain revert no longer applies because the driver
now uses a kfifo, so the code is removed by hand.

Fixes: f06c2a9000eb ("tty: serial: sh-sci: Fix end of transmission on SCI")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index bd58bbfa65aa..9eb297dbc901 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1036,13 +1036,6 @@ static void sci_transmit_chars(struct uart_port *port)
 			c = port->x_char;
 			port->x_char = 0;
 		} else if (stopped || !kfifo_get(&tport->xmit_fifo, &c)) {
-			if (s->type == PORT_SCI &&
-			    kfifo_is_empty(&tport->xmit_fifo)) {
-				ctrl = sci_serial_in(port, SCSCR);
-				ctrl &= ~SCSCR_TE;
-				sci_serial_out(port, SCSCR, ctrl);
-				return;
-			}
 			break;
 		}
 

-- 
2.43.0

