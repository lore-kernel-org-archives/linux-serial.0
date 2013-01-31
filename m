From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: RS485 implementation questions (primarly in atmel_serial.c)
Date: Thu, 31 Jan 2013 14:42:03 +0000 (UTC)
Message-ID: <kedvrr$qb0$1@ger.gmane.org>
References: <CAJa4H3fhgEyGCO4wZjww0-rrNnRzAfpJq0cF4QoG3F+QgDqR4w@mail.gmail.com>
 <000401cdfef7$0d4a9020$27dfb060$@acksys.fr>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60850 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851Ab3AaOmR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 31 Jan 2013 09:42:17 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1U0vLV-0003li-Cn
	for linux-serial@vger.kernel.org; Thu, 31 Jan 2013 15:42:33 +0100
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 31 Jan 2013 15:42:33 +0100
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 31 Jan 2013 15:42:33 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-01-30, Jean-Pierre Tosoni <jp.tosoni@acksys.fr> wrote:
>
> Well, you need to ascertain that the previous frame is all out AND
> the RTS has dropped before sending a new frame. Else the receiver
> might think it is the same long frame. Using TXEMPTY interrupt avoids
> setting an extra timer. However in the real life you are half-duplex
> and never send two frames in a row without waiting for an answer.
> Other than that I agree with your remark.
>
>> rare.  But this function is not especially related to RS485. It is
>> also applicable in RS232 mode.  So in my view it is not the
>
> True, it applies to some half-duplex RS232 radio modems too AFAIK.

It applies to half duplex modems and line-drivers whether they're
radio or not.  Believe it or not, Bell-202 half-duplex over plain old
copper wire is still used a lot in the process control industry.

But, because of the general brokeness of both Windows and Linux serial
drivers when it comes to half-duplex communications, many of the
Bell-202 modems sold these days have automatic tx data detection and
handle the "RTS toggle" function themselves.

-- 
Grant Edwards               grant.b.edwards        Yow! Psychoanalysis??
                                  at               I thought this was a nude
                              gmail.com            rap session!!!

