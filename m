From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: [BUG] serial base baud misdetected in 2.6.27
Date: Tue, 04 Nov 2008 14:29:33 -0600
Message-ID: <4910B0AD.3020802@nortel.com>
References: <4910936D.4030605@nortel.com> <20081104192253.151d6ef3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from zcars04e.nortel.com ([47.129.242.56]:37691 "EHLO
	zcars04e.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402AbYKDU3j (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Nov 2008 15:29:39 -0500
In-Reply-To: <20081104192253.151d6ef3@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Alan Cox wrote:
> On Tue, 04 Nov 2008 12:24:45 -0600
> "Chris Friesen" <cfriesen@nortel.com> wrote:
> 
>> I'm running an ATCA7101 board.  This board has two 16550 ports that get 
>> detected as ttyS4 and ttyS5.
>>
>> With a much earlier kernel (2.6.14) the serial port base speed is 
>> correctly detected as 230400, which gives the desired 115200 when I 
>> specify that on the kernel commandline.
>>
>> With 2.6.16 and 2.6.27 (not sure about the intervening kernels) the 
>> serial port base speed is detected as 921600, which means that I need to 
>> specify 460800 on the commandline to get a real speed of 115200 (as 
>> verified by an external terminal server).
>>
>> Any ideas what could be causing this misdetection?  I'm having lab 
>> issues right now so I can't track it down, but I'll have a go at it 
>> eventually.
> 
> If this is a PCI card it may be matching against a PCI entry for a
> similar card with different crystals and need the right svid/sdid adding.

This is an ATCA board, so it's not a separate PCI card, but it does look 
like it's hanging off the PCI bus.  The vendor/device matches to an Exar 
Corp. XR17C152, which is given a base_baud of 921600 in 
drivers/serial/8250_pci.c.

According to the chip specs, 921600 is correct with the default crystal 
and control register values.  However, other crystals can be used and 
there's also a control register bit to enable a prescalar which cuts the 
baud rate by a factor of four.  I suspect that one of these has been 
done on our boards.

The confusing thing is that the 2.6.14 code seems to also use a value of 
921600, but somehow it works.  I wonder if our kernel vendor has tweaked 
something in the code to adjust this value later on.

Chris


