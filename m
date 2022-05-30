Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24300C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 30 May 2022 16:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbiE3QXf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 May 2022 12:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbiE3QXe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 May 2022 12:23:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B7957B33;
        Mon, 30 May 2022 09:23:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED7A0B80E75;
        Mon, 30 May 2022 16:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8705C385B8;
        Mon, 30 May 2022 16:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653927809;
        bh=ht6XEoFiNhtg5eJtqnGr2xAtkI8fVlEizDAsobVhHYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=znBC5C8kKYkxi9tsJLVOVuW2x1YNbFPLaDmnu9AmyozoTBYJaaorgSqUjUvERzwIs
         ujtGE3lRialiSBEkLHVs33ZMUsgilOXehC+KmPJQtDnHw2LhDiL5Ljlzp4x0TTm/OS
         F/YAflFEig66S2gFS+JWF0EvBOlsxMqF3bGr4W4U=
Date:   Mon, 30 May 2022 18:23:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mychaela Falconia <mychaela.falconia@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/6] serial ports: add ability to suppress raising DTR &
 RTS on open
Message-ID: <YpTvffJRWK19ZtW+@kroah.com>
References: <20220527222703.BA4D3374020E@freecalypso.org>
 <YpTGF1dh2RafcFT2@kroah.com>
 <CA+uuBqbAz0SL88HTsg1m-80i9eHS7EjnRyrKE=GWrXA7u1GB_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+uuBqbAz0SL88HTsg1m-80i9eHS7EjnRyrKE=GWrXA7u1GB_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 30, 2022 at 08:05:00AM -0800, Mychaela Falconia wrote:
> Greg K-H wrote:
> 
> > To ignore the public, accepted, standard is to become an operating
> > system that does not follow the standard, which would not be a good
> > thing at all.
> 
> So is FreeBSD 13.x a bad OS then, because it offers an *option* of
> suppressing this particular standard-mandated behaviour?

I never said that, please do not be disengenous, that will only get you
added to people's email filters to be ignored.

> > Again, that is the standard, why wouldn't you want to do that?  To not
> > do that would be to break interoperability with millions of devices out
> > there (remember modems?)
> 
> I don't need to "remember" modems, I use them almost every day in my
> test lab - but none of my proposed patch versions (nor FreeBSD's recent
> CNO_RTSDTR feature addition) break interoperability with anything,
> instead both FreeBSD's solution (for their OS) and my proposed Linux
> patches merely provide an *option* for more specialized hw devices
> that require different handling.

That's fine, but again, you were ranting against the existing standard
as if that was the thing that is wrong and broken here.  Not your
one-off hardware implementation that does not follow the existing
standard.  Please read the context you cut out.

> > > The solution implemented in FreeBSD relies on a feature of that OS
> > > which does not exist in Linux: initial-state devices.
> >
> > Linux dropped those a long time ago for good reasons, let's not revisit
> > that design decision again please.
> 
> Dropped?  Are you saying that Linux once had them at some point in the
> past?

Yes we had much the same thing, but they might have worked a bit
differently.  Check the 2.2 kernel days or earlier.

> > From what I recall with the original patch series, Johan is the author
> > of these, not you.  Rebasing and forwarding on is great, but please
> > never drop original authorship of patches, that's just rude, and in
> > some cases, ripe for legal worries.
> 
> In the case of the 3 patches which originate from Johan (1/6, 2/6 and
> 4/6), I submitted them with the following attribution:
> 
> From: me
> [...]
> Co-developed-by: Johan
> Signed-off-by: Johan
> Signed-off-by: me
> 
> My reading of Documentation/process/submitting-patches.rst told me
> this was the correct protocol - but if I got it wrong, what is the
> correct way then?  Specifically, what is the correct protocol when
> (in this chronological order):

"From:" would be from Johan as he wrote the commit.

thanks,

greg k-h
