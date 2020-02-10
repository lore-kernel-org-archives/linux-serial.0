Return-Path: <SRS0=+uUE=36=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B100C352A4
	for <linux-serial@archiver.kernel.org>; Mon, 10 Feb 2020 23:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C79120715
	for <linux-serial@archiver.kernel.org>; Mon, 10 Feb 2020 23:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kopismobile-com.20150623.gappssmtp.com header.i=@kopismobile-com.20150623.gappssmtp.com header.b="D7vSbXJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgBJXD0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 Feb 2020 18:03:26 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37826 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgBJXD0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Feb 2020 18:03:26 -0500
Received: by mail-ua1-f65.google.com with SMTP id h32so3229083uah.4
        for <linux-serial@vger.kernel.org>; Mon, 10 Feb 2020 15:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kopismobile-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C5GirwcztmRlUAA0zFH9GkeX/YNV47Vk7xovWQjcsTY=;
        b=D7vSbXJxmKpoKBCAAK55xYF8eqhBrw3wAteKEisjIrQkuumQVXm46U5FQoTIP8m8sJ
         maC5ZLvIq+hHU6qbmJGiZay/kSprgTDYblgyFEYE51dM4TI30gJbdTq0chKAld1iNdUc
         a/jMcz7MxDhJWsd3h/ZRfOznhs+62V/LuU3k5Gj0Oo66AHTJlLckUw6gyykOBNk3ERY+
         qdRnZFHn6iQcFWhb51+haHsaeu2nQ12NJJRBoOsm8dhqL583CjPXkw14hVyVKt1H9n7s
         TsQeffn1ldnNKqSlLAugEV1foFJyKWdgLmXU+OhQOlMEZxhz2gUc5mDQnomIBvq7+R01
         SsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C5GirwcztmRlUAA0zFH9GkeX/YNV47Vk7xovWQjcsTY=;
        b=FsK6Y4bNYISxjPokP+TXXLdZJ198arTcvIDQnTqEqY0DMbbto//WjOOUz5BXZpI6fR
         vZ7lDuv1vBV5Q7kF9qNnackyUN5BpJ3IGcizhFIfFHslMfjjwCA5s3o7Zy1v5I6bdfq6
         URKfMc2al7WHnkmcK7iPTjBxYbPI6dvvDjJrSejAM7S1aZJL3BNxLkg7Pmmvh2IhyG9N
         beseWt37RErpbfB72B1rwa6FY5ercjr93hEumwLvaFn9Jm6BAkydd7KBLlUGd+2j03Mw
         wYKQUnsNn4kgegGjQkK7IhOeuUnTgXBQzN4Z6lXEhcMyuWTLsDGrEECwd3q+iGqd+HmL
         UqJg==
X-Gm-Message-State: APjAAAWURq1jF9YuihMBiPsxYDIBTxN9WKuis7T0NGH11UEsPfpva9F4
        oif+dfaz4sJBp1RQpuASrVD1VtHfXZqhMfP7PBCD0w==
X-Google-Smtp-Source: APXvYqz8+e2ip6ZtrEun+w0dwbFruG/3SV4gKsgrTeTbWL9Cev9v+ynnw9Kx2crTWX4m8j/kdmt0RgrTYXdipLo/dTo=
X-Received: by 2002:ab0:21cc:: with SMTP id u12mr31230uan.55.1581375805214;
 Mon, 10 Feb 2020 15:03:25 -0800 (PST)
MIME-Version: 1.0
References: <20200210192949.7338-1-ghilliard@kopismobile.com>
 <20200210192949.7338-3-ghilliard@kopismobile.com> <20200210205003.x7xduj3avwjhimjm@pengutronix.de>
In-Reply-To: <20200210205003.x7xduj3avwjhimjm@pengutronix.de>
From:   George Hilliard <ghilliard@kopismobile.com>
Date:   Mon, 10 Feb 2020 17:03:14 -0600
Message-ID: <CALM8J=dZjK9C+-yMOC_DKp+6m2MaKJsNXaz_+enDVtkgj32U+A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tty: imx serial: Implement support for reversing
 TX and RX polarity
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@pengutronix.de, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 10, 2020 at 2:50 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello George,
>
> On Mon, Feb 10, 2020 at 01:29:49PM -0600, George Hilliard wrote:
> > @@ -1390,6 +1392,8 @@ static int imx_uart_startup(struct uart_port *por=
t)
> >       ucr4 =3D imx_uart_readl(sport, UCR4) & ~UCR4_OREN;
> >       if (!sport->dma_is_enabled)
> >               ucr4 |=3D UCR4_OREN;
> > +     if (sport->inverted_rx)
> > +             ucr4 |=3D UCR4_INVR;
>
> You fail to clear this bit if .inverted_rx is false.

I believe this is taken care of by the SRST asserted slightly above
this - UCR* is reset by this. I see that this reset is also done in the
imx_uart_flush_buffer() implementation, but as I understand it, this
is a cleanup method that doesn't reconfigure much of the peripheral.

> >       imx_uart_writel(sport, ucr4, UCR4);
> >
> >       ucr2 =3D imx_uart_readl(sport, UCR2) & ~UCR2_ATEN;
> > @@ -1404,19 +1408,17 @@ static int imx_uart_startup(struct uart_port *p=
ort)
> >               ucr2 &=3D ~UCR2_RTSEN;
> >       imx_uart_writel(sport, ucr2, UCR2);
> >
> > +     ucr3 =3D imx_uart_readl(sport, UCR3);
> > +     if (sport->inverted_tx)
> > +             ucr3 |=3D UCR3_INVT;
>
> Also I think setting this bit here is a bit late because UCR2_TXEN was
> already set so changing UCR3_INVT probably results in a spike?!

Good point here; this should indeed be done before TX start.

George
