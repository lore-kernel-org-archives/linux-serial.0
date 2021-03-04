Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B39C433E0
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 21:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 299C064FE1
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 21:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbhCDV2O (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 Mar 2021 16:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbhCDV14 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Mar 2021 16:27:56 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E4CC061761
        for <linux-serial@vger.kernel.org>; Thu,  4 Mar 2021 13:27:16 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id d9so30119844ybq.1
        for <linux-serial@vger.kernel.org>; Thu, 04 Mar 2021 13:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=roQDl0hplogokKqbtVYqGeoeBm5YnTXonLIwyu/ufS4=;
        b=fWm1QaGVa7QzdwUGj81yQYo31FKEqerEfgk0r+kSI6sH7ogbtoMRauuYX9+7VViUwM
         s9I2kKg0zxzLb7G1rAW6JLwUlPJmHcJMVSf0S23McCZojBau95bHx4m/Oos0UPRBibnt
         YQdyB/P8KI4n6/aHDKtKoGDzrNpgAftjYKtjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=roQDl0hplogokKqbtVYqGeoeBm5YnTXonLIwyu/ufS4=;
        b=ui9l1AQTQk5PvjOXxym9rT4rOOMlcMVJ0xvcE+T3olwJGFgm2FCdgv4PWHJEf0P7X7
         C4rsN1sOOk0EYXMdvDmKKBEd3tzglUGi4S3UG0ePcQWlwwOxobIvUBZhGRLhHG/xpJR4
         cXiCb6I3u5bsx3HjTKnhziKmFJ4GWd2NmThvAd61nPzlKEv53SJ84gSKGN2oUWlnCs1y
         Q9Uqn8vI3Ms3NJT4dWHOnyVyv4QRbBicx+UbmAXlsgt9lNAevK1SNA7uCKFwBK5fQ6hg
         HiH1MA3Pr/pNEBHH/zoc5QsxtjHA4LcvxexJXPC+I7iVEYkNVeIfIfbIGT2nvssK/U4n
         9obA==
X-Gm-Message-State: AOAM532r/yRSP+QPNDraXgF3ELl6O+zlp+0gOxtrDFpRoawNucFUC0MK
        dRid0Y3pHE5pyaT1OQoqlFWL+CdLJeUrsWEi//Xr
X-Google-Smtp-Source: ABdhPJxBePWQlVgodfjgeQCWwKdFqrydfK7M0xKSxYnbVhWwmopTDx2AcUwAN1RPB61OkfYiLQaREiy2e8bxF+saTBQ=
X-Received: by 2002:a25:dd43:: with SMTP id u64mr9714824ybg.96.1614893235229;
 Thu, 04 Mar 2021 13:27:15 -0800 (PST)
MIME-Version: 1.0
References: <20210219203708.49056-1-alcooperx@gmail.com> <20210219203708.49056-3-alcooperx@gmail.com>
 <YD/jkaozGobbvSmJ@kroah.com>
In-Reply-To: <YD/jkaozGobbvSmJ@kroah.com>
From:   Al Cooper <al.cooper@broadcom.com>
Date:   Thu, 4 Mar 2021 16:27:03 -0500
Message-ID: <CAGh=XAA0E8mXOGWbJ=TikQhg0vw7fb+sh-XL1O4URUBSoW6GLA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] serial: 8250: Add new 8250-core based Broadcom STB driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Al Cooper <alcooperx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ab50fb05bcbca151"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--000000000000ab50fb05bcbca151
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 3, 2021 at 2:29 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 19, 2021 at 03:37:08PM -0500, Al Cooper wrote:
> > Add a UART driver for the new Broadcom 8250 based STB UART. The new
> > UART is backward compatible with the standard 8250, but has some
> > additional features. The new features include a high accuracy baud
> > rate clock system and DMA support.
> >
> > The driver will use the new optional BAUD MUX clock to select the best
> > one of the four master clocks (81MHz, 108MHz, 64MHz and 48MHz) to feed
> > the baud rate selection logic for any requested baud rate.  This allows
> > for more accurate BAUD rates when high speed baud rates are selected.
> >
> > The driver will use the new UART DMA hardware if the UART DMA registers
> > are specified in Device Tree "reg" property.
> >
> > The driver also sets the UPSTAT_AUTOCTS flag when hardware flow control
> > is enabled. This flag is needed for UARTs that don't assert a CTS
> > changed interrupt when CTS changes and AFE (Hardware Flow Control) is
> > enabled.
> >
> > The driver also contains a workaround for a bug in the Synopsis 8250
> > core. The problem is that at high baud rates, the RX partial FIFO
> > timeout interrupt can occur but there is no RX data (DR not set in
> > the LSR register). In this case the driver will not read the Receive
> > Buffer Register, which clears the interrupt, and the system will get
> > continuous UART interrupts until the next RX character arrives. The
> > fix originally suggested by Synopsis was to read the Receive Buffer
> > Register and discard the character when the DR bit in the LSR was
> > not set, to clear the interrupt. The problem was that occasionally
> > a character would arrive just after the DR bit check and a valid
> > character would be discarded. The fix that was added will clear
> > receive interrupts to stop the interrupt, deassert RTS to insure
> > that no new data can arrive, wait for 1.5 character times for the
> > sender to react to RTS and then check for data and either do a dummy
> > read or a valid read. Sysfs error counters were also added and were
> > used to help create test software that would cause the error condition.
> > The counters can be found at:
> > /sys/devices/platform/rdb/*serial/rx_bad_timeout_late_char
> > /sys/devices/platform/rdb/*serial/rx_bad_timeout_no_char
>
> No, serial drivers do NOT get custom sysfs attributes, that's crazy.
>
> And you didn't even document them in Documentation/ABI/?  Even if they
> were ok this patch can't be accepted for that reason.
>
> Why do you need custom sysfs files?  Who is going to use them?  Why
> doesn't the existing tty ioctl structures handle these, I can't imagine
> that something "new" has been added to a 8250-based chip, right?
>

Bad choice, I'll move these to debugfs.


> >
> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> > ---
> >  MAINTAINERS                            |    8 +
> >  drivers/tty/serial/8250/8250_bcm7271.c | 1100 ++++++++++++++++++++++++
> >  drivers/tty/serial/8250/Kconfig        |   10 +
> >  drivers/tty/serial/8250/Makefile       |    1 +
> >  drivers/tty/serial/8250/bcm7271_uart.h |  158 ++++
>
> Why a .h file for a single .c file?  Just merge them together into one
> file please.

Okay.

>
> Minor comments below:
>
> > +#define TX_BUF_SIZE 4096
> > +#define RX_BUF_SIZE 4096
> > +#define RX_BUFS_COUNT 2
> > +#define KHZ    1000
> > +#define MHZ(x) ((x) * KHZ * KHZ)
>
> KHZ and MHZ are not already defined in the kernel somewhere?

I couldn't find these defined anywhere for global use. Anywhere
they're used in kernel code they're defined locally.

>
> > +struct brcmuart_priv {
> > +     int             line;
> > +     struct clk      *baud_mux_clk;
> > +     unsigned long   default_mux_rate;
> > +     u32             real_rates[ARRAY_SIZE(brcmstb_rate_table)];
> > +     const u32       *rate_table;
> > +     ktime_t         char_wait;
> > +     struct uart_port *up;
> > +     struct hrtimer  hrt;
> > +     u32             flags;
> > +#define BRCMUART_PRIV_FLAGS_SHUTDOWN 1
>
> Enumerated type for your flag?

Yes.

>
> > +     bool            dma_enabled;
> > +     struct uart_8250_dma dma;
> > +     void __iomem    *regs[REGS_MAX];
> > +     dma_addr_t      rx_addr;
> > +     void            *rx_bufs;
> > +     size_t          rx_size;
> > +     int             rx_next_buf;
> > +     dma_addr_t      tx_addr;
> > +     void            *tx_buf;
> > +     size_t          tx_size;
> > +     bool            tx_running;
> > +     bool            rx_running;
> > +
> > +     /* sysfs attributes */
> > +     u64             dma_rx_partial_buf;
> > +     u64             dma_rx_full_buf;
> > +     u32             rx_bad_timeout_late_char;
> > +     u32             rx_bad_timeout_no_char;
> > +     u32             rx_missing_close_timeout;
>
> Why not just make them debugfs entries if you really want to have
> something to poke around in the driver?

