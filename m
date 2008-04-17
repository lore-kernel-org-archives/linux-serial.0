From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: Change to serial_core.c .... causing my serial driver problem
 Help Request
Date: Thu, 17 Apr 2008 16:58:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804171657320.6716@axis700.grange>
References: <8CA6D5E4DEA920C-1128-2973@webmail-nb07.sysops.aol.com>
 <Pine.LNX.4.64.0804160046460.6851@axis700.grange>
 <8CA6D67D9E313CC-1128-35BB@webmail-nb07.sysops.aol.com>
 <8CA6D6D112DB4D4-1128-38B0@webmail-nb07.sysops.aol.com>
 <Pine.LNX.4.64.0804170103040.7335@axis700.grange>
 <8CA6E48B50204C0-15A8-47D0@webmail-nb06.sysops.aol.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:46497 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754308AbYDQO57 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Apr 2008 10:57:59 -0400
In-Reply-To: <8CA6E48B50204C0-15A8-47D0@webmail-nb06.sysops.aol.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: vcgandhi1@aol.com
Cc: linux-serial@vger.kernel.org

On Wed, 16 Apr 2008, vcgandhi1@aol.com wrote:

> dev_t devt = MKDEV(match->driver->major, match->driver->minor) +
> match->port->line;
> 
> One more thing, I use dynamic major and minor number could that be the
> problem. Does the driver you test use  dynamic Major and Minor Numbers?

Doesn't look like 8250.c uses dynamic major and minor numbers.

Thanks
Guennadi
---
Guennadi Liakhovetski
