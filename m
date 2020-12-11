Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC648C1B0D8
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 10:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB21023F2B
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 10:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392251AbgLKKmj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Dec 2020 05:42:39 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34080 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390487AbgLKKmc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Dec 2020 05:42:32 -0500
Received: by mail-lf1-f65.google.com with SMTP id m19so12709329lfb.1;
        Fri, 11 Dec 2020 02:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=onb0vWvYKVgv9jIlAPZEnDCvyKGaQ1qrw8/SN9or3bY=;
        b=nGXM0zml1ETlqZT5hZN5HNpGFKOts8TOnvd9C1joR0hhyccROwmiL/oGM9GQ2wSgs2
         6pBxKyT54+lJ4EA6vUXm8LnkYw/bWtS7irb0l5apE0/OskykQ2WgXKzEDcrgTIo/NQyL
         Dqt2dGNa8/mMSI4mxbGmauPscSZHnA2I+4smr7vS9xFTfemCpammSA/S+OsGiEZdwrWd
         Zwfw+csv6sirqYvfKUxudShfIDzpokWw26JLz95PfuU976KDEMNST4gKZhNq8oIA0YN+
         2IoTVoiR91MR5xCbefLk0bD1//tD8nYhkJge0F8StHOji/fPprzUoncyXc/HKYSn0jQ9
         ymjw==
X-Gm-Message-State: AOAM533dPYohZRCLnYanEl5+v3fkOHbOarU8aVf94L+/Sgmhc/g9e37B
        i5oattw9ThPWBR/I7sl5kjw=
X-Google-Smtp-Source: ABdhPJzXe0Kl27LGVfLRrK9PR3df/6wUXauPSa4kk+l/Q/TOc12B00Sq6AQUxUNXAIXKnjkpgC5F5w==
X-Received: by 2002:ac2:4307:: with SMTP id l7mr4093684lfh.304.1607683309183;
        Fri, 11 Dec 2020 02:41:49 -0800 (PST)
Received: from xi.terra (c-d2ade455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.173.210])
        by smtp.gmail.com with ESMTPSA id i9sm953906lja.56.2020.12.11.02.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 02:41:48 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1knfru-0000tU-OJ; Fri, 11 Dec 2020 11:41:47 +0100
Date:   Fri, 11 Dec 2020 11:41:46 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Maarten Brock <m.brock@vanmierlo.com>
Cc:     Mychaela Falconia <mychaela.falconia@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] tty: add flag to suppress ready signalling on open
Message-ID: <X9NM6i5mRTUTFKr9@localhost>
References: <20201202113942.27024-1-johan@kernel.org>
 <X9Dficb8sQGRut+S@kroah.com>
 <CA+uuBqYTzXCHGY8QnP+OQ5nRNAbqx2rMNzLM7OKLM1_4AzzinQ@mail.gmail.com>
 <6b81cca21561305b55ba8f019b78da28@vanmierlo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b81cca21561305b55ba8f019b78da28@vanmierlo.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Dec 10, 2020 at 11:41:24AM +0100, Maarten Brock wrote:
> Hello Mychaela,
> 
> On 2020-12-09 23:49, Mychaela Falconia wrote:

> > But the problem is that the current status quo is fundamentally broken
> > for those hardware devices in which DTR and/or RTS have been repurposed
> > for something other than modem and flow control.  Right now whenever a
> > "cold" (never previously opened) serial port is opened for the first
> > time, that open action immediately and unstoppably asserts both DTR
> > and RTS hardware outputs, without giving userspace any opportunity to
> > say "no, please don't do it".  Yes, this behaviour is codified in a
> > bunch of standards that ultimately trace back to 1970s Original UNIX,
> > but just because it is a standard does not make it right - this
> > Unix/POSIX/Linux "standard" serial port behaviour is a bug, not a
> > feature.
> 
> I agree. And an application not configuring the required handshakes, but
> still relying on them is an equal bug.

Ehh, don't be silly. Relying on having Linux assert DTR/RTS on open is
in no way a bug; it's the standard behaviour that we must continue to
support unless explicitly overridden. Period.

> > But if there exist some custom hw devices out there that are in the
> > same predicament as my DUART28 adapter, but are different in that they
> > are classic old-fashioned RS-232 rather than integrated USB-serial,
> > with no place to assign a custom USB ID, *then* we need a non-USB-ID-
> > dependent solution such as Johan's sysfs attribute or O_DIRECT.
> 
> Any device with a classic old-fashioned RS-232 has probably already
> solved this in another way or is accepted as not working on Linux.
> 
> And then there is also the device tree (overlay?) through which a quirk
> like this can be communicated to the kernel driver. Not sure if this
> could help for a plug-and-play device like on USB.

Not every system use devicetree and no, it doesn't help with
hotpluggable buses either.

Johan
