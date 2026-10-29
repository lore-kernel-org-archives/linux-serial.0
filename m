Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259468;
	b=ofZhp5Ml4OP78oZBp1rvm0vh23bY+nWDOtf2Fj8iYUMry8/7yJQCQMhKi8HjHfoGgrXy
	 fs9iZp85mSuVPwWCOby8rA2uQPs39W9Ocj5HegElGy3Ky7VQNEfoA2tPiPXHxYW3NCSZm
	 tjB+6aCjKXZDNv45Y0137NhyNSBcTTKtJw/xfNUdeGwqjxfEXYAfkmgrzcstypr3b1KVD
	 xGmBNUVFbiOSjo86gdoh2QddTEY+HEZOyvoPCMMCWU7ajLgyTBktSDan6EW5G6tyHiOmU
	 sHCTxoEnhKDNPVdAsWVWMwfPe9qJfpgcmDV7s+Z71iKSe3yqhGTDWfcp4zCzjhd3lxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
	b=FVT/foyIw72UxoqdNvVqw/EdF89aiamsctxmyP+UuutXPReWQoq9kyk7s0Ugla102OAv
	 MOjOHTUONU72quoYsEWAfZxQ5lW1ALE5YPVMPOU0MIjVKuCYEVRGD4fkLfzxxrJUhVmmN
	 G2CKW9v/GVA+6AtNhnC48P7BpjkiFyAbTvJnhPFPoJbtKU6hMpg/i5lFBiWOUdqvddbGn
	 i+6gDu++6nefl5KFyr9tgJ9BGnHvdHRIfZn1loD+D92Yz640S4DaHWNJvnP5/h44Zxnvy
	 RjCY3WEBZOd+WvduviCXgg8/fLmNiCb10xFUb1Wt8huAHh7HvT52JP2ApKWJ5HdvNkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0pa3kufE;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1805606A326
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 07:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1805606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0pa3kufE
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-85a5455bd3cso1139672a34.3
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 00:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793259466; x=1793864266; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=0pa3kufEA9c101+XdeoRmqgpAKBUwpsOw57aCaQTMp8NcAvRPGI7CIS4w64XMngd+d
         g/oT0g88Jwx8f4kKZ4i39rnY0OtCV5kJuIUEPDQcFJJfG/qRVKeSoEmJEbFcdMrRhiY7
         MbLQoD9bZxrMGn+QOl/jc+dGJS9JdObcoAYCAB8V1eNKCvN10wFoRtiOp7ycLm/9yT9A
         M+h7bjNeF9E2ZLhuotJ7Ufkq2404MiY/cvhIwppcM3jzi663l1tI97ZHqg+y0E5YtJAM
         1Zzh46d5u5WMjfdgDJugr+h8YaB2uT3fUMIEad2EOUjfJLTG8wymCHWpbPjPaBHOOGG6
         GuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793259466; x=1793864266;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vTCI+nDxJukp6A5kK1BpAWHpCDcT464wzBcHkx0Jj0Y=;
        b=pJfcy6vYAbKOox7vYjdAz+SZ74pcxSDfHCZfIMUYAt8ibCSn6fk39Wkc6L9zV9LrGw
         PE/f03fxnspjjJuf8WtS15dBjCM5k6WMCZ1BAGE9c+bFxEl6FkR6afnj7F9oALfislFz
         ZZkRnYoyf35Y2jqzXExGqRW2Q9qjamh5lb8Ki+2EeHpA69ODa4Zif1qsQg0U855yztKw
         CZLVV680C5J7FysMxVCp4DETZcmhXvx4KK9kb73OpTM7GN/JNc95ezC9vKtsiQz6bCVC
         /yBxfFKHUoOtV3pOJfsWPsIk/c08cl/KlyBkHFGOP4DRmS9ao4K0hMOz7oUY2w7uIYlM
         Wotg==
X-Forwarded-Encrypted: i=1; AKwUvByT2oIqEKQSAhLOiKDd7KVP3AKE62jRQ46LJl6CMSu49OFxBTnvPgqayDTT1QUz4aArEjmmKv4SIi6ByAM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLGzoxuNRARh1Avdwi8/udEw37vAiUrRyDpQcqdpY+EcMspPtYj
	f9PgiqV9gnjXdLalfdxi6QosWRS4NO573+APuJ3ABkN4mwSMBQPTneBq
