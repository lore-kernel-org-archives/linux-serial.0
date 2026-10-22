Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682426;
	b=IXRdxwQ+5Y7rOMt2GCPajWP2XCt271dNo8ESHE8mdtgLJTxjz6O1jmFMdCxaJA9StUcV
	 lo+37iU6Jdir2jCJCazTKUEY7xogYtryE57GOWHfKXODxr985oivp+s01JLOcVPnKoUhC
	 l/dAtHt/kw7fixdmkOskcTYTHM13lVEtj27hLrzqzKWVTzpcHBDHSG9nxuwelLj9rcT/n
	 pJAZ40Lvlrv5yQJPHL7Wm1vkuUd8Yl5tmkV/AZ8gz7xFo9qMyv1MAMPIohtBB/VUxdeGi
	 tkOePtBMdE5388tLpVQyGP5kF+adp1AWpVxnoOlXs67qkiz+UTKf9AXHJmoJOUF1A4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rRi45sW2+bKKrACqOGGFs9zVqBs9HnBDWjRGt4baDbY=;
	b=2pYvKHGcpGxl+D14knMxu8KPPQUzlDoIbCLruozZjKzhPbDw4HKOpstP3yOMSLyACQTG
	 qyvwvO9g3W8w98+dpJvccFGRHRGK4PHLGMXvsdA4u0BmbkkdAzwOJ+fZCvCT169sTpB8/
	 BMYjD1XR3xs0xlFReMC6vk3Enxk/QR0NQu5zt3eMYv9zl8w1eS8x3KFr5svW4bvmTpGsl
	 43KGtbXhlWQnjJI8EETHQN82GNj7CeB48nUCl3r29ziU7owhwYPmoSNDM9zhPnMwpJDhn
	 uqAkFnXeByrJ0rL7nXaNE6YHBxEV1heW//j/Gk+lSwbwSYPBYJ5Z0zprRs5V9MUn0Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cMb86KTk;
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA350606CC42
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 15:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA350606CC42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cMb86KTk
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6ddef424972so1173596eaf.3
        for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792682424; x=1793287224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rRi45sW2+bKKrACqOGGFs9zVqBs9HnBDWjRGt4baDbY=;
        b=cMb86KTk8lCTxsh5V69XHaUYwuaSrvX6oIvt8qinCGAkllJxt++dqbZuO4jBWGCynU
         KLRmapo+9/nZ2Y+fK1g5ifPZ5Hd4c9R+amxHoZLMUFH3aBvTUztK60dCHqcNU0V2bvto
         ljlvuZDuVYMdxevQ+GwIsX7abVbGs+oCgFh0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792682424; x=1793287224;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rRi45sW2+bKKrACqOGGFs9zVqBs9HnBDWjRGt4baDbY=;
        b=FOG5869t852W1l9TqtPKZmH+MsPnuzsrUJhcF93f5CFNRswIyxlqKsyI9Onuh3avBe
         ilWuRSlbo5fC20JonKy5xUIr8ky3JMfZoYZUmGW+q3CaBRZqdu5acIkTwvvqN6vDdoOh
         fdz1bAXys2AuFNJVj9TsKokcyhJlv0WwjQ9Tot6Pk0/cX3Bu76BckvLXE0BGxRScVi19
         tKw4dDYjOM5FWma7q3kA+i+B0Murx7PHqeNDvIyHWs+nODLlFsCEZOIE1TXsXaQJA2Rn
         Mk9ojrjtJPr3mNRgLuoF3rVnYc3vP/D8tBovgNn4SV4MaLx3LCVRSwgW9z11ah2eHt2j
         ft+g==
X-Forwarded-Encrypted: i=1; AKwUvBwwWBIrV9tEnF64J8Bp/pR9Lz/EWye9QKBSsYjfA9cED9Px8PXKzRaDiVmV2XKgsC+1i4pyLnvv7tQA0i4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLagSa9EyeTClBb9HSDPvKrbmIZf1jmgIbZMLYUraveNMqbMbaX
	tqd4NACGppWsxieqovVkNnDgJP4WO8kPWTr5/pOg4P+LDxj7lBL+x6swbf/ftakPiw==
X-Gm-Gg: AYBFou12/H+m5PVh2QM6bhka8VGgeYVVMaziMBhuGDl6l9FA4wwRSidQT7XSC4t35w/
	/S2qRjgsVgJ5hbsXeilSPsZQnBPtjuujQHr0EpggY++pM2uf7HgQon2DO3YSUzcbBr0vQLQ78dK
	2JwDoGGw/z515tw5cjDBhT9RxTPbkOZEVRCNZUtv72MOLolCVB97/k17I+RBW74UzyjIh6AFMXM
	xgRcsRKk7WtKkuC5zg1dLWJ0vcYH8lwwA1ni7Gy1/r46dwN6GVrjSvF7h+L7zcur7SSSZ0JnxiJ
	YOJr6YBBiRTlnDWXKM07qp00Cyw8FV+6LtwgCoWspBFMpfb4ai9vYFYezIzLxSDv7Atm4g7XrDE
	AwvzeLTNAgDp43H8EyueNdcrI2sKYNuu16i23sXnQJ3p4s3fXu5DjdzKB75xkDCWNXQEamvwREn
	YdQ6gVvi6SVeUvLYUHCvcFkjUlgtrFE96VtQuOBdqJjSJhCvJqK4bBW9sQPEa7+g604vxP18Gpn
	ed1VTJwadHiTWMQn8FLST5k4y75aXtguvaXrXR8H2Fw2cYOJzehc7SzfaeG/UQ1geXMZ6D6VYal
	ZEI8EWVmEUV9IRv1aPqwI8IIDbhk4IxmHZniHOlcihsU
