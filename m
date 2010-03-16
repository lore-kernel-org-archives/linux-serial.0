From: Thomas Chou <thomas@wytron.com.tw>
Subject: Re: [Nios2-dev] [PATCHv3 1/2] serial: Add driver for the Altera
 JTAG UART
Date: Tue, 16 Mar 2010 08:47:43 +0800
Message-ID: <4B9ED52F.6050407@wytron.com.tw>
References: <cover.1267807169.git.klto@zhaw.ch>	<15dc056891fb785001073bab4f9a0d0f3bf99af1.1267807169.git.klto@zhaw.ch> <20100312124835.724eb806.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.wytron.com.tw ([211.75.82.101]:41201 "EHLO
	www.wytron.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937335Ab0CPBaz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Mar 2010 21:30:55 -0400
In-Reply-To: <20100312124835.724eb806.akpm@linux-foundation.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: nios2-dev@sopc.et.ntust.edu.tw, Tobias Klauser <tklauser@distanz.ch>, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On 03/13/2010 04:48 AM, Andrew Morton wrote:
>> +config SERIAL_ALTERA_JTAGUART
>> +	bool "Altera JTAG UART support"
>> +	select SERIAL_CORE
>> +	help
>> +	  This driver supports the Altera JTAG UART port.
>> +
> So this driver will be available on all CPU architectures.
>
> I'm guessing that the hardware _isn't_ available on all CPU
> architectures?  Maybe that's wrong.
>
>    
It is true that this driver is used mostly with nios2, soft-core 
coldfire and arm. But peripherals on FPGA can be made available to 
almost any CPU architecture. So I think it might make sense to let it 
available to all. Or should we put a "default n" ?

>> +#include<linux/platform_device.h>
>> +#include<linux/io.h>
>> +#include<linux/altera_jtaguart.h>
>>      
>
> Does it make sense to put altera_jtaguart.h into include/linux?  Could
> we put it in drivers/serial/?
>
>
>    
There is only a platform data structure declaration in the header, which 
should be passed through platform device data to the driver. If we put 
it in drivers/serial/, then we will need to include 
"../../../drivers/serial/altera_jtaguart.h" .

I have written this driver in parallel with the altera_uart driver. We 
could have passed the data ( base, irq, freq ) using platform resources. 
But I don't know if there is a way to pass ( freq )? Please let me know 
if you have any suggestions.

- Thomas
