Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7C433B97F;
	Thu, 23 Apr 2026 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776975320; cv=none; b=WNfHq3LDH9vAtcefXwTiXv9FX+8rqLfNkiviEBDu6Ot0zuOMZjJ50kQllWvPzph2Twsn2chj/ViA9QKE/Q+xrVKiu3Ny86Gqp5qlJ382Q4fHpGl+OSfLhYeQAwqjgNG/8cLxBd0VS+VKFHyBsdzhHAfigBV7wCzYaQ8rQNjS0Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776975320; c=relaxed/simple;
	bh=EJPrKqBxkdjXERiK4cwkc7VD6yOaOR5y0dyDPxd8axY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Npokl8YLmSzP5nLDWZiR8b8cGwjR6M+fXIBsg8rp1Bq0B00evuVCZCsGumSO8GKrClDdvTcgMOCUexBB8eIrSGVZNcvus0Cb+aVEmq/0usMnwxYIeO19189VVwvt97JufOuE03HWiF94qqYxdiIe6O6xxsfaMN7+l3Mc17PyZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=NoP5XyPa; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="NoP5XyPa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=nQwpibKU/Kvu4xinmgisjbECDkB88p4i9/qMW2ej3g0=; b=NoP5XyPaOS7MHXfqFYTAEZtVNk
	fPHB6FU5CA4SewrId3LvhC7eS2BB3WLFp+FMRodmI9ao/9M4k6EskBFUpB1tvdLesUilFJeTRyIwq
	ow89HLt08fjZizKJjHqMsPteGgqcg+Hn5p2cmFI9x7F+7EB3rCa06K5d7pclaYVecAIg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wG0S7-000000002qN-3F4H;
	Thu, 23 Apr 2026 16:15:11 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Thu, 23 Apr 2026 16:15:09 -0400
Subject: [PATCH 9/9] serial: max3100: use new UPIO_BUS as iotype
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-tty-upio-v1-9-baf82d3b86d1@dimonoff.com>
References: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com>
In-Reply-To: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com>
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

