Return-Path: <SRS0=t8aj=AV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF65C433E3
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 18:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3292207BB
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 18:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fIzKSved"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgGJSTl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jul 2020 14:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgGJSTk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jul 2020 14:19:40 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39535C08C5DC
        for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2020 11:19:40 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id p25so3474675vsg.4
        for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2020 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wnOuOYXoizS/zBJcCxGZB+NxpIyUG/B4G9U+uO4vkR8=;
        b=fIzKSvedd4Xt5WU2QaHjdRj4b+kQNS0g4OL/AbWRJroDEmFD6e2U7AfiGxiqLSrEsh
         cbA8OTFyZGQg4LPC7mhD+97Rsxo3xGQbiUQU07CTX/Jri44VcMEmEFLK3znjZyauLD2N
         Ti+2fqqRdC62TnnqThorhsp32v+sNHqM7B4z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wnOuOYXoizS/zBJcCxGZB+NxpIyUG/B4G9U+uO4vkR8=;
        b=VT1VqccoMA0dVcR9Z+nXO7e0ARz/EE+6ZEix4JNuW+KXy0ddZXnmBUaS+PdrSgliOy
         Kc0vlfRB1hq/2fNnooIeGWmaU58/TScmvYI00gDUBUGkHQDsR6HPWc/bR/0BHl4kiXEv
         KOcf1LjpDtiDDVVrx/IGvdQrHozdGXT1r9uHu6J7hSk87jQxQD1dwQiDHInyEse5taQ2
         dpxUQT7CIIFUWxaj9SMKoB04l1NL6fE0htbtlJTdIYu0HjsdM9F9Rkjl4fBLLQL5OSK3
         nFWGqCINB3CozXvlaAcWGD4sTa0S5xljNMMCZnmxRJpqOhiD3htf7e+EWyMjXWVDQUY9
         daCg==
X-Gm-Message-State: AOAM530IUZQqPIDzC0i5UiX79Q58382P2vkRbXYcNoIjd4EOwOcGBtZD
        hP3jMKI51FuuZ6HfFbIGmp/4C603oYc=
X-Google-Smtp-Source: ABdhPJx8urXkFQGIBJAvM6lmPU0prZm0PNcw0C0ZbuBM8/nMyZBTlI8Utu+HX9I3bSSSJHLfadvlOA==
X-Received: by 2002:a67:ed59:: with SMTP id m25mr2129951vsp.218.1594405178698;
        Fri, 10 Jul 2020 11:19:38 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id t2sm936764vka.28.2020.07.10.11.19.36
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 11:19:37 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id d198so3489857vsc.1
        for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2020 11:19:36 -0700 (PDT)
X-Received: by 2002:a05:6102:20a:: with SMTP id z10mr43192375vsp.213.1594405176107;
 Fri, 10 Jul 2020 11:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200626200033.1528052-1-dianders@chromium.org>
 <20200626125844.1.I8546ecb6c5beb054f70c5302d1a7293484212cd1@changeid> <CAE=gft7Q-KC2+9kGVT1k3BaAHZv61iWaeEODZEf7FnXX6i=1LA@mail.gmail.com>
In-Reply-To: <CAE=gft7Q-KC2+9kGVT1k3BaAHZv61iWaeEODZEf7FnXX6i=1LA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 10 Jul 2020 11:19:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VS9e_rj1ufEDw5+Vu_WMVrSqJWjSdK-oZ2OtPxahsMvg@mail.gmail.com>
Message-ID: <CAD=FV=VS9e_rj1ufEDw5+Vu_WMVrSqJWjSdK-oZ2OtPxahsMvg@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: qcom_geni_serial: Make kgdb work even if UART
 isn't console
