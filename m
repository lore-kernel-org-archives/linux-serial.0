Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241301;
	b=4tTORvhZ8n5J8YJN0SVHP09ju3+0WmaZUNNrjCv6u/lcfcctGPQG8C0vk56gW138eesE
	 G33u48tUhKe9Pv9FXQIGofuNwFbocYtw03tZkUASfoBbwW8CgoR3JFueMAM0aMfJI3Tz9
	 EngKbatG2vDqzw0RlnmYzxJLbaw4RKLnPDxq1IMsaE6Mm3clxHHFCRSVf8BMLB6m9RL/v
	 Jec9mIGVA7P2pTuP+VqkfSXQDWLWttKms7r5ZhX7+46FFeUSfkrLVGGG56LW77cXcs32x
	 TSKAgJ5D//SWXPgwUj5Ppe//d6IyoDNWpvBpBNsvPuDSML5y53l7T9goX3jOx9t1KrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ATsD9Xu4uSt2b+wnr6JUehFjGprw+gnrB702q3SrL8o=;
	b=bECPiS3u0fKoG/JYbVpnS7C5pEIAFf/NF9uFp53cCWepc0k8sAM6H7tsJtM9U10JKJAQ
	 YhKo25FLtwuuXs9eV5x7v2sMEvSjsfrmo4UjNzyns6WbEmaGkQCApba8ARUzTa+aXVyEy
	 4iVI5TEne7n/Bu6HyliFYnCHDZ69qK/sE5F8mGsPrYOkt2nYV9S/YUbLduoInkNU/0XhN
	 elaKkZyR4PyaNJlTUFWckuEOaDc1ooXMXo7/FdZONeqXAtaNZPrTum2asvFaoQV4dtJ2i
	 Yj0zgK4Qn1XTR7zJ/exyBFNaBHP0mMUsQsVTX2XVWGML1tqp/hs2uZZJgizd772RUNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=QXsgHcTW;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CE606A326
	for <linux-serial@vger.kernel.org>; Mon,  9 Nov 2026 16:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E4CE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=QXsgHcTW
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7f84a55cc06so597445a34.2
        for <linux-serial@vger.kernel.org>; Mon, 09 Nov 2026 08:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794241299; x=1794846099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ATsD9Xu4uSt2b+wnr6JUehFjGprw+gnrB702q3SrL8o=;
        b=QXsgHcTWjVBgaQXzzvr2fmr0U6ledf/trAhz8TN+rD+PynRuRBaCESBi5Zy9TnEGGn
         do931ru0KCn9gvaipF4pvLq6soXCyUobCG+jwEnV/e8OwdpOFfbrZuwd0hEizf1EVkmX
         swi2fWk/fmryv+DS4eMIZkLWJR3BTNv3ifLR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794241299; x=1794846099;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ATsD9Xu4uSt2b+wnr6JUehFjGprw+gnrB702q3SrL8o=;
        b=NsaoFJOdjzSVdw7eR8xLGYSSIMp5/1kj2iSCD+yegK3hPbuqp6GVrkKFPwa23Rl1rG
         a3nfTvOyvs2WEa6qpKDAo5Zu2rTNWc26wEDoHitnod8R2uiTj7jKkt0U14pX0mjQJF2X
         M+v9uUs3XAj65fRbsARFLkM40w3VrnGE9mWHjlKy1UsKx4DVu6tTJLksxdHX/ukBq8Sz
         WT33kDZ4MMherE2ZPL7F50KCLxSwJZU0zP/VtxywNbbspP5Ryviq2uDF1mwElv5KVH/6
         aa8Yn2w0SHJEGVAYwdnz5n5PAAJ535duI5dQBGvI/CXzvGcl1eYo5jObK4kKmmlqaWNI
         OgQQ==
