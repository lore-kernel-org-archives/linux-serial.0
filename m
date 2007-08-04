From: Paul Fulghum <paulkf@microgate.com>
Subject: Re: serial flow control appears broken
Date: Sat, 04 Aug 2007 16:07:41 -0600
Message-ID: <46B4F8AD.3000405@microgate.com>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no>	 <46A84B4A.6070902@shaw.ca> <46A8C6F1.4080309@howardsilvan.com>	 <20070726173121.70088a92@the-village.bc.nu>	 <46A98845.8010806@howardsilvan.com> <46A9F712.70706@imap.cc>	 <46D33636.7070200@microgate.com> <46AA5A0E.1050600@howardsilvan.com>	 <1185578908.2989.15.camel@x2> <46AACB4D.7080004@howardsilvan.com> <2c0942db0707280941n1b9e1f7i9c0de332286e8aac@mail.gmail.com> <46B4C393.4020506@howardsilvan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765869AbXHDVJ7@vger.kernel.org>
In-Reply-To: <46B4C393.4020506@howardsilvan.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Howard <faxguy@howardsilvan.com>
Cc: Ray Lee <ray-lk@madrabbit.org>, Tilman Schmidt <tilman@imap.cc>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Hancock <hancockr@shaw.ca>, linux-serial@vger.kernel.org, tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Lee Howard wrote:
> And in repeat tests it is quite evident that IDE disk activity is, 
> indeed, at least part of the problem.  As IDE disk activity increases an 
> increased amount of data coming in on the serial port goes missing.

Lee, you mentioned 2.2.x kernels did not exhibit this problem.

Was this on the same hardware you are currently testing?
Which 2.2.x version were you using?
Was the 2.2.x serial driver also identifying the UART as a 16550A?
Can you get /proc/interrupts output
from both the current setup and the 2.2.x setup?

It would be interesting to compare the interrupt
assignment and UART setup between the versions.

--
Paul