Yes, that's a much more suitable solution.

>
> > +/*
> > + * NOTE: printk's in this routine will hang the system if this is
> > + * the console tty
>
> Nice, but then you go and do:
>
> > + */
> > +static int brcmuart_tx_dma(struct uart_8250_port *p)
> > +{
> > +     struct brcmuart_priv *priv = p->port.private_data;
> > +     struct circ_buf *xmit = &p->port.state->xmit;
> > +     struct device *dev = p->port.dev;
> > +     u32 tx_size;
> > +
> > +     if (uart_tx_stopped(&p->port) || priv->tx_running ||
> > +             uart_circ_empty(xmit)) {
> > +             return 0;
> > +     }
> > +     tx_size = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
> > +
> > +     dev_dbg(dev, "%s: size: %d\n", __func__, tx_size);
>
> A printk().  Are you trying to lock up systems?

This worked during bringup because the DMA was never enabled on the
console UART. I'll remove all DMA related dev_dbg messages.

>
> :(
>
> > +static void brcmuart_rx_buf_done_isr(struct uart_port *up, int index)
> > +{
> > +     struct brcmuart_priv *priv = up->private_data;
> > +     struct tty_port *tty_port = &up->state->port;
> > +     u32 status;
> > +     u32 length;
> > +     u32 copied;
> > +
> > +     /* Make sure we're still in sync with the hardware */
> > +     status = udma_readl(priv, REGS_DMA_RX, UDMA_RX_BUFx_STATUS(index));
> > +     length = udma_readl(priv, REGS_DMA_RX, UDMA_RX_BUFx_DATA_LEN(index));
> > +
> > +     if ((status & UDMA_RX_BUFX_STATUS_DATA_RDY) == 0) {
> > +             dev_err(up->dev, "RX done interrupt but DATA_RDY not found\n");
> > +             return;
> > +     }
> > +     if (status & (UDMA_RX_BUFX_STATUS_OVERRUN_ERR |
> > +                   UDMA_RX_BUFX_STATUS_FRAME_ERR |
> > +                   UDMA_RX_BUFX_STATUS_PARITY_ERR)) {
> > +             if (status & UDMA_RX_BUFX_STATUS_OVERRUN_ERR) {
> > +                     up->icount.overrun++;
> > +                     dev_warn(up->dev, "RX OVERRUN Error\n");
> > +             }
> > +             if (status & UDMA_RX_BUFX_STATUS_FRAME_ERR) {
> > +                     up->icount.frame++;
> > +                     dev_warn(up->dev, "RX FRAMING Error\n");
> > +             }
> > +             if (status & UDMA_RX_BUFX_STATUS_PARITY_ERR) {
> > +                     up->icount.parity++;
> > +                     dev_warn(up->dev, "RX PARITY Error\n");
> > +             }
> > +     }
> > +     copied = (u32)tty_insert_flip_string(
> > +             tty_port,
> > +             priv->rx_bufs + (index * RX_BUF_SIZE),
> > +             length);
> > +     if (copied != length) {
> > +             dev_warn(up->dev, "Flip buffer overrun of %d bytes\n",
> > +                      length - copied);
>
> What can userspace do about this warning?

User space (or the user) can try to throttle the source of the tty
receive data. Many other tty drivers print a dev_err or dev_warn
message, a few drivers increment the overrun count.

>
> > +             up->icount.overrun += length - copied;
> > +     }
> > +     up->icount.rx += length;
> > +     if (status & UDMA_RX_BUFX_STATUS_CLOSE_EXPIRED)
> > +             priv->dma_rx_partial_buf++;
> > +     else if (length != RX_BUF_SIZE)
> > +             /*
> > +              * This is a bug in the controller that doesn't cause
> > +              * any problems but will be fixed in the future.
> > +              */
> > +             priv->rx_missing_close_timeout++;
> > +     else
> > +             priv->dma_rx_full_buf++;
> > +
> > +     tty_flip_buffer_push(tty_port);
> > +
> > +     dev_dbg(up->dev, "RX: %d chars, chan %d, stat: 0x%x, 0x%x\n",
> > +             length, index, status,
> > +             (unsigned int)((unsigned char *)priv->rx_bufs)[index *
> > +                                                            RX_BUF_SIZE]);
> > +}
> > +
> > +static void brcmuart_rx_isr(struct uart_port *up, u32 rx_isr)
> > +{
> > +     struct brcmuart_priv *priv = up->private_data;
> > +     struct device *dev = up->dev;
> > +     u32 rx_done_isr;
> > +     u32 check_isr;
> > +
> > +     rx_done_isr = (rx_isr & UDMA_INTR_RX_READY_MASK);
> > +     dev_dbg(dev, "Got RX interrupt: 0x%x, next: %d\n", rx_done_isr,
> > +             priv->rx_next_buf);
> > +     while (rx_done_isr) {
> > +             check_isr = UDMA_INTR_RX_READY_BUF0 << priv->rx_next_buf;
> > +             if (check_isr & rx_done_isr) {
> > +                     brcmuart_rx_buf_done_isr(up, priv->rx_next_buf);
> > +             } else {
> > +                     dev_err(dev,
> > +                             "RX buffer ready out of sequence, restarting RX DMA\n");
> > +                     start_rx_dma(up_to_u8250p(up));
> > +                     break;
> > +             }
> > +             if (rx_isr & UDMA_RX_ERR_INTERRUPTS) {
> > +                     if (rx_isr & UDMA_INTR_RX_ERROR)
> > +                             dev_dbg(dev, "RX FRAME/OVERRUN/PARITY Error\n");
> > +                     if (rx_isr & UDMA_INTR_RX_TIMEOUT)
> > +                             dev_err(dev, "RX TIMEOUT Error\n");
> > +                     if (rx_isr & UDMA_INTR_RX_ABORT)
> > +                             dev_dbg(dev, "RX ABORT\n");
> > +                     priv->rx_running = false;
> > +             }
> > +             /* If not ABORT, re-enable RX buffer */
> > +             if (!(rx_isr & UDMA_INTR_RX_ABORT))
> > +                     udma_unset(priv, REGS_DMA_RX,
> > +                                UDMA_RX_BUFx_STATUS(priv->rx_next_buf),
> > +                                UDMA_RX_BUFX_STATUS_DATA_RDY);
> > +             dev_dbg(dev, "RX interrupt DONE for channel %d\n",
> > +                     priv->rx_next_buf);
> > +             rx_done_isr &= ~check_isr;
> > +             priv->rx_next_buf++;
> > +             if (priv->rx_next_buf == RX_BUFS_COUNT)
> > +                     priv->rx_next_buf = 0;
> > +     }
> > +}
> > +
> > +static void brcmuart_tx_isr(struct uart_port *up, u32 isr)
> > +{
> > +     struct brcmuart_priv *priv = up->private_data;
> > +     struct device *dev = up->dev;
> > +     struct uart_8250_port *port_8250 = up_to_u8250p(up);
> > +     struct circ_buf *xmit = &port_8250->port.state->xmit;
> > +     int length;
> > +
> > +     length = udma_readl(priv, REGS_DMA_TX, UDMA_TX_TRANSFER_TOTAL);
> > +     dev_dbg(dev, "Got TX interrupt, length %d\n", length);
> > +
> > +     if (isr & UDMA_INTR_TX_ABORT) {
> > +             if (priv->tx_running)
> > +                     dev_err(dev, "Unexpected TX_ABORT interrupt\n");
> > +             return;
> > +     }
> > +     priv->tx_running = false;
> > +     if (!uart_circ_empty(xmit) && !uart_tx_stopped(up))
> > +             brcmuart_tx_dma(port_8250);
> > +}
> > +
> > +static irqreturn_t brcmuart_isr(int irq, void *dev_id)
> > +{
> > +     struct uart_port *up = dev_id;
> > +     struct device *dev = up->dev;
> > +     struct brcmuart_priv *priv = up->private_data;
> > +     unsigned long flags;
> > +     u32 interrupts;
> > +     u32 rval;
> > +     u32 tval;
> > +
> > +     interrupts = udma_readl(priv, REGS_DMA_ISR, UDMA_INTR_STATUS);
> > +     dev_dbg(up->dev, "ISR: interrupts: 0x%x\n", interrupts);
> > +     if (interrupts == 0)
> > +             return IRQ_NONE;
> > +
> > +     spin_lock_irqsave(&up->lock, flags);
> > +
> > +     /* Clear all interrupts */
> > +     udma_writel(priv, REGS_DMA_ISR, UDMA_INTR_CLEAR, interrupts);
> > +
> > +     rval = UDMA_IS_RX_INTERRUPT(interrupts);
> > +     if (rval)
> > +             brcmuart_rx_isr(up, rval);
> > +     tval = UDMA_IS_TX_INTERRUPT(interrupts);
> > +     if (tval)
> > +             brcmuart_tx_isr(up, tval);
> > +     if ((rval | tval) == 0)
> > +             dev_warn(dev, "Spurious interrupt: 0x%x\n", interrupts);
> > +
> > +     spin_unlock_irqrestore(&up->lock, flags);
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int brcmuart_startup(struct uart_port *port)
> > +{
> > +     int res;
> > +     struct uart_8250_port *up = up_to_u8250p(port);
> > +     struct brcmuart_priv *priv = up->port.private_data;
> > +     struct device *dev = port->dev;
> > +
> > +     dev_dbg(dev, "%s\n", __func__);
> > +
> > +     priv->flags &= ~BRCMUART_PRIV_FLAGS_SHUTDOWN;
> > +
> > +     /*
> > +      * prevent serial8250_do_startup() from allocating non-existent
> > +      * DMA resources
> > +      */
> > +     up->dma = NULL;
> > +
> > +     res = serial8250_do_startup(port);
> > +     if (!priv->dma_enabled)
> > +             return res;
> > +     /*
> > +      * Disable the Receive Data Interrupt because the DMA engine
> > +      * will handle this.
> > +      */
> > +     up->ier &= ~UART_IER_RDI;
> > +     serial_port_out(port, UART_IER, up->ier);
> > +
> > +     priv->tx_running = false;
> > +     priv->dma.rx_dma = NULL;
> > +     priv->dma.tx_dma = brcmuart_tx_dma;
> > +     up->dma = &priv->dma;
> > +
> > +     brcmuart_init_dma_hardware(priv);
> > +     start_rx_dma(up);
> > +     return res;
> > +}
> > +
> > +static void brcmuart_shutdown(struct uart_port *port)
> > +{
> > +     struct uart_8250_port *up = up_to_u8250p(port);
> > +     struct brcmuart_priv *priv = up->port.private_data;
> > +     struct device *dev = port->dev;
> > +     unsigned long flags;
> > +
> > +     dev_dbg(dev, "%s\n", __func__);
>
> ftrace is your friend, use it instead of lines like this.

These were used in early stage debugging, I'll remove them.

>
> Also, dev_dbg() already gives you __func__ for free, why add it again?
>
>
> > +
> > +     spin_lock_irqsave(&port->lock, flags);
> > +     priv->flags |= BRCMUART_PRIV_FLAGS_SHUTDOWN;
> > +     if (priv->dma_enabled) {
> > +             stop_rx_dma(up);
> > +             stop_tx_dma(up);
> > +             /* disable all interrupts */
> > +             udma_writel(priv, REGS_DMA_ISR, UDMA_INTR_MASK_SET,
> > +                     UDMA_RX_INTERRUPTS | UDMA_TX_INTERRUPTS);
> > +     }
> > +
> > +     /*
> > +      * prevent serial8250_do_shutdown() from trying to free
> > +      * DMA resources that we never alloc'd for this driver.
> > +      */
> > +     up->dma = NULL;
> > +
> > +     spin_unlock_irqrestore(&port->lock, flags);
> > +     serial8250_do_shutdown(port);
> > +}
> > +
> > +/*
> > + * Not all clocks run at the exact specified rate, so set each requested
> > + * rate and then get the actual rate.
> > + */
> > +static void init_real_clk_rates(struct device *dev, struct brcmuart_priv *priv)
> > +{
> > +     int x;
> > +     int rc;
> > +
> > +     priv->default_mux_rate = clk_get_rate(priv->baud_mux_clk);
> > +     dev_dbg(dev, "Default BAUD MUX Clock rate is %lu\n",
> > +             priv->default_mux_rate);
> > +
> > +     for (x = 0; x < ARRAY_SIZE(priv->real_rates); x++) {
> > +             if (priv->rate_table[x] == 0) {
> > +                     priv->real_rates[x] = 0;
> > +                     continue;
> > +             }
> > +             rc = clk_set_rate(priv->baud_mux_clk, priv->rate_table[x]);
> > +             if (rc) {
> > +                     dev_err(dev, "Error selecting BAUD MUX clock for %u\n",
> > +                             priv->rate_table[x]);
> > +                     priv->real_rates[x] = priv->rate_table[x];
> > +             } else {
> > +                     priv->real_rates[x] = clk_get_rate(priv->baud_mux_clk);
> > +             }
> > +     }
> > +     clk_set_rate(priv->baud_mux_clk, priv->default_mux_rate);
> > +}
> > +
> > +static void set_clock_mux(struct uart_port *up, struct brcmuart_priv *priv,
> > +                     u32 baud)
> > +{
> > +     u32 percent;
> > +     u32 best_percent = UINT_MAX;
> > +     u32 quot;
> > +     u32 best_quot = 1;
> > +     u32 rate;
> > +     int best_index = -1;
> > +     u64 hires_rate;
> > +     u64 hires_baud;
> > +     u64 hires_err;
> > +     int rc;
> > +     int i;
> > +     int real_baud;
> > +
> > +     /* If the Baud Mux Clock was not specified, just return */
> > +     if (priv->baud_mux_clk == NULL)
> > +             return;
> > +
> > +     /* Find the closest match for specified baud */
> > +     for (i = 0; i < ARRAY_SIZE(priv->real_rates); i++) {
> > +             if (priv->real_rates[i] == 0)
> > +                     continue;
> > +             rate = priv->real_rates[i] / 16;
> > +             quot = DIV_ROUND_CLOSEST(rate, baud);
> > +             if (!quot)
> > +                     continue;
> > +
> > +             /* increase resolution to get xx.xx percent */
> > +             hires_rate = (u64)rate * 10000;
> > +             hires_baud = (u64)baud * 10000;
> > +
> > +             hires_err = div_u64(hires_rate, (u64)quot);
> > +
> > +             /* get the delta */
> > +             if (hires_err > hires_baud)
> > +                     hires_err = (hires_err - hires_baud);
> > +             else
> > +                     hires_err = (hires_baud - hires_err);
> > +
> > +             percent = (unsigned long)DIV_ROUND_CLOSEST_ULL(hires_err, baud);
> > +             dev_dbg(up->dev,
> > +                     "Baud rate: %u, MUX Clk: %u, Error: %u.%u%%\n",
> > +                     baud, priv->real_rates[i], percent / 100,
> > +                     percent % 100);
> > +             if (percent < best_percent) {
> > +                     best_percent = percent;
> > +                     best_index = i;
> > +                     best_quot = quot;
> > +             }
> > +     }
> > +     if (best_index == -1) {
> > +             dev_err(up->dev, "Error, %d BAUD rate is too fast.\n", baud);
> > +             return;
> > +     }
> > +     rate = priv->real_rates[best_index];
> > +     rc = clk_set_rate(priv->baud_mux_clk, rate);
> > +     if (rc)
> > +             dev_err(up->dev, "Error selecting BAUD MUX clock\n");
> > +
> > +     /* Error over 3 percent will cause data errors */
> > +     if (best_percent > 300)
> > +             dev_err(up->dev, "Error, baud: %d has %u.%u%% error\n",
> > +                     baud, percent / 100, percent % 100);
> > +
> > +     real_baud = rate / 16 / best_quot;
> > +     dev_dbg(up->dev, "Selecting BAUD MUX rate: %u\n", rate);
> > +     dev_dbg(up->dev, "Requested baud: %u, Actual baud: %u\n",
> > +             baud, real_baud);
> > +
> > +     /* calc nanoseconds for 1.5 characters time at the given baud rate */
> > +     i = NSEC_PER_SEC / real_baud / 10;
> > +     i += (i / 2);
> > +     priv->char_wait = ns_to_ktime(i);
> > +
> > +     up->uartclk = rate;
> > +}
> > +
> > +static void brcmstb_set_termios(struct uart_port *up,
> > +                             struct ktermios *termios,
> > +                             struct ktermios *old)
> > +{
> > +     struct uart_8250_port *p8250 = up_to_u8250p(up);
> > +     struct brcmuart_priv *priv = up->private_data;
> > +
> > +     if (priv->dma_enabled)
> > +             stop_rx_dma(p8250);
> > +     set_clock_mux(up, priv, tty_termios_baud_rate(termios));
> > +     serial8250_do_set_termios(up, termios, old);
> > +     if (p8250->mcr & UART_MCR_AFE)
> > +             p8250->port.status |= UPSTAT_AUTOCTS;
> > +     if (priv->dma_enabled)
> > +             start_rx_dma(p8250);
> > +}
> > +
> > +static int brcmuart_handle_irq(struct uart_port *p)
> > +{
> > +     unsigned int iir = serial_port_in(p, UART_IIR);
> > +     struct brcmuart_priv *priv = p->private_data;
> > +     struct uart_8250_port *up = up_to_u8250p(p);
> > +     unsigned int status;
> > +     unsigned long flags;
> > +     unsigned int ier;
> > +     unsigned int mcr;
> > +     int handled = 0;
> > +
> > +     /*
> > +      * There's a bug in some 8250 cores where we get a timeout
> > +      * interrupt but there is no data ready.
> > +      */
> > +     if (((iir & UART_IIR_ID) == UART_IIR_RX_TIMEOUT) &&
> > +         ((priv->flags & BRCMUART_PRIV_FLAGS_SHUTDOWN) == 0)) {
> > +             spin_lock_irqsave(&p->lock, flags);
> > +             status = serial_port_in(p, UART_LSR);
> > +             if ((status & UART_LSR_DR) == 0) {
> > +
> > +                     ier = serial_port_in(p, UART_IER);
> > +                     /*
> > +                      * if Receive Data Interrupt is enabled and
> > +                      * we're uing hardware flow control, deassert
> > +                      * RTS and wait for any chars in the pipline to
> > +                      * arrive and then check for DR again.
> > +                      */
> > +                     if ((ier & UART_IER_RDI) && (up->mcr & UART_MCR_AFE)) {
> > +                             ier &= ~(UART_IER_RLSI | UART_IER_RDI);
> > +                             serial_port_out(p, UART_IER, ier);
> > +                             mcr = serial_port_in(p, UART_MCR);
> > +                             mcr &= ~UART_MCR_RTS;
> > +                             serial_port_out(p, UART_MCR, mcr);
> > +                             hrtimer_start(&priv->hrt, priv->char_wait,
> > +                                           HRTIMER_MODE_REL);
> > +                     } else {
> > +                             serial_port_in(p, UART_RX);
> > +                     }
> > +
> > +                     handled = 1;
> > +             }
> > +             spin_unlock_irqrestore(&p->lock, flags);
> > +             if (handled)
> > +                     return 1;
> > +     }
> > +     return serial8250_handle_irq(p, iir);
> > +}
> > +
> > +static enum hrtimer_restart brcmuart_hrtimer_func(struct hrtimer *t)
> > +{
> > +     struct brcmuart_priv *priv = container_of(t, struct brcmuart_priv, hrt);
> > +     struct uart_port *p = priv->up;
> > +     struct uart_8250_port *up = up_to_u8250p(p);
> > +     unsigned int status;
> > +     unsigned long flags;
> > +
> > +     if (priv->flags & BRCMUART_PRIV_FLAGS_SHUTDOWN)
> > +             return HRTIMER_NORESTART;
> > +
> > +     spin_lock_irqsave(&p->lock, flags);
> > +     status = serial_port_in(p, UART_LSR);
> > +
> > +     /*
> > +      * If a character did not arrive after the timeout, clear the false
> > +      * receive timeout.
> > +      */
> > +     if ((status & UART_LSR_DR) == 0) {
> > +             serial_port_in(p, UART_RX);
> > +             priv->rx_bad_timeout_no_char++;
> > +     } else {
> > +             priv->rx_bad_timeout_late_char++;
> > +     }
> > +
> > +     /* re-enable receive unless upper layer has disabled it */
> > +     if ((up->ier & (UART_IER_RLSI | UART_IER_RDI)) ==
> > +         (UART_IER_RLSI | UART_IER_RDI)) {
> > +             status = serial_port_in(p, UART_IER);
> > +             status |= (UART_IER_RLSI | UART_IER_RDI);
> > +             serial_port_out(p, UART_IER, status);
> > +             status = serial_port_in(p, UART_MCR);
> > +             status |= UART_MCR_RTS;
> > +             serial_port_out(p, UART_MCR, status);
> > +     }
> > +     spin_unlock_irqrestore(&p->lock, flags);
> > +     return HRTIMER_NORESTART;
> > +}
> > +
> > +static ssize_t rx_bad_timeout_no_char_show(struct device *dev,
> > +                                        struct device_attribute *attr,
> > +                                        char *buf)
> > +{
> > +     struct brcmuart_priv *priv = dev_get_drvdata(dev);
> > +
> > +     return sprintf(buf, "%d\n", priv->rx_bad_timeout_no_char);
>
> In the future, please use sysfs_emit() for new sysfs files.  Not that
> these are acceptable, but for your other kernel work :)
>
> > +static struct attribute *brcmuart_dev_attrs[] = {
> > +     &dev_attr_rx_bad_timeout_no_char.attr,
> > +     &dev_attr_rx_bad_timeout_late_char.attr,
> > +     &dev_attr_rx_missing_close_timeout.attr,
> > +     &dev_attr_dma_rx_partial_buf.attr,
> > +     &dev_attr_dma_rx_full_buf.attr,
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group brcmuart_dev_attr_group = {
> > +     .attrs = brcmuart_dev_attrs,
> > +};
>
> ATTRIBUTE_GROUPS()?
>
> > +
> > +static const struct of_device_id brcmuart_dt_ids[] = {
> > +     {
> > +             .compatible = "brcm,bcm7278-uart",
> > +             .data = brcmstb_rate_table_7278,
> > +     },
> > +     {
> > +             .compatible = "brcm,bcm7271-uart",
> > +             .data = brcmstb_rate_table,
> > +     },
> > +     {},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, brcmuart_dt_ids);
> > +
> > +static void brcmuart_free_bufs(struct device *dev, struct brcmuart_priv *priv)
> > +{
> > +     if (priv->rx_bufs)
> > +             dma_free_coherent(dev, priv->rx_size, priv->rx_bufs,
> > +                               priv->rx_addr);
> > +     if (priv->tx_buf)
> > +             dma_free_coherent(dev, priv->tx_size, priv->tx_buf,
> > +                               priv->tx_addr);
> > +}
> > +
> > +static void brcmuart_throttle(struct uart_port *port)
> > +{
> > +     struct brcmuart_priv *priv = port->private_data;
> > +
> > +     dev_dbg(port->dev, "%s\n", __func__);
> > +
> > +     udma_writel(priv, REGS_DMA_ISR, UDMA_INTR_MASK_SET, UDMA_RX_INTERRUPTS);
> > +}
> > +
> > +static void brcmuart_unthrottle(struct uart_port *port)
> > +{
> > +     struct brcmuart_priv *priv = port->private_data;
> > +
> > +     dev_dbg(port->dev, "%s\n", __func__);
> > +
> > +     udma_writel(priv, REGS_DMA_ISR, UDMA_INTR_MASK_CLEAR,
> > +                 UDMA_RX_INTERRUPTS);
> > +}
> > +
> > +static int brcmuart_probe(struct platform_device *pdev)
> > +{
> > +     struct resource *regs;
> > +     struct device_node *np = pdev->dev.of_node;
> > +     const struct of_device_id *of_id = NULL;
> > +     struct uart_8250_port *new_port;
> > +     struct device *dev = &pdev->dev;
> > +     struct brcmuart_priv *priv;
> > +     struct clk *baud_mux_clk;
> > +     struct uart_8250_port up;
> > +     struct resource *irq;
> > +     void __iomem *membase = 0;
> > +     resource_size_t mapbase = 0;
> > +     u32 clk_rate = 0;
> > +     int ret;
> > +     int x;
> > +     int dma_irq;
> > +     static const char * const reg_names[REGS_MAX] = {
> > +             "uart", "dma_rx", "dma_tx", "dma_intr2", "dma_arb"
> > +     };
> > +
> > +     irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > +     if (!irq) {
> > +             dev_err(dev, "missing irq\n");
> > +             return -EINVAL;
> > +     }
> > +     priv = devm_kzalloc(dev, sizeof(struct brcmuart_priv),
> > +                     GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     of_id = of_match_node(brcmuart_dt_ids, np);
> > +     if (!of_id || !of_id->data)
> > +             priv->rate_table = brcmstb_rate_table;
> > +     else
> > +             priv->rate_table = of_id->data;
> > +
> > +     for (x = 0; x < REGS_MAX; x++) {
> > +             regs = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > +                                             reg_names[x]);
> > +             if (!regs)
> > +                     break;
> > +             priv->regs[x] = devm_ioremap(dev, regs->start,
> > +                                          resource_size(regs));
> > +             if (IS_ERR(priv->regs[x]))
> > +                     return PTR_ERR(priv->regs[x]);
> > +             if (x == REGS_8250) {
> > +                     mapbase = regs->start;
> > +                     membase = priv->regs[x];
> > +             }
> > +     }
> > +
> > +     /* We should have just the uart base registers or all the registers */
> > +     if (x != 1 && x != REGS_MAX) {
> > +             dev_warn(dev, "%s registers not specified\n", reg_names[x]);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* if the DMA registers were specified, try to enable DMA */
> > +     if (x > REGS_DMA_RX) {
> > +             if (brcmuart_arbitration(priv, 1) == 0) {
> > +                     u32 txrev = 0;
> > +                     u32 rxrev = 0;
> > +
> > +                     txrev = udma_readl(priv, REGS_DMA_RX, UDMA_RX_REVISION);
> > +                     rxrev = udma_readl(priv, REGS_DMA_TX, UDMA_TX_REVISION);
> > +                     if ((txrev >= UDMA_TX_REVISION_REQUIRED) &&
> > +                             (rxrev >= UDMA_RX_REVISION_REQUIRED)) {
> > +
> > +                             /* Enable the use of the DMA hardware */
> > +                             priv->dma_enabled = true;
> > +                     } else {
> > +                             brcmuart_arbitration(priv, 0);
> > +                             dev_err(dev,
> > +                                     "Unsupported DMA Hardware Revision\n");
> > +                     }
> > +             } else {
> > +                     dev_err(dev,
> > +                             "Timeout arbitrating for UART DMA hardware\n");
> > +             }
> > +     }
> > +
> > +     of_property_read_u32(np, "clock-frequency", &clk_rate);
> > +
> > +     /* See if a Baud clock has been specified */
> > +     baud_mux_clk = of_clk_get_by_name(np, "sw_baud");
> > +     if (IS_ERR(baud_mux_clk)) {
> > +             if (PTR_ERR(baud_mux_clk) == -EPROBE_DEFER)
> > +                     return -EPROBE_DEFER;
> > +             dev_info(dev, "BAUD MUX clock not specified\n");
> > +     } else {
> > +             dev_info(dev, "BAUD MUX clock found\n");
> > +             ret = clk_prepare_enable(baud_mux_clk);
> > +             if (ret)
> > +                     return ret;
> > +             priv->baud_mux_clk = baud_mux_clk;
> > +             init_real_clk_rates(dev, priv);
> > +             clk_rate = priv->default_mux_rate;
> > +     }
> > +
> > +     if (clk_rate == 0) {
> > +             dev_err(dev, "clock-frequency or clk not defined\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     dev_info(dev, "DMA is %senabled\n", priv->dma_enabled ? "" : "not ");
> > +
> > +     memset(&up, 0, sizeof(up));
> > +     up.port.type = PORT_16550A;
> > +     up.port.uartclk = clk_rate;
> > +     up.port.dev = dev;
> > +     up.port.mapbase = mapbase;
> > +     up.port.membase = membase;
> > +     up.port.irq = irq->start;
> > +     up.port.handle_irq = brcmuart_handle_irq;
> > +     up.port.regshift = 2;
> > +     up.port.iotype = of_device_is_big_endian(np) ?
> > +             UPIO_MEM32BE : UPIO_MEM32;
> > +     up.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
> > +             | UPF_FIXED_PORT | UPF_FIXED_TYPE;
> > +     up.port.dev = dev;
> > +     up.port.private_data = priv;
> > +     up.capabilities = UART_CAP_FIFO | UART_CAP_AFE;
> > +     up.port.fifosize = 32;
> > +
> > +     /* Check for a fixed line number */
> > +     ret = of_alias_get_id(np, "serial");
> > +     if (ret >= 0)
> > +             up.port.line = ret;
> > +
> > +     /* setup HR timer */
> > +     hrtimer_init(&priv->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
> > +     priv->hrt.function = brcmuart_hrtimer_func;
> > +
> > +     up.port.shutdown = brcmuart_shutdown;
> > +     up.port.startup = brcmuart_startup;
> > +     up.port.throttle = brcmuart_throttle;
> > +     up.port.unthrottle = brcmuart_unthrottle;
> > +     up.port.set_termios = brcmstb_set_termios;
> > +
> > +     if (priv->dma_enabled) {
> > +             priv->rx_size = RX_BUF_SIZE * RX_BUFS_COUNT;
> > +             priv->rx_bufs = dma_alloc_coherent(dev,
> > +                                                priv->rx_size,
> > +                                                &priv->rx_addr, GFP_KERNEL);
> > +             if (!priv->rx_bufs)
> > +                     goto err;
> > +             priv->tx_size = UART_XMIT_SIZE;
> > +             priv->tx_buf = dma_alloc_coherent(dev,
> > +                                               priv->tx_size,
> > +                                               &priv->tx_addr, GFP_KERNEL);
> > +             if (!priv->tx_buf)
> > +                     goto err;
> > +     }
> > +
> > +     ret = serial8250_register_8250_port(&up);
> > +     if (ret < 0) {
> > +             dev_err(dev, "unable to register 8250 port\n");
> > +             goto err;
> > +     }
> > +     priv->line = ret;
> > +     new_port = serial8250_get_port(ret);
> > +     priv->up = &new_port->port;
> > +     if (priv->dma_enabled) {
> > +             dma_irq = platform_get_irq_byname(pdev,  "dma");
> > +             if (dma_irq < 0) {
> > +                     dev_err(dev, "no IRQ resource info\n");
> > +                     goto err1;
> > +             }
> > +             ret = devm_request_irq(dev, dma_irq, brcmuart_isr,
> > +                             IRQF_SHARED, "uart DMA irq", &new_port->port);
> > +             if (ret) {
> > +                     dev_err(dev, "unable to register IRQ handler\n");
> > +                     goto err1;
> > +             }
> > +     }
> > +     platform_set_drvdata(pdev, priv);
> > +     ret = sysfs_create_group(&dev->kobj, &brcmuart_dev_attr_group);
>
> You just raced with userspace and lost.
>
> Never do this, use the default attribute group for your driver and the
> driver core will properly create/destroy your files.
>
> If you were using sysfs files, which this driver should not be doing :)
>

I'm removing the sysfs support from this driver. If I have a need to
use sysfs in the future I'll be sure to avoid the mistakes pointed out
here.
Thanks for the review!
Al

>
> thanks,
>
> greg k-h

--000000000000ab50fb05bcbca151
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ttvt2FH7IWicVeEY2xMeWBfRtFY8anAKhTykkxVm9rAGHFj6Rj3tbMRCZizYUtlqyfrAUxkV7/+M
lJOhEKlpaANYkXoNuBW8PTcnOFVn6s1coaUCAwEAAaOCAdcwggHTMA4GA1UdDwEB/wQEAwIFoDCB
owYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcwAYY1aHR0
cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAwTQYDVR0g
BEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24u
Y29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDovL2NybC5n
bG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwIQYDVR0RBBowGIEW
YWwuY29vcGVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSW
M9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUB/Y1r/DQXIWt+XAn5hAwnXShDBYwDQYJKoZI
hvcNAQELBQADggEBAG4wYsV9AObl2akkl93oiHpdF2p7tbtd6H3GdNwyPcLHCIUa5inJwSFPRBdR
lFFxiicUm7yEVEHBLcYZF11xM+8hKoHq8Y7mtEXuJVvRZ+/0poqcJ9Y5ePe3U2oq+TIEboWtzBt7
pIBh/9lzSlx4WH3ICUhc0O3MSSfo835JpsaQ0L+xeK1vvh/jUgfO0dka/6VrcO9ImZQEPE/Rq/6X
BnyP/11h9hpq9LMet8vKQHzj05XHRchrP6sn0Yfej7LzhGFZG4P3U2VMOhRcyBvKtFJy9AhreOHc
fteRGM0b7B45hCt+xljp46Zi9N5DA8Q+UTXRUiAf+Xw2em834OXLRNYxggJtMIICaQIBATBrMFsx
CzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxT
aWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgw4dvuXenZP3ci2MSowDQYJYIZIAWUD
BAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEqlqoTGE8hhCgb9m6z/lictOaw5511HJzZiFYEtxJWI
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMDMwNDIxMjcxNVow
aQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAK
BggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG
9w0BAQEFAASCAQA+NT7auCEi5I95Yno8q59Mem4YX3mlxbaip4aHoZBy4VN6TH6UCE8qIoJZcUuE
yjPGxXO8tBXgjYm+Tgs0vpU+w282r+opteu5Ord0cAZIs4353WasfMyvXVSKb5+ePmaQBRpvCXoD
nvOenjaxcIEhHZarwLE1JRQFvcIOXWpUhnMAPZ3wA1jLQQgD7PbtKKzzGXDKBXVNaWynkUFbhiS+
vSOs1Z9TCKvWhXPS0ao2HxrLXwYhBsTdbxKdXwkNeb+uMqZ4V4LA4k7i51XD9gO8rp5F+SOesznr
qJcVJSfEV1zRTV14ksMeWwGnKcPQbOF8YDIqhBp/72qWAtAaGwnv
--000000000000ab50fb05bcbca151--
