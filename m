Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC6DC43334
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jul 2022 16:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiGLQxk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jul 2022 12:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiGLQxj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jul 2022 12:53:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FF1631A;
        Tue, 12 Jul 2022 09:53:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFDC261999;
        Tue, 12 Jul 2022 16:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CB8C3411C;
        Tue, 12 Jul 2022 16:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657644816;
        bh=AteLLtbvakx1vBJu6F5E6kPBaxAVBPBVW1kg1qHqUNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYAAnmbLEjSDEBj3t8q0Uq4RiByFfY0kiGQTiRpXbr2R3MQlFHHyWvuKQj7QDXn/h
         b3HAcs0hQjZrAlPu3NC8zuJS1oGhWwzvo2e3wv4WkM6mwpnqoKtgt82C/O0U1prSrZ
         eztc02DytcfTWQy7pyj42nZCOsreMPrHpwaygkZ8CALKZ/TkojjwImm3JCozPMFIfU
         LgGsWPLI8vDHFIcWbf/0b2muuqRkC///g2xzATUl2ErzWkViMexJ/qEv92weAOo/Mu
         MIV/I+yQGDdk7bjzu+Ew3BRITeLo79sIFVWUVpiadLqYzm/DIAzjSfhFugCT+P4F2z
         0QDyhQHxP0WfA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oBJ8k-000726-De; Tue, 12 Jul 2022 18:53:39 +0200
Date:   Tue, 12 Jul 2022 18:53:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jonathan Woithe <jwoithe@just42.net>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [Regression] CH341 USB-serial converter passes data in 32 byte
 chunks
Message-ID: <Ys2nEmkvz2dfAKkU@hovoldconsulting.com>
References: <Ys1iPTfiZRWj2gXs@marvin.atrad.com.au>
 <Ys1sfRyL6El7go94@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys1sfRyL6El7go94@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 12, 2022 at 02:43:41PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jul 12, 2022 at 09:29:57PM +0930, Jonathan Woithe wrote:
> > Hi all
> > 
> > For many years I have been using a CH341 USB-serial converter (VID:PID
> > 4348:5523) to drive a microcontroller programming dongle.  This was under
> > kernel 4.4.14.  When I recently upgraded the machine to a 5.15.27 kernel the
> > programmer stopped working, reporting timeouts.  Using a loopback cable and
> > minicom I discovered that under 5.15.27 data was only delivered back to
> > minicom in blocks of 32 characters.  This explains why the programming
> > software reported timeouts.  It seems that either outgoing data is blocked
> > until 32 bytes are ready for transmission, or receive data is only reported
> > in blocks of 32 bytes.
> > 
> > Under 4.4.14 (and all kernels prior to 4.10.0), individual characters are
> > echoed back by minicom as soon as they hare pressed on the keyboard.
> > 
> > As far as I can tell, the regression affects all kernels since 4.10.0.
> > 
> > I have done a git bisect which identified the following commit as the source
> > of the problem.
> > 
> > commit 55fa15b5987db22b4f35d3f0798928c126be5f1c
> > Author: Johan Hovold <johan@kernel.org>
> > Date:   Fri Jan 6 19:15:16 2017 +0100
> 
> Please always cc: the developer who wrote a commit that you have
> questions about, so that they are sure to see it, otherwise it's just
> random luck :)

Thanks for the report, and for forwarding it.
 
> >     USB: serial: ch341: fix baud rate and line-control handling
> > 
> >     Revert to using direct register writes to set the divisor and
> >     line-control registers.
> > 
> >     A recent change switched to using the init vendor command to update
> >     these registers, something which also enabled support for CH341A
> >     devices. It turns out that simply setting bit 7 in the divisor register
> >     is sufficient to support CH341A and specifically prevent data from being
> >     buffered until a full endpoint-size packet (32 bytes) has been received.
> > 
> >     Using the init command also had the side-effect of temporarily
> >     deasserting the DTR/RTS signals on every termios change (including
> >     initialisation on open) something which for example could cause problems
> >     in setups where DTR is used to trigger a reset.
> > 
> >     Fixes: 4e46c410e050 ("USB: serial: ch341: reinitialize chip on
> >     reconfiguration")
> >     Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> It seems like this change does the opposite of what it says, we don't
> want the device to wait for a full endpoint of packets to send stuff
> out, right?

No, the commit does what it says, namely to fix a regression just like
the one reported here (i.e. that data was buffered in 32 byte chunks).

The offending commit was merged in 4.10-rc1 and the above fixed
corrected it 4.10-rc3.

> > It would be great if this regression could be addressed.  At present I must
> > boot a pre-4.10 kernel whenever I need to use the programming dongle with
> > this converter.
> > 
> > Please let me know if there is anything I can do to help resolve the
> > problem.
> 
> If you revert this commit on top of the latest kernel release, does it
> solve the problem for you?

Simply reverting the commit blamed by the bisection should only makes
things worse, at least for some device types.

Perhaps we need to set that bit 7 based on the type, even if the bit
meaning having been inverted seems a bit far-fetched.

Jonathan, could you try simply commenting out the
	
	val |= BIT(7);

statement in ch341_set_baudrate_lcr()?

Also, what chip version do you have (see debug statement in
ch341_configure())?

Johan
