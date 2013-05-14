From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] serial: sccnxp: Improve verify_port
Date: Tue, 14 May 2013 12:46:39 -0400
Message-ID: <20130514164639.GA3686@kroah.com>
References: <1368547151-7384-1-git-send-email-shc_work@mail.ru>
 <20130514160931.GA2695@kroah.com>
 <1368549047.374871060@f159.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:50858 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658Ab3ENQq2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 May 2013 12:46:28 -0400
Received: by mail-vc0-f173.google.com with SMTP id ht10so823154vcb.32
        for <linux-serial@vger.kernel.org>; Tue, 14 May 2013 09:46:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1368549047.374871060@f159.mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Tue, May 14, 2013 at 08:30:47PM +0400, Alexander Shiyan wrote:
> > On Tue, May 14, 2013 at 07:59:11PM +0400, Alexander Shiyan wrote:
> > > The patch improves verify_port procedure by comparing the type of
> > > port and IRQ numbers simultaneously. This can be important in the
> > > case of multiple drivers SCCNXP in the system that are different IRQs.
> > 
> > So this fixes a bug?  Really?
> 
> Only in theory.

How?  It really doesn't look like you are doing anything here, except
rearranging the logic to look different, but yet do the same thing.

So again, why are you doing this?

greg k-h
