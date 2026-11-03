Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722282;
	b=jHI1gXh3ctXPNwUvYBsSUcGq0q1mrf4uNH59dPA+mlVN1gaClFLvwZnwrECvj+rRJ7P+
	 swOGXBYS1cd5FqPVgi0xwpQBSyhdHmwdGGEiXH9RlwTqbBMfF4Ol9/nKTOW9SPt6+U//A
	 EYxQWbtTsac6N09zYx44lUwtTBcX8YM6Oo95ORMaxOXZK//Uh/N1jqWSBH7fJ5U0xGKz9
	 Ze/LETVnwDH2Y6xwXhQq5H2FsmkRJxFmUdHjTiibnBu7no7mTe3H6AhrN0rCkVasHFu/A
	 67Lp47k0go30x2kxGD5sIUAB9fsO+M/aNmVVUsNoaJ+xYG3dvGhAp0JF7lcPWuetVCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=acYk1wdTfJFTPT2zxMP3Y5i0dH0kUe7R3DKFdNTib58=;
	b=EP9O2UZJQTmXgVc3MKVxGOSVH+q4ThTow3B+3axtev+1h+cJBrUcDj/j0ZHBeIvsBILo
	 0pfIQ2QiyYtbNGNJcWyixS84TfGTWX7pCcBvsBIIENlhoZUGNhlJCQT5V/PsTgHFUPJKk
	 JQ0RjHmMAB+o7izcX6xJOGGuA7JPWe4tgciE9aojYr7bjDotLNAFr4cS/VBHz8jcGJezr
	 Tr3s4EOfMvsqqgSiLgvwmDXSlEQgdflJ3YA71HlkyYwEt6BA/YKsQsMJxUtn3Tzodlrs/
	 BvK27YecgdRBkM4v4eQRhyrYPgjbLhboDhm343E1ItZYm4sotgMHSJqHK1rtbs32eiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=i2x26pLq;
	arc=none smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68C6083608
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 16:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E68C6083608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=i2x26pLq
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-8470d7d430fso1594066a34.3
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 08:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793722281; x=1794327081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=acYk1wdTfJFTPT2zxMP3Y5i0dH0kUe7R3DKFdNTib58=;
        b=i2x26pLqQWWqN6d8hoId4K2RGTZ8EFgUpVynbwrSYwxofg+WIdLKV+gfsUx77BOnf+
         sK5fmkVngHWldzr2LklkCBMSTbcjx/NWrl2a6CD0sEmXznbZmwBXnK8BB1xf0yoIVJ7u
         +38ha0eJaNw5lbBkgQVvnZFWpJPagrKkPUmIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722281; x=1794327081;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=acYk1wdTfJFTPT2zxMP3Y5i0dH0kUe7R3DKFdNTib58=;
        b=t2jaEMqOgwFB734CXXRQ+x8+mUjmsmo3IyMLrVvWgt8s0FpNiQY0QXpleEkxvsp/9h
         LseV6EhX7DUDEJ8dwxRNHgx9iO89Zrihypyo4h4FjzQgOBxSTNZKpasPwS5rx8hqfEGJ
         /Ws01c/hToohQBAQBS2cDHopGRZDBnsGiKsqLo3cuxsnMbEoUj9EhzaovHUmIcuF0eZJ
         1TQ/B/MbCy8i4haOjrKsrEPjtL44f/OUg4viN0yFOwMQkVXtXB+WTcV9WXf7JuM2XmeF
         bg8WqTQ/gK7X1JpuDrEDSNYObzps3H2PaYalfKO6rTXV4jT70cbCOS7+T+37sqRrJVe2
         Sb6Q==
X-Forwarded-Encrypted: i=1; AKwUvBypPQYp2Gh9mWBto2SH7zlCNH4AE+IhY38wMvr7ahA6eD8RMiplYlv4k7dPplXdLyIBG4S+m6DwCnNw0Co=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AX+N/pbQ8Z4e8b7pSfhnyBX+1kF6VH/EXzRDRXGbL/sKHGZ3i
	6bfAeb3a+JM+IKcq5ils6WXxbsR/SMJptEAlXz8uidllP8cE66K2LuRQMxY34dV2ig==
X-Gm-Gg: AYBFou1oa/qOWleuLsr9vb+cwoldoKmlJhQQwiHm5F23ObXaJ8bxmJtxTpHmpHzhxi+
	MTo6/Blv3V0XhaqbEtQ6yMEpj36nFDugM+0mseEaAGWveISUa7Sc2yvjmX2lWCP93QhNnkd2oGw
	ucLgi+Aullhmo834Q//G25uHbpJt7sl+1xtQsQ5I+5xZtVaLsZFukC6BTr6el1dfiGbiQrB2TPI
	XCPTqGwGZH3w/zOCYN0Y2/WG7CizNkEUs5NNs2N6xqlwwQwl3Dwb01W/Wqc2cb0A99Vfz6gxBHo
	248E5QT6awnwOOPv3Ka4cnet9cPAah88zZAxsAf0R0zL5wtTQpC+PlvZELKtJp4TGL2rTMSD0w4
	L9vxPgdBwODAoI3Y8y9n2gFz+d9HHOkRBxJVbxwq6ffkJdCUgg1iaOYpvDd/QZMJtl+/Qt+cwNk
	wuJpJckokES6Dez85U5xzPolfVXxeH2GTij+YMpcniQzHFi/jPTjZ9sCdj7FUyidvpZAcGqXUVH
	ZArImHLLWKVDNSBprI4zXKk1H/VakruSiHvADpXiSbQiL5kQS48hSc6A2MYA9/asJE70nnHOHnW
	N9kLBYVQIMuQlYNMOK2ygQKgl9sov57OXcJij7OSMhXsxgAuvuxZP04DukmNkgkV8P+2nth/r1l
	Ht2Bo1aYT7en0POM=
