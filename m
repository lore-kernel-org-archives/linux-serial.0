From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH V4] workaround for mpc52xx erratum #364 (serial may not be reset in break state)
Date: Fri, 14 Nov 2008 12:09:53 -0700
Message-ID: <fa686aa40811141109v2892236fj5f8f85a64537cbb3@mail.gmail.com>
References: <490F51E7.3020309@unicontrol.de>
	 <fa686aa40811031255w3d9a065dgb0eb7ad4b26c9651@mail.gmail.com>
	 <4910274E.5030305@unicontrol.de>
	 <20081104111545.GB17864@pengutronix.de>
	 <4910A519.3030701@unicontrol.de>
	 <20081104212152.GC28064@pengutronix.de>
	 <4912A69B.6020707@unicontrol.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:32954 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193AbYKNTJy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Nov 2008 14:09:54 -0500
Received: by yw-out-2324.google.com with SMTP id 9so691984ywe.1
        for <linux-serial@vger.kernel.org>; Fri, 14 Nov 2008 11:09:53 -0800 (PST)
In-Reply-To: <4912A69B.6020707@unicontrol.de>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_B=FCrgel?= <r.buergel@unicontrol.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org, John Rigby <jcrigby@gmail.com>

On Thu, Nov 6, 2008 at 1:11 AM, Ren=E9 B=FCrgel <r.buergel@unicontrol.d=
e> wrote:
> This patch is a workaround for bug #364 found in the MPC52xx processo=
r.
> The errata document can be found under
> http://www.freescale.com/files/32bit/doc/errata/MPC5200E.pdf?fpsp=3D1=
&WT_TYPE=3DErrata&WT_VENDOR=3DFREESCALE&WT_FILE_FORMAT=3Dpdf&WT_ASSET=3D=
Documentation
>
> When a device with a low baudrate is connected to the serial port, bu=
t the
> processor "listens" on a higher baudrate, it might falsely receive br=
eaks
> from the controller. During a break, the serial controller may not be=
 reset.
> The appended patch provides a workaround for that situation by loweri=
ng the
> baudrate without resetting the controller and waiting until no break =
is
> received anymore.
>

I'm still don't like the state of this patch for two reasons:
1. It is enabled/disabled by a #ifdef.  It is quite possible that we
will eventually be able to build a multiplaform kernel that boots on
both mpc5200 and mpc5121.  The workaround needs to be detected and
enabled at runtime based on the data in the device tree (ie. if the
compatible property is "fsl,mpc5200-psc-uart").

2. I'm do not like the mdelay() busywait loop.  The long busy wait
just wastes CPU time.  Doing it with IRQs off means that irq latencies
become unbounded while this is happening.  This needs to be reworked
to use a workqueue or something similar.

Also, I'm not convinced that this is the best fix.  It doesn't
actually solve the problem, it just makes it less likely to occur.
What happens if you instead manipulate portconfig to change the PSC
pins to GPIO?  I wonder if that will disconnect the RX pin from the
PSC entirely.  If it does, then that might be a suitable method to
eliminate the break condition entirely.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
