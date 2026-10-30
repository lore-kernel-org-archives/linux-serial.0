Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381801;
	b=CiNlkL3+PSjlKeL0i5ppiqHJuqG22/sIrU+SJEFPUUhLCH7AbFCTc7uIxil5VXxhJrKc
	 IrLMU79bGv6yqnPiLg7jh02uPrzyNo0IBmTuMRKKo3aFM5gvC3fYlZe2lTytrsaEW8p6i
	 wM9EPil3e0wOZyjJNIVShPCg2amYdkiviICKM8a+zYVwR3J8Tz3vZDA0LuljXuQt+nhAA
	 h1V6jX3OoJfxkYwnVEkDt5GPpnSinlMYfDMagURLzh/sYpRk9OfEWxp6/9fmLspRAUjtS
	 AA+VQWstl1SbbDgiADDsZfeAi6IzEmIM7b9N2IwY4m6gsD5pcvXyhOzs24TIeW7lGPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=p+eb7dwaVi2e/2az0lhLRof2o3XdtzLR7+wZ1rytyEE=;
	b=eI7Xme1ZzRBzab0fS9xec6K37r6s/IDh7zFTvo8KSAWq80KiEuKy4AIbNnvCCH8IuIch
	 eA3UPXpzpXd2UfyXVDJf7EZz5DnqotvRjdclqJqe/cSCce1UmpX4N8McGAcT7q5zMfEyZ
	 eWp2OmcZ+pUetIUpaZ0eM0xiz6IZJZtMfw0wNKaP+1/DYlGzXtjV8+J2HytyV1VrG8nuw
	 5K26NIznyoU8wOoE9B8qce51CVkeUrSMFD83cSYY+VzeTulwPOh0hkFjPCf1ABlz0lG88
	 Hi2L9wK9XzCa2nDT8xxs9+sEy63nAMWEOeW0v5EnUFgyIVAK5MDsE+NqqN/seulJM7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hhtoH1xT;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5172606A31F
	for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 17:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5172606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hhtoH1xT
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-844a8bf7e25so744041a34.1
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 10:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793381800; x=1793986600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p+eb7dwaVi2e/2az0lhLRof2o3XdtzLR7+wZ1rytyEE=;
        b=hhtoH1xTR8H5n8tmtEhfVc3fHuOrmb7/zV9XKE9geyxUt6ig4tg4dLNtVNCaR4wmSB
         wXxHYYauBCbA2RlxGrc03pICUjdTnvw8EFiZkfJky0ezTyfyEOx4Toys6dcRJnwCNd6a
         4E+gyJLT8yyPuEoFel7lnaAVLfOvzPZDYzN1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793381800; x=1793986600;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p+eb7dwaVi2e/2az0lhLRof2o3XdtzLR7+wZ1rytyEE=;
        b=E5xAslKu1wzGZGhiU4mSk8lvhVrM99U87ue2LwEEx9gmphIa2SBl1I0BfdJSAhvM2S
         rTsIrXcNQgKBQIKxPMx5kdcl1tT3FyOt11ADh8O8U7mHio1MwTZvBVun/co7lYBFq70B
         i0FxeHYa2l+Sy/0mV25hSPcxVedcrBNn8pvT5cECN8mHgBTR2EUFYjPwa3NLrykVdrMW
         P+cfv0uLB+slA28suPDyX4fhirZhsXnA0z2BlgftL5NPAaJF00OnQjG0hPw6npkZIG8b
         UHr9eZ5nBplofyZ5wDhKvsr4hbEvEaCQ8JnbKYjouAhUU6JwuJ2tKXqkXlpDgREY1/fd
         lC5w==
X-Forwarded-Encrypted: i=1; AKwUvBxq8wr1W7Npi4WZYelc6ee0RY4bhsdguSesViz1bIkALTvGTIkI5O6DkGcwlpwtoi/WpM1Sa8RZMoIjI1k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQfC94/kS3EUkCN2w5frBRNuUoglIIJwWzqlMu+xry72VOM38P
	24LFLPIDEAvkrHbHS6nqd+4Fh5T1Rv6388MICSv+65T3W1Ed014iY1cghamr0VAsgg==
