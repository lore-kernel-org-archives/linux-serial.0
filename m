Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793220536;
	b=4b4eQTlEAhDmc0rs3+1sKtWOJFogynABY15TkxRFA4l5BnoSlKZUahSrpd4/lEUsMTxl
	 gk63dahS9YP+pK3j3zsGFeEklik6FPdM+sBsWvDnmluWrQGLvHv2snoJqh0vGqe7L//23
	 Aqwx75QFXbpNVUWskfex8FYTGpIYpmi1dAvs6Zj19I7nMKm7nBCImLBkRqp0SW6iCk/kz
	 1a2vErUO5Z2gUTlkD2N7mbbTWLdsjhR+1Lcj1XoOwAgMm83wrJTlVq+/G2ZYvgAKISmwE
	 gD8go+SHQ6QC1uIYF4GDAcK5se1FSvaW15pTNnZHfu40kmQLkMzlYwuuJkj/6nA6Few==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vc9uFw9UVF1A8RYaaUz33Ia3H+vJB3EZ/DUe+0FMK90=;
	b=lmljFp6QCJejuMsMnrmZ88I0Aj7XXnFKrTistIloMlmnxX/s80Oq5MvYR4l0R7vSO8im
	 Th9Mntf+CZrTPVxOf8kRZZGLl9pBVI7GM8u6OBUCz/vu7ZOTw2dkvZMkDj0gRUcukyPBH
	 p5nzD7Ct8ykf3jbxCQPGiZGghVARlacvZ5w3FAUO561e5+yeQBRRpZNdsere49zVHXoy+
	 HvOr+BySfls/v2xueCuAvNqdom5qtAJVL07Bsx0cV0Y3r6ZvSNpdo4/zM4zFX1j63bz3n
	 CsPpKLjO4BxhVqYV204F8jE+rGNzrWLrMEvaOt4vt+soEZJ70cDSwZEr8t/rC/UyE/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kSLGHIJq;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54F7606A32F
	for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 20:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B54F7606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kSLGHIJq
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4b28d7c729fso813286b6e.0
        for <linux-serial@vger.kernel.org>; Wed, 28 Oct 2026 13:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793220535; x=1793825335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vc9uFw9UVF1A8RYaaUz33Ia3H+vJB3EZ/DUe+0FMK90=;
        b=kSLGHIJq8n1yNc5ysWmES9Ntc1ov/5WFPhTdXo+jUEFD5soxrpRLj/9bztaAoSd0MY
         BeuEUfDzpjOx0AfwrLFqw3ouH/CxFYtKhUAsM5GsOXFz0M2zTsUVcefIWYRS6fAg/liZ
         QfbLkf5hTHyRQ6imAGkUgzqoFthCTPz+egmEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793220535; x=1793825335;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vc9uFw9UVF1A8RYaaUz33Ia3H+vJB3EZ/DUe+0FMK90=;
        b=UXzF61Z+DE7NZ77jyKXvLgVfH+NLdG0GRSBabzUOAQ46xCogeArmI0wBkgL6QpVfDr
         z5kQO/W7LOTH9SW+1x5VE/Zs2tl/8pGRqzKdCFUydij5GnUoPWSyEm89Ebhxwvc54kRF
         ZHoml9ss4BZztBV7EeZTFsCSyNCEaDcul1NL3OAnfpeSgSOP4NuYl/NXrAZ3YPCBx7RB
         7zi5pTp8bb1UF5l+SoaNfHQkZoZ1aLX8acWXEstTv9pPI0f2jEy5vWwjzrynir5Cmy5A
         5P7gtGo2Lgl8YUSJJGtYajK9t00OKYPn7GrHdurS5UJTmcIaiwjWghhWn5w2KmsdpCEz
         TAbA==
X-Forwarded-Encrypted: i=1; AKwUvBzJ6UKjW8zng8rfnwxhUTEHy5sxH7ZWlpEpC1TDj338vGZ3UOEtP7nDhUhaQaWylBbhgPawreaKOxpU6UQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLD2O68Mp2igAQk7i3qweuB0p/0rD+epqEJw7VwofI6B+f2J4Vq
	oSm5F5UKNtM3p5sjnwkHbO+WEhHL7XTeafsB7MPEemXAEK1GZMEbyLawkoqCh2z6Xg==