X-Received: by 2002:a05:6808:11c6:b0:4f4:b5ba:a241 with SMTP id 5614622812f47-5640dde805amr8598864b6e.39.1793722281085;
        Tue, 03 Nov 2026 08:11:21 -0800 (PST)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd95dc0sm11688383b6e.6.2026.11.03.08.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:11:20 -0800 (PST)
From: Raul E Rangel <rrangel@chromium.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Timur Tabi <timur@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 7/8] serial: 8250: retire canceled RX DMA before reusing the receive buffer
Date: Tue,  3 Nov 2026 09:11:03 -0700
Message-ID: <20261103161104.2449407-7-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261102-submit-serial-8250-dma-cancel-v1-v9-7-9159caade148@gmail.com>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com> <20261102-submit-serial-8250-dma-cancel-v1-v9-7-9159caade148@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi James,

Thanks for v9 — fixing asc_startup() locking in Patch 2/8, waking
tty->write_wait for drain waiters in Patch 5/8, splitting OMAP RX locking
and IRQ quiescing into Patches 3/8 and 4/8, and adding rx_pause_wait with
immediate wakeups from dma_rx_complete() and serial8250_do_shutdown() all
look good. Waking rx_pause_wait under port->lock cleanly avoids delaying
normal completion or cancel_work_sync(&dma->rx_flush_work) during shutdown.

Two remaining comments on Patch 7/8:

1. Escalating to serial8250_rx_dma_recover() after a bounded pause-stall
   window on partial RX transfers:

   The commit message notes:
   > A provider which never pauses or completes retains RX ownership until
   > an error or shutdown; a timeout alone cannot establish that discarding
   > the buffer is safe.

   I completely agree that a timeout alone cannot establish that *reusing*
   or *freeing* dma->rx_buf is safe while the channel is still running.
   However, calling serial8250_rx_dma_recover(p) under p->port.lock once
   the retry budget expires does *not* reuse or free dma->rx_buf without
   stopping the channel:

   - Calling serial8250_rx_dma_recover(p) under p->port.lock inside the
     worker's retry block sets dma->rx_err = true and
     dma->rx_terminating = true (and keeps RX masked in UART_IER), which
     causes serial8250_rx_dma_flush_work() to exit the for (;;) loop
     (retry = false, recover = true) and call
     dmaengine_terminate_sync(dma->rxchan) outside p->port.lock in process
     context (8250_dma.c:233-239).
   - If dmaengine_terminate_sync(dma->rxchan) succeeds (ret == 0), the
     channel is stopped and its callbacks are drained, so clearing
     rx_pause_pending/rx_terminating and restoring p->ier safely falls back
     to PIO ("RX DMA failed, using PIO\n").
   - If dmaengine_terminate_sync(dma->rxchan) also fails (ret != 0),
     lines 235-239 already retain dma->rx_buf and return early with RX
     interrupts masked.

   Why does this matter in practice?
   Look at drivers/dma/tegra186-gpc-dma.c:
   - Line 1521 unconditionally assigns .device_pause = tegra_dma_device_pause,
     so dma_get_slave_caps() (drivers/dma/dmaengine.c:614) sets
     caps.cmd_pause = true and serial8250_request_dma() enables RX DMA.
   - On Tegra186, tegra186_dma_chip_data sets .hw_support_pause = false
     (line 1351), so tegra_dma_device_pause() (lines 420-423) unconditionally
     returns -ENOSYS. (On Tegra194/234/264, tegra_dma_pause() at lines
     389-414 polls TEGRA_GPCDMA_STATUS_BUSY after setting
     TEGRA_GPCDMA_CHAN_CSRE_PAUSE for 20 us and returns -ETIMEDOUT if the
     channel does not pause.)

   When an RX timeout interrupt (UART_IIR_RX_TIMEOUT) fires on a partial
   transfer (e.g. a few bytes typed at an interactive console or a short
   command waiting for a reply, count < 4096), hardware transfer completion
   will never occur while the remote peer is waiting for our response. With
   an unbounded for (;;) loop:
   - Those partial bytes in dma->rx_buf are never delivered anyway (even if
     we wait forever until the user closes the port, serial8250_release_dma()
     terminates the channel without copying dma->rx_buf).
   - UART RX remains permanently dead with RLSI/RDI masked and never falls
     back to PIO.
   - serial8250_rx_dma_flush_work() holds a runtime PM reference
     (guard(serial8250_rpm)(p)) for the lifetime of the open port.
   - On 8250_dw, dw8250_idle_enter() (8250_dw.c:151) sees
     serial8250_rx_dma_flush(up) == -EAGAIN and silently aborts
     dw8250_set_divisor() and dw8250_check_lcr(), breaking baud-rate and
     LCR updates while rx_pause_pending is stuck.

   If serial8250_rx_dma_flush_work() escalates to serial8250_rx_dma_recover(p)
   under p->port.lock once the stall threshold is reached (or immediately when
   dmaengine_pause() returns -ENOSYS / -EOPNOTSUPP), dmaengine_terminate_sync()
   safely stops the channel before any buffer state is released and the UART
   recovers on PIO instead of wedging until close().

2. Minor nit in drivers/tty/serial/8250/8250_omap.c:783-784:
   In omap_8250_shutdown():
     WRITE_ONCE(up->dma->rx_pause_wakeup, true);
     wake_up(&up->dma->rx_pause_wait);
   8250_omap uses its own synchronous omap_8250_rx_dma_flush() and never
   schedules rx_flush_work or sleeps on rx_pause_wait, so those two lines
   in omap_8250_shutdown() can be dropped.

Thanks,
Raul
