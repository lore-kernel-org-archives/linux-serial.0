Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2413C4361B
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 17:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D81023DC2
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 17:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394491AbgLKQIJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Dec 2020 11:08:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbgLKQHu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Dec 2020 11:07:50 -0500
Date:   Fri, 11 Dec 2020 17:08:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607702827;
        bh=8K0AfIOlGYfDnbwCgLtNMgoVihEssPErUyL/IHSIz9k=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=BsIaVEp3uqEAYNZk99Io6CDWA37Cm8A4g7a3B87UNlku8RHzGjqhpuNodglNP+fXK
         w8tnKhXsmk50UTXMtrHng+k66xY85uvXrEeJGZhgRXLlEQ7ri7crTlXTeQ59VBKaFP
         aoVjuB3t70dYzaTfbUMaC2WKILbsEN1AVWnD9eJw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mychaela Falconia <mychaela.falconia@gmail.com>
Cc:     Maarten Brock <m.brock@vanmierlo.com>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] tty: add flag to suppress ready signalling on open
Message-ID: <X9OZcKgk2IjYI6z9@kroah.com>
References: <20201202113942.27024-1-johan@kernel.org>
 <X9Dficb8sQGRut+S@kroah.com>
 <CA+uuBqYTzXCHGY8QnP+OQ5nRNAbqx2rMNzLM7OKLM1_4AzzinQ@mail.gmail.com>
 <6b81cca21561305b55ba8f019b78da28@vanmierlo.com>
 <X9H9i98E1Gro+mDP@kroah.com>
 <3fc3097ce1d35ce1e45fa5a3c7173666@vanmierlo.com>
 <X9IcKoofq+2iGZn7@kroah.com>
 <CA+uuBqaNcKadyLRyufm+6HUHXcs7o0rtgw84BrHc7Jq9PauV8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+uuBqaNcKadyLRyufm+6HUHXcs7o0rtgw84BrHc7Jq9PauV8Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Dec 10, 2020 at 10:59:41AM -0800, Mychaela Falconia wrote:
> Greg K-H wrote:
> 
> > Companies/devices lie about vid:pid all the time,
> 
> Wait, are you accusing *me* of lying?  PID range 0x7150 through 0x7157
> out of FTDI's VID 0x0403 has been officially allocated by FTDI (please
> feel free to confirm with FTDI, no need to take my word blindly) to
> Falconia Partners LLC, which is *my* company - Falconia is my last
> name.  Therefore, any accusation of lying in connection with any
> VID:PID in this range, including DUART28C VID:PID of 0x0403:0x7152, is
> an accusation of lying against me personally, which I take very
> seriously.

I am not saying you are using an "invalid id", or copying anything, see
below:

> > wait until your
> > specific vid:pid is repurposed for some other device and then what
> > happens?  :)
> 
> Let's break it down:
> 
> 1) I do have an idea for a future hw product that could indeed reuse
> DUART28C VID:PID - however, the reason for reusing the same USB ID is
> that the potential product in question would have exactly the same
> wiring inside and require the exact same handling from Linux, i.e.,
> suppress automatic DTR/RTS assertion on Channel B, but retain standard
> behaviour on Channel A.
> 
> 2) If I were to reuse the same USB ID for a different hw product that
> should NOT receive the exact same quirk treatment, it would be 100% my
> fault and I would have no right to run to OS maintainers complaining,
> or even to sell such product, I would argue.
> 
> 3) If some other party illegally squats on a PID out of FTDI's VID
> range which FTDI officially allocated to me, and then comes to Linux
> maintainers with a complaint however many years from now, whoever will
> be the maintainer at that time will be able to check with FTDI, get an
> official answer as to whom that PID rightfully belongs to, and that
> will be the resolution.

We see devices that are "obviously" not the real vid/pid all the time in
the wild.  There's nothing "illegal" about another company using your
vid/pid, look at all of the ones out there already that use the FTDI
vendor id yet are "clones", same with pl2303 devices.

We also have fuzzing devices that spoof vid/pid pairs in order to test
kernel code, as well as being used as malicious devices to hack systems
or do other "fun" things.  Blindly trusting these numbers are something
we can no longer do.

The point being, while it is nice to trigger off of these values, beware
that it is not the only way that something like a userspace visable
change should trigger off of because this is something that a user wants
to have happen.  This also makes it easier as it "should" work for all
serial devices, and not be tied to specific hardware ids, requiring
kernel updates for new devices that want to do this.

hope this helps explain this a bit more.

> > O_DIRECT is an interesting hack, has anyone seen if it violates the
> > posix rules for us to use it on a character device like this?
> 
> According to open(2) Linux man page, O_DIRECT does not come from POSIX
> at all, instead it is specific to Linux, FreeBSD and SGI IRIX.  Thus
> it seems like there aren't any POSIX rules to be violated here.

Ah, for some reason I thought that newer POSIX releases finally defined
this, as vendors wanted that written down so they could "rely" on it.
Maybe not...

thanks,

greg k-h
