Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA01AC433E0
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jan 2021 15:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EBFA23405
	for <linux-serial@archiver.kernel.org>; Thu,  7 Jan 2021 15:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbhAGPYh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 7 Jan 2021 10:24:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbhAGPYh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 7 Jan 2021 10:24:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 490C0224B0;
        Thu,  7 Jan 2021 15:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610033036;
        bh=f+RvX/8PLKLcATPKcNCbrp8iv9sFa7OxE+/hcfSwHOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hvYxI5VcYh5vz74cw/yMwWDAOL8KV73cVhkXn7BInLaPM2R6lTKpaEsTy3eie84v0
         Osdj0HWs/rTfcA+pLGcnEJUUr16gk7WiKd7c+FbcGsspblsei8vMs6bH+OC2I2Fifa
         NxYKnT5oLsqnwP3ynrnv9INGYjHH+oabhMuXZRmM=
Date:   Thu, 7 Jan 2021 16:25:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mychaela Falconia <mychaela.falconia@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Maarten Brock <m.brock@vanmierlo.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] tty: add flag to suppress ready signalling on open
Message-ID: <X/cn3N4yk+A66pX0@kroah.com>
References: <20201202113942.27024-1-johan@kernel.org>
 <X9Dficb8sQGRut+S@kroah.com>
 <CA+uuBqYTzXCHGY8QnP+OQ5nRNAbqx2rMNzLM7OKLM1_4AzzinQ@mail.gmail.com>
 <6b81cca21561305b55ba8f019b78da28@vanmierlo.com>
 <X9H9i98E1Gro+mDP@kroah.com>
 <3fc3097ce1d35ce1e45fa5a3c7173666@vanmierlo.com>
 <X9IcKoofq+2iGZn7@kroah.com>
 <CA+uuBqaNcKadyLRyufm+6HUHXcs7o0rtgw84BrHc7Jq9PauV8Q@mail.gmail.com>
 <X9d039qPr/LO/2R/@localhost>
 <CA+uuBqZgq4KRZsqGRKDUbKAcQxYr1XPhYDrjzMNfWMYgDX8Wfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+uuBqZgq4KRZsqGRKDUbKAcQxYr1XPhYDrjzMNfWMYgDX8Wfg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Dec 18, 2020 at 10:03:59AM -0800, Mychaela Falconia wrote:
> Greg K-H wrote:
> 
> > We see devices that are "obviously" not the real vid/pid all the time in
> > the wild.  There's nothing "illegal" about another company using your
> > vid/pid, look at all of the ones out there already that use the FTDI
> > vendor id yet are "clones", same with pl2303 devices.
> 
> But are those reusers of someone else's VID or PID coming to Linux
> kernel maintainers with requests to modify ftdi_sio or pl2303 drivers
> to work with their clones?  Do you ever see LKML posts along the lines
> of "Hi, I am so and so from such and such company, we are not FTDI but
> we reuse FTDI's VID and PIDs, but our clone chip does not match the
> original and we need to modify the ftdi_sio driver to work with our
> poor man's clone chip" - do reusers of someone else's VID or PID come
> here with such requests?

Users of devices with cloned ids come to us asking why their devices do
not work on Linux and how to fix them.  Happens all the time, and as the
job of a kernel is to enable hardware, we work to make this happen.

The vendors who do this are no where to be found, of course, and telling
people that the device they just purchased is "counterfit" doesn't
really fall in our job description.  We have all sorts of work-arounds
in Linux drivers to support "fake" devices, our job is to make Linux
work for everyone.

Anyway, this is far off-topic for this thread, sorry, just letting you
know why trying to rely on vid/pid is not the "final solution" people
might think it is.

I wish someone else would have weighed in on the different api options
here, oh well, let me think about this over the next week or so...

thanks,

greg k-h
