Return-Path: <SRS0=t8aj=AV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3243C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 19:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C352B2075D
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 19:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h7HSeaPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgGJTGZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbgGJTGV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jul 2020 15:06:21 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC747C08C5DD
        for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2020 12:05:43 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id k15so3784485lfc.4
        for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2020 12:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n1KyNBVjAamBOz/CBaK/fbOZWKGWi/WBao5hHLUdULo=;
        b=h7HSeaPHcc2kUJWQCUNF0ZEctOCeF5/G4Bh07ahmWxXImubD59GRgouUxj/sFcACNv
         B3scMhGC4rUC0qSuR/LW31Ik2Wyf3Jh0QcAOL0ASccyHBNHlsSOWippa0ypV1g1yQCS0
         rPIe07vLV8ahwIUeOy7zmvZ/KwgEgAI7FZhhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1KyNBVjAamBOz/CBaK/fbOZWKGWi/WBao5hHLUdULo=;
        b=ooM2CzKmJSRJ/RACTuu/dnnxYq2anx5B9M+SDX8Y/WvWgCuLMeuqYfSuG3r7DozCk/
         3OrniBXLuDHGdSJjMrgP3K2aKSbQszNEBaEbBVzJtdAJalpDVrm8YGoqd3giCANfvgua
         OnrLL46wpYOAxCGe6UONagF8FvaxO7fsoi0AjHfGyl4I82aiIWs0zQt0Af4ZqpNlhc66
         R0tKHqbEDICOkrEO84V8PfKkg7ss8t5zX/r/qwN78VJTU8abRCFVwtaYI2wN0bEVIUrd
         l/928z/r+qU3JOW1mcnx7W2JSOHLWq8Js5j6CMXMYrL87j5JA6GIRyvcgnkqQMntIdgU
         5g8A==
X-Gm-Message-State: AOAM533sEkU5A9+33EvaHrMU3OSRacsYg+oLM/s+D15ilIxhR3M3lxHv
        WQFFd3UPavzv2XgEUScYFEXeQP/9gLU=
X-Google-Smtp-Source: ABdhPJxQnCssycID8uMvg4Plao6hiqVuhJ1o68m9KIAk+lef2AkVliao9eTzitDVW+fiYFDXfNg3BQ==
X-Received: by 2002:ac2:4c03:: with SMTP id t3mr43519338lfq.72.1594407941831;
        Fri, 10 Jul 2020 12:05:41 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id h9sm2176168lja.35.2020.07.10.12.05.39
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 12:05:40 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id r19so7607942ljn.12
        for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2020 12:05:39 -0700 (PDT)
X-Received: by 2002:a2e:b0ed:: with SMTP id h13mr30661389ljl.250.1594407938513;
 Fri, 10 Jul 2020 12:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200626200033.1528052-1-dianders@chromium.org>
 <20200626125844.2.Iabd56347670b9e4e916422773aba5b27943d19ee@changeid>
 <CAE=gft504BAm2sr0S32kSO2xoQWhjrXLXa9+uqgkcPO6wjNhrg@mail.gmail.com> <CAD=FV=XfYL0po+8Wm4hLYgwDQpREFSeGEaNSQMCZhmV2tP_u0A@mail.gmail.com>
In-Reply-To: <CAD=FV=XfYL0po+8Wm4hLYgwDQpREFSeGEaNSQMCZhmV2tP_u0A@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 10 Jul 2020 12:05:01 -0700
X-Gmail-Original-Message-ID: <CAE=gft7wpD52fgmpRqkY2+Y6DEa82wJ_fqZ=MXa_TZgXPdp8uA@mail.gmail.com>
Message-ID: <CAE=gft7wpD52fgmpRqkY2+Y6DEa82wJ_fqZ=MXa_TZgXPdp8uA@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: qcom_geni_serial: Always use 4 bytes per TX
 FIFO word
To:     Doug Anderson <dianders@chromium.org>
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

