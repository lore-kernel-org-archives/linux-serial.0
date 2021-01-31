Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD25C433DB
	for <linux-serial@archiver.kernel.org>; Sun, 31 Jan 2021 15:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E7A864E27
	for <linux-serial@archiver.kernel.org>; Sun, 31 Jan 2021 15:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbhAaPyv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 31 Jan 2021 10:54:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhAaPyi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 31 Jan 2021 10:54:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D2E660234;
        Sun, 31 Jan 2021 15:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612108436;
        bh=ah6r8UeYnEhlKek8MTboV+B+Bj+BpBVllXLr4EGC76A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nIw2C7Ft/derWwcIHyqQO7eE2n2vI+vubHmKkheA355ljhxtlxVtj1lud9v3nmCTX
         f9jHqByrdazku9t8DTvzZGBrG5s5erY4TpIDh1KEmT33ZxtrNN5fSmdowzQ/fsv+60
         gP5U2Zr3RgU/21DjDIPG8JHaTUTXq7gL1+/m5VNQ=
Date:   Sun, 31 Jan 2021 16:53:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: add option to disable registration of
 legacy ISA ports
Message-ID: <YBbSkig1wcXlbN7f@kroah.com>
References: <20210128172244.22859-1-mans@mansr.com>
 <YBam2m2VMowH5Yth@kroah.com>
 <yw1xwnvtcki0.fsf@mansr.com>
 <YBa0J82FrD6mdP/v@kroah.com>
 <yw1xsg6hcdlt.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xsg6hcdlt.fsf@mansr.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Jan 31, 2021 at 03:47:42PM +0000, Måns Rullgård wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Sun, Jan 31, 2021 at 01:18:47PM +0000, Måns Rullgård wrote:
> >> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> >> 
> >> > On Thu, Jan 28, 2021 at 05:22:44PM +0000, Mans Rullgard wrote:
> >> >> On systems that do not have the traditional PC ISA serial ports, the
> >> >> 8250 driver still creates non-functional device nodes.  This change
> >> >> makes only ports that actually exist (PCI, DT, ...) get device nodes.
> >> >> 
> >> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
> >> >> ---
> >> >>  drivers/tty/serial/8250/8250_core.c | 26 ++++++++++++++++++++------
> >> >>  drivers/tty/serial/8250/Kconfig     |  5 +++++
> >> >>  2 files changed, 25 insertions(+), 6 deletions(-)
> >> >> 
> >> >> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> >> >> index cae61d1ebec5..49695dd3677c 100644
> >> >> --- a/drivers/tty/serial/8250/8250_core.c
> >> >> +++ b/drivers/tty/serial/8250/8250_core.c
> >> >> @@ -555,6 +555,7 @@ static void __init serial8250_isa_init_ports(void)
> >> >>  	}
> >> >>  }
> >> >>  
> >> >> +#ifdef CONFIG_SERIAL_8250_ISA
> >> >
> >> > This is just making a mess of the code. 
> >> 
> >> It was already a mess.
> >
> > True, but don't make it a worse one please.
> >
> >> 
> >> > To do this right, pull the isa code out into a separate file and put
> >> > the #ifdef in a .h file, so we can properly maintain and support this
> >> > code over time.  This change as-is is not going to make that any
> >> > easier :(
> >> 
> >> I might put in that effort if there's a reasonable chance this change
> >> will be accepted.  If it's going to be rejected regardless, I'd rather
> >> not waste my time.
> >> 
> >> >> +config SERIAL_8250_ISA
> >> >> +	bool "8250/16550 ISA device support" if EXPERT
> >> >
> >> > So, no one will set this?
> >> 
> >> I followed the pattern of the existing SERIAL_8250_PNP option.  Was that
> >> a mistake?  How would you prefer it?
> >
> > I don't know, I'm just asking.
> >
> >> > What userspace visable change will be caused by this? 
> >> 
> >> There won't be /dev/ttyS devices for ports that don't exist.
> >> 
> >> > Will ports get renumbered?
> >> 
> >> Not if they had predictable numbers to begin with.
> >
> > So that would be "yes"?  If so, obviously we couldn't take this, right?
> 
> On a Beaglebone Black based system with some of the UARTs enabled, those
> keep their numbers such that e.g. ttyS0, ttyS1, and ttyS4 show up in
> /dev while ttyS2 and ttyS3 do not since they don't correspond to any
> (enabled) ports.
> 
> If any of the very many variants of this driver do not assign fixed
> numbers, those would possibly be renumbered.  Should that be the case,
> the numbering was never guaranteed to begin with, so I fail to see any
> problem.

Ok, if that's the case, then yes, a cleaned up version of this patch
would be nice, thanks!

greg k-h
