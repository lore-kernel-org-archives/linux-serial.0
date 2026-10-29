Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312864;
	b=rhcurANb3qwS2T45ZGGT6x6MqfvcWCcguedLEtOw96WqVe2C0RBOV3LyTNxbEVyY49We
	 gGpTB1lGhyGEhoC3nKmS6jqZGGfqqzbTQtLFW/7TjR16ASiOjjtFQA1Jc6aiSLphLfVhV
	 GQz8Iirh56NvIztiguOYgnsCqUhEqAwoNCaMFMybBF/+9ITGB0rTIuqu8vNCBns0GyRpA
	 yUf47N29Xcvz3mx9GQiRsI5GQA2pT4hDB4DFnlgopthJ1GZS7JfmC2ceucs0Qyd222xaO
	 e0kFE1v9C0TTwmbbLhZZ39QRyAo3ykD6W24Dwd2V1CO2qPDW5c1sbRd7grMiCoqvSGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sXO3ewVqFwoOGcXfkU3q3dcDer2CaAHOZmthFd8gt1s=;
	b=QL9upD+kYXZLIJ/MizcIUJpVGuDHuWmGU4ElNeWAVSXfQIP+cLR+1N+AtE64uSKaMOr9
	 BXlUG93/9dFnh8WudglVq55QFL8hqTL6sY7JOMEqGtcZKTOloxKI/F7f6MUjuMX7j1Hrt
	 g/mPpBZhc0R8LjyZChx9hkhqa4svMLc20se78GDRYpCwl0Kb4y3xaStC7Ec+nx4Bbi6VJ
	 BlGG7Tx9hzwZIPOOfHa23ZzAnuwZLkuiO2aOinauAT+f3AhWlwbvJcz8l7W3oPqkiJwx7
	 G1yrkB5P3EjfWCZEKLEf3L9tCxotBsqGU6W6ZKEVpRUUpFf4q9qqIpeJNUGr4KZrYiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LgbIvAP6;
	arc=none smtp.remote-ip=209.85.210.44
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE6A606A31D
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 22:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BE6A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LgbIvAP6
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-84a248254f4so121439a34.0
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 15:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793312863; x=1793917663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sXO3ewVqFwoOGcXfkU3q3dcDer2CaAHOZmthFd8gt1s=;
        b=LgbIvAP6Xc+OIRRd087wBSrpkSpFf5dO+GjsHu/al6RAz98XL7Uy6xc+47Xjk0sgw7
         19tUaKX0LpqbEddYjEgqYwjLX/uAMwPqCJ1FekM38Mrg3PNoTnxo1j11ktpKfsjW0iRJ
         pe+lAAr0XU8xkbm6SoBK6bfsX+zlXINoj1vpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793312863; x=1793917663;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sXO3ewVqFwoOGcXfkU3q3dcDer2CaAHOZmthFd8gt1s=;
        b=s4oBjoz+i4Y2YDqOyPrcd1rkxSO2mbVtZhzPd/bUV1NynzNec++qPnDWePUFF7ETXm
         Z7Wsf3rZptW2IJcMwrGLMbQzSeekhB6G+BnTN0guaNwqwxPJrxfChzAnnpkMyAG8k3+w
         Z0FHPPibiY2EtkYrO2xaOyE8+Yfd1FiKcr5NRORWtaubdJGkE1WgBCB/OKCGeachMCdn
         NB5NJ3mOUwLC1I3aSoxoL0goWmK6AisCFfQUa3/QiTUuIjnERzZqnNq4y2ynNExXVGIY
         WvKbhSDSR5tstPopl7pdU7vYiRBqwdmSx4CfKCebF55mozbPp+S12Yt8xneXwJ5jSiO/
         VJ4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzCVhggqPmfEho0K59JF1zmEskzgLGdQYVoFRI58W7oRI9ovqyWCIh8ZmIp6DP/9aWYYXNDVCGZti85pDE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJngmtiLuG4HOfiSlLxlW/20Vf+BjxyLVX2feV0E0sxutmtmOcV
	IdIzN6I4FqNHHwDtLsoIeDlnZoLjnNO+8DpcsQNtXugzbWI/vgU0RlmtEbsyS2VtjQ==
X-Gm-Gg: AYBFou33tQ7oZHLqt14ZOi9w8K9fvWN6pF4s/+4t5IkmgjBWZBkJ3C2MUIJ9eJhq192
	RHu/jkWlYoIaXVGodpdXt61kl7c/K4w81TWYchdLQ7QtUaqIjTA/X6VURx+mBn7Ymr+WZBggzbg
	ZoUVwyhdLm6P0IJG1eWhcaGxGSo6Di02AhbMTL92bPRRdBm4lMOQ50H3e6h8ULmWME0Pmj/5X6N
	6otf9wKjhT2JiK4gJbw8GTLlp/DDe1f5UDzC++fs4bYQrlPx8dKbUFIhHKsJAYDr9luWIoOA59i
	KY0Tdd3k+fgAAVu2RrhwFDEOfOLaORkntIuXw0BaMeyCvg3vj0Ey05yT1hOmQMvKEBnsmq8+yIF
	UBWQf72hYkq5I3sOkuD2O4tTg02sJ+0rMrqMoGZVioMeqtZkH3C031xy85MTS1Qh6SwhE+pVVY/
	gqH/Q3H9KnBO0h9HZhnzmBHPGEJGKlv9VQuMZgCpBKF7WAep/VhYih+igTrz9QucGRAy5g1WjP7
	2HGSEutvqwiJQua0dVZwbSvUSL9YaiWitkWZHWu07Q3yYOPgopw+dkiiuXDQe9BT3YBYhDhe42u
	ZZBfkJFniTeFieBS1BpJJ07qkZylFAewjyF7fJCg3A3s3f2l8SbmIrRMpbFyTQFkTx7nTDY83Pu
	MUzvmKoi9ppLUuvQ=
