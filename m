Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11749C64E90
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 11:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78F02086A
	for <linux-serial@archiver.kernel.org>; Wed,  2 Dec 2020 11:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgLBLsa (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Dec 2020 06:48:30 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42715 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgLBLsa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Dec 2020 06:48:30 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so4152927lfd.9;
        Wed, 02 Dec 2020 03:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=He+Sa9rFfqOxdvahQG2TB0WWdsTSDzRE0mk+yggW0ao=;
        b=L7RnSdAkjos4papThhSAmN1ZULXFJ7B//oCM3aXMSreOIdeZzUyYF2DpBa1G/+DKZ8
         erqL+UHsrjBoLxxvySiZDN+32adNQ5cDw5VPFPhNvqgbWWeVbvioQpjcG7rp+GqSUPXF
         cQNUK3cwGfc7cK9uagvmIVuRNmN9pkTRLmsJq/12hdRfZnBOZo0C4Wt/B4V0e5zT5c20
         54TbIdxWOT1O2v2QNoWR6MAUjjq0D7ciE5j8/684h1YuTv/6PvRa2sPdhN8MjwYAxyfy
         QUWo+eVPOM4Xru+Dt0MUKKF7NOzSTHboL8NglP6MFEh0FIL4HXKMVTvNnFT0xafz8lOC
         +A6w==
X-Gm-Message-State: AOAM532xbcodSIyb8aD/+QZReZ6taEtZBIxP+vAWUtMq1CnoBHVLvvPm
        Og+kQ+31EmMglQXCqu8GRyM=
X-Google-Smtp-Source: ABdhPJy7nLm9BLIO+krjm7ukXB1GlbftAMWyr/RFqOThReZZAiAzUaEFva+vBw4tu5uh0nHmcJU0Dg==
X-Received: by 2002:a19:5e5e:: with SMTP id z30mr1041757lfi.277.1606909667287;
        Wed, 02 Dec 2020 03:47:47 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id u8sm386298lfo.168.2020.12.02.03.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 03:47:46 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kkQcL-000751-39; Wed, 02 Dec 2020 12:48:17 +0100
Date:   Wed, 2 Dec 2020 12:48:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Mychaela Falconia <mychaela.falconia@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] tty: add flag to suppress ready signalling on open
Message-ID: <X8d/Ac5Z4bT/W7ZA@localhost>
References: <20201130153742.9163-1-johan@kernel.org>
 <CA+uuBqYmzJMiY75LrA_uKb_uL2=7oQTrzCFksb2ehT0XMXxrbw@mail.gmail.com>
 <c8f3e485-54c6-99c7-4888-6eef2e174bf6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8f3e485-54c6-99c7-4888-6eef2e174bf6@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Dec 01, 2020 at 08:14:07AM +0100, Jiri Slaby wrote:
> On 30. 11. 20, 22:22, Mychaela Falconia wrote:
> > 2) For situations in which the luxury of a custom USB ID is not
> > available, e.g., a situation where the device that does not tolerate
> > automatic DTR/RTS assertion on open is a physical RS-232 device that
> > can be connected to "any" serial port, the new sysfs attribute comes
> > to the rescue.
> > 
> > Johan's patch comments say that the new flag can also be brought out
> > to termios in the future, similarly to HUPCL,
> 
> The difference to other control flags is that open raises DTR/RTS in any 
> case (i.e. including O_NONBLOCK) -- provided baud rate is set (and it is 
> for casual serials). That means you cannot open a port to configure it 
> (using e.g. setserial) without actually raising the DTR/RTS.

Right, but depending on the application this may be ok (e.g. reset and
initialise on first open after boot, which may have triggered a reset
anyway).

If control over first open is needed, the sysfs interface provides that
out-of-band.

> > but I question the
> > usefulness of doing so, as it is a chicken and egg problem: one needs
> > to open the tty device in order to do termios ioctls on it, and if
> > that initial open triggers DTR/RTS hardware actions, then the end user
> > is still screwed.  If Johan or someone else can see a potential use
> > case for manipulating this new flag via termios (as opposed to sysfs
> > or USB-ID-based driver quirks), perhaps you could elaborate on it?
> 
> We would need to (ab)use another open flag (e.g. O_DIRECT). I am not 
> biased to either of solutions.

Forgot to mention that using open-flags would prevent using standard
utilities like cat, echo and terminal programs. So for that reason a
termios and/or sysfs interface is also preferred.

Johan