X-Forwarded-Encrypted: i=1; AL+hErHoQif9FhvO2KhGdpURL8pyNZ+bpjq/3RFW5QB1K4EeCyu7d2WjcEN/aZPc+25WXGEFZ+2pcwYwkJhdh2w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0v43cnunrTPBib6cRoqzYO9F/2KH74H+YxVmPf/WQq548A647
	A7R+4OsO6DtmE0EloJNIXU9gh9UqQtTqLXV9r6Q0eqCR9NsuiQIm+bFW60BGecvGgw==
X-Gm-Gg: AYBFou1NE3wkAdyUSaFMXcXCcW0K39S5bRvPooe5HK7wK18R0azfoFAuZgvcdR6wiPi
	1shm4x6FViQctCLuAbu4I275y8hSao075rYMTL6Gw9oOkcd8KhjTyqJLJYXufMtfs22Z9Uj4a/b
	H1PBMRSYGnB9qdTC/vCST5WpgNBIac6m4V/Japm3V6D0GsSuxm2zDsZUniYHbHrWyqMmO2J5E0O
	PRXBqAlSfErkQBonTplHD4NkYkAfX7tuRrYOrC0WO6uOIgf+2GZeJsk86d6mgCgy41XJNZAVh58
	+tcQjccejSAy2F4D2LRF9S/PyU5jq2qt/8qx1kWY54KVFE2EHnwwi3IDYhUKTXahjGGvA8ErGXR
	NjuzwUWGRhCY1diYRzaNxRr12tF+xAOzMzwZjr1AZ5MHVsUK4fWpF88STXNHFbD2tS1O3ga664h
	QExVdFvVak+MJKcLU5CyS2VRmmkoq/foBN/4bkPaO3H+jBp5RUNajN4smlPjG4dKzb2Q3pc1RMT
	Gf/xMY+lrK17nzAzUSKx9w9LToUlyEwVGTle8BARoVnAMZm5CT6omqIM1Z9W+QpjIAcqJx5yVgD
	Y+3rH27oicH7VyEFjr576boTblH9SXQ/XfIP+jiXZxbS8sqEFO+NGDyhxoYdT9vUYEtotB07/Ix
	4vFnc13USMyaupc4=
X-Received: by 2002:a05:6808:159f:b0:4d6:90f3:74a1 with SMTP id 5614622812f47-5683ccd209amr89819b6e.44.1794241299242;
        Mon, 09 Nov 2026 08:21:39 -0800 (PST)
Received: from rrangel.c.googlers.com.com (194.246.27.34.bc.googleusercontent.com. [34.27.246.194])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ade694062csm5510676fac.8.2026.11.09.08.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:21:38 -0800 (PST)
From: Raul E Rangel <rrangel@chromium.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Raul E Rangel <rrangel@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v10 7/8] serial: 8250: retire canceled RX DMA before reusing the receive buffer
Date: Mon,  9 Nov 2026 09:21:34 -0700
Message-ID: <20261109162135.906262-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261108-submit-serial-8250-dma-cancel-v1-v10-7-e6227ddb95b1@gmail.com>
References: <20261108-submit-serial-8250-dma-cancel-v1-v10-0-e6227ddb95b1@gmail.com> <20261108-submit-serial-8250-dma-cancel-v1-v10-7-e6227ddb95b1@gmail.com> <CADvTj4qXcOqS-wDrrN-x3sXUQr5BtFBeGzz_wqpW8WJ1DMPg+g@mail.gmail.com>
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

Thanks for dropping the unused rx_pause_wakeup lines in omap_8250_shutdown()
in v10. Following up here on your question from the v9 7/8 thread:

On Tue, Nov 03, 2026 at 11:05:42AM -0700, James Hilliard wrote:
> For pause-capable hardware, a recovery timeout does not have to prove
> that the failure is permanent. The concern is what happens after that
> timeout: the current recovery path discards the pending transfer and
> leaves RX on PIO until reopen.
>
> Is there a recovery approach that avoids an indefinite RX stall
> without turning a potentially temporary pause failure into loss of DMA
> for the rest of the open session?