X-Gm-Gg: AYBFou3ecMUEuAYgDg2IusWtsZcTqqjfe6x1REIytoaeMiESWEudCuRpy3nhX3X9U8p
	0KE8H9DNGlXiwWLW85vi3lTJarE+284nIFRYwOJTfpfkJmm3ue9KJDlP/nIoyIb6ocSisUQTxzU
	lqYfDWnNScWoOO39nkihSAEzHZMoyBVhIvhR11rsRn9FjaBhenVuHIt0JISqoBHcODawaviwTjw
	DommoA58so4rLnkKRQ4I7hlyu9l1VE6KiZDg3uFAu3hFhkzsvCeD3OqE3ykr/VhRxq5StV6VHW6
	U5klsEllYSAMzoVEitnETQdOstIdxU8m2DdxjXy44BueGMEpuEKVMqz+Mh2MFpHEnrpHVNIhj56
	h0fwWcLeMbfvylH8rc4lqq7iZtUBCOiPOlKr8shTZyKLfVWUuNFjr63zVHSeYxuz/AAB8eBtWqK
	+u/bVnAMN+zCUtCRFqDR44U2o+6Vpb4m40YDMQLV67/ecVOz3yJeNcJg31osMpMkdb3yxLlo+ao
	D5Z7r3cYFKHjN9LnFWg5xFfqZlU7e+UfoC/gX4bDYSt6jg+An6d5PxlOM/l3D7IfdSAbiPaOqwT
	YCBp4ydOBH6hBDj+YgIqapdn6slElZTpFCJbU4WICyCwjkFzYfYbNm/loastZUR2pjOozUfqsOr
	K2SDoL8HKpUBQp6TtvQ==
X-Received: by 2002:a05:6808:5090:b0:4c3:9892:96c3 with SMTP id 5614622812f47-56385c45dbbmr2597003b6e.22.1793220534711;
        Wed, 28 Oct 2026 13:48:54 -0700 (PDT)
Received: from rrangel.c.googlers.com.com (202.168.136.34.bc.googleusercontent.com. [34.136.168.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-563c363902esm2281137b6e.2.2026.10.28.13.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 13:48:54 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v7 5/5] serial: 8250: retire canceled RX DMA before reusing the receive buffer
Date: Wed, 28 Oct 2026 14:48:47 -0600
Message-ID: <20261028204847.3471382-3-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261027-submit-serial-8250-dma-cancel-v1-v7-5-985a023ba4b4@gmail.com>
References: <20261027-submit-serial-8250-dma-cancel-v1-v7-0-985a023ba4b4@gmail.com> <20261027-submit-serial-8250-dma-cancel-v1-v7-5-985a023ba4b4@gmail.com>
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

In serial8250_rx_dma_flush():

> +	ret = dmaengine_pause(dma->rxchan);
> +	status = dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
> +	/* A completed transfer may reject pause before its callback gets the lock. */
> +	if (ret && status != DMA_COMPLETE)
> +		goto recover;

Checking `status != DMA_COMPLETE` assumes that whenever the hardware DMA channel
has finished transferring the buffer (causing dmaengine_pause() to fail because
the channel is no longer active), dmaengine_tx_status() will already return
DMA_COMPLETE.

However, dma_cookie_status() only returns DMA_COMPLETE after the DMA driver's
interrupt handler has called dma_cookie_complete() / vchan_cookie_complete().
Because serial8250_rx_dma_flush() runs under uart_port_lock_irqsave() in the
UART ISR, if the RX DMA transfer finishes in hardware just before
dmaengine_pause() is called (or while local IRQs are masked on the same CPU
before the DMAC hardirq is serviced):
- On dw-axi-dmac (drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c, used with
  8250_dw), hardware clears CH_EN in DMAC_CHEN when the transfer completes, so
  dma_chan_pause() times out polling DWAXIDMAC_IRQ_SUSPENDED and returns
  -EAGAIN, while dma_chan_tx_status() still returns DMA_IN_PROGRESS because
  dw_axi_dma_interrupt() has not called vchan_cookie_complete() yet (and
  dma_chan_tx_status() also reports state.residue = length for non-cyclic
  transfers until dw_axi_dma_interrupt() runs).
- Similarly, tegra_adma_pause() (drivers/dma/tegra210-adma.c:696) returns
  -EBUSY and omap_dma_pause() (drivers/dma/ti/omap-dma.c:513) returns -EINVAL
  if the hardware channel cleared CCR_ENABLE before the DMA ISR ran, while
  dma_cookie_status() still returns DMA_IN_PROGRESS.

In that window, `if (ret && status != DMA_COMPLETE)` jumps to `recover:`,
dropping up to 4 KB of received data and permanently disabling RX DMA
(dma->rx_err = true) on a normal transfer completion.

Also, on a related shutdown note in drivers/tty/serial/8250/8250_omap.c:
omap_8250_shutdown() (line 775) still calls omap_8250_rx_dma_flush(up) before
taking port->lock to set up->dma->shutting_down = true and clear UART_IER = 0
(lines 783-786). Because __dma_rx_do_complete() clears
UART_OMAP_IER2_RHR_IT_DIS and dma->rx_running = 0, an RX interrupt or callback
in that window can see shutting_down == false and restart RX DMA right before
serial8250_release_dma(up).

We also published the TLA+ model and TLC counterexample trace
(Serial8250RxDmaV7_HwDoneBeforeIrq.cfg) here:
https://github.com/ismell/linux-8250-dma-tla

Thanks,
Raul
