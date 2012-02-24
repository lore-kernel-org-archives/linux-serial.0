From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 2/4] pch_uart: Add Fish River Island II uart clock quirks
Date: Fri, 24 Feb 2012 14:25:47 -0800
Message-ID: <4F480E6B.90301@linux.intel.com>
References: <26a433d1bdb5805cac69efb20d3e32dbf790339b.1329875301.git.dvhart@linux.intel.com> <4982ca7a73cfe208a2a5ff0a7e0da54b99ca2d2e.1329875301.git.dvhart@linux.intel.com> <20120222085250.193096c9@pyramind.ukuu.org.uk> <4F44B95E.3030307@linux.intel.com> <20120224215315.GC25330@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37425 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754248Ab2BXW0U (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 24 Feb 2012 17:26:20 -0500
In-Reply-To: <20120224215315.GC25330@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomoya MORINAGA <tomoya.rohm@gmail.com>, Feng Tang <feng.tang@intel.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org



On 02/24/2012 01:53 PM, Greg Kroah-Hartman wrote:
> On Wed, Feb 22, 2012 at 01:46:06AM -0800, Darren Hart wrote:
>>
>>
>> On 02/22/2012 12:52 AM, Alan Cox wrote:
>>>> +	/* Setup UART clock, checking for board specific clocks. */
>>>> +	uartclk = DEFAULT_UARTCLK;
>>>> +
>>>> +	board_name = dmi_get_system_info(DMI_BOARD_NAME);
>>>> +	if (board_name && strstr(board_name, "CM-iTC"))
>>>> +		uartclk = CMITC_UARTCLK;
>>>> +
>>>> +	board_name = dmi_get_system_info(DMI_PRODUCT_NAME);
>>>> +	if (board_name && strstr(board_name, "Fish River Island II"))
>>>> +		uartclk = FRI2_UARTCLK;
>>>> +
>>>> +	port->uartclk = uartclk;
>>>
>>> This is confusing, you load product name into a variable called
>>> board_name ?? perhaps "name" would be clearer ?
>>
>> OK, done.
> 
> "Done" where?  Is there a newer patch series I should be looking at
> here to apply?  I'm guessing I can ignore this one, right?
> 
> consider it ignored :)

I have the V2 patch series here, tested it, was going to send it today
.... then received a new revision of the hardware/firmware which hides
the PCI device and the UART is driven by the 8250 driver and requires me
to use 3318 as the baud ..... ***sigh***. I'm not sure what the right
thing is to do right now. I'm going to have a conversation with the
hardware manufacturer and the TWO firmware teams I'm working with.

If anyone has experience with this sort of mess and would like to offer
a recommended course of action, I'm all ears.
-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
