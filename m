Return-Path: <SRS0=zL5S=3D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F321C33C9E
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 17:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590E52465A
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 17:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579024611;
	bh=yOtLnUO5Ym3EaCqIMQHuofC8OLSSDAFzdn+4A1v7ju8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eu6bx0z6w9W3oTfYkFvxVRvFisBaPDdMdFjS6TUobAeQkGzlEhG4wc/Y5txIapZnn
	 Jppv33WBlFE8UUotne12Q4uwsvfxZjGNxihEDh2+Kdatinj9OTZOHhFquLF2Rrt2FH
	 zcprXVCw2+07isTMckiEt/jTHRCR0krP9YDPQHlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgANR4v (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:56:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgANR4v (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jan 2020 12:56:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ECA724656;
        Tue, 14 Jan 2020 17:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579024610;
        bh=yOtLnUO5Ym3EaCqIMQHuofC8OLSSDAFzdn+4A1v7ju8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kSmLnGtYFH2i3CoU+unGvIp1h6C8YQ4yTiLkhriTng6g4qEx/sCAsL8sd80jNr0cI
         WdHRaM/jOmQYryhjrZvsclFhdtjlf8vI4JmnGfm0bb8oq6kwqCZCKvcHeL3GGa2LZR
         UTew4F5VjJohhyqakV4EttOn+4B0OXvL2eiSB5GU=
Date:   Tue, 14 Jan 2020 18:56:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCHv2-next 3/3] serial_core: Remove unused member in uart_port
Message-ID: <20200114175647.GA2055173@kroah.com>
References: <20200114171912.261787-1-dima@arista.com>
 <20200114171912.261787-4-dima@arista.com>
 <e1b3cccb0814ba4b0c99592715776ed48f343795.camel@perches.com>
 <8f11e2fa-495d-fe25-f5e4-52c9580240d7@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f11e2fa-495d-fe25-f5e4-52c9580240d7@arista.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 14, 2020 at 05:47:33PM +0000, Dmitry Safonov wrote:
> On 1/14/20 5:36 PM, Joe Perches wrote:
> > On Tue, 2020-01-14 at 17:19 +0000, Dmitry Safonov wrote:
> >> It should remove the align-padding before @name.
> > []
> >> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> > []
> >> @@ -247,7 +247,6 @@ struct uart_port {
> >>  
> >>  	unsigned char		hub6;			/* this should be in the 8250 driver */
> >>  	unsigned char		suspended;
> >> -	unsigned char		unused;
> > 
> > I suggest this not be applied as this is just to let
> > readers know that there is an unused 1 byte alignment
> > hole here that could be used for something else.
> 
> Heh, 2/3 adds another `unsigned char`, so the neighbours look like:
> 
> : unsigned long sysrq;		/* sysrq timeout */
> : unsigned int	sysrq_ch;	/* char for sysrq */
> : unsigned char	has_sysrq;
> : unsigned char	sysrq_seq;	/* index in sysrq_toggle_seq */
> :
> : unsigned char	hub6;		/* this should be in the 8250 driver */
> : unsigned char	suspended;
> : unsigned char	unused;
> : const char	*name;		/* port name */
> 
> So the hole became 4 bytes on 64-bit.
> 
> I can make it unused[4], but..
> 
> Separated the patch per Greg's review and I think it makes sense to have
> it separately from 2/3 because last time I've touched it, it actually
> was in use by drivers (regardless the name).

Yes, it makes sense to remove it now.  And then we can properly
reorginize the structure if people really care about the padding issues
(hint, I really doubt it).  Someone can run pahole on the structure if
they care, but getting rid of "unused" is good as it has been abused in
the past.

thanks,

greg k-h