X-Received: by 2002:a05:6820:1388:b0:6dc:16e5:d37c with SMTP id 006d021491bc7-70942b811f1mr3814505eaf.85.1792682424578;
        Thu, 22 Oct 2026 08:20:24 -0700 (PDT)
Received: from rrangel.c.googlers.com.com (202.168.136.34.bc.googleusercontent.com. [34.136.168.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84f774321d6sm4814a34.9.2026.10.22.08.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:20:23 -0700 (PDT)
From: Raul E Rangel <rrangel@chromium.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?UTF-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250: retire canceled RX DMA before reusing the receive buffer
Date: Thu, 22 Oct 2026 09:20:19 -0600
Message-ID: <20261022152019.1621716-2-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261021-submit-serial-8250-dma-cancel-v1-v1-2-efe2b89f2303@gmail.com>
References: <20261021-submit-serial-8250-dma-cancel-v1-v1-0-efe2b89f2303@gmail.com> <20261021-submit-serial-8250-dma-cancel-v1-v1-2-efe2b89f2303@gmail.com>
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

Beyond the two issues Sashiko already flagged (`dma->shutting_down` not
checked in `serial8250_rx_dma_flush()`, and `DMA_IN_PROGRESS` rejected after
`dmaengine_pause()` leading to an unhandled `UART_IIR_RX_TIMEOUT` interrupt
storm when `!serial8250_rx_dma_flush(up)` returns `false` in `handle_rx_dma()`),
there are a few additional issues here:

> -static void __dma_rx_complete(struct uart_8250_port *p)
> +static enum dma_status serial8250_rx_dma_complete(struct uart_8250_port *p)
>  {
...
> -	ret = tty_insert_flip_string(tty_port, dma->rx_buf, count);
> -	p->port.icount.rx += ret;
> -	p->port.icount.buf_overrun += count - ret;
> +	count = dma->rx_size - state.residue - dma->rx_pos;
> +
> +	if (tty_insert_flip_string(tty_port, dma->rx_buf + dma->rx_pos,
> +				   count) != count)
> +		p->port.icount.buf_overrun++;
> +	p->port.icount.rx += count;
> +	dma->rx_pos += count;

1. Accidental revert of prerequisite patch [2]:
   This chunk reverts your prerequisite patch ("serial: 8250: account for
   partial receive DMA delivery to TTY") in `8250_dma.c`, restoring the old
   `icount.rx += count` and `icount.buf_overrun++` accounting.

> +static void serial8250_rx_dma_flush_work(struct work_struct *work)
> +{
> +	struct uart_8250_dma *dma = container_of(work, struct uart_8250_dma,
> +						 rx_flush_work);
> +	struct uart_8250_port *p = dma->port;
> +
> +	dmaengine_synchronize(dma->rxchan);
> +
> +	guard(uart_port_lock_irqsave)(&p->port);
> +	dma->rx_terminating = false;
> +	dma->rx_running = 0;
> +	if (!dma->shutting_down && (p->ier & UART_IER_RDI) &&
> +	    (serial_lsr_in(p) & UART_LSR_DR))
> +		dma->rx_dma(p);
> +}

2. Spurious RX DMA restart during `dw8250_idle_enter()`:
   In `drivers/tty/serial/8250/8250_dw.c`, `dw8250_idle_enter()` sets
   `d->in_idle = 1` and writes `0` to hardware `UART_IER`, but intentionally
   leaves `UART_IER_RDI` set in `up->ier` so `dw8250_idle_exit()` can restore
   it. `dw8250_idle_enter()` then calls `serial8250_rx_dma_flush(up)`, which
   schedules `rx_flush_work`. If `rx_flush_work` runs while `d->in_idle == 1`
   (while the port is in loopback mode reconfiguring LCR/divisors),
   `p->ier & UART_IER_RDI` is still true and `rx_flush_work` will restart
   `dma->rx_dma(p)` in the middle of the idle sequence.

3. Missing runtime PM reference and `serial_lsr_in()` side effects in
   `serial8250_rx_dma_flush_work()`:
   - `serial8250_rx_dma_flush_work()` runs on `system_wq` and reads
     `serial_lsr_in(p)` / starts `dma->rx_dma(p)` without acquiring
     `serial8250_rpm_get(p)` / `serial8250_rpm_put(p)`. After the RX timeout
     ISR exits and drops its runtime PM reference, the port can autosuspend
     before `rx_flush_work` executes.
   - Reading `serial_lsr_in(p)` outside IRQ context clears any pending
     `UART_IIR_RLSI` in hardware and starts RX DMA before any saved LSR error
     bits (`OE`/`PE`/`FE`/`BI`) are processed with the corresponding byte in
     the FIFO.
   - If `UART_IIR_RDI` is enabled in hardware, why does `rx_flush_work` need
     to poll `UART_LSR_DR` and restart `rx_dma(p)` at all rather than letting
     the UART interrupt handler start RX DMA (or drain via PIO) when data is
     present?

4. `dmaengine_resume()` on error in `serial8250_rx_dma_flush()`:
   `serial8250_request_dma()` only checks `caps.cmd_pause` and
   `caps.cmd_terminate`, not `caps.cmd_resume` (e.g. `pl330` and
   `mtk-uart-apdma` implement pause to read residue before termination, but
   do not implement `.device_resume`). Also, on Renesas RZ/N1
   (`DW_UART_QUIRK_IS_DMA_FC`), `dw8250_handle_irq()` has already cleared
   `RZN1_UART_RDMACR = 0` before calling `serial8250_rx_dma_flush()`, so the
   error-recovery path leaves RX DMA disabled.

Thanks,
Raul
