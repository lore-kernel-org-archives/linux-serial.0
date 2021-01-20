Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE86C433DB
	for <linux-serial@archiver.kernel.org>; Wed, 20 Jan 2021 19:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99905238EC
	for <linux-serial@archiver.kernel.org>; Wed, 20 Jan 2021 19:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbhATRfp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Jan 2021 12:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387637AbhATRbN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Jan 2021 12:31:13 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96184C061757
        for <linux-serial@vger.kernel.org>; Wed, 20 Jan 2021 09:30:32 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id k132so13052667ybf.2
        for <linux-serial@vger.kernel.org>; Wed, 20 Jan 2021 09:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KOeM31tOWx3bUxpU77JyNRwQCcJtPzq4vaE4mMXeTqA=;
        b=Pvu2kHtZjikzxDN3FfKxVGONx9An1ywgCXI3Ez04zKDE/AXj7+XCYv3K2UsmZRGTV0
         IlBGcC+KKoGIJlf2MuyH+3nWW3Ne1GNIaCungWuDT/o/y5Jk6iHMlJ4pyojyMmxMhEeb
         LKXo0DDRunYzS6phmcoc3+KjWIgfFuuZwZzEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KOeM31tOWx3bUxpU77JyNRwQCcJtPzq4vaE4mMXeTqA=;
        b=KjBMRsulmIaN+zSEAGKnfRLz1jC/KnBDrrTKbOP35ETG1MHQIBJYToD324UyfR/oDL
         EFFVD8m6/qp2rgj/zLjAQgot3LeTDyfa8LEBzRZuOazvScRQrkPSKUY1ZViNqGGslUjW
         4X623gMB0dpNuYItObtqNPik+tXfPM08TC9WD0DVJUXfWJpnfVUrH0PUmInq1fgDfSr7
         YpsbAo3kyvDEf0CL2+eW8dgrqo2P2fiFJDmZSFTPedMuoUyQf2tS3lJ6+iXCZ/Ycr2by
         TaUQeRCuWiqIFGqVkMhkj+yU1pNfSExm5guN+m56F7HDL8DBCjrUYmLN7hcNGzz3uW3a
         PPfg==
X-Gm-Message-State: AOAM533XPMn+jCrMSaVWc/aWVt1mmusS4ifW5bxyKoOancYSkvB0SG8j
        ZEH9eg5yOji6bxFR7ot/8x++ILTP7ger2WE34Lsn
X-Google-Smtp-Source: ABdhPJwdq8JxL/t2+LDJM+zKFnhqGK+mRxzNKyTSXvw8lkMY1iy5t/8sJFNSlX6GmIApW3cm18I9WEngYyeRxmFb+HE=
X-Received: by 2002:a25:7c06:: with SMTP id x6mr15101679ybc.445.1611163831555;
 Wed, 20 Jan 2021 09:30:31 -0800 (PST)
MIME-Version: 1.0
References: <20210115211543.33563-1-alcooperx@gmail.com> <20210115211543.33563-3-alcooperx@gmail.com>
 <CAHp75VdQPQK8jTF3QDKx6mF1QzOg-qiuHrTiojnWn7GskokfoA@mail.gmail.com>
 <71d58a3e-2707-69d7-8074-c67235912e06@gmail.com> <CAHp75VfNumFBwbytCuA_YK1w-+kN20vRF+GhogtU+DDG3EB_7g@mail.gmail.com>
In-Reply-To: <CAHp75VfNumFBwbytCuA_YK1w-+kN20vRF+GhogtU+DDG3EB_7g@mail.gmail.com>
From:   Al Cooper <al.cooper@broadcom.com>
Date:   Wed, 20 Jan 2021 12:30:20 -0500
Message-ID: <CAGh=XAAPPDP4dp1V2rhOt5gKGp1zRvUF+xJCuEHvhVAzw+5nGA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] serial: 8250: Add new 8250-core based Broadcom STB driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        devicetree <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000e3bb5f05b9584f6d"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--000000000000e3bb5f05b9584f6d
Content-Type: text/plain; charset="UTF-8"

I took another look at using the DMA framework for this and I still
don't think it fits. The problem is that the DMA hardware is so
tightly coupled to the 8250 UART hardware that a generic DMA model
where a DMA engine will read the data from the UART data register when
Data Ready is asserted and transfer it to memory, doesn't fit.  For
example:
- The flush timeout, parity error, framing error and overrun errors
are kept separately in the DMA hardware.
- The DMA hardware expects to be enabled before receiving input data
and it will continually write the data to ping pong data buffers as
long as a buffer empty bit is set on the next buffer.
- When DMA is enabled it bypasses some of the normal 8250 control and
data registers.

I think that trying to force this hardware into the current 8250 DMA
model using the DMA framework would not be a good approach.
I'll look at the other suggestions.

Thanks
Al