X-Received: by 2002:a05:6830:25c6:b0:81f:827a:b1cf with SMTP id 46e09a7af769-85d3644f500mr541370a34.22.1793312863265;
        Thu, 29 Oct 2026 15:27:43 -0700 (PDT)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d3545b89asm718163a34.6.2026.10.29.15.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:27:41 -0700 (PDT)
From: Raul E Rangel <rrangel@chromium.org>
To: James Hilliard <james.hilliard1@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
Subject: Re: [PATCH v8 6/6] serial: 8250: retain DMA resources when termination fails
Date: Thu, 29 Oct 2026 16:27:34 -0600
Message-ID: <20261029222734.3086943-2-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <CADvTj4pOg4w5LpFW_E3qzP7FZDnDgpB8LyR9xxhT_mZre21vFw@mail.gmail.com>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com> <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com> <auNW_Oc-Ao5Iw-Gw@ashevche-desk.local> <CADvTj4pOg4w5LpFW_E3qzP7FZDnDgpB8LyR9xxhT_mZre21vFw@mail.gmail.com>
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

On Thu, Oct 29, 2026 at 11:19 AM James Hilliard <james.hilliard1@gmail.com> wrote:
> On Thu, Oct 29, 2026 at 8:24 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > > +	while (rx_ret || tx_ret) {
> > > +		dev_err_ratelimited(p->port.dev,
> > > > +				    "DMA termination failed: RX %d, TX %d; retrying\n",
> > > > +				    rx_ret, tx_ret);
> > > > +		msleep(100);
> > > > +		if (rx_ret)
> > > > +			rx_ret = dmaengine_terminate_sync(dma->rxchan);
> > > > +		if (tx_ret)
> > > > +			tx_ret = dmaengine_terminate_sync(dma->txchan);
> > > > +	}
> > >
> > > Huh?!
> > >
> > > This is unacceptable. Sleeping is okay, but value should really match the
> > > baudspeed and other parameters of the transfer.
> ...
> Regardless of the retry interval, shutdown cannot release the buffers
> until the provider establishes that DMA and its callbacks have stopped.

Agreed that if dmaengine_terminate_sync() fails, shutdown must not free
dma->rx_buf, unmap dma->tx_addr, or kfree(port->xmit_buf) while hardware
or a detached callback may still touch them.

However, because serial8250_release_dma() runs under port->mutex in
uart_shutdown(), uart_tty_port_shutdown(), and uart_suspend_port(), an
unbounded `while (rx_ret || tx_ret) { msleep(100); ... }` loop means that
if a DMA provider returns a persistent error from dmaengine_terminate_sync()
(-ENOSYS, -EINVAL, -ENODEV, -ENXIO, -ETIMEDOUT, or a wedged controller),
close(), hangup(), and system suspend will hang forever in
TASK_UNINTERRUPTIBLE while holding port->mutex (triggering hung_task_panic
after 120 seconds).

Would it make sense to satisfy both constraints (no UAF on buffers/callbacks,
and no infinite sleep in close()/suspend()) by quarantining/leaking only the
failed channel's resources instead of looping forever? Specifically:
1. Bound the retry loop in serial8250_terminate_dma() (or do not loop on
   non-transient errors, checking `if (dma->rxchan)` / `if (dma->txchan)`).
2. If rx_ret or tx_ret is still non-zero, warn once (`dev_err` / `WARN_ON_ONCE`)
   and intentionally quarantine/leak only the failed channel's resources:
   - If rx_ret != 0, leave dma->rxchan non-NULL, keep dma->shutting_down = true,
     and skip dma_free_coherent() / dma_release_channel(dma->rxchan).
   - If tx_ret != 0, leave dma->txchan non-NULL, keep dma->shutting_down = true
     and state->xmit_blocked = true, skip dma_unmap_single() /
     uart_xmit_unblock() / dma_release_channel(dma->txchan), and in
     serial_core.c:uart_free_xmit_buf(), skip `kfree(xmit_buf)` if
     `state->xmit_blocked` is still set.
3. For a subsequent port reopen after a quarantined failure:
   - Remove the redundant `up->dma->shutting_down = false;` in
     serial8250_do_startup() before serial8250_request_dma(up) (which already
     clears shutting_down under port->lock), and have serial8250_request_dma()
     return -EBUSY if `dma->rxchan || dma->txchan` is still non-NULL so
     reopen falls back cleanly to PIO (`up->dma = NULL`).
   - Guard the DMA completion callbacks (`__dma_tx_complete`, `dma_rx_complete`,
     `omap_8250_dma_tx_complete`, `__dma_rx_complete`) with `if (!dma || ...)`
     so a late callback after `up->dma = NULL` is ignored safely.

That way, neither hardware nor a detached callback can ever UAF rx_buf or
xmit_buf, while close(), system suspend, and subsequent PIO reopen all
complete cleanly without an unbounded msleep() loop.

Thanks,
Raul
