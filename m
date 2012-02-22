From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 2/4] pch_uart: Add Fish River Island II uart clock quirks
Date: Wed, 22 Feb 2012 01:46:06 -0800
Message-ID: <4F44B95E.3030307@linux.intel.com>
References: <26a433d1bdb5805cac69efb20d3e32dbf790339b.1329875301.git.dvhart@linux.intel.com> <4982ca7a73cfe208a2a5ff0a7e0da54b99ca2d2e.1329875301.git.dvhart@linux.intel.com> <20120222085250.193096c9@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:54712 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905Ab2BVJql (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Feb 2012 04:46:41 -0500
In-Reply-To: <20120222085250.193096c9@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomoya MORINAGA <tomoya.rohm@gmail.com>, Feng Tang <feng.tang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org



On 02/22/2012 12:52 AM, Alan Cox wrote:
>> +	/* Setup UART clock, checking for board specific clocks. */
>> +	uartclk = DEFAULT_UARTCLK;
>> +
>> +	board_name = dmi_get_system_info(DMI_BOARD_NAME);
>> +	if (board_name && strstr(board_name, "CM-iTC"))
>> +		uartclk = CMITC_UARTCLK;
>> +
>> +	board_name = dmi_get_system_info(DMI_PRODUCT_NAME);
>> +	if (board_name && strstr(board_name, "Fish River Island II"))
>> +		uartclk = FRI2_UARTCLK;
>> +
>> +	port->uartclk = uartclk;
> 
> This is confusing, you load product name into a variable called
> board_name ?? perhaps "name" would be clearer ?

OK, done.

> 
>>  
>>  	if (options)
>>  		uart_parse_options(options, &baud, &parity, &bits, &flow);
>> @@ -1566,12 +1580,16 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
>>  	if (!rxbuf)
>>  		goto init_port_free_txbuf;
>>  
>> +	/* Setup UART clock, checking for board specific clocks. */
>>  	uartclk = DEFAULT_UARTCLK;
>>  
>> -	/* quirk for CM-iTC board */
>>  	board_name = dmi_get_system_info(DMI_BOARD_NAME);
>>  	if (board_name && strstr(board_name, "CM-iTC"))
>> -		uartclk = 192000000; /* 192.0MHz */
>> +		uartclk = CMITC_UARTCLK;
>> +
>> +	board_name = dmi_get_system_info(DMI_PRODUCT_NAME);
>> +	if (board_name && strstr(board_name, "Fish River Island II"))
>> +		uartclk = FRI2_UARTCLK;
> 
> And we have two locations so this is going to get missed on updates. Can
> we have one function for this please ?

Right, bad dvhart. Done. That cleans things up nicely. I'll resend as V2
after considering your 0/4 response....

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
