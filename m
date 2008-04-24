From: vcgandhi1@aol.com
Subject: Re: Change to serial_core.c .... causing my serial driver problem Help
 Request
Date: Wed, 23 Apr 2008 20:21:12 -0400
Message-ID: <8CA73B83C791846-148-41B9@webmail-nb17.sysops.aol.com>
References: <8CA6D5E4DEA920C-1128-2973@webmail-nb07.sysops.aol.com> <Pine.LNX.4.64.0804160046460.6851@axis700.grange> <8CA6D67D9E313CC-1128-35BB@webmail-nb07.sysops.aol.com> <8CA6D6D112DB4D4-1128-38B0@webmail-nb07.sysops.aol.com> <Pine.LNX.4.64.0804170103040.7335@axis700.grange> <8CA6E48B50204C0-15A8-47D0@webmail-nb06.sysops.aol.com> <Pine.LNX.4.64.0804171657320.6716@axis700.grange> <8CA6EC102F70775-15A8-8B4A@webmail-nb06.sysops.aol.com> <Pine.LNX.4.64.0804171915180.6716@axis700.grange> <8CA6EF5BC26E069-12A0-1888@webmail-nc13.sysops.aol.com> <Pine.LNX.4.64.0804181700300.5725@axis700.grange> <8CA6FF4B03B281A-E10-2E1C@webmail-nf05.sim.aol.com> <Pine.LNX.4.64.0804231108170.5160@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from imo-m24.mx.aol.com ([64.12.137.5]:58233 "EHLO
	imo-m24.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961AbYDXAVT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Apr 2008 20:21:19 -0400
In-Reply-To: <Pine.LNX.4.64.0804231108170.5160@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: g.liakhovetski@gmx.de
Cc: linux-serial@vger.kernel.org


Guennadi,

Yes that fixes the problem. Sorry for taking some time to test it, but 
been busy buying a house. The process is making me exhausted.

Please do try to get the patch into the mainline, and thank you for 
your time.

Vipul


-----Original Message-----
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: vcgandhi1@aol.com
Cc: linux-serial@vger.kernel.org
Sent: Wed, 23 Apr 2008 2:09 am
Subject: Re: Change to serial_core.c .... causing my serial driver 
problem Help Request



On Sat, 19 Apr 2008, vcgandhi1@aol.com wrote:

> I have not had a chance to test it today, Sorry. The patches should 
solve the
> problem, but I will confirm on the hardware this weekend.

Have you been able to test the patches? We need to know it if we want 
to
fix it in the mainline.

Thanks
Guennadi
---
Guennadi Liakhovetski