X-Gm-Gg: AYBFou2bVpfHnoiqYMVNGDp3l4c8CTNIqMlBpDfyuCYBtAzsjmaheRC15RKD0aCEHOv
	NtFt+G8zadhkiBi64c7ReJhDtQHjM/+RGQBP2dXkjOC6f9XK8DmRvbutF7GYP0CrvKNETkLmlwS
	gKRJFa9QJMBXCCkJbh7JqzvD7ifQ1cVFbzQ+ycboFqXOeD2bOqhZy9Kl1N/8KfJ1sHXYM3abQlu
	yTqxJGT3/XyWs7c/c4SPPgdxYWObHmTw1j7hjBS+d2+BQ3gEMRYaJEAfxm9c/I0+cKB46JZJTu/
	ljO8GA64axxWy7L011yvhY4qZg1o6DOPERegBsUpJHr89ExEcCjFo9acZEHHdcy4VDJorBePmr1
	x/eH/sjHBpMh0NwtYy1XNXtQIUAf5k8n3HGsZU6hNxEJtooOnxpWXjau8e8lKGZ4pBquA3g+oKP
	fINfHgKPTltDpVXo1T/Ech9/86Qu6ZMls+fLTifo3sru0o8JYTmH1cWMYRpV3nRlBjOCVE0AMH1
	BZB7b5h9S7ZZq7kbBL+TeDuE99XkG1/Suwzfxq1VpsPcywDEkCDcXOXHhL66qztgMPc2W/El3Ij
	VmCdF0SWP1alc3Su/zMJ/pJj5/BYJxYe7qd/1xfX61h3ysmmuG6IW4jv1B8dzydwffDJSmJu8MB
	Q6zyK2kJy3Ch2dnvb
X-Received: by 2002:a05:6830:7181:b0:81b:ac9a:5681 with SMTP id 46e09a7af769-85d3649ebddmr2330039a34.29.1793381799663;
        Fri, 30 Oct 2026 10:36:39 -0700 (PDT)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354efebesm2497044a34.19.2026.10.30.10.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:36:39 -0700 (PDT)
From: Raul E Rangel <rrangel@chromium.org>
To: James Hilliard <james.hilliard1@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?UTF-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Pali =?UTF-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
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
Date: Fri, 30 Oct 2026 11:36:35 -0600
Message-ID: <20261030173635.2186490-2-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <CADvTj4rRtKyq_7yhpfwGQrbOA=k_jxQymTpZSvdVBB0A-xR-Rw@mail.gmail.com>
References: <20261029-submit-serial-8250-dma-cancel-v1-v8-0-3fd56ba352ed@gmail.com> <20261029-submit-serial-8250-dma-cancel-v1-v8-6-3fd56ba352ed@gmail.com> <auNW_Oc-Ao5Iw-Gw@ashevche-desk.local> <CADvTj4pOg4w5LpFW_E3qzP7FZDnDgpB8LyR9xxhT_mZre21vFw@mail.gmail.com> <20261029222734.3086943-2-rrangel@chromium.org> <CADvTj4rRtKyq_7yhpfwGQrbOA=k_jxQymTpZSvdVBB0A-xR-Rw@mail.gmail.com>
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

On Thu, Oct 29, 2026 at 6:35 PM James Hilliard <james.hilliard1@gmail.com> wrote:
> That is the current behavior. Returning from shutdown allows serial
> core to free the TX buffer and removal to release the callback
> context. The retry loop prevents those releases, but a permanent
> termination failure blocks teardown indefinitely
...
> Retaining the buffers and channels does not preserve the complete
> callback context.
>
> The callbacks carry a uart_8250_port pointer. For DW, the DMA state is
> embedded in devm-managed private data, which can be freed after
> unbind. The registered 8250 port slot can also be reused. Retaining
> the DMA channel does not prevent either operation.
...
> Clearing up->dma does not stop hardware accesses. After unsuccessful
> termination, the channel may still access the UART FIFO, so reopening
> with PIO can introduce concurrent FIFO access.
>
> A hardware-specific stop/reset sequence could establish quiescence,
> but its implementation and effects on other channels depend on the
> controller. If the channel cannot be stopped, quarantine also needs
> to preserve callback-context lifetimes and prevent unsafe port reuse.
...
> The current callbacks fetch p->dma before acquiring the port lock.
> A callback can therefore retain the old non-NULL pointer across the
> assignment of NULL. Checking that cached pointer does not protect
> its backing allocation from being freed.
>
> When termination returns an error, dmaengine_terminate_sync() also
> returns without calling dmaengine_synchronize(), so callback draining
> has not been established.

Those are all good points. We added port reopen and a `NoConcurrentFifoAccess`
invariant to `Serial8250TxDmaV8.tla`
(`Serial8250TxDmaV8_QuarantinePioReopenHazard.cfg`), and TLC immediately
confirmed your point on FIFO contention: clearing `up->dma = NULL` and
falling back to PIO when reopening after a failed `dmaengine_terminate_sync()`
violates `NoConcurrentFifoAccess` in 7 states because the un-terminated DMA
descriptor can still access the hardware UART FIFO concurrently with PIO.

