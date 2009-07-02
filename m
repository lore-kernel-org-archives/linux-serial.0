From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Serial loop back virtual device
Date: Thu, 2 Jul 2009 20:55:49 +0000 (UTC)
Message-ID: <h2j6sl$2k9$1@ger.gmane.org>
References: <21ed1c370907021308g18fb0ab5r895ee8871244a341@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:51977 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753350AbZGBVAE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 2 Jul 2009 17:00:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MMTNy-0000rB-Cy
	for linux-serial@vger.kernel.org; Thu, 02 Jul 2009 21:00:02 +0000
Received: from mn-69-34-67-62.sta.embarqhsd.net ([69.34.67.62])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 02 Jul 2009 21:00:02 +0000
Received: from grant.b.edwards by mn-69-34-67-62.sta.embarqhsd.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 02 Jul 2009 21:00:02 +0000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2009-07-02, Manuel Jander <manuel.jander@gmail.com> wrote:

> hopefuly this message is going to the right people. I wrote a
> small virtual serial loop back driver and I have some
> questions in regard to that.
>
> First, the driver basically creates a set of serial port
> device pairs (/dev/ttySL0, /dev/ttySL1, etc) and if some
> programs talks to one of this ports, the counterpart port will
> receive all data and vice versa.

Interesting.  

Does your driver live in the layer below the line-discipline
layer, or is it a "from-scratch" character device driver?

Are changes in termios settings (e.g. parity, buad, flow, etc.)
reflected between the two devices?

How does it handle modem-control/status lines?

> This is usful for writing a simulator of a hardware device
> which has a serial port, without having to connect to real
> serial ports together with a null modem cable or something
> like that. I'm using to develop a simulator of Webasto W-Bus
> (ODB-II) car heating device. The driver can optionally do line
> echo, required for K-Line emulation.
>
> Now the questions:
>
> - Did I really need to write a driver like this or are there
>   any trivial tricks to accomplish this somehow else?

Without looking at the details of your driver, it's hard to say.

For some applications that expect to talk to a serial port, you
can use a pty pair.  However, a pty only implements a subset of
the serial port API Some applications that work with normal
serial ports will fail if you point them at a pty instead of a
"real" tty device.

> Note, that the software to talk to my simulator is a
> propietary windows executable (using wine), thus I can not
> modify it. And my computer has only one single serial port
> (and I would need to buy a second ODB-II hardware adapter
> anyway, software is way much cheaper).
>
> - Is this useful to anyone ? I think it is :) and it would be
>   kind of stupid if anyone requiring this would have to either
>   use 2 hardware ports or write another driver like this. But
>   maybe I'm wrong, I dont know.
>
> - Is this driver worth to be part of the Linux mainline tree ?
>   Probably some adjustment would be required...

On a couple occasions I offered (if it would be accepted) to
fix up the pty driver so that it implements more of the serial
port API, but I've never gotten any response.

> source code is available here:
> http://micro.homelinux.net/~mjander/serial_loop.zip

Dude, a zip file?  That ruined your Unix street cred.  ;)

> It did built on 2.6.28, hopefuly it also does on the current
> vanilla tree.


-- 
Grant Edwards                   grante             Yow! ... I want a COLOR
                                  at               T.V. and a VIBRATING BED!!!
                               visi.com            

