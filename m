Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DC7C433FE
	for <linux-serial@archiver.kernel.org>; Mon, 30 May 2022 13:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbiE3Nnw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 May 2022 09:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237804AbiE3NmF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 May 2022 09:42:05 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1BC9A98C;
        Mon, 30 May 2022 06:32:03 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w27so6858443edl.7;
        Mon, 30 May 2022 06:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VmC5J5LAtvxholHC0kJMwLzD6EpuzXL1X0zC6FmW1Eo=;
        b=gtClHKizARJKVaT/I/8Z7FkUBInOenM6EVVtQwhZldOZiiVHS5tkuBJG5zlvBIUpL0
         rvudAZhIfyA/MRCGN94wHSVTqkYEExkxROH6YwlKGNDPREjeyNua5axKWdgGq9PXB9Qv
         6/A2y0SPcDGNDhntWPM5aArmXnDmP7Ah4vH4Rq+EHrrX4LQ+H8BwHK8yo6DbLaFHkrke
         4ST0RMWoVI1vS/8thOslzdfROfixbC6gi0HrjGtBkfwnE9mZQmd09WUWRI/Dl/wBcKHq
         wjoo/W8V3045qertaSYvpan4puzMRtRj8oVIz1iL+ZlydadJ8aPDLudZMaSAfHwoExWX
         /Hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VmC5J5LAtvxholHC0kJMwLzD6EpuzXL1X0zC6FmW1Eo=;
        b=zR8tEXxqsP/LZRPxov31jKzLqS8d+GO9tZ7frwkyjTxDPsw4H0JtfVlHfsyreU9oJU
         Idmtc4VnXQuFiPSQj6izpDE7e+CAyqQHknUtCZr1tAJmOi4c3gRGCNakRBv++sYK+TRp
         4G2gxejAJb+z5GjxrxSaoRIEKRP+ClNx3n3Syn8AmCsQLQRJUOQ7h0P1DqJCayGtSief
         Hi7zo9wz34U2qI2K8D0kxQmUk1k4ebIaNHnZDTe1JMD2XJB6yYy5YXOpCcTX2AKQehfF
         qwm8gRHKwihcAa6xUiG1dO9VsDFXGxk2R/K3hQpmYZWhDPIH3tA6ZY1widxuSkfCg0xu
         al5g==
X-Gm-Message-State: AOAM533CSTvWCNv7nQiJ2uJVmDYzJ7sJfkUBLGLECft5jZIc3FQm2do1
        RjcDzEmiB2r0U2O1jJ/znB5qBm1nnLrqgfme/3E=
X-Google-Smtp-Source: ABdhPJw7yEAy0iu+jD3K6+RYaallqZkORRLUe8H7vJHEHL+AYzkc3jtqNHKEFmro5Xmt/PBuwTdey0kle8MLbQy7fsI=
X-Received: by 2002:a05:6402:4394:b0:42a:e84c:2cfb with SMTP id
 o20-20020a056402439400b0042ae84c2cfbmr59605567edc.97.1653917521475; Mon, 30
 May 2022 06:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220527222709.1AC8837401F1@freecalypso.org>
In-Reply-To: <20220527222709.1AC8837401F1@freecalypso.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 May 2022 15:31:25 +0200
Message-ID: <CAHp75VeQzY+Pfru4LSgv+fqya-2F7G21TjaVsybCqQBSD8NeUw@mail.gmail.com>
Subject: Re: [PATCH 1/6] tty: add port flag to suppress raising DTR & RTS on open
To:     "Mychaela N. Falconia" <falcon@freecalypso.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Mychaela Falconia <mychaela.falconia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, May 28, 2022 at 8:51 PM Mychaela N. Falconia
<falcon@freecalypso.org> wrote:
>
> There exist special serial devices (either attaching to generic serial
> ports or containing a built-in USB-serial chip) in which DTR and/or RTS
> have been repurposed for non-standard uses.  Depending on exactly how
> these signals are repurposed, standard POSIX/SUS behaviour of

Which version of POSIX and SUS standards are in consideration?

> unconditionally raising both signals on open may range from harmless
> to undesirable to a total killer, precluding the use of Linux with
> such custom hardware.
>
> The newly added TTY_PORT_MANUAL_RTSDTR flag switches an individual
> serial port from POSIX/SUS standard to non-standard behaviour: when
> set, it suppresses the built-in action of raising DTR & RTS on serial
> port open.
>
> This flag can be exported through sysfs, and it can also be set by
> USB-serial device drivers when they see a custom hw device (identified
> by VID:PID) that is known to be wired in a way that requires this flag
> to be set.

Is it only the USB class of devices that are affected or do we have
examples on other buses?

...

>  void tty_port_raise_dtr_rts(struct tty_port *port)
>  {
> -       if (port->ops->dtr_rts)
> +       if (port->ops->dtr_rts && !tty_port_manual_rtsdtr(port))
>                 port->ops->dtr_rts(port, 1);

Logically I would put them otherwise, first to check a custom flag and
then the existence of the callback.

>  }

-- 
With Best Regards,
Andy Shevchenko