Yes — the only reason the current recovery path disables RX DMA for the
rest of the open session is that serial8250_rx_dma_recover() sets
dma->rx_err = true and serial8250_rx_dma_flush_work() leaves it set
after dmaengine_terminate_sync(dma->rxchan) succeeds, which causes
serial8250_rx_dma() to return -EIO until reopen.

Notice that struct uart_8250_dma already distinguishes a normal
post-pause async termination from an unpaused transfer that needs
synchronous termination:
- When serial8250_rx_dma_try_flush() succeeds, it calls
  dmaengine_terminate_async(dma->rxchan), sets dma->rx_terminating =
  true, and clears dma->rx_running = 0.
- When serial8250_rx_dma_try_flush() fails, dma->rx_running remains 1.

So we can decouple bounded pause-timeout recovery from sticky PIO
fallback without adding any new struct fields:

1. In serial8250_rx_dma_flush_work(), if retry is still true when the
   1-second retry budget expires (or immediately if ret == -ENOSYS ||
   ret == -EOPNOTSUPP):
   - If ret == -ENOSYS || ret == -EOPNOTSUPP (e.g. Tegra186 where
     hw_support_pause is false), call serial8250_rx_dma_recover(p) so
     dma->rx_err = true permanently falls back to PIO for the session.
   - Otherwise (a pause timeout such as -EAGAIN, -EBUSY, or
     -ETIMEDOUT), set dma->rx_terminating = true while keeping
     dma->rx_running = 1, dma->rx_pause_pending = true, and
     dma->rx_err = false, and set retry = false.

2. Derive recover from persistent state under port->lock:

     recover = dma->rx_err || (dma->rx_running && dma->rx_terminating);
     fall_back_pio = dma->rx_err;

   And in serial8250_rx_dma_recovering() (8250.h):

     return up->dma &&
            (up->dma->rx_pause_pending ||
             ((up->dma->rx_err || up->dma->rx_running) &&
              up->dma->rx_terminating));

3. In if (recover), run ret = dmaengine_terminate_sync(dma->rxchan):
   - While dmaengine_terminate_sync() runs outside port->lock,
     serial8250_rx_dma_recovering() is true (keeping RX interrupts
     masked in UART_IER and skip_rx = true) and dma->rx_terminating is
     true (blocking dma_rx_complete() and serial8250_rx_dma()).
   - If dmaengine_terminate_sync(dma->rxchan) fails (ret != 0), latch
     dma->rx_err = true under port->lock and return early so RX stays
     masked and the buffer stays owned by DMA.
   - If dmaengine_terminate_sync(dma->rxchan) succeeds (ret == 0), the
     existing post-sync cleanup block clears rx_pause_pending,
     rx_terminating, and rx_running and restores UART_IER with
     dma->rx_err == false.

Because 8250 RX DMA is armed on-demand when rx_running == 0 and
!rx_err, any trigger-tail bytes remaining in the UART RX FIFO below the
RDI trigger level are drained via PIO on UART_IIR_RX_TIMEOUT, and the
next UART_IIR_RDI interrupt submits a fresh RX DMA descriptor — so RX
DMA remains active for the rest of the open session.

(Regarding the dw-axi-dmac driver mentioned on v10 7/8:
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c has separate provider
bugs where dw_axi_dma_interrupt() clears CH_INTSTATUS across all
channels including DWAXIDMAC_IRQ_SUSPENDED, dma_chan_pause() leaves
DMAC_CHSUSPREG and chan->is_paused = true set when returning -EAGAIN,
and dma_chan_terminate_all() only clears DMAC_CHEN without clearing
DMAC_CHSUSPREG or chan->is_paused. Those belong in a dw-axi-dmac
driver fix, whereas the non-sticky pause-timeout recovery above ensures
8250_dma.c never stalls RX indefinitely on a pause timeout while
keeping RX DMA enabled for subsequent transfers.)

Thanks,
Raul
