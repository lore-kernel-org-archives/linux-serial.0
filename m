From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [V2, 2/6] tty: serial: lpuart: add little endian 32 bit register
 support
Date: Wed, 17 May 2017 08:37:41 +0300
Message-ID: <8f4cf45e-45ab-e6e6-d95c-f3d4243697f4@cogentembedded.com>
References: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
 <fb9fe0cd-5ca7-74e6-33dc-7638e205b2e3@cogentembedded.com>
 <20170517033927.GC9913@b29396-OptiPlex-7040>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170517033927.GC9913@b29396-OptiPlex-7040>
Sender: linux-kernel-owner@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, linux-serial@vger.kernel.org, fugang.duan@nxp.com, gregkh@linuxfoundation.org, yangbo.lu@nxp.com, linux-kernel@vger.kernel.org, stefan@agner.ch, Mingkai.Hu@nxp.com, jslaby@suse.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org



17.05.2017 06:39, Dong Aisheng wrote:
> On Tue, May 16, 2017 at 02:15:08PM +0300, Nikita Yushchenko wrote:
>>>  static u32 lpuart32_read(void __iomem *addr)
>>>  {
>>> -	return ioread32be(addr);
>>> +	return lpuart_is_be ? ioread32be(addr) : readl(addr);
>>>  }
>>>  
>>>  static void lpuart32_write(u32 val, void __iomem *addr)
>>>  {
>>> -	iowrite32be(val, addr);
>>> +	if (lpuart_is_be)
>>> +		iowrite32be(val, addr);
>>> +	else
>>> +		writel(val, addr);
>>>  }
>>
>> What if this is ever executed on big endian system?
>>
> 
> Sorry, not catching the point...
> 
> What issues will meet?

Isn't writel() in host endian?
