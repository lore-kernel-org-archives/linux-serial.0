Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50D4C433DB
	for <linux-serial@archiver.kernel.org>; Fri, 19 Feb 2021 20:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CDD864EBF
	for <linux-serial@archiver.kernel.org>; Fri, 19 Feb 2021 20:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhBSUCj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Feb 2021 15:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhBSUCg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Feb 2021 15:02:36 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C3CC06178A
        for <linux-serial@vger.kernel.org>; Fri, 19 Feb 2021 12:01:56 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id c131so6661234ybf.7
        for <linux-serial@vger.kernel.org>; Fri, 19 Feb 2021 12:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8E0eX2pmXxrf+QoDKPJ2f9az6zy3M3kgeLEqRMp9Wc=;
        b=KnG59tYqGA07cgb+wH7BIlxaDRTdJpHll5geyffWXyjnYIajnbEDm4VsK4SK48Mwdh
         yj5GOWwnr6PovffzFxrUkjljYxMvFPWyf2wM4JV+VV8qAQ99rqfibokrcyPe4mCW/x1B
         V7UYW8PZl5vBnpvbky0X9Bp4dnnl3IIrO52T4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8E0eX2pmXxrf+QoDKPJ2f9az6zy3M3kgeLEqRMp9Wc=;
        b=qWfuWhVuw/v274S/0DZhondKmwmEHMs3JYmmQXzXsmkcctwC6wulZMxIKGcuK7rYHu
         ToHKatbe8MZltqT3K0/qnWmblN+HUR5NI6bmtmwZB9hTJQd26rPt+FfvcJfY8bq8Fj7h
         eF/6GljTut9ECgzj0zVfBKfkUSdp3PII/tMODP4K22GdtOTvPqlQi6hjDECP9iMtJr0G
         kaC50VKJYVqyFlVai6BQHvMNgzcxGqmaS0VYUfro408fj/OsvJzwXoXMJVEEZC13ry5o
         +CBI92wREzm8bLlxjDl/OnjwHbyWQbZ1rsarNkaftMDwNpUJnqmMDCxRq1aAjjSP/cuq
         4YOw==
X-Gm-Message-State: AOAM530MJ60VdoRP+1AgJ3RIkVR16chEioqQmfrCUKXlY3QZ4PVDmjNX
        Ke70Pp9OQYmURo42qPKbPiHRdq+Hy68lWX5kijQE
X-Google-Smtp-Source: ABdhPJxxXeDo/c9E4D29ULaD4VmVHtgWzSwK6UeyzH3iKbahW+SFSZi7vIkF/gEm0lWR2LCrZx7oGV0YbXT4aisb1QM=
X-Received: by 2002:a05:6902:706:: with SMTP id k6mr15938059ybt.87.1613764914757;
 Fri, 19 Feb 2021 12:01:54 -0800 (PST)
MIME-Version: 1.0
References: <20210212195736.45328-1-alcooperx@gmail.com> <20210212195736.45328-3-alcooperx@gmail.com>
 <d891e5bf-4fd8-fc44-7256-35ffa9d0931a@kernel.org>
