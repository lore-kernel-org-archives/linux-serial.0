Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BEC3E9C26;
	Thu, 21 May 2026 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779387433; cv=none; b=j7dHpPef39md+DBEV5RgZM3fV4/Uxb73mti9Rwy7sqcFLSHybYrH+Mq/UwlWFsiSwF4eQJlQ1mWIQV+CX4kStAbSnOKg8MPFqRMoS6uhUWljBIUmBOvuXIQ91UjiZlk8YgaPK3i/iUsbNbl32sK/LLP93EuHHz+ByyD8FVf2wHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779387433; c=relaxed/simple;
	bh=EJPrKqBxkdjXERiK4cwkc7VD6yOaOR5y0dyDPxd8axY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fZFZ61NciEcy29+jIlaogz55rcqs57aKCRKSqaEu5N/ai+UeBEBng3Cfb+byiFhEQa9I4Z74V83A14omPeOWB2Dd0qEm01xmuUEHhXlO5RSjZQswKAR08S9gKjci3fYFprztOHMxJPzTo8lbAmU8u0pcwZB/PmAP6l7tBCC1r0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=c0qglzCH; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="c0qglzCH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=nQwpibKU/Kvu4xinmgisjbECDkB88p4i9/qMW2ej3g0=; b=c0qglzCHfB9fZTp4izLM1Cvwju
	q3mU3shYOZPuglbD+c5bRZhPGUvWK/rKXith+5GDeu5RTbzzE+FKiuhmIGEvnnVfPhOBTbo5V1xrk
	URzZtf6X0L+L9Hdsnt99IVC8vujAckOBtAF5PhdYYyncUQxlECTknsfJZxaFBDPAwYyE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wQ7xA-000000001yA-0Wx1;
	Thu, 21 May 2026 14:17:04 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Thu, 21 May 2026 14:16:56 -0400
Subject: [PATCH v3 10/10] serial: max3100: use new UPIO_BUS as iotype
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-tty-upio-v3-10-bf74567994a0@dimonoff.com>
References: <20260521-tty-upio-v3-0-bf74567994a0@dimonoff.com>
In-Reply-To: <20260521-tty-upio-v3-0-bf74567994a0@dimonoff.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com, ilpo.jarvinen@linux.intel.com, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Now that we have a new UPIO_BUS I/O type, use it to register our serial
port. This allows the driver to work properly when using DT where
membase/iobase are not set.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max3100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 475b0a6efce4bec36aa4b94ccff83934dbdf9246..17a2ff410305142798ddbbb22b46f18eadce91aa 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -725,6 +725,7 @@ static int max3100_probe(struct spi_device *spi)
 	max3100s[i]->port.ops = &max3100_ops;
 	max3100s[i]->port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
 	max3100s[i]->port.line = i;
+	max3100s[i]->port.iotype = UPIO_BUS;
 	max3100s[i]->port.type = PORT_MAX3100;
 	max3100s[i]->port.dev = &spi->dev;
 

-- 
2.47.3