X-Gm-Gg: AYBFou2spBhEaWNMN0JTLiwTIC39XIP5TjmIPqex4d45dNvcmDNOaE119JIJfhelFry
	TRX4oZJWSS0Y7F2Wr8V9n4/r1Omlg8YCvNFnksFqw+uARCpj9lPUEJ0BMnRLBJ3OkZT4h8d+I5q
	JtjitxPbqK4GcgqzLLHp0rbmfQYYFn2oicfEHPwoJ04Q725sL73CCGf4Phh+/owkrNAABCS/gaU
	QBqDNXBKV5Zyd8JnzglACVS9DRnSisGQB8NV7s1Wr0hsvQMVb1IRcUn7f47rCwsqIptJ1bXEIyW
	ETcIc2Lo7SugHiuHt9fqxWJr7E8z4dxoljfG+1lzLAN0spHVD9NnvJn5Y5AcBR/RENfO3hQ8hZs
	88Jn7ppWZWXLS2NDjU90Irt2vtfojAeUuBuQSVn2b5lxeYmyt84K34P4vNXGoldwmIpDZG9Oatm
	aBl1I6QDBOthfI0l/10JMfBPcJLc8TkIcshOu7+fN/dfWy0e/ejI6Gr0skU3xt5wxMdHkOwe5zJ
	5tvInqOvC0kBhVehfiAYbMbteRloLmXm+LWIiNHRB/lA1Msq5FZVR7DZ6hgm7XIrsfaEY4SSw6U
	uKs+2HZWo/NY6YRhuCyTGEmdKPbDSyqPp7o23m1hbzUzNc0JxHd2CXk1mspEVw+R6uTU7/t69D8
	u7XWjjZxJQ0JYBlnDr4nlnb/fC7K3MoN2OfVMwxsvHO633Tz5ycvsEkuvX+jc3olALV8M/sjIu9
	LNnIKpc5eIAdPrxZ4yd59BuSocLMq8KbpWdw+s0syPEaRaURSUJUQm//6TP0a9vEDr8iELJ8vOj
	g==
X-Received: by 2002:a05:6808:508a:b0:4d5:295c:a831 with SMTP id 5614622812f47-56384191e36mr3343729b6e.62.1793259466485;
        Thu, 29 Oct 2026 00:37:46 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-563c3638604sm3321976b6e.1.2026.10.29.00.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 00:37:46 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 29 Oct 2026 01:36:57 -0600
Subject: [PATCH v8 1/6] serial: 8250_omap: separate locked TX DMA
 completion processing
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
Message-Id: <20261029-submit-serial-8250-dma-cancel-v1-v8-1-3fd56ba352ed@gmail.com>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
In-Reply-To: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Tony Lindgren <tony@atomide.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
 Timur Tabi <timur@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Separate the port-locked completion processing from the DMA callback
wrapper. Keep the shutdown check and locking in the callback, and retain
the existing FIFO accounting, delayed register restore and THRI handling
in the helper.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_omap.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 4805b644ccb1..b6f108d34854 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1080,18 +1080,13 @@ static int omap_8250_rx_dma(struct uart_8250_port *p)
 
 static int omap_8250_tx_dma(struct uart_8250_port *p);
 
-static void omap_8250_dma_tx_complete(void *param)
+static void omap_8250_tx_dma_complete(struct uart_8250_port *p)
 {
-	struct uart_8250_port	*p = param;
 	struct uart_8250_dma	*dma = p->dma;
 	struct tty_port		*tport = &p->port.state->port;
 	bool			en_thri = false;
 	struct omap8250_priv	*priv = p->port.private_data;
 
-	guard(uart_port_lock_irqsave)(&p->port);
-	if (dma->shutting_down)
-		return;
-
 	dma_sync_single_for_cpu(dmaengine_get_dma_device(dma->txchan), dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 
@@ -1123,6 +1118,18 @@ static void omap_8250_dma_tx_complete(void *param)
 	}
 }
 
+static void omap_8250_dma_tx_complete(void *param)
+{
+	struct uart_8250_port *p = param;
+	struct uart_8250_dma *dma = p->dma;
+
+	guard(uart_port_lock_irqsave)(&p->port);
+
+	if (dma->shutting_down)
+		return;
+	omap_8250_tx_dma_complete(p);
+}
+
 static int omap_8250_tx_dma(struct uart_8250_port *p)
 {
 	struct uart_8250_dma		*dma = p->dma;

-- 
2.53.0