On Fri, Jul 10, 2020 at 11:28 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Jul 10, 2020 at 10:46 AM Evan Green <evgreen@chromium.org> wrote:
> >
> > On Fri, Jun 26, 2020 at 1:01 PM Douglas Anderson <dianders@chromium.org> wrote:
> > >
> > > The geni serial driver had a rule that we'd only use 1 byte per FIFO
> > > word for the TX FIFO if we were being used for the serial console.
> > > This is ugly and a bit of a pain.  It's not too hard to fix, so fix
> > > it.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > >  drivers/tty/serial/qcom_geni_serial.c | 57 +++++++++++++++++----------
> > >  1 file changed, 37 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> > > index 4610e391e886..583d903321b5 100644
> > > --- a/drivers/tty/serial/qcom_geni_serial.c
> > > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > > @@ -103,12 +103,18 @@
> > >  #define DEFAULT_IO_MACRO_IO2_IO3_MASK          GENMASK(15, 4)
> > >  #define IO_MACRO_IO2_IO3_SWAP          0x4640
> > >
> > > +/* We always configure 4 bytes per FIFO word */
> > > +#define BYTES_PER_FIFO_WORD            4
> > > +
> > >  struct qcom_geni_private_data {
> > >         /* NOTE: earlycon port will have NULL here */
> > >         struct uart_driver *drv;
> > >
> > >         u32 poll_cached_bytes;
> > >         unsigned int poll_cached_bytes_cnt;
> > > +
> > > +       u32 write_cached_bytes;
> > > +       unsigned int write_cached_bytes_cnt;
> > >  };
> > >
> > >  struct qcom_geni_serial_port {
> > > @@ -121,8 +127,6 @@ struct qcom_geni_serial_port {
> > >         bool setup;
> > >         int (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
> > >         unsigned int baud;
> > > -       unsigned int tx_bytes_pw;
> > > -       unsigned int rx_bytes_pw;
> > >         void *rx_fifo;
> > >         u32 loopback;
> > >         bool brk;
> > > @@ -390,13 +394,25 @@ static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
> > >  #ifdef CONFIG_SERIAL_QCOM_GENI_CONSOLE
> > >  static void qcom_geni_serial_wr_char(struct uart_port *uport, int ch)
> > >  {
> > > -       writel(ch, uport->membase + SE_GENI_TX_FIFOn);
> > > +       struct qcom_geni_private_data *private_data = uport->private_data;
> > > +
> > > +       private_data->write_cached_bytes =
> > > +               (private_data->write_cached_bytes >> 8) | (ch << 24);
> > > +       private_data->write_cached_bytes_cnt++;
> > > +
> > > +       if (private_data->write_cached_bytes_cnt == BYTES_PER_FIFO_WORD) {
> > > +               writel(private_data->write_cached_bytes,
> > > +                      uport->membase + SE_GENI_TX_FIFOn);
> > > +               private_data->write_cached_bytes_cnt = 0;
> > > +       }
> > >  }
> > >
> > >  static void
> > >  __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
> > >                                  unsigned int count)
> > >  {
> > > +       struct qcom_geni_private_data *private_data = uport->private_data;
> > > +
> > >         int i;
> > >         u32 bytes_to_send = count;
> > >
> > > @@ -431,6 +447,15 @@ __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
> > >                                                         SE_GENI_M_IRQ_CLEAR);
> > >                 i += chars_to_write;
> > >         }
> > > +
> > > +       if (private_data->write_cached_bytes_cnt) {
> > > +               private_data->write_cached_bytes >>= BITS_PER_BYTE *
> > > +                       (BYTES_PER_FIFO_WORD - private_data->write_cached_bytes_cnt);
> > > +               writel(private_data->write_cached_bytes,
> > > +                      uport->membase + SE_GENI_TX_FIFOn);
> > > +               private_data->write_cached_bytes_cnt = 0;
> > > +       }
> >
> > How does this not end up sending stray zeros? In other words, how does
> > the hardware know which bytes of this word are valid?
>
> We told it how many bytes we wanted to send in
> qcom_geni_serial_setup_tx().  If the total number of bytes being sent
> is not a multiple of the FIFO word size then it knows that the last
> word will be a partial and it'll extract just the number of needed
> bytes out of it.

Ohh right. Sounds good.

Reviewed-by: Evan Green <evgreen@chromium.org>
