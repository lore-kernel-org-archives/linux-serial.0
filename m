Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FBA30F928
	for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764434615; cv=none; b=GqCfQ/yJlD5agp09zSON+y2tOJEEPbQ+X4Sj6aOUK5/H3Zwas8qt8mX4AJfASMghF/Ze4k1yeLt6Z1PyaxqAMDOskD2UBHoKiuVx9620kS+NSyTABF/SPQfEPYIb/dHdN0i45wlRh0NPfkrrUAkCTW+sdQnKU8U88xNowFYSpvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764434615; c=relaxed/simple;
	bh=Jyr2CHVhr92k//wyRYmvtRWJKSE0xW9i+OMuWE/VQ3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqVSgVGqVdOse2q8i8vG3FVhBTKHM+pVOf17xM3p7FSglrwmd1zc7lSIJgQPY7cOirqrss//+UrLlzWw6lrL9MtUEyKKOc957Sxn/9wmQAiXDEem627k7CcwkgS5tHzSNT9rLISWRMGLodDoBTvZ0geS/dCE/rIMKcqE4/3MJu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m77s565E; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m77s565E"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47118259fd8so24575455e9.3
        for <linux-serial@vger.kernel.org>; Sat, 29 Nov 2025 08:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764434611; x=1765039411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1laVFJ5J/2PogvGPArKDBntximPg68iaWIWh3V2PMC8=;
        b=m77s565EkotB4BJCJQBhXEToYm61Mb548kx8KAOur8XI9cBMIFz0ccOG8A1bkMhR3b
         5PEzEqj2s6Jb2whhBZHncBXkrNZVP6HouqllVTw3ziWTV6I+ehlKWkLuGtGFSDF4u+FQ
         nCcAF4sqU9NnrBQMjZQJPmZNnRyhdGtK9jW6D5LigoZ36EvPs4AuAzFlUaSqYdPL9jxB
         Gt2XzZZFUeEl2LGb/enVROVp6NbsebuwUSenRGLc1erbSZ2mokwxZ8jghauzWodB3veR
         JK1puyZ0dCqwlnmHPSd3fqMdxooLvEMgtWZgneZ05Pj/KPGoOa2H8Z84jn4fulKo2PJC
         Ep8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764434611; x=1765039411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1laVFJ5J/2PogvGPArKDBntximPg68iaWIWh3V2PMC8=;
        b=ZqOqfMHRAhOIvOOhBNZrbFvTfG0a93e0EnvOikiEHc2Ds6CiFBP5BvrltC8abRZD2u
         kjSFLxwGXul+nwp4RyMFkyjlLJDjthinSQ6HMaR9PfPoijV705P01m/5XpJ5mOZEKKNZ
         TyTuX9wDyjt9k8+JG7eKwg/bTnf6rcylVt+un/lObjHiRQ5cmVBkyS4x0X2kHdzH8Ka6
         nGaOCYbj/lmQZNfga8Crj+iv1bvKShx4r/hPdHfDGOn12iC1lA3ZI4fYQQnQotnj8e15
         8EVOiAnH7Slg0fHmULk/RfqwPPCj2YANNPOg59rh4nR6V32a9vASHXJmHLt+hi+Rtlxf
         tRZA==
X-Forwarded-Encrypted: i=1; AJvYcCWsaABAeymRAX5Tkl/ciz5cAbl/wV+yWBqN5lDq0ntwonZaL2JCQGj/610qUo+uyW2OBv0uxKCf8yuO69E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF7R/2fhQjXwHi08POWCy9CZTAh+Al0hSLxSpFR9N/LfceIge2
	3vWvxHy4n99UuF8zf7LObIW5UO4l1FoFJSE1TusCxXjTE590fHQXBBck
X-Gm-Gg: ASbGncu2iLv3WeTTnVZxLZDI45W7n8zmj54hU6FOqqD2JrTPFOzoIWZAn3f/FDMdngx
	FHWN7rWUd2/so2I7tzS3MK6kG28F8pSqORWNPalpA1SWTsBu+jdN1OmmgdAtdczvYxVymQPpg5L
	UyV3yFvFeyS2d1J32LsRUJh9dtvy0jvMLnAmxBo1aickRaopTNc3SAcyA6yG/z38yLAalvQWHhB
	nQ6rFZhzYSIwx/3x3y0y985GSVTplYJd8u7mVMNjcBsLbunpeEBl4wYBHVua28BLTm0Qsz/b5mt
	cbI4KIN174ASgWVb+XfUXvX67s4isTcYHLcIobcOdKntR48B4Nu0787RIg/MhV88jYX/5KXc/pA
	1DTB0QE6H3d40G74Bj+g4M6YL9aLKMvyydNcKSQWbXczRyvaPA+Dmbut2iQUj6FgZvlWy3rzOL/
	Mqabpt+0Q1hvCNa+XFjPueg8vBFrUG3JjXU89CldqrvSN0fQ09ov1zYn3Wa4NYVLA1Sjb8McRcr
	KLgaJqx4go3YX84
X-Google-Smtp-Source: AGHT+IFOOPMW+EuE+WoBWDENaBFiI9rdwCgXZ+oiJXrJkuUjq1n/4uLYNcYjwXAPQNmHWmA+/475eQ==
X-Received: by 2002:a05:600c:c8c:b0:477:a9e:859a with SMTP id 5b1f17b1804b1-47904b1ad30mr172572825e9.22.1764434611363;
        Sat, 29 Nov 2025 08:43:31 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca4078csm15970060f8f.29.2025.11.29.08.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 08:43:30 -0800 (PST)
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
Subject: [PATCH v5 04/17] serial: sh-sci: Drop checking port type for device file{create, remove}
Date: Sat, 29 Nov 2025 16:43:00 +0000
Message-ID: <20251129164325.209213-5-biju.das.jz@bp.renesas.com>
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

Ports that support FIFO has fifosize > 1. Replace checking the port type
with fifosize for device file{create, remove}.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4->v5:
 * Dropped checking port type for device file{create, remove} and instead
   started checking the fifosize.
 * Dropped sci_is_fifo_type() helper.
 * Updated commit header and description.
v4:
 * New patch.
---
 drivers/tty/serial/sh-sci.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 28d665a9861a..ff5459c449fb 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3549,16 +3549,14 @@ static struct uart_driver sci_uart_driver = {
 static void sci_remove(struct platform_device *dev)
 {
 	struct sci_port *s = platform_get_drvdata(dev);
-	unsigned int type = s->type;	/* uart_remove_... clears it */
 
 	sci_ports_in_use &= ~BIT(s->port.line);
 	uart_remove_one_port(&sci_uart_driver, &s->port);
 
-	if (s->port.fifosize > 1)
+	if (s->port.fifosize > 1) {
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
-	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF ||
-	    type == SCI_PORT_RSCI)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_timeout);
+	}
 }
 
 static const struct sci_of_data of_sci_scif_sh2 = {
@@ -3917,15 +3915,10 @@ static int sci_probe(struct platform_device *dev)
 		ret = device_create_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 		if (ret)
 			return ret;
-	}
-	if (sp->type == PORT_SCIFA || sp->type == PORT_SCIFB ||
-	    sp->type == PORT_HSCIF || sp->type == SCI_PORT_RSCI) {
+
 		ret = device_create_file(&dev->dev, &dev_attr_rx_fifo_timeout);
 		if (ret) {
-			if (sp->port.fifosize > 1) {
-				device_remove_file(&dev->dev,
-						   &dev_attr_rx_fifo_trigger);
-			}
+			device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 			return ret;
 		}
 	}
-- 
2.43.0

