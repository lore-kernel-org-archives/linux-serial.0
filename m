From: vcgandhi1@aol.com
Subject: Re: Change to serial_core.c .... causing my serial driver problem Help
 Request
Date: Thu, 17 Apr 2008 12:41:26 -0400
Message-ID: <8CA6EC102F70775-15A8-8B4A@webmail-nb06.sysops.aol.com>
References: <8CA6D5E4DEA920C-1128-2973@webmail-nb07.sysops.aol.com> <Pine.LNX.4.64.0804160046460.6851@axis700.grange> <8CA6D67D9E313CC-1128-35BB@webmail-nb07.sysops.aol.com> <8CA6D6D112DB4D4-1128-38B0@webmail-nb07.sysops.aol.com> <Pine.LNX.4.64.0804170103040.7335@axis700.grange> <8CA6E48B50204C0-15A8-47D0@webmail-nb06.sysops.aol.com> <Pine.LNX.4.64.0804171657320.6716@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from imo-d03.mx.aol.com ([205.188.157.35]:62806 "EHLO
	imo-d03.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764699AbYDQQma (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Apr 2008 12:42:30 -0400
In-Reply-To: <Pine.LNX.4.64.0804171657320.6716@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: g.liakhovetski@gmx.de
Cc: linux-serial@vger.kernel.org

Guennadi,

When I switch to static Major and Minor numbers, the code started to 
work. So I believe the issue is with dynamic Major and Minor number.

I switch to static Major and Minor number till this gets fix or if it 
ever gets fixed. Let me know what your thoughts are maybe I doing 
something wrong which is causing Dynamic Major and Minor numbers not to 
work.

Thank You
Vipul



-----Original Message-----
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: vcgandhi1@aol.com
Cc: linux-serial@vger.kernel.org
Sent: Thu, 17 Apr 2008 7:58 am
Subject: Re: Change to serial_core.c .... causing my serial driver 
problem Help Request



On Wed, 16 Apr 2008, vcgandhi1@aol.com wrote:

> dev_t devt = MKDEV(match->driver->major, match->driver->minor) +
> match->port->line;
>
> One more thing, I use dynamic major and minor number could that be the
> problem. Does the driver you test use  dynamic Major and Minor 
Numbers?

Doesn't look like 8250.c uses dynamic major and minor numbers.

Thanks
Guennadi
---
Guennadi Liakhovetski

