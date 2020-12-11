Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599F1C4361B
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 17:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2986923E1B
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 17:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394689AbgLKQIl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Dec 2020 11:08:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbgLKQIW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Dec 2020 11:08:22 -0500
Date:   Fri, 11 Dec 2020 17:08:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607702861;
        bh=1WeVfIHrj5CTqkyBJR1jYYf3odkPTbkUW4EIu+xgpu0=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=hXu+o2p+c8Es89OJnWhGUnKBiLsLTFQzOl3PfdcDZONEdP80JF/OVtrJND5j8ceSX
         90pfMqiaSc3d2qLadRHSx0MjHLEnaczDufoEL6s4sAK7W+WYXOLPzHq7AMoaujp+4F
         9A18/0pUy+yNs4fmjTX5ap5SeDmwpe+Og4K78OsY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Mychaela Falconia <mychaela.falconia@gmail.com>,
        Maarten Brock <m.brock@vanmierlo.com>,
        Johan Hovold <johan@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] tty: add flag to suppress ready signalling on open
Message-ID: <X9OZklRPquV8wE+E@kroah.com>
References: <20201202113942.27024-1-johan@kernel.org>
 <X9Dficb8sQGRut+S@kroah.com>
 <CA+uuBqYTzXCHGY8QnP+OQ5nRNAbqx2rMNzLM7OKLM1_4AzzinQ@mail.gmail.com>
 <6b81cca21561305b55ba8f019b78da28@vanmierlo.com>
 <X9H9i98E1Gro+mDP@kroah.com>
 <3fc3097ce1d35ce1e45fa5a3c7173666@vanmierlo.com>
 <X9IcKoofq+2iGZn7@kroah.com>
 <CA+uuBqaNcKadyLRyufm+6HUHXcs7o0rtgw84BrHc7Jq9PauV8Q@mail.gmail.com>
 <54f40116-9a11-8daa-d3cd-5557cc60a4ef@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54f40116-9a11-8daa-d3cd-5557cc60a4ef@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Dec 11, 2020 at 09:46:54AM +0100, Jiri Slaby wrote:
> On 10. 12. 20, 19:59, Mychaela Falconia wrote:
> > > O_DIRECT is an interesting hack, has anyone seen if it violates the
> > > posix rules for us to use it on a character device like this?
> > 
> > According to open(2) Linux man page, O_DIRECT does not come from POSIX
> > at all, instead it is specific to Linux, FreeBSD and SGI IRIX.  Thus
> > it seems like there aren't any POSIX rules to be violated here.
> > 
> > If we go with O_DIRECT, what semantics are we going to implement?
> > There are 3 possibilities that come to mind most readily:
> > 
> > 1) O_DIRECT applies only to the open call in which this flag is set,
> > and suppresses DTR/RTS assertion on that open.  If someone needs to do
> > multiple opens with DTR/RTS suppression being required every time,
> > then they need to include O_DIRECT every time.
> > 
> > 2) O_DIRECT applies not only immediately, but also sets a latched flag
> > whereby all subsequent opens continue to suppress auto-assertion
> > without requiring O_DIRECT every time.  This approach by itself runs
> > counter to the generic Unix way of doing things, but it may be OK if
> > there is also some ioctl to explicitly set or clear the latched flag.
> > 
> > 3) O_DIRECT applies only to the open call in which it is set, no
> > built-in latching, but there is also some ioctl to control a flag
> > enabling or disabling DTR/RTS auto-assertion on subsequent opens.
> 
> 3) -- to allow standard tools to work on the device after the quirk is set
> up once.

I'm lost, what do you mean here?

thanks,

greg k-h
