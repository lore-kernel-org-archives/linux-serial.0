Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED057C00144
	for <linux-serial@archiver.kernel.org>; Fri, 29 Jul 2022 09:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbiG2JKA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Jul 2022 05:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbiG2JJ6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Jul 2022 05:09:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351D785F80;
        Fri, 29 Jul 2022 02:09:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7CB061D43;
        Fri, 29 Jul 2022 09:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36713C433C1;
        Fri, 29 Jul 2022 09:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659085797;
        bh=Yall9tUMFhT+qHLY2CQ4RSosUaj/51DCndyhqSodfwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EDhl5tT7SbJkV/HJQ0XFnAcSYYRAxBs6zIbsygfA5WSuGuiOZaeznd7/59bqcDTyx
         KOoJWtjbBNoY92yz5vT/FgNSCKaSb2IhhJ7ouXcX3gBJAWsCLDN69M5bCZthSGzHas
         loHhPQeZxlhfLimqXbA4ri4Aingn/LxrjJS1ZYLmRXQbwF+4sTPKqtDA9FQKF1lypt
         okdBjHL7BjdG+VRDFnN6BsdJAhJmTS+cya7KYfPZu1J4fA6yo8+yXT0RWF3QYiqW4O
         OpYdNzi3+KC1DOAB585ncflhNHeCyXXoo/Q1v8jhA2QIbjQuk+E9/vxp0kRL+NtUN5
         uTUBcks7tzLtg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oHM0a-0000fD-Gd; Fri, 29 Jul 2022 11:10:13 +0200
Date:   Fri, 29 Jul 2022 11:10:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jonathan Woithe <jwoithe@just42.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Aidan Thornton <makosoft@gmail.com>,
        Grigori Goronzy <greg@chown.ath.cx>,
        Michael Hanselmann <public@hansmi.ch>
Subject: Re: [Regression] CH341 USB-serial converter passes data in 32 byte
 chunks
Message-ID: <YuOj9EHckqzR1/KF@hovoldconsulting.com>
References: <Ys4QOgNF0pJDwRCJ@marvin.atrad.com.au>
 <YtUfcSOTl/ia+ahL@hovoldconsulting.com>
 <YtYsFVCShDeVCeis@marvin.atrad.com.au>
 <YtZG5vFNpXCXIMf0@hovoldconsulting.com>
 <YtZQjcUMYZEky+Ta@marvin.atrad.com.au>
 <YtZbWhGx/nqgAIX7@hovoldconsulting.com>
 <YtZlwLoDO9CVt9RO@marvin.atrad.com.au>
 <YtahM9hyrPVATchX@marvin.atrad.com.au>
 <YtvT/6DqPjUumpsl@hovoldconsulting.com>
 <Yt8rJWGKdfhkIBBY@marvin.atrad.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt8rJWGKdfhkIBBY@marvin.atrad.com.au>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 26, 2022 at 09:15:41AM +0930, Jonathan Woithe wrote:
> On Sat, Jul 23, 2022 at 12:57:03PM +0200, Johan Hovold wrote:

> > Thanks for testing this. The above observations appear consistent with
> > LCR updates for your CH341 not taking effect (e.g. stuck at 8N1 unlike
> > the PL2303).
> > 
> > An easy way to test this is to send the letter 'q' (0x71) from CH341 to
> > PL2303 (in 8N1 mode). This should be received as 0xf1 if the CH341 is in
> > 7N1 mode as the stop bit is interpreted as MSB, or as 0x71 if still in
> > 8N1 mode.
> 
> Apologies for the delayed response to your requests.
> 
> The result of the above test:
> 
>  1. With both the PL2303 and CH341 in 8N1, "q" is received correctly by
>     both ends.
> 
>  2. With the CH341 configured for 7N1 in minicom and the PL2303 left in
>     8N1, a "q" sent by the CH341 system is received as "q" by the PL2303.
> 
> Thus your suspicion seems to be correct: the LCR changes are not taking
> effect on the CH341.

Thanks for confirming.

> > Actually, LCR configuration wasn't supported before 4.10 either so the
> > only question would be if LCR control works at all with your chip
> > (except for the lost character).
> > 
> > I found this thread where Micahel provides some details after apparently
> > having disassembled the vendor driver:
> > 
> > 	https://lore.kernel.org/all/2e80916d-1be8-dc0f-abf9-adc0feea1803@msgid.hansmi.ch/
> > 
> > Based on that (and the comment that made it into the driver), chips
> > before version 0x30 uses a different protocol for updating LCR so that
> > anything but 8N1 has indeed likely never worked for these chips. 
> > 
> > Could you try the patch below, which simply disables LCR updates for
> > older chips and which I believe you already confirmed works.
> 
> A you expected, I can confirm that with the most recent patch in place as
> sent:
> 
>  1. There are no delays sending or receiving characters on the CH341.
> 
>  2. There is no loss of the first character sent or received by the CH341.
> 
>  3. With both the PL2303 and CH341 in 8N1, "q" is received correctly by
>     both ends.
> 
>  4. With the CH341 configured for 7N1 in minicom and the PL2303 left in
>     8N1, a "q" sent by the CH341 system is received as "q" by the PL2303.
> 
> That is, it seems to work (notwithstanding the LCR issue).
> 
> > And then as a follow up, see if enabling the LCR update again has any
> > effect on the word size (e.g. rerun the test you did above, or the "q"
> > test I mentioned).
> 
> I commented out the "priv->version < 0x30" conditional to re-enable the LCR
> update and repeated the above test.  The result was the same: with the
> PL2303 in 8N1 and the CH341 supposedly in 7N1, both ends received a "q" as
> "q".
> 
> > This may give an indication of how far we are from being able to support
> > LCR updates on older chips even this is not something we need to
> > implement now.
> 
> It seems there are still some mysteries left to solve surrounding the
> earlier chips.  At least they seem to work in 8N1 through, which is what
> most things would be using these days.

Thanks for confirming, and for all your careful testing so far.

I'll wrap this this up in the next few weeks (merge window) and get this
fixed in 5.20-rc and backported to stable. I'll keep you on CC.

Johan
