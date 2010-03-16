From: christian pellegrin <chripell@gmail.com>
Subject: Re: spi-devel-general Digest, Vol 46, Issue 10
Date: Tue, 16 Mar 2010 18:32:32 +0100
Message-ID: <cabda6421003161032y32f34472s32dab90233500a7b@mail.gmail.com>
References: <mailman.59674.1267729564.5170.spi-devel-general@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:1764 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933080Ab0CPRcf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Mar 2010 13:32:35 -0400
Received: by fg-out-1718.google.com with SMTP id l26so1841663fgb.1
        for <linux-serial@vger.kernel.org>; Tue, 16 Mar 2010 10:32:33 -0700 (PDT)
In-Reply-To: <mailman.59674.1267729564.5170.spi-devel-general@lists.sourceforge.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Masakazu Mokuno <mokuno@sm.sony.co.jp>, Feng Tang <feng.tang@intel.com>
Cc: Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>, linux-serial@vger.kernel.org, spi-devel-list <spi-devel-general@lists.sourceforge.net>, Andrew Morton <akpm@linuxfoundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hi,

On Thu, Mar 4, 2010 at 8:06 PM,
<spi-devel-general-request@lists.sourceforge.net> wrote:

>> + =A0 =A0 if (use_irq) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D request_irq(max->irq, serial_m3110=
_irq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 IRQ_TYPE_EDGE_FALLING, "max3110", max);
>
> According to the manufacturer's datasheet, it looks like MAX3110'irq =
is
> level interrupt. Refer Figure 6 of the datasheet.
>

It should work anyway if you are sure you clear the the condition that
generated the interrupt (so the interrupt line will have another
transition for sure). It's quite common when using deferred work
(worqueues for example) otherwise you have to turn irq off to avoid an
interrupt storm. Usually turning interrupts on and off is quite tricky
because they are counted.

>> + =A0 =A0 pmax =3D max;
>
> If this driver supports only one instance of devices, how about
> declaring a global struct uart_m3100 instead of kmallc()?
>

huh didn't noticed that it supports only one instance. I guess this is
very bad (my test machine for example has 2 MAX3100s, one for a GPS
receiver and one for a slow RS485 link).

--=20
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