On Wed, Jan 20, 2021 at 11:47 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jan 19, 2021 at 8:16 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > On 1/19/2021 7:21 AM, Andy Shevchenko wrote:
> > > On Fri, Jan 15, 2021 at 11:19 PM Al Cooper <alcooperx@gmail.com> wrote:
> > >>
> > >> Add a UART driver for the new Broadcom 8250 based STB UART. The new
> > >> UART is backward compatible with the standard 8250, but has some
> > >> additional features. The new features include a high accuracy baud
> > >> rate clock system and DMA support.
> > >>
> > >> The driver will use the new optional BAUD MUX clock to select the best
> > >> one of the four master clocks (81MHz, 108MHz, 64MHz and 48MHz) to feed
> > >> the baud rate selection logic for any requested baud rate.  This allows
> > >> for more accurate BAUD rates when high speed baud rates are selected.
> > >>
> > >> The driver will use the new UART DMA hardware if the UART DMA registers
> > >> are specified in Device Tree "reg" property. The DMA functionality can
> > >> be disabled on kernel boot with the argument:
> > >> "8250_bcm7271.disable_dma=Y".
> > >>
> > >> The driver also set the UPSTAT_AUTOCTS flag when hardware flow control
> > >> is enabled. This flag is needed for UARTs that don't assert a CTS
> > >> changed interrupt when CTS changes and AFE (Hardware Flow Control) is
> > >> enabled.
> > >>
> > >> The driver also contains a workaround for a bug in the Synopsis 8250
> > >> core. The problem is that at high baud rates, the RX partial FIFO
> > >> timeout interrupt can occur but there is no RX data (DR not set in
> > >> the LSR register). In this case the driver will not read the Receive
> > >> Buffer Register, which clears the interrupt, and the system will get
> > >> continuous UART interrupts until the next RX character arrives. The
> > >> fix originally suggested by Synopsis was to read the Receive Buffer
> > >> Register and discard the character when the DR bit in the LSR was
> > >> not set, to clear the interrupt. The problem was that occasionally
> > >> a character would arrive just after the DR bit check and a valid
> > >> character would be discarded. The fix that was added will clear
> > >> receive interrupts to stop the interrupt, deassert RTS to insure
> > >> that no new data can arrive, wait for 1.5 character times for the
> > >> sender to react to RTS and then check for data and either do a dummy
> > >> read or a valid read. Sysfs error counters were also added and were
> > >> used to help create test software that would cause the error condition.
> > >> The counters can be found at:
> > >> /sys/devices/platform/rdb/*serial/rx_bad_timeout_late_char
> > >> /sys/devices/platform/rdb/*serial/rx_bad_timeout_no_char
> > >
> > > Brief looking into the code raises several questions:
> > >  - is it driver from the last decade?
> >
> > Work on this driver started back in 2018, that was indeed the last decade.
> >
> > >  - why it's not using what kernel provides?
> > >  - we have a lot of nice helpers:
> > >    - DMA Engine API
> >
> > Not sure this makes sense, given that the DMA hardware that was added to
> > this UART block is only used by the UART block and no other pieces of HW
> > in the system, nor will they ever be. Not sure it makes sense to pay the
> > cost of an extra indirection and subsystem unless there are at least two
> > consumers of that DMA hardware to warrant modeling it after a dmaengine
> > driver. I also remember that Al researched before whether 8250_dma.c
> > could work, and came to the conclusion that it would not, but I will let
> > him comment on the specifics.
>
> I see. In any case I still believe that the driver can be shrinked by
> a notable amount of lines.
>
> > >    - BIT() and GENMASK() macros
> > >    - tons of different helpers like regmap API (if you wish to dump
> > > registers via debugfs)
> > >
> > > Can you shrink this driver by 20-30% (I truly believe it's possible)
> > > and split DMA driver to drivers/dma (which may already have something
> > > similar there)?
> >
> > See previous response.
>
>
> --
> With Best Regards,
> Andy Shevchenko

--000000000000e3bb5f05b9584f6d
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
HDSO3jANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgzJD78I1NJwJoWpYJSLKPYYGS
aGK1+vXzA33fk/OL6m0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
MjEwMTIwMTczMDMyWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYw
CwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZI
AWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJBOfqB1cK+6L8xOGYcdF8/ERo4jP9nQ0SvrYfRrteUF
4LkIkQ313AZCd2Igk0yy8nPI1jiaTfNxEcCtoUUtg3aPau+PU+lD9rv85hUFyEB6SaANEzuQOCON
NMJ2n2E2xyJcnbBlHY/+YdtZ28Tpqi2VMAQCiY2Tk/5CU958QvWpNVIhYe02tlWNpX7P/ydiCEyT
y+a5Wz/ddkEQEZFu2kZ0pc09qzQt/AGr01K6CxpEaFoBibKLtKa1CiIqiPmsFENNZ+KXoyp6oTpo
Gxn8NWsT3jYP/OC+v+xwew14fIZdUd2auShD0DavnUjbU+/w7N5ppiZ6iRlVyN6KwQeANpQ=
--000000000000e3bb5f05b9584f6d--
