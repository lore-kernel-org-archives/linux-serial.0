From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] serial imx.c: fix CTS trigger level lower to avoid
 lost chars
Date: Wed, 5 May 2010 09:42:00 -0700
Message-ID: <20100505164200.GA4157@suse.de>
References: <20100122115853.GF4782@pengutronix.de>
 <1264330095-32225-1-git-send-email-valentin.longchamp@epfl.ch>
 <4BE13E9B.6050406@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58530 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932302Ab0EEQmR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 May 2010 12:42:17 -0400
Content-Disposition: inline
In-Reply-To: <4BE13E9B.6050406@epfl.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Valentin Longchamp <valentin.longchamp@epfl.ch>
Cc: Alan Cox <alan@linux.intel.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Wed, May 05, 2010 at 11:47:07AM +0200, Valentin Longchamp wrote:
> Hello,
> 
> I had sent this patch more than 3 months ago and noone has pushed it
> into mainline. It is very important for our use and I think it may
> affect other people later.
> 
> Is there a linux-serial tree where it could be added to be pulled
> from for mainline then ? What is the usual path for serial patches ?

I've been taking serial patches lately as-needed, so feel free to send
them to me.  I'll go queue this one up.

thanks,

greg k-h
