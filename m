From: Greg KH <greg@kroah.com>
Subject: Re: [Resend with Signed-off-by]: Add new FT232H chip to
 drivers/usb/serial/ftdi_sio.c
Date: Fri, 17 Jun 2011 10:25:17 -0700
Message-ID: <20110617172517.GA18101@kroah.com>
References: <19963.29455.319574.581029@elektron.ikp.physik.tu-darmstadt.de>
 <4DFB8BAC.5080901@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:58379 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759526Ab1FQRZa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Jun 2011 13:25:30 -0400
Content-Disposition: inline
In-Reply-To: <4DFB8BAC.5080901@ru.mvista.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, Jun 17, 2011 at 09:15:24PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> Uwe Bonnes wrote:
> 
> >Hello,
> 
>    Greetings shouldn't be a part of the patch description. Just omit
> them, for the future.
> 
> >appended patch adds support for the new FTDI FT232H chip. This chip is a
> >single channel version of the dual FT2232H/quad FT4232H, coming with it's
> >own default PID 0x6014 (FT2232H uses the same PID 0x6010 like FT2232C,
> >FT4232H has also it's own PID).
> 
> >The patch was checked on an UM232H module and a terminal program with TX/RX
> >shorted to that typing in the terminal reproduced the characters. The patch
> >was written against the running  2.6.37.6 kernel, but applies to git-head
> >without errors.
> 
>    The last sentence should really be placed after the --- tear line.
> 
> >Please review and let me know(CC) of any problems.
> 
> >Signed-off-by: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
> 
> >-- 
> >Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de
> 
> >Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
> >--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
> >From 8a6a023dfc616a53bb1dd9b989d01276499ce6a4 Mon Sep 17 00:00:00 2001
> >From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
> >Date: Fri, 17 Jun 2011 15:59:07 +0200
> >Subject: Add new FT232H chip
> 
>    The signature (if any) should be after the patch, not before. Now
> Greg will have to hand edit your patch to remove it.

Which, for one-off patches, like this, is fine, I can easily handle it.

All of these are trivial things, and aren't really an issue at all,
unless you send multiple patches to me.

Uwe, don't worry about this at all, I'll fix it up.

Sergei, please be more accomidating, and don't second-guess what I will,
or will not need to do or accept.

greg k-h
