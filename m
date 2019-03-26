From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v6] tty: 8250: fix a missing check for pci_ioremap_bar
Date: Tue, 26 Mar 2019 11:28:44 +0100
Message-ID: <2d90d0ca-0155-b602-c0d1-f59790d618ad@suse.cz>
References: <20190325222147.13342-1-pakki001@umn.edu>
 <20190326101758.GV9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326101758.GV9224@smile.fi.intel.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aditya Pakki <pakki001@umn.edu>
Cc: Vinod Koul <vkoul@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kjlu@umn.edu, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 26. 03. 19, 11:17, Andy Shevchenko wrote:
>> @@ -199,7 +203,10 @@ static void qrk_serial_exit_dma(struct lpss8250 *lpss)
>>  
>>  	if (!param->dma_dev)
>>  		return;
>> +
>>  	dw_dma_remove(&lpss->dma_chip);
>> +
>> +	iounmap(&lpss->dma_chip->regs);
> 
> This is a bit fragile form of writing. Perhaps

It actually won't even compile, will it (it must have been
"(&lpss->dma_chip)->regs")? Do you at least compile-test your patches
before sending?

thanks,
-- 
js
suse labs
