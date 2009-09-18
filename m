From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] MIPS: BCM63xx: Add serial driver for bcm63xx
	integrated UART.
Date: Fri, 18 Sep 2009 07:57:15 -0700
Message-ID: <20090918145715.GB8884@suse.de>
References: <1253271898.1627.272.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:58986 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752735AbZIRO5c (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Sep 2009 10:57:32 -0400
Content-Disposition: inline
In-Reply-To: <1253271898.1627.272.camel@sakura.staff.proxad.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Maxime Bizon <mbizon@freebox.fr>
Cc: linux-serial@vger.kernel.org, linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>

On Fri, Sep 18, 2009 at 01:04:58PM +0200, Maxime Bizon wrote:
> 
> Hi Greg,
> 
> This is a serial driver for the bcm63xx mips SOCs, it was already posted
> twice:
> 
> one year ago: http://marc.info/?l=linux-serial&m=122438266322439&w=2
> three months ago: http://lkml.org/lkml/2009/7/1/370
> 
> but got no review or ack.
> 
> 
> Linus merged the SOC support patch from Ralf tree yesterday, but without
> serial support.
> 
> Could you please have a look at it ? Is it ok if it goes upstream
> through Ralf tree ?

I have no objection for this to go through Ralf's tree.  Or if he needs
it to go through mine, just let me know.

> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>


thanks,

greg k-h
