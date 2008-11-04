From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: [BUG] serial base baud misdetected in 2.6.27
Date: Tue, 04 Nov 2008 15:30:51 -0600
Message-ID: <4910BF0B.4070607@nortel.com>
References: <4910936D.4030605@nortel.com> <20081104192253.151d6ef3@lxorguk.ukuu.org.uk> <4910B0AD.3020802@nortel.com> <20081104203643.77cdfa6c@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from zrtps0kp.nortel.com ([47.140.192.56]:36490 "EHLO
	zrtps0kp.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbYKDVa7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Nov 2008 16:30:59 -0500
In-Reply-To: <20081104203643.77cdfa6c@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Alan Cox wrote:
>> like it's hanging off the PCI bus.  The vendor/device matches to an Exar 
>> Corp. XR17C152, which is given a base_baud of 921600 in 
>> drivers/serial/8250_pci.c.
>>
>> According to the chip specs, 921600 is correct with the default crystal 
>> and control register values.  However, other crystals can be used and 
>> there's also a control register bit to enable a prescalar which cuts the 
>> baud rate by a factor of four.  I suspect that one of these has been 
>> done on our boards.
> 
> Probably. Did your vendor have the sense to set subvendor/subdevice
> identifiers that can be used to identify that specific unit ?

No idea, but I'll look into it.  Thanks for the help.

Chris
