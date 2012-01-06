From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
Subject: Re: [PATCH] jsm: Fixed EEH recovery error
Date: Fri, 06 Jan 2012 18:43:46 -0200
Message-ID: <4F075D02.3010407@linux.vnet.ibm.com>
References: <1315834565-9280-1-git-send-email-lucaskt@linux.vnet.ibm.com> <20110912153508.GA8851@oc1711230544.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e24smtp03.br.ibm.com ([32.104.18.24]:34118 "EHLO
	e24smtp03.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759136Ab2AFUn7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Jan 2012 15:43:59 -0500
Received: from /spool/local
	by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-serial@vger.kernel.org> from <lucaskt@linux.vnet.ibm.com>;
	Fri, 6 Jan 2012 18:43:55 -0200
In-Reply-To: <20110912153508.GA8851@oc1711230544.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Cc: Breno Leitao <leitao@linux.vnet.ibm.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>


On 09/12/2011 12:35 PM, Thadeu Lima de Souza Cascardo wrote:
> On Mon, Sep 12, 2011 at 10:36:05AM -0300, Lucas Kannebley Tavares wrote:
>> There was an error on the jsm driver that would cause it to be unable to
>> recover after a second error is detected.
>>
>> At the first error, the device recovers properly:
>>
>> [72521.485691] EEH: Detected PCI bus error on device 0003:02:00.0
>> [72521.485695] EEH: This PCI device has failed 1 times in the last hour:
>> ...
>> [72532.035693] ttyn3 at MMIO 0x0 (irq = 49) is a jsm
>> [72532.105689] jsm: Port 3 added
>>
>> However, at the second error, it cascades until EEH disables the device:
>>
>> [72631.229549] Call Trace:
>> ...
>> [72641.725687] jsm: Port 3 added
>> [72641.725695] EEH: Detected PCI bus error on device 0003:02:00.0
>> [72641.725698] EEH: This PCI device has failed 3 times in the last hour:
>>
>> It was caused because the PCI state was not being saved after the first
>> restore. Therefore, at the second recovery the PCI state would not be
>> restored.
>>
>> Signed-off-by: Lucas Kannebley Tavares<lucaskt@linux.vnet.ibm.com>
>Signed-off-by: Breno Leitao <brenohl@br.ibm.com>
> Acked-by: Thadeu Lima de Souza Cascardo<cascardo@linux.vnet.ibm.com>

Adding Greg to the CC list. It wasn't added earlier because 
get_maintainers.pl only listed Alan's name. I apologize for the delay.

This is a bugfix to EEH handling on jsm.

>
>> ---
>>   drivers/tty/serial/jsm/jsm_driver.c |    1 +
>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/tty/serial/jsm/jsm_driver.c b/drivers/tty/serial/jsm/jsm_driver.c
>> index 96da178..8941b15 100644
>> --- a/drivers/tty/serial/jsm/jsm_driver.c
>> +++ b/drivers/tty/serial/jsm/jsm_driver.c
>> @@ -270,6 +270,7 @@ static void jsm_io_resume(struct pci_dev *pdev)
>>   	struct jsm_board *brd = pci_get_drvdata(pdev);
>>
>>   	pci_restore_state(pdev);
>> +	pci_save_state(pdev);
>>
>>   	jsm_uart_port_init(brd);
>>   }
>> --
>> 1.7.4.4
>>

