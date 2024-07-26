Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FFE2E631
	for <linux-serial@vger.kernel.org>; Fri, 26 Jul 2024 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722010955; cv=none; b=ppuQPNIJ2EPXZbIfmV22Ckkl6ZoeOtVM6w3nn3beG5ZJe3CHuMNyGLq/i1nVaCksk18MImr7kZJIIJnfZ+S0IJJJoeqpQiO7HdIu51rPG3jOMeOz/V1Xck9dUq9R8y11HLdmn5OkVSzaHWgw1bsiuYcrHrCNab7wKyah61FUfpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722010955; c=relaxed/simple;
	bh=EuHCtkeudbs9CJER2oJtd3dzpDp+7S0yaBpnRqqREnM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e1d+sQ696SVlRPHe8YflH0qvA+Rs5Pre4pSFhWP2mI9dL3vzxUq+YnK+IeUDu9gMuDv/w8AEHQmB7jSUWoDEhwKcIu2EHhRzhnd1bUBZQO16QolP2ynbGzisM37JnZdjCM8J3xAvPatoV35KCHRU09mflQYZ7Rv1zyOoxpNXMtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2DPECmk; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2DPECmk"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-80a2939265cso50343539f.3
        for <linux-serial@vger.kernel.org>; Fri, 26 Jul 2024 09:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722010952; x=1722615752; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XAWHxqYOiG7RZkLUkA9MyHwfUM+srqmdVVtSXfRT4T0=;
        b=S2DPECmkhMKHIScDVXelZLPBcGQFRxNLl7zapckbDmdYlk7jgCYQaVJe7MvM9zxjLA
         7xvfNtKegy9MLYK+TEYe9YAulFNszvL115edyETPDmj2vuS+EieBn8tVtLF5QvaKnAjD
         P/vzq3WGYsfwF3s/5pGPqf42CmgNibx2d8RfyieCiS18FvDJ9b6RfQHfAtCteCKLaPH6
         +NxC2LEdofOeeIO9mXJ/l5b3uH/8VQqunlYM2s7daSGGnntxwHNgHZAIryjIC80FuJq6
         FfbToRfNgeNfRjZOFNNtmEizWaN++wuVNcCHJQiowykaHuHP2kgtUUSh0TVJrYK1Nesh
         LQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722010952; x=1722615752;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XAWHxqYOiG7RZkLUkA9MyHwfUM+srqmdVVtSXfRT4T0=;
        b=datmTGWEvkEoH/sJaeYYJPtMGesIskvK3k9HhAoQup/w6P8byg0VTX5wgpLVVv54g0
         l9tOZ9Z6rBeKwY2bz+y+MxIyvdj9a269H7PhnLNMKmbg3IrEpBTlP7oEhVKmS1WPtCrW
         r9mWU5xHklAkFZ0T+WVAY3B6Yh6vPZF5zDtf64uqBfQJ8sJE44Cvd+BO0W75ZjqEoUsa
         7HRVt2JATyDIbztC12Tpkk13jx3gbt80qpC+ogRkDModhIRxCsUZbJ3eY1XhFUWJd9R/
         5ERf1ENX6sH2XdyFYVRMSE7ygTcnRxf9oSnut7+CFgcVDH3Fuh6NbZ1c+9etZem6+eMO
         x6Wg==
X-Gm-Message-State: AOJu0Yw/TfDS4iDwtqRazhZLzq/F2efPPgmfidEBFDMeI3ikhpUjdlQD
	o+rnT7RQ9tRKPErF2SJS6GBDNL3I9AzLmm47w/XCRwBlOZxSE4+U1QqsBg==
X-Google-Smtp-Source: AGHT+IFA7zy9zC9iI9PWCJGQDtCDyNp+i28DjwDny9EJdbTXf06phLSjKugBHZ9YJMR5ZDGY/5vAuA==
X-Received: by 2002:a05:6602:2dca:b0:814:65dd:8cdf with SMTP id ca18e2360f4ac-81f7e49ee2bmr679896939f.10.1722010952499;
        Fri, 26 Jul 2024 09:22:32 -0700 (PDT)
