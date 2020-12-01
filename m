Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5945C64E8A
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 08:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E62206D8
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 08:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgLAIkZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 03:40:25 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43147 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgLAIkY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 03:40:24 -0500
Received: by mail-lf1-f67.google.com with SMTP id q13so2478521lfr.10;
        Tue, 01 Dec 2020 00:40:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MjLBH1cflhBFcl6LdyISGTYGBSe5XpfGgyu9jQzj1CM=;
        b=tUE9Qy2Cf1iRC+gsusfaE7IHMfI0UlTk4CKUYZCO7acFwE5JFG1KqEv+6q25jD3lUF
         1FnTOdNlJX9zYM1oV0ARMCyEpijt+8fMC9BFw87uTGjqQqo6n9OXGJF/e+KgkUstgdDr
         xb8iRmfZZZ2ctpbO37LK+bZdyoiyilDJx/vjnddRn2+wItIhbosisIz5FEoVdYqzVGNC
         uSqpEY26wzBlTQuoE5nxIorL7Hb2502JXoPYiMPTpKYHZwbE0zKiQOhsDhbLVlvRtU4v
         FQ9atbf47LL9wry532PlF87UpCtR+GwEvPfrg5l+2DUFaN7/BzC5V/TToYEkxiFHNClt
         sv1w==
X-Gm-Message-State: AOAM532ViKtrNIb1c5p7NkMI+g/izG5/ONsDl+Lo5CR9lxXDdNmGPx9p
        or1DTFL8A5O7GfhL4807+/0=
X-Google-Smtp-Source: ABdhPJxkpVHP/xAsARyqEb2/B9OVaHDG/Bej/tto3bL6B27YKQ6177MMhs3NVPJ+KWVDoAIVtRIpzQ==
X-Received: by 2002:a19:8854:: with SMTP id k81mr740945lfd.577.1606811982325;
        Tue, 01 Dec 2020 00:39:42 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id x23sm124165lfa.219.2020.12.01.00.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 00:39:41 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kk1Cl-0003EW-8j; Tue, 01 Dec 2020 09:40:11 +0100
Date:   Tue, 1 Dec 2020 09:40:11 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mychaela Falconia <mychaela.falconia@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] tty: add flag to suppress ready signalling on open
Message-ID: <X8YBaydsuB/+UxcX@localhost>
References: <20201130153742.9163-1-johan@kernel.org>
 <CA+uuBqYmzJMiY75LrA_uKb_uL2=7oQTrzCFksb2ehT0XMXxrbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+uuBqYmzJMiY75LrA_uKb_uL2=7oQTrzCFksb2ehT0XMXxrbw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 30, 2020 at 01:22:07PM -0800, Mychaela Falconia wrote:

> Johan's patch comments say that the new flag can also be brought out
> to termios in the future, similarly to HUPCL, but I question the
> usefulness of doing so, as it is a chicken and egg problem: one needs
> to open the tty device in order to do termios ioctls on it, and if
> that initial open triggers DTR/RTS hardware actions, then the end user
> is still screwed.  If Johan or someone else can see a potential use
> case for manipulating this new flag via termios (as opposed to sysfs
> or USB-ID-based driver quirks), perhaps you could elaborate on it?

Depending on the application it may be acceptable to assert the
modem-control lines on first open (e.g. before initialisation). 

A new termios flag allows for a generic interface which could be shared
with other OSes and controlled through stty.

In case that isn't sufficient and you need control over the default port
setting, you can always fall back to the Linux-specific sysfs interface.

> In any case, it would be really awesome if this patch series (with or
> without further modifications) can make it into 5.10 - any chance of
> such happening, or will it have to be pushed out to 5.11?

Let's see, but I don't think this necessarily has to take that long to
get merged.

Johan
