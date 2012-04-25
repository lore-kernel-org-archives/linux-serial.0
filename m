From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: 8250.c less than 2400 baud fix.
Date: Wed, 25 Apr 2012 07:11:47 -0700
Message-ID: <20120425141147.GA28315@kroah.com>
References: <1346E68D3A5B2043907CF4BF466383411A07E00CF0@ESESSCMS0353.eemea.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56404 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758725Ab2DYOLv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Apr 2012 10:11:51 -0400
Received: by pbbro12 with SMTP id ro12so1499704pbb.19
        for <linux-serial@vger.kernel.org>; Wed, 25 Apr 2012 07:11:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1346E68D3A5B2043907CF4BF466383411A07E00CF0@ESESSCMS0353.eemea.ericsson.se>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Christian Melki <christian.melki@ericsson.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Wed, Apr 25, 2012 at 02:26:36PM +0200, Christian Melki wrote:
> Hi.
> 
> We noticed that we were loosing data at speed less than 2400 baud.
> It turned out our (TI16750 compatible) uart with 64 byte outgoing fifo was truncated to 16 byte (bit 5 sets fifo len) when modifying the fcr reg.
> The input code still fills the buffer with 64 bytes if I remember correctly and thus data is lost.
> Our fix was to remove whiping of the fcr content and just add the TRIGGER_1 which we want for latency.
> I can't see why this would not work on less than 2400 always, for all uarts...
> Otherwise one would have to make sure the filling of the fifo re-checks the current state of available fifo size (urrk).

Thank you for your fix, but could you take a look at the file,
Documentation/SubmittingPatches and resend it with a Signed-off-by: line
so that I am able to apply the patch?

thanks,

greg k-h
