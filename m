Return-Path: <SRS0=+90y=4V=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1101C3F2CD
	for <linux-serial@archiver.kernel.org>; Wed,  4 Mar 2020 14:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14BE20838
	for <linux-serial@archiver.kernel.org>; Wed,  4 Mar 2020 14:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgCDOok (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:44:40 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45265 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbgCDOok (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Mar 2020 09:44:40 -0500
Received: by mail-oi1-f196.google.com with SMTP id v19so2270533oic.12;
        Wed, 04 Mar 2020 06:44:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XOyEFLox1SQQtJ8fAzmf4z4RXvxyAgTDWTn6WDDXb0=;
        b=NoPtP+2rFup78yuWoFf2plZRQ8RE2qI8qzLRaLxyOaM2hLSZTILq9rBfpZaThK1Aj6
         92dZC7RZu1P4684lxgQ3MlhNkSWmC/MBj0kq8PT/qqhM34ftz5vWVAmZ3zWYYr8tsAFM
         vI0degjA5cMoRSJRUDJWAjBzuN4z90wHxUHtJNlup73itPLAf8NXV1ACnkUiPbg7cR5L
         tstxEpfY9CAw4h9UUilDyhhZZu1vUBpOIoiY0cJ2XHEOvY7uQQfTsI+WY2SJ1boOyYc2
         gdRO5OGJGljc2qQn+Y29R4Gyyv2kXhJDx2dHJiJ+2M5TofDLCs5ZbMongCKMx4lWxSwW
         V2hA==
X-Gm-Message-State: ANhLgQ3iMUF4VOt3Pyl/WqXuQNv8EK01ZznywCSA/AE3kRcuyXrRbEbU
        38cTk6aUayBg3t7oyis5JphxB7Bg11ohkSj77NLPtA==
X-Google-Smtp-Source: ADFU+vsNbazIxFcBqKAFb1GPMqJOgG0BnyAB/010ZqCwEoOiw2M0os0lbMfyWVyaKYil1kGEVzObhyVfS3zKdPxdGpo=
X-Received: by 2002:aca:b4c3:: with SMTP id d186mr1916382oif.131.1583333079104;
 Wed, 04 Mar 2020 06:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20200303134351.22270-1-geert+renesas@glider.be>
 <20200303134351.22270-2-geert+renesas@glider.be> <CAL_JsqL7x-XevypLxUUksOCyezbn8=NpL9rMfo0rCQyYzrUxmw@mail.gmail.com>
In-Reply-To: <CAL_JsqL7x-XevypLxUUksOCyezbn8=NpL9rMfo0rCQyYzrUxmw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Mar 2020 15:44:28 +0100
Message-ID: <CAMuHMdUh-NBSDhO7A_HU54S7X920PUj8ScAZUWh8uMqZnjE2xA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: Convert generic bindings to json-schema
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Rob,

On Wed, Mar 4, 2020 at 3:03 PM Rob Herring <robh+dt@kernel.org> wrote:
> On Tue, Mar 3, 2020 at 7:43 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Convert the generic serial interface Device Tree binding documentation
> > to json-schema.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > +  cts-gpios:
> > +    description:
> > +      Must contain a GPIO specifier, referring to the GPIO pin to be used as
> > +      the UART's CTS line.

> > +  rts-gpios:
> > +    description:
> > +      Must contain a GPIO specifier, referring to the GPIO pin to be used as
> > +      the UART's RTS line.
> > +
> > +  uart-has-rtscts:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      The presence of this property indicates that the UART has dedicated lines
> > +      for RTS/CTS hardware flow control, and that they are available for use
> > +      (wired and enabled by pinmux configuration).  This depends on both the
> > +      UART hardware and the board wiring.
> > +      Note that this property is mutually-exclusive with "cts-gpios" and
> > +      "rts-gpios" above, unless support is provided to switch between modes
> > +      dynamically.
>
> This can be expressed as:
>
> oneOf:
>   - {} # None of the properties present
>   - required:
>       - uart-has-rtscts
>   - anyOf:
>       - required:
>           - cts-gpios
>       - required:
>           - rts-gpios
>
> Or probably more clearly:
>
> if:
>   required:
>     - uart-has-rtscts
> then:
>   properties:
>     rts-gpios: false
>     cts-gpios: false
>
> (Untested)

Thanks. Note that when adding this, the note above must be removed.

>
> > +
> > +examples:
>
> Personally, I'd just drop examples from schemas that aren't complete.

OK.


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