In-Reply-To: <d891e5bf-4fd8-fc44-7256-35ffa9d0931a@kernel.org>
From:   Al Cooper <al.cooper@broadcom.com>
Date:   Fri, 19 Feb 2021 15:01:43 -0500
Message-ID: <CAGh=XABS6zvDKyRVqYVq6j=9rdpZvwuj9ienm59tW1Buc5vzzQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] serial: 8250: Add new 8250-core based Broadcom STB driver
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Al Cooper <alcooperx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000088261405bbb5ecea"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--00000000000088261405bbb5ecea
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 19, 2021 at 4:43 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 12. 02. 21, 20:57, Al Cooper wrote:
> > Add a UART driver for the new Broadcom 8250 based STB UART. The new
> > UART is backward compatible with the standard 8250, but has some
> > additional features. The new features include a high accuracy baud
> > rate clock system and DMA support.
> >
> > The driver will use the new optional BAUD MUX clock to select the best
> > one of the four master clocks (81MHz, 108MHz, 64MHz and 48MHz) to feed
> > the baud rate selection logic for any requested baud rate.  This allows
> > for more accurate BAUD rates when high speed baud rates are selected.
> ...
> > --- /dev/null
> > +++ b/drivers/tty/serial/8250/8250_bcm7271.c
> ...
> > +static void brcmuart_rx_isr(struct uart_port *up, u32 rx_isr)
> > +{
> > +     struct brcmuart_priv *priv = up->private_data;
> > +     struct device *dev = up->dev;
> > +     u32 rx_done_isr;
> > +     u32 check_isr;
> > +     char seq_err[] = "RX buffer ready out of sequence, restarting RX DMA\n";
>
> What's the purpose of this on-stack variable?

This was done to make the line fit in 80 columns. Now that the rule
has been relaxed, I'll move it.

>
>
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
> > +      clk_set_rate(priv->baud_mux_clk, priv->default_mux_rate);
>
> This is only weirdly indented.

Fixed.

>
>
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
> > +     i = 1000000000 / real_baud / 10;
>
> NSEC_PER_SEC here?

Fixed.

>
>
> > +     i += (i / 2);
> > +     priv->char_wait = ns_to_ktime(i);
> > +
> > +     up->uartclk = rate;
> > +}
>
> ...
>
> > +static int __maybe_unused brcmuart_resume(struct device *dev)
> > +{
> > +     struct brcmuart_priv *priv = dev_get_drvdata(dev);
> > +     int ret;
> > +
> > +     ret = clk_prepare_enable(priv->baud_mux_clk);
> > +     if (ret)
> > +             dev_err(dev, "Error enabling BAUD MUX clock\n");
> > +
> > +     /*
> > +      * The hardware goes back to it's default after suspend
> > +      * so get the "clk" back in sync.
> > +      */
> > +     ret = clk_set_rate(priv->baud_mux_clk, priv->default_mux_rate);
> > +     if (ret)
> > +             dev_err(dev, "Error restoring default BAUD MUX clock\n");
> > +     if (priv->dma_enabled) {
> > +             brcmuart_arbitration(priv, 1);
> > +             brcmuart_init_dma_hardware(priv);
> > +             start_rx_dma(serial8250_get_port(priv->line));
> > +     }
> > +     serial8250_resume_port(priv->line);
>
> All these cannot fail? Or the above can, so does proceeding further
> without an error make sense?

brcmuart_arbitration() can return a failure and I'll print an error
message and return EBUSY if it does.
The other functions always return 0 and I'll change them to return void.

>
> > +     return 0;
> > +}
> ....
> > --- a/drivers/tty/serial/8250/Kconfig
> > +++ b/drivers/tty/serial/8250/Kconfig
> > @@ -501,6 +501,7 @@ config SERIAL_8250_PXA
> >         applicable to both devicetree and legacy boards, and early console is
> >         part of its support.
> >
> > +
>
> Why adding a newline here?

Fixed

>
>
> >   config SERIAL_8250_TEGRA
> >       tristate "8250 support for Tegra serial ports"
> >       default SERIAL_8250
>
> regards,
> --
> js
> suse labs

Jira, thanks for the review.
Al

--00000000000088261405bbb5ecea
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
yXmUToMxtlREK8ddtKO4bV6ekA5Mxh5jo4JcHCHlgaNowvQgrCTX+FCX8utZUxwNAgMBAAGjggHN
MIIByTAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsGAQUFBzAChkFodHRw
Oi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2lnbjJzaGEyZzNvY3Nw
LmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxz
aWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBEBgNVHR8EPTA7MDmg
N6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWduMnNoYTJnMy5jcmww
IQYDVR0RBBowGIEWYWwuY29vcGVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQUgzDqs/CvVCxhgdEnsBOO
IpL3nHAwDQYJKoZIhvcNAQELBQADggEBACPmJjK2ALJm+IX2DvRRxd7cn7ZA10wn9zxy4ifd84Y7
MSoFpkcgMBFNZB0BF05H/KXZGTFlQm+DdKIIhg/LbPsca/s1i8rXgk1mo2wqn+/mNCtwllAfHe8j
gvBuVbTIhYXp5o/JC2AX639UdQaVAV66YQUpyj5KiMA79MRQU3fbd62/7ynokd5Ufw7XbkhqG7uK
8H7iL6o7IlMM8F5Mf22eZB8hM3WZGYFEyl8V2uYLFWiUDXcp4RiNeCV45AnT+Jg83AWNwTr0TxuE
tlnxwkojsM1vKTuxUQ5kNI8Aq3v/obzat389kqxBjAd7HTjWDFso5KRS9ZVH2tsbKB1dZtAxggJv
MIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTMwMQYD
VQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMCDEzVwUNs2XQM
HDSO3jANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgg6V10zMGRhGj+TM/hTfVeTZ9
MtknAXhb94G/EJ9P46swGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
MjEwMjE5MjAwMTU1WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYw
CwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZI
AWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBABFa+bffiBpZQXfBLsFqaTB23oigP+rn8ULNXrQH/Mrf
/XizmLe4lrckRhdVJAzE+F6uWtERNl6qlt3UxOblrA7c659BxjTkzpZSIx6Sq2i1O7neryIeRByj
zPS1RTh1Aocumq3FOB0PJKHYbJzmA5FQZVs5OnedL0ot8h+cv+tR2WdTUEM83s6eEEr5cINGBV8s
u9pHXhajQVTWaJvDSnpR6E0T6goyQclqGj4zVDkAshq/UxUD+u1bXh35koOJCsGNcXqQMpHiN+z1
gu5Scwqb30oQw4Zmg3gbbwAMgQFFdIo/3+NiBhI38sSl+OYYJlBdVoDoQcDdqWutLIjBTQc=
--00000000000088261405bbb5ecea--