We can satisfy all three constraints while still preventing normal `close()`,
`hangup()`, and system `suspend()` from hanging forever in
`TASK_UNINTERRUPTIBLE` under `port->mutex` across the three lifecycle edges:

1. **On `close()` / `hangup()` / `uart_suspend_port()` (`serial8250_release_dma()` & `uart_free_xmit_buf()`)**:
   - Bound the retry loop in `serial8250_terminate_dma()` (with a short
     backoff rather than an unbounded `msleep(100)`, guarding
     `if (dma->rxchan)` / `if (dma->txchan)`) and release whichever
     channel(s) terminated cleanly (`rx_ret == 0` or `tx_ret == 0`).
   - If `rx_ret != 0` or `tx_ret != 0`, **keep `up->dma` intact** (do not set
     `up->dma = NULL`, including in `8250_omap.c:omap_8250_shutdown()`), keep
     `dma->shutting_down = true`, and retain the failed channel and its
     buffer (`dma->rxchan` / `dma->rx_buf` when `rx_ret != 0`; `dma->txchan`
     and mapped `dma->tx_addr` when `tx_ret != 0`).
   - When `tx_ret != 0`, explicitly call `uart_xmit_block(&p->port)` under
     `p->port.lock` (`state->xmit_blocked = true`, since `xmit_blocked` is
     otherwise only set when `uart_flush_buffer()` ran prior to `close()`),
     and in `serial_core.c:uart_free_xmit_buf()`, return early under
     `uport->lock` if `state->xmit_blocked` is set (without clearing
     `port->xmit_buf = NULL`, resetting `port->xmit_fifo`, or calling
     `kfree(xmit_buf)`).
   - Because `up->dma` is not cleared and `struct uart_8250_dma` /
     `struct uart_8250_port` remain allocated on the bound device during
     `close()`, `hangup()`, and `suspend()`, any callback that was not
     drained by `dmaengine_terminate_sync()` safely loads a valid `p->dma`,
     observes `dma->shutting_down == true` under `port->lock`, and returns
     without UAF—while `close()`, `hangup()`, and system `suspend()` return
     cleanly without hanging in `D` state or triggering `hung_task_panic`.

2. **On subsequent `open()` (`serial8250_do_startup()` & `omap_8250_startup()`)**:
   - At the very start of `serial8250_do_startup()` (`8250_port.c:2356`) and
     `omap_8250_startup()` (`8250_omap.c:724`)—after acquiring runtime PM,
     and **before** clearing `up->dma->shutting_down = false`, touching
     `UART_FCR` / `UART_RX` / `UART_TX`, or setting up IRQs/timers—if
     `up->dma && (up->dma->rxchan || up->dma->txchan)` is still non-NULL from
     a prior failed termination, retry `serial8250_release_dma(up)` first:
     - If `up->dma->rxchan || up->dma->txchan` is **still** non-NULL
       (termination still failed), immediately return `-EIO` and **fail
       `startup()`** (do *not* clear `up->dma = NULL` and do *not* fall back
       to PIO while the wedged DMA channel may still touch the UART FIFO).
     - If termination succeeded on retry (`rxchan == NULL && txchan == NULL`,
       which also unblocked `state->xmit_blocked`), reset `xmit_fifo` and
       proceed with normal startup and `serial8250_request_dma(up)`.

3. **On driver unbind (`serial8250_unregister_port()` / `serial_core_remove_one_port()`)**:
   - Driver removal is the *only* point where `devm`-allocated
     `struct uart_8250_dma` and the `serial8250_ports[]` slot are about to be
     freed/reused (note also that `serial_core_remove_one_port()` at
     `serial_core.c:3336` only calls `uart_shutdown()` when
     `tty_port_initialized(port)` is true, so if the port was already closed
     with a quarantined channel, unbind must still drain/release it).
   - Restricting blocking termination wait to driver unbind (when a channel is
     still active/quarantined) prevents `close()`, `hangup()`, and system
     `suspend()` from ever hanging the kernel in `msleep(100)`.

We verified this quarantine + `-EIO` reopen contract in
`Serial8250TxDmaV8_TerminateRetryHang_Fixed.cfg` (`AllowReopen = TRUE`,
`ReopenFallbackToPio = FALSE`), which passes all safety and liveness
properties (`NoUsersAtFree`, `BoundedTerminateRetries`,
`NoConcurrentFifoAccess`, `QuarantineImpliesXmitBlocked`, `ShutdownProgress`)
with 0 errors:
https://github.com/ismell/linux-8250-dma-tla

Thanks,
Raul
