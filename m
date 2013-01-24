From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: RS485 implementation questions (primarly in atmel_serial.c)
Date: Thu, 24 Jan 2013 00:10:02 +0000 (UTC)
Message-ID: <kdpu4q$m7l$1@ger.gmane.org>
References: <CAJa4H3fhgEyGCO4wZjww0-rrNnRzAfpJq0cF4QoG3F+QgDqR4w@mail.gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52614 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465Ab3AXAKW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Jan 2013 19:10:22 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1TyAOq-0007ao-ET
	for linux-serial@vger.kernel.org; Thu, 24 Jan 2013 01:10:36 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 24 Jan 2013 01:10:36 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 24 Jan 2013 01:10:36 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-01-23, Guido Classen <clagix@gmail.com> wrote:

> I this cases you need a way to assert RTS some milliseconds before the
> first character of a frame is transmitted and leave it on some
> milliseconds after the end of the frame. In my opinion that is what
> delay_rts_before/after_send should be for. (In other equipment this
> feature is also called turn on / turn off delay)

In applications like links using half-duplex modems, you may have to
assert RTS for many hundreds of millisconds to allow the modulator to
key up and stabilze and the demodulator to lock onto the signal before
you can send data.  Some modems will let you know when they're ready
by asserting CTS, and for others you just have to have a fixed delay.
In those cases, you also typically hold RTS for some time after the
end of the data for a time ranging up to several byte times.

In our non-Linux based products, we implement pre/pose data RTS "hold"
times as you describe in our device driver.  Our Linux-based products
can't handle those applications.

-- 
Grant Edwards               grant.b.edwards        Yow! Are we laid back yet?
                                  at               
                              gmail.com            

