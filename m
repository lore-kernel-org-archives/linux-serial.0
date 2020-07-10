Return-Path: <SRS0=t8aj=AV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C67C433E8
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 17:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38EC82076A
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 17:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ILDYVm0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgGJRoq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgGJRoq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jul 2020 13:44:46 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AE2C08C5DC
        for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2020 10:44:46 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dp18so6971787ejc.8
        for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2020 10:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m/CMHk4w6+cNFzgYJXIzp3UU76Y8y9UeHEGOkUVbXTU=;
        b=ILDYVm0LcXLZZrfmAxtURkQprTX9skjAShvhFipQKJAKbFGyoFEeZfJniL4uh1sJtQ
         6GQsddyIJ/M36EE7v0/XiEEynwtBixNj1dz7zWXkp46lP3Sbmpdp/lJneh5gVSnuRIoP
         uDZ95SWe4tPPb6v31ajhDIGF2FUlWNiVlWd+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/CMHk4w6+cNFzgYJXIzp3UU76Y8y9UeHEGOkUVbXTU=;
        b=rWT501k+C1kBxp1O3vu9z3wmJD5jO31Uo9+apfAxGtGeQlxEWe/3e0A7pLl/TdCq8o
         S0aeXICAWt8SwhBrU7uFXHnTA3K72vvyo34Ut5eiKkWsQRPmYH/fd6f1fUgsa1X92+Ri
         bB8inmYrIuQf7IKxbVRladiklJFyT29Km0pKuNJuiOKz0lOT9WnxaRjsMfK6aIpzhUBe
         EIj8q+YPnC1disw7qIIzKGBmi9w+e/lVujNn0mAh5rsxs05BKCL6XENYyglxoAbl4jHA
         MYJkmQGSrqhqzbmO7qMTLzG4m4n0jXSahVbp4oSbfAL3z18hYbR4Jowg9ftnDLaXftvg
         mF1Q==
X-Gm-Message-State: AOAM533LQLseKvPh/YnKE2E+qnWUmWSUoseK3xGEaPAiEl+JFMXxybsl
        uan3axFWwLAQgfof8cPoCYPthgK2VUw=
X-Google-Smtp-Source: ABdhPJxNTxtLIGEY0VgYVUiaMSTPzcBPhVW5tHxZ4a6Jg9r8XdKio65pntlheqejU9KieWjDtdiFbg==
X-Received: by 2002:a17:906:915:: with SMTP id i21mr64354889ejd.313.1594403084539;
        Fri, 10 Jul 2020 10:44:44 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id ce15sm4054447ejc.86.2020.07.10.10.44.44
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 10:44:44 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a1so6957915ejg.12
        for <linux-serial@vger.kernel.org>; Fri, 10 Jul 2020 10:44:44 -0700 (PDT)
X-Received: by 2002:ac2:44b2:: with SMTP id c18mr42517426lfm.99.1594402767378;
 Fri, 10 Jul 2020 10:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200626200033.1528052-1-dianders@chromium.org> <20200626125844.2.Iabd56347670b9e4e916422773aba5b27943d19ee@changeid>
In-Reply-To: <20200626125844.2.Iabd56347670b9e4e916422773aba5b27943d19ee@changeid>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 10 Jul 2020 10:38:50 -0700
X-Gmail-Original-Message-ID: <CAE=gft504BAm2sr0S32kSO2xoQWhjrXLXa9+uqgkcPO6wjNhrg@mail.gmail.com>
Message-ID: <CAE=gft504BAm2sr0S32kSO2xoQWhjrXLXa9+uqgkcPO6wjNhrg@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: qcom_geni_serial: Always use 4 bytes per TX
 FIFO word
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        daniel.thompson@linaro.org,
        Akash Asthana <akashast@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        sumit.garg@linaro.org, Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 26, 2020 at 1:01 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> The geni serial driver had a rule that we'd only use 1 byte per FIFO
> word for the TX FIFO if we were being used for the serial console.
> This is ugly and a bit of a pain.  It's not too hard to fix, so fix
> it.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/tty/serial/qcom_geni_serial.c | 57 +++++++++++++++++----------
>  1 file changed, 37 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 4610e391e886..583d903321b5 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -103,12 +103,18 @@
>  #define DEFAULT_IO_MACRO_IO2_IO3_MASK          GENMASK(15, 4)
>  #define IO_MACRO_IO2_IO3_SWAP          0x4640
>
> +/* We always configure 4 bytes per FIFO word */
> +#define BYTES_PER_FIFO_WORD            4
> +
>  struct qcom_geni_private_data {
>         /* NOTE: earlycon port will have NULL here */
>         struct uart_driver *drv;
>
>         u32 poll_cached_bytes;
>         unsigned int poll_cached_bytes_cnt;
> +
> +       u32 write_cached_bytes;
> +       unsigned int write_cached_bytes_cnt;
>  };
>
>  struct qcom_geni_serial_port {
> @@ -121,8 +127,6 @@ struct qcom_geni_serial_port {
>         bool setup;
>         int (*handle_rx)(struct uart_port *uport, u32 bytes, bool drop);
>         unsigned int baud;
> -       unsigned int tx_bytes_pw;
> -       unsigned int rx_bytes_pw;
>         void *rx_fifo;
>         u32 loopback;
>         bool brk;
> @@ -390,13 +394,25 @@ static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
>  #ifdef CONFIG_SERIAL_QCOM_GENI_CONSOLE
>  static void qcom_geni_serial_wr_char(struct uart_port *uport, int ch)
>  {
> -       writel(ch, uport->membase + SE_GENI_TX_FIFOn);
> +       struct qcom_geni_private_data *private_data = uport->private_data;
> +
> +       private_data->write_cached_bytes =
> +               (private_data->write_cached_bytes >> 8) | (ch << 24);
> +       private_data->write_cached_bytes_cnt++;
> +
> +       if (private_data->write_cached_bytes_cnt == BYTES_PER_FIFO_WORD) {
> +               writel(private_data->write_cached_bytes,
> +                      uport->membase + SE_GENI_TX_FIFOn);
> +               private_data->write_cached_bytes_cnt = 0;
> +       }
>  }
>
>  static void
>  __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
>                                  unsigned int count)
>  {
> +       struct qcom_geni_private_data *private_data = uport->private_data;
> +
>         int i;
>         u32 bytes_to_send = count;
>
> @@ -431,6 +447,15 @@ __qcom_geni_serial_console_write(struct uart_port *uport, const char *s,
>                                                         SE_GENI_M_IRQ_CLEAR);
>                 i += chars_to_write;
>         }
> +
> +       if (private_data->write_cached_bytes_cnt) {
> +               private_data->write_cached_bytes >>= BITS_PER_BYTE *
> +                       (BYTES_PER_FIFO_WORD - private_data->write_cached_bytes_cnt);
> +               writel(private_data->write_cached_bytes,
> +                      uport->membase + SE_GENI_TX_FIFOn);
> +               private_data->write_cached_bytes_cnt = 0;
> +       }

How does this not end up sending stray zeros? In other words, how does
the hardware know which bytes of this word are valid?
