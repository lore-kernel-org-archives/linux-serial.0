From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: [PATCH V2 1/2] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices
Date: Wed, 3 Jul 2019 17:41:25 +0200
Message-ID: <d6910b29-3ba6-4a3b-04e2-bc7c3c012554@metux.net>
References: <20190703072435.34152-1-je.yen.tam@ni.com>
 <63697b10-98a7-86b7-2513-3eb793ed03c5@metux.net>
 <20190703144744.GB24961@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190703144744.GB24961@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jeyentam <je.yen.tam@ni.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03.07.19 16:47, Greg KH wrote:
> On Wed, Jul 03, 2019 at 03:27:11PM +0200, Enrico Weigelt, metux IT consult wrote:
>>>  /* UART Port Control Register */> -#define NI8430_PORTCON	0x0f> -#define NI8430_PORTCON_TXVR_ENABLE	(1 << 3)
>> Can we have that renaming as a separate patch, to ease review ?
>>
>> And what about introducing a config sym for the new device specific
>> stuff ? These devices seem to be pretty rare - never seen them in
>> embeded world, where we do need to care of kernel size.
> 
> No, that's not the way this driver works, sorry.

That's sad, because in embedded world we often have to care about
code size, so making those devices optional would be of great help.

OTOH, the 8250 driver already has several such options. What's your
concern about adding another one for a new device ? Config variant
inflation ? Would putting it behind CONFIG_EXPERT or CONFIG_EMBEDDED
an option ?


thx.
--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
