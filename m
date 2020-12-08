Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C9BC433FE
	for <linux-serial@archiver.kernel.org>; Tue,  8 Dec 2020 09:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3443D23A7E
	for <linux-serial@archiver.kernel.org>; Tue,  8 Dec 2020 09:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgLHJaQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Dec 2020 04:30:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40768 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgLHJaQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Dec 2020 04:30:16 -0500
Received: by mail-lj1-f193.google.com with SMTP id x23so11314467lji.7;
        Tue, 08 Dec 2020 01:29:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bl1BpzFHK81haaQNi3dHDZIBtyotDgiUUbLCQGH6GfI=;
        b=SQBhODFnNvXBiJfUCF9Uwf1e+3Lk9eLuJRYWOODP2VPL4hre93105NtZmTq6F4aFHf
         gomzq23ms1ACmm+OrwURakYdLdtnPilbRjNxT75vfUVau7nmT8yOIFW6YwKMco0dCSpl
         /X/2nTrYymYfjzzcYh159xUeA4T+KiM247MZSkgfTCu6C4p3shXqpjOKpbVuE29zV/X1
         zWu/balRE2gpUMSddvqwKbTPDZjPizbmCXptFGusM1WmCxfbc3uc4Yl1e8o2QST32/qE
         REyv9x8iVZVuw7bbkCHgtWvsoal4IrXKaZvX/aV4mrX7JV4pdfCRXgcgtcH46mbWAfbT
         DMpw==
X-Gm-Message-State: AOAM532V78+ywnX4O/bESjXHBZXGODNsrIbXJAfzwQwt/yFEgWfNZFVE
        kEJtmGqDBbOAO3hwLjhjyc6ahzoB4qh2/g==
X-Google-Smtp-Source: ABdhPJzHrVV9YWmfaaFMMWTV5pgu/BNkM/0NoXuaq4HsnWzuDQU6v34rrJi6vLLFiflu1MxTNKokfA==
X-Received: by 2002:a2e:9990:: with SMTP id w16mr10427297lji.111.1607419767923;
        Tue, 08 Dec 2020 01:29:27 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id e10sm3172455lfn.115.2020.12.08.01.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 01:29:27 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kmZJs-0002TL-Vz; Tue, 08 Dec 2020 10:30:05 +0100
Date:   Tue, 8 Dec 2020 10:30:04 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Mychaela Falconia <mychaela.falconia@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] tty: add flag to suppress ready signalling on open
Message-ID: <X89HnHOUy9519yhU@localhost>
References: <20201130153742.9163-1-johan@kernel.org>
 <CA+uuBqYmzJMiY75LrA_uKb_uL2=7oQTrzCFksb2ehT0XMXxrbw@mail.gmail.com>
 <c8f3e485-54c6-99c7-4888-6eef2e174bf6@kernel.org>
 <X8d/Ac5Z4bT/W7ZA@localhost>
 <a58e3a7b-58bb-0430-2344-8e8155758e45@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a58e3a7b-58bb-0430-2344-8e8155758e45@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Dec 04, 2020 at 07:58:53AM +0100, Jiri Slaby wrote:
> On 02. 12. 20, 12:48, Johan Hovold wrote:
> >>> but I question the
> >>> usefulness of doing so, as it is a chicken and egg problem: one needs
> >>> to open the tty device in order to do termios ioctls on it, and if
> >>> that initial open triggers DTR/RTS hardware actions, then the end user
> >>> is still screwed.  If Johan or someone else can see a potential use
> >>> case for manipulating this new flag via termios (as opposed to sysfs
> >>> or USB-ID-based driver quirks), perhaps you could elaborate on it?
> >>
> >> We would need to (ab)use another open flag (e.g. O_DIRECT). I am not
> >> biased to either of solutions.
> > 
> > Forgot to mention that using open-flags would prevent using standard
> > utilities like cat, echo and terminal programs. So for that reason a
> > termios and/or sysfs interface is also preferred.
> 
> Nope, I meant it differently. You set it up once using the special open 
> flag. Like with setserial, one sets I/O port, irqs etc. and then uses 
> standard tools as the port is already set up (marked as NORDY in this
> case).

Ok, but leaving the open flag abuse aside, that would still require a
custom tool to do the setup.

There are also no other examples of such an interface with a "sticky"
open flag affecting later opens. But you probably meant that the open
flag only affects the current open, and then the termios flag is used
to make the setting stick. 

Note that having a udev rule handle this at boot using a sysfs interface
does not require any custom tools at all.

And in theory nothing prevents extending/abusing POSIX with such an open
behaviour later.

Johan