To:     Evan Green <evgreen@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Fri, Jul 10, 2020 at 10:39 AM Evan Green <evgreen@chromium.org> wrote:
>
> On Fri, Jun 26, 2020 at 1:01 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > The geni serial driver had the rather sketchy hack in it where it
> > would adjust the number of bytes per RX FIFO word from 4 down to 1 if
> > it detected that CONFIG_CONSOLE_POLL was enabled (for kgdb) and this
> > was a console port (defined by the kernel directing output to this
> > port via the "console=" command line argument).
> >
> > The problem with that sketchy hack is that it's possible to run kgdb
> > over a serial port even if it isn't used for console.
> >
> > Let's avoid the hack by simply handling the 4-bytes-per-FIFO word case
> > for kdb.  We'll have to have a (very small) cache but that should be
> > fine.
> >
> > A nice side effect of this patch is that an agetty (or similar)
> > running on this port is less likely to drop characters.  We'll
> > have roughly 4 times the RX FIFO depth than we used to now.
> >
> > NOTE: the character cache here isn't shared between the polling API
> > and the non-polling API.  That means that, technically, the polling
> > API could eat a few extra bytes.  This doesn't seem to pose a huge
> > problem in reality because we'll only get several characters per FIFO
> > word if those characters are all received at nearly the same time and
> > we don't really expect non-kgdb characters to be sent to the same port
> > as kgdb at the exact same time we're exiting kgdb.
> >
> > ALSO NOTE: we still have the sketchy hack for setting the number of
> > bytes per TX FIFO word in place, but that one is less bad.  kgdb
> > doesn't have any problem with this because it always just sends 1 byte
> > at a time and waits for it to finish.  The TX FIFO hack is only really
> > needed for console output.  In any case, a future patch will remove
> > that hack, too.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/tty/serial/qcom_geni_serial.c | 80 ++++++++++++++++++---------
> >  1 file changed, 55 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> > index 0300867eab7a..4610e391e886 100644
> > --- a/drivers/tty/serial/qcom_geni_serial.c
> > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > @@ -103,11 +103,13 @@
> >  #define DEFAULT_IO_MACRO_IO2_IO3_MASK          GENMASK(15, 4)
> >  #define IO_MACRO_IO2_IO3_SWAP          0x4640
> >
> > -#ifdef CONFIG_CONSOLE_POLL
> > -#define CONSOLE_RX_BYTES_PW 1
> > -#else
> > -#define CONSOLE_RX_BYTES_PW 4
> > -#endif
> > +struct qcom_geni_private_data {
> > +       /* NOTE: earlycon port will have NULL here */
> > +       struct uart_driver *drv;
> > +
> > +       u32 poll_cached_bytes;
> > +       unsigned int poll_cached_bytes_cnt;
> > +};
> >
> >  struct qcom_geni_serial_port {
> >         struct uart_port uport;
> > @@ -129,6 +131,8 @@ struct qcom_geni_serial_port {
> >         int wakeup_irq;
> >         bool rx_tx_swap;
> >         bool cts_rts_swap;
> > +
> > +       struct qcom_geni_private_data private_data;
> >  };
> >
> >  static const struct uart_ops qcom_geni_console_pops;
> > @@ -264,8 +268,9 @@ static bool qcom_geni_serial_poll_bit(struct uart_port *uport,
> >         unsigned int baud;
> >         unsigned int fifo_bits;
> >         unsigned long timeout_us = 20000;
> > +       struct qcom_geni_private_data *private_data = uport->private_data;
> >
> > -       if (uport->private_data) {
> > +       if (private_data->drv) {
> >                 port = to_dev_port(uport, uport);
> >                 baud = port->baud;
> >                 if (!baud)
> > @@ -331,23 +336,42 @@ static void qcom_geni_serial_abort_rx(struct uart_port *uport)
> >  }
> >
> >  #ifdef CONFIG_CONSOLE_POLL
> > +
> >  static int qcom_geni_serial_get_char(struct uart_port *uport)
> >  {
> > -       u32 rx_fifo;
> > +       struct qcom_geni_private_data *private_data = uport->private_data;
> >         u32 status;
> > +       u32 word_cnt;
> > +       int ret;
> > +
> > +       if (!private_data->poll_cached_bytes_cnt) {
> > +               status = readl(uport->membase + SE_GENI_M_IRQ_STATUS);
> > +               writel(status, uport->membase + SE_GENI_M_IRQ_CLEAR);
> >
> > -       status = readl(uport->membase + SE_GENI_M_IRQ_STATUS);
> > -       writel(status, uport->membase + SE_GENI_M_IRQ_CLEAR);
> > +               status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
> > +               writel(status, uport->membase + SE_GENI_S_IRQ_CLEAR);
> >
> > -       status = readl(uport->membase + SE_GENI_S_IRQ_STATUS);
> > -       writel(status, uport->membase + SE_GENI_S_IRQ_CLEAR);
> > +               status = readl(uport->membase + SE_GENI_RX_FIFO_STATUS);
> > +               word_cnt = status & RX_FIFO_WC_MSK;
> > +               if (!word_cnt)
> > +                       return NO_POLL_CHAR;
> >
> > -       status = readl(uport->membase + SE_GENI_RX_FIFO_STATUS);
> > -       if (!(status & RX_FIFO_WC_MSK))
> > -               return NO_POLL_CHAR;
> > +               if (word_cnt == 1 && (status & RX_LAST))
>
> I forget how the partial word snapping works. Are you sure you want
> word_cnt == 1? I see qcom_geni_serial_handle_rx() looks at RX_LAST
> independently as long as word_cnt != 0. I'm worried the hardware
> allows one FIFO entry with say 2 bytes in it and RX_LAST set, but then
> also piles new stuff in the FIFO behind it, so that word_cnt can be
> >1.

So I guess one point of evidence that the logic I have there is OK is
that it works.  :-P

...but also looking closer.  Maybe first it's important to understand
the REALLY WEIRD protocol that geni serial uses.  This was discovered
through a bunch of trial and error long ago when poking at how the
driver worked.

When you're reading from geni it essentially breaks things into
packets.  If you're midway through reading a packet of data and more
bytes come in then geni will hide them from you until you read the
whole packet.  I'm not totally sure the exact conditions for when it
decides to make a packet out of the data, but it's not important for
this discussion.

So when you read "RX_FIFO_WC" it tells you the total number of FIFO
words in the current packet.  That number will only ever go down.  A
packet is made up of some number of whole words plus one word that
could be a whole word or could be a partial word.  So if "RX_FIFO_WC"
says 4 it means you've got 3 whole words (3 * 4 = 12 bytes) and one
word that might be partial.  You can find out about that one partial
word (always the last word in the FIFO) by reading "RX_LAST" and
"RX_LAST_BYTE_VALID".

Once you finally read the last word in the FIFO then geni can tell you
about the next packet of data.

OK, so hopefully that made sense?

So qcom_geni_serial_handle_rx() is trying to read ALL bytes.  It first
figures out the total count of bytes and then reads them all.  That's
why it needs to look at RX_LAST all the time.  Also of note: RX_LAST
only ever applies to the last word in the FIFO.  If it was possible
for the word count to grow _before_ fully clearing out the FIFO then
it would be a race and software would never be able to tell which byte
RX_LAST applied to.

In the case of qcom_geni_serial_get_char() we don't want to read all
bytes because we don't have a place to put them.  We only want 1 byte
but sometimes we're forced to read 4 because of the whole
4-bytes-per-fifo-entry thing.  So we read one FIFO entry.  As long as
we're not reading the _last_ FIFO entry then geni won't start a new
packet.  So if RX_FIFO_WC > 1 and we read a byte then it'll go down by
1.  If RX_FIFO_WC == 1 then we're reading the last entry and geni is
allowed to start its next packet.


> Also I mostly reviewed the change on Gerrit, they seemed to be the
> same. In this case it was easier to understand the indentation
> changes. If there were gotchas between the Gerrit version and this
> patch, let me know.

They are the same.

-Doug
