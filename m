From: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: Re: Serial Console
Date: Mon, 19 Aug 2002 09:17:18 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <013d01c24782$be5a3a60$294b82ce@connecttech.com>
References: <200208191108120240.0D409F0A@192.168.128.16> <200208191110530792.0D43161A@192.168.128.16>
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: Carlos Velasco <carlosev@newipnet.com>, linux-serial@vger.kernel.org

From: "Carlos Velasco" <carlosev@newipnet.com>
>   append="console=ttyS0,115200n8r console=tty0 vga=0x0301"

I'm don't know the parameter syntax, but are you sure the above is
correct? A) n8r? Perhaps that r should be a 1? B) Can you set the
console twice like that?

> However I have seen that if I don't open the serial port from another
machine, I can't reboot or boot kernel, as the output seems to freeze until
port is open. When I open the serial port, normal operation is resumed.
> Is there something to solve this issue?
> I would like to use the serial console only when needed not always that I
want boot or reboot machine.

It sounds like the serial port is waiting for a signal, like DCD, to
become active before proceeding. I believe this has been discussed
before, have you checked the linux-kernel mailing archive? Use google
to find it.

..Stu

--
We make multiport serial boards.
<http://www.connecttech.com>
(800) 426-8979


