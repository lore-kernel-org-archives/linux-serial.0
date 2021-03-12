Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24736C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 12 Mar 2021 13:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA55A64FC9
	for <linux-serial@archiver.kernel.org>; Fri, 12 Mar 2021 13:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhCLNoL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Mar 2021 08:44:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:51770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhCLNoL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Mar 2021 08:44:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C34E164F77;
        Fri, 12 Mar 2021 13:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615556650;
        bh=mVvSkwEsOKN3rHPXEAFiEdEy6jIlgESBUsTEswU/k9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZXxG9V+TvJJxCP+rNHDLoc+QSu4qLI10Jdm6tMvxo8a81Qcbf7wTs85Bipj6guvEF
         gyszkF5TFQX9Elc5T/LDkHG98X9v3nJVQsGPte1D6vWGWdWYsAufHVo8vNKDemJsCo
         sVtpt9cYtvxJqG5t1smPvPQXHtz/3nyOPLx+gFr/D4QlYbJRbYUV86GszY7JfMocCh
         l1bom+rMo0/TsO7T4nsdL2e6OQpN2Doio1G5rVAf96DqJX/xuwg4wP+XItIXAk1sy7
         UXPrITUzq0tw6SyrtOw0dTdVCRKO5hTHzFp2ndfd2rQcxv8g7Rw43Y3fF3x/Hv1QI+
         mw1QYw5PZKT8Q==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lKi5X-000807-NM; Fri, 12 Mar 2021 14:44:23 +0100
Date:   Fri, 12 Mar 2021 14:44:23 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Michael G. Katzmann" <michaelk@IEEE.org>
Cc:     Charles Yeh <charlesyeh522@gmail.com>,
        =?utf-8?B?WWVoLkNoYXJsZXMgW+iRieamrumRq10=?= 
        <charles-yeh@prolific.com.tw>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Joe Abbott <jabbott@rollanet.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <YEtwNzhCmvyKhRto@hovoldconsulting.com>
References: <YDUp0tIThOZSTHJt@hovoldconsulting.com>
 <93584ae4-665e-1e67-01e0-cc53f987bee4@IEEE.org>
 <YDUysZY90FfVhrHK@hovoldconsulting.com>
 <CAAZvQQ6F=cQ-EhC0kgeTVM3GrtBWR+HfM6UJWj2AEF1NYZ-vAQ@mail.gmail.com>
 <YDaGRRYrEO5BEJv0@hovoldconsulting.com>
 <CAAZvQQ7+b9=DKqPxgsXxS7Lhqj=QTzKHCMarSbsQkAnYqdO1GA@mail.gmail.com>
 <YEH7okblCx8+Odxn@hovoldconsulting.com>
 <ddc0e424-21c2-b8f4-1b00-f589267d2b51@IEEE.org>
 <YEpAaL9QtVMduEpi@hovoldconsulting.com>
 <9d02257d-cca1-116e-634a-6ac952362c5d@IEEE.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d02257d-cca1-116e-634a-6ac952362c5d@IEEE.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 12, 2021 at 08:17:55AM -0500, Michael G. Katzmann wrote:
> On 3/11/21 11:08 AM, Johan Hovold wrote:

> >> static speed_t pl2303_encode_baud_rate_divisor( struct usb_serial_port *port,
> >> 							unsigned char buf[4],
> >> 								speed_t baud)
> >> {
> >> 	unsigned int baseline, mantissa, exponent;
> >> 	struct usb_serial *serial = port->serial;
> >> 	struct pl2303_serial_private *spriv = usb_get_serial_data(serial);
> >>
> >> 	/*
> >> 	 * Apparently the formula is:
> >> 	 * baudrate = 12M * 32 / (mantissa * 4^exponent)
> >> 	 * where
> >> 	 *   mantissa = buf[8:0]
> >> 	 *   exponent = buf[11:9]
> >> 	 *
> >> 	 * TA version has more precision
> >> 	 *      uses mantissa = buf[bits 10:0 ]
> > So you discovered that there were even more bits here? Your first
> > version used ten bits, I believe.
> >
> > I got an offline mail from a third person having problems with the TA
> > and who had also verified eleven bits here.
> 
> I was basing this on Joe's discovery of the value used for 110 bd by
> the windows driver (confirmed by Charles). The sequence 80 01 a6 a8
> implies that the mantissa is 0x6a8 (i.e. 11 bits). The tests that I
> did seemed to confirm this.

Ah, of course.

> Pardon my ignorance of the process but where is the git repo for this
> development branch?

I'll wait for a few days before applying the series I posted yesterday
to the usb-next (development) branch, but I've pushed a pl2303-wip
branch for you that you can use use until then:

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/log/?h=pl2303-wip

You can fetch from

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git

Johan