Received: from grante (24-152-157-105.fttp.usinternet.com. [24.152.157.105])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fa4158asm902569173.8.2024.07.26.09.22.31
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 09:22:32 -0700 (PDT)
Date: Fri, 26 Jul 2024 11:22:30 -0500
From: Grant Edwards <grant.b.edwards@gmail.com>
To: linux-serial@vger.kernel.org
Subject: Confused about UART stop_tx() start_tx() functions.
Message-ID: <ZqPNRjxL8WU_QAJ0@grante>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm confused about the start_tx() and stop_tx() UART driver methods.

According to include/linux/serial_core.h

 * @stop_tx: ``void ()(struct uart_port *port)``
 *
 *      Stop transmitting characters. This might be due to the CTS line
 *      becoming inactive or the tty layer indicating we want to stop
 *      transmission due to an %XOFF character.
 *
 *      The driver should stop transmitting characters as soon as possible.
 *
 *      [...]
 *
 * @start_tx: ``void ()(struct uart_port *port)``
 *
 *      Start transmitting characters.
 *
 *      [...]

But in many drivers, that's not what those two functions do. For
example in rp2.c:

static void rp2_uart_stop_tx(struct uart_port *port)
{
        rp2_rmw_clr(port_to_up(port), RP2_TXRX_CTL, RP2_TXRX_CTL_TXIRQ_m);
}

static void rp2_uart_stop_rx(struct uart_port *port)
{
        rp2_rmw_clr(port_to_up(port), RP2_TXRX_CTL, RP2_TXRX_CTL_RXIRQ_m);
}

Those two functions *do not start/stop transmitting characters*, they
enable/disable the transmit interrupt. After disabling the transmit
interrupt, the UART continues to transmit anything in the tx FIFO (up
to 256 bytes). That hardly qualifies as "stop transmitting characters
as soon as possible".

Starting and stopping the transmission of characters is controlled by
the RP2_TXRX_CTL_TX_EN_m bit in that same register. Clearing that bit
will "stop transmitting characters as soon as possible" (at the end of
the byte currently in the tx shift register).

While stop/start_tx() behavior in rp2.c is clearly wrong according to
serial_core.h, it does seems to be what is expected by the serial core
code:

#define __uart_port_tx(uport, ch, flags, tx_ready, put_char, tx_done,         \
                       for_test, for_post)                                    \
({                                                                            \
        struct uart_port *__port = (uport);                                   \
        struct tty_port *__tport = &__port->state->port;                      \
        unsigned int pending;                                                 \
                                                                              \
        for (; (for_test) && (tx_ready); (for_post), __port->icount.tx++) {   \
             [write bytes into tx FIFO]                                       \
        }                                                                     \
                                                                              \
        [...]                                                                 \
                                                                              \
        pending = kfifo_len(&__tport->xmit_fifo);                             \
        if (pending < WAKEUP_CHARS) {                                         \
                uart_write_wakeup(__port);                                    \
                                                                              \
                if (!((flags) & UART_TX_NOSTOP) && pending == 0)              \
                        __port->ops->stop_tx(__port);                         \
        }                                                                     \
                                                                              \
        pending;                                                              \
})


It wouldn't make sense to copy data from the tx buffer into the tx
FIFO and then immediately call stop_tx() because the tx buffer is now
empty. Disabling the tx interrupt because the tx buffer is empty does
make sense.

However, there seem to be plenty of other drivers where stop_tx() and
start_tx() do actually start and stop the transmission of characters
as defined by serial_core.h.

21285.c:

#define tx_disable(port)        disable(port, tx_enabled_bit)

static void serial21285_stop_tx(struct uart_port *port)
{
        if (is_tx_enabled(port)) {
                disable_irq_nosync(IRQ_CONTX);
                tx_disable(port);
        }
}

Can somebody please clarify exactly what start_tx() and stop_tx() are
supposed to do?

Thanks

--
Grant

