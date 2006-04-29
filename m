From: gxatzipavlis@softnet.tuc.gr
Subject: help for self-made serial driver
Date: Sat, 29 Apr 2006 19:48:33 +0300 (EEST)
Message-ID: <40964.62.74.4.251.1146329313.squirrel@62.74.4.251>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from panoramix.softnet.tuc.gr ([147.27.14.5]:42195 "HELO
	softnet.tuc.gr") by vger.kernel.org with SMTP id S1750759AbWD2Qsj
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 29 Apr 2006 12:48:39 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


hello people.

i don't know if my question should be here. please inform me if not where
i can get some help.

i have writen a kernel module in order to communicate with a home network
through my serial port. the module work ok when i connect my pc with
another pc via NULL modem cable ( i do this to test my module). but when i
try to communicate with the real network i can't receive anything.

in order to communicate with this network a small device is connected to
my serial port as shown below

  _______      ____________
 |       |     |          |
 | my pc |-----| gateway  |------  network (let's say a ligth actuator)
 |_______|     |__________|

when ever i press the light actuator it send a message A. the purpose of
the gateway is to convert the package from the network to serial data,so
there is a voltage conversion from 24V (in the network) to 12V for the
serial hardware. The problem is that i don't receive the message A. When i
use the linux serial driver i get the message so i guess that i do
something wrong in my driver. As long as i have red from manuals of the
serial port i haven't found anything about voltage conversion.
When i connect my computer with another one ( pc 2 ) via NULL modem and
send from pc 2 the message A my driver works fine so i guess that my
processing on the serial stream is ok. Am i missing something about the
serial hardware?

i do the kernel module just to practise in kernel development as a hobbie.
I can do my job with the linux serial driver but i would like to learn how
to handle my computer resources  by myself.

thank you

