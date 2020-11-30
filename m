Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D84C64E7B
	for <linux-serial@archiver.kernel.org>; Mon, 30 Nov 2020 18:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08EA2074A
	for <linux-serial@archiver.kernel.org>; Mon, 30 Nov 2020 18:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImC2tXLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgK3S1q (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Nov 2020 13:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgK3S1q (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Nov 2020 13:27:46 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE78AC0613D6;
        Mon, 30 Nov 2020 10:27:05 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id p6so6957669plr.7;
        Mon, 30 Nov 2020 10:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kjq7AqurfeU73O1TvNnB5Y0LVcGlDBz5FkbYl20IufU=;
        b=ImC2tXLjBq/6sX2N/46SyLLN8+pobdu3/UY54y5DuhKe6J39QsrDbaZU5si9EXoHNc
         NhEdeNRNXAviG2HUrPIMO5G7uNSrBXakTKc51lSiLn86ioqSTxZg+MdlRJJwuqI3GAv6
         y8Ll3j3fsWB1f7oSyJD/PBfMPLiEOP8Hdvj3sGpVhZ+uHy75cebuZS/q1h+23DMXby2K
         G711GRW5TcmiPGCkkSr4pKJHOntAKwHzFE/s9kgu5y4Vuuki4+qHf6IKaGSAlUn+itdQ
         qrNLr+fgU+dvn6ma14N/pxvmUZWGZQQxaT9r8VPvd5N5KdgF7w1irR/5VTPJV7JYf6in
         qPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjq7AqurfeU73O1TvNnB5Y0LVcGlDBz5FkbYl20IufU=;
        b=n8/hC9c+NSiD9TC31kDHk3FxLxPmZQ8AtSGgDyYsoiQUxKLZf6Kwetue4S7z9Kb/LM
         eeJH7pr3XUKj7pkjKWgtsQMuA9HGUHcQTFnpoh02DHLXRrfTr+AH4g29y6rZmWvdl7Bl
         lIW3AmHDPPYMcdh7rVVIRWbnj/HjE2YGrwqueGRrWHMFcyj0eJ705OdR1GS/TnAJmYhv
         322DtA36aWFlxh03q2UawxgGtaTRIkPd9i4MP5iVhJ62QFytzTORaPp4rI0G/s6d5aQI
         bx6HR20SfIcIW9XMOxmB8EoTuIbTk9fMofh/W7bEEmNAh/Nj5zhB0vkgSP7ChVBOtnM+
         h4mw==
X-Gm-Message-State: AOAM530qjuiKIacJ7nHCiJV911G6kSwFHs+gqmya34Eg5Xilmi50hO2v
        1E+N4QVZ27zFzYn+7fHWYSeYwMxs1mh0ihQzV2GDv8tpw9s=
X-Google-Smtp-Source: ABdhPJzZT74pc8LY5TmeNr2gqUnmChzjOPkZ/CaNXyHbonCAXs4PDvd/WvcAYTa4q0cV+/kDpY0/7aJllNiQdZtUY3c=
X-Received: by 2002:a17:90b:350:: with SMTP id fh16mr121104pjb.228.1606760825351;
 Mon, 30 Nov 2020 10:27:05 -0800 (PST)
MIME-Version: 1.0
References: <20201130153742.9163-1-johan@kernel.org> <20201130153742.9163-3-johan@kernel.org>
In-Reply-To: <20201130153742.9163-3-johan@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Nov 2020 20:27:54 +0200
Message-ID: <CAHp75VdedN5iaGFpfiPFz6G=Ey3axgaZbKYtt95HEwwjWoWbmQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] serial: core: add sysfs attribute to suppress ready
 signalling on open
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 30, 2020 at 5:42 PM Johan Hovold <johan@kernel.org> wrote:
>
> Add a nordy sysfs attribute to suppress raising the modem-control lines
> on open to signal DTE readiness.

Why not call it nomctrl ?

> This can be use to prevent undesirable side-effects on open for

used

> applications where the DTR and RTS lines are used for non-standard
> purposes such as generating power-on and reset pulses.

...

> +static ssize_t nordy_store(struct device *dev, struct device_attribute *attr,
> +                               const char *buf, size_t count)
> +{
> +       struct tty_port *port = dev_get_drvdata(dev);
> +       unsigned int val;
> +       int ret;
> +
> +       ret = kstrtouint(buf, 0, &val);
> +       if (ret)
> +               return ret;

> +       if (val > 1)
> +               return -EINVAL;

Can't we utilise kstrtobool() instead?

> +       tty_port_set_nordy(port, val);
> +
> +       return count;
> +}

-- 
With Best Regards,
Andy Shevchenko
