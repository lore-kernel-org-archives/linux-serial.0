From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: RE: Change to serial_core.c .... causing my serial driver problem
 Help Request
Date: Wed, 16 Apr 2008 00:49:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804160046460.6851@axis700.grange>
References: <8CA6D5E4DEA920C-1128-2973@webmail-nb07.sysops.aol.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:45544 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751880AbYDOWtA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Apr 2008 18:49:00 -0400
In-Reply-To: <8CA6D5E4DEA920C-1128-2973@webmail-nb07.sysops.aol.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: vcgandhi1@aol.com
Cc: linux-serial@vger.kernel.org

On Tue, 15 Apr 2008, vcgandhi1@aol.com wrote:

> Will do,

I added linux-serial to cc.

> But it seems like the code that was check in has issues.

Given the number and names of signed-off's under this patch, it is pretty 
unlikely.

> If you look in 
> the directory no serial driver properly sets port->dev to be pointing to 
> the parent. It looks like they all point to themselves. Can you tell me 
> which driver you tested this change on. I can look to see how they set 
> port->dev.

8250_pci.c, and I do think it sets it properly in pciserial_init_ports().

Thanks
Guennadi

> Vipul?
> ?
> 
> -----Original Message-----
> From: Guennadi Liakhovetski [mailto:g.liakhovetski@gmx.de] 
> Sent: Tuesday, April 15, 2008 2:50 PM
> To: Gandhi, Vipul
> Subject: Re: Change to serial_core.c .... causing my serial driver problem Help Request
> 
> ?
> 
> On Tue, 15 Apr 2008, Gandhi, Vipul wrote:
> 
> ?
> 
> > For my driver the following call is returning a NULL .????????? 
> 
> > 
> 
> >? 
> 
> > 
> 
> > tty_dev = device_find_child(port->dev, &match, serial_match_port);
> 
> > 
> 
> >? 
> 
> > 
> 
> > Any idea? why, previously this was not in serial_core.c but was recently
> 
> > added by you I believe. Any help would be appreciated.
> 
> ?
> 
> No, not without seeing the source-code of your driver. Also, please, 
> 
> direct such questions to the linux-serial or linux-kernel mailing list, 
> 
> you may then additionally CC the person, who you think can help you best.
> 
> ?
> 
> Thanks
> 
> Guennadi
> 
> ---
> 
> Guennadi Liakhovetski
> 

---
Guennadi Liakhovetski
