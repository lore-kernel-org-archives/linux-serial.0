From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH V2 1/2] serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices
Date: Thu, 4 Jul 2019 20:17:56 +0200
Message-ID: <9f08515a-3498-709e-d72b-538a54b704ad@metux.net>
References: <20190703072435.34152-1-je.yen.tam@ni.com>
 <63697b10-98a7-86b7-2513-3eb793ed03c5@metux.net>
 <20190703144744.GB24961@kroah.com>
 <d6910b29-3ba6-4a3b-04e2-bc7c3c012554@metux.net>
 <20190703155941.GB19567@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190703155941.GB19567@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jeyentam <je.yen.tam@ni.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03.07.19 17:59, Greg KH wrote:

>> That's sad, because in embedded world we often have to care about
>> code size, so making those devices optional would be of great help.
> 
> Really?  are you sure?  Try it and see what you really end up saving.

Just in 8250_pci.c alone, I could (depending on actual target) drop
about 80% LoC. Haven't tested how much the difference in image size
will really be.

But if you really like to know and would consider taking some patches
for making those things optional, I'll take some time and do the
dirty work.

By the way: would you still be opposed when these options are masked
behind CONFIG_EXPERT or CONFIG_EMBEDDED ? I can imagine this could be a
good compromise.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
