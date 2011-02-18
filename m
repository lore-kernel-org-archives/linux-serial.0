From: Thomas Chou <thomas@wytron.com.tw>
Subject: Re: [Nios2-dev] [PATCH 0/5] tty: serial: Updates for  altera_jtaguart
 driver
Date: Fri, 18 Feb 2011 15:29:58 +0800
Message-ID: <4D5E1FF6.20805@wytron.com.tw>
References: <cover.1297974227.git.tklauser@distanz.ch>	<20110217221504.GA10686@kroah.com> <20110218072324.GS4076@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.wytron.com.tw ([211.75.82.101]:37412 "EHLO
	www.wytron.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755825Ab1BRHaH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Feb 2011 02:30:07 -0500
In-Reply-To: <20110218072324.GS4076@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: nios2-dev@sopc.et.ntust.edu.tw
Cc: Tobias Klauser <tklauser@distanz.ch>, Greg KH <greg@kroah.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org

Hi Tobias,

On 02/18/2011 03:23 PM, Tobias Klauser wrote:
> On 2011-02-17 at 23:15:04 +0100, Greg KH<greg@kroah.com>  wrote:
>> On Thu, Feb 17, 2011 at 09:28:23PM +0100, Tobias Klauser wrote:
>>> This patchset adds updates taken from the Nios2 Linux port (currently
>>> out-of-tree) repository to the altera_jtaguart driver.
>>>
>>> And this time with the correct cover letter right away :-)
>>>
>>> Tobias Klauser (5):
>>>    tty: serial: altera_jtaguart: Don't use plain integer as NULL pointer
>>>    tty: serial: altera_jtaguart: Remove unused function
>>>      early_altera_jtaguart_setup
>>>    tty: serial: altera_jtaguart: Support getting mapbase and IRQ from
>>>      resources
>>>    tty: serial: altera_jtaguart: Fixup type usage of port flags
>>>    tty: serial: altera_jtaguart: Add device tree support
>>
>> After this series, I get the following build error:
>> 	  CC [M]  drivers/tty/serial/altera_jtaguart.o
>> 	  drivers/tty/serial/altera_jtaguart.c:485:3: error: unknown field ???of_match_table??? specified in initializer
>
> Strange, I didn't get that one when compile testing against linux-next
> on x86_64. Though it seems I didn't correctly test it on nios2 and I got
> a compile error about a missing semicolon in the definition of
> altera_jtaguart_match there.

It might be that the of_match_table patch is available in Grant's branch 
only, which is for v3.6.39. Maybe you can ask Grant to take this patch 5/5.

- Thomas
