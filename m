Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025F6C64E7A
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 10:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBCA20809
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 10:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgLAK6Q (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 05:58:16 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40074 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgLAK6P (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 05:58:15 -0500
Received: by mail-lf1-f66.google.com with SMTP id u19so3260996lfr.7;
        Tue, 01 Dec 2020 02:57:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=du7uqxSFDOlCM/d6eepPiXeCZVMNky/Lr2KTn2WudY4=;
        b=IAMqSIRAh7QvKLiHcCM6q3RQMpXFiN4V/ttF5moY/5uworb0A5WAvsnygJp5dfhIgK
         dQXFbg4hBvr0in0dF9t8y11r97p1ZwvG1AanKEoau7ztDdIvFYoZfPNeX+VsDsw5Tfay
         +lOa4wcsJ5lMNsdoRZFyoz0/Rw3VTxOyvpYaIzhBfai16Sn7lhOpsYgaZl4fOx/1Haxl
         rsXwTXwHhQxbpSL6z4kUE/vGyi9+H3Nzo3e6nmKociBgUyQ9dI90mlSzlRWW+dEi1+kj
         I+YYKPvxPycX9TdFx/4jEMe5HzbVe9hoIJcbIm00HnQaGZ6HBrko2j9CwRT1XOO6xoui
         T0Sg==
X-Gm-Message-State: AOAM530IqG7WwPEkpuirPiIkn3eJvkxN/F7kpGz6LVLwqrE7pOgoOARV
        iM3mQylFhThRrO+R5kVy1Q4=
X-Google-Smtp-Source: ABdhPJwT47z4c6gcp5xcXM7WhIzVaegIW/1/ElHuQiuhC816et9p1/qKqS2CNVExVnI3Cp4rAU4cpA==
X-Received: by 2002:ac2:4c9a:: with SMTP id d26mr932274lfl.427.1606820253539;
        Tue, 01 Dec 2020 02:57:33 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id a22sm165777lfl.11.2020.12.01.02.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 02:57:32 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kk3M9-0007Iw-Tz; Tue, 01 Dec 2020 11:58:02 +0100
Date:   Tue, 1 Dec 2020 11:58:01 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mychaela Falconia <mychaela.falconia@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] tty: add flag to suppress ready signalling on open
Message-ID: <X8YhuQeBtMrbh42W@localhost>
References: <20201130153742.9163-1-johan@kernel.org>
 <CA+uuBqYmzJMiY75LrA_uKb_uL2=7oQTrzCFksb2ehT0XMXxrbw@mail.gmail.com>
 <CAHp75Vczx=qjNed-8nwm6iSq5sxUKE2mXzPSd70zUxumZ5sANQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vczx=qjNed-8nwm6iSq5sxUKE2mXzPSd70zUxumZ5sANQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 01, 2020 at 12:48:48PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 30, 2020 at 11:25 PM Mychaela Falconia
> <mychaela.falconia@gmail.com> wrote:

> > > Why not call it nomctrl ?
> >
> > I have no opinion one way or another as to what the new sysfs attribute
> > should be called - my use case won't involve this sysfs mechanism at
> > all, instead I care much more about the path where the tty port flag
> > gets set via a driver quirk upon seeing my custom USB ID. :)
> 
> Then why do we bother with sysfs right now? It's an ABI and Johan is
> completely aware and knows that once it's in the kernel it is close to
> being carved in stone.
> I would vote to remove sysfs from now and see if we really need it in
> the future.

Eh, because this is generally useful and has come up in the past. I'm
not interested in adding quirks for odd devices that want non-standard
behaviour that we need to maintain indefinitely; that's precisely why I
proposed a general interface that can be use with any serial port.

Johan
