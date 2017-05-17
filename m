From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [V2, 2/6] tty: serial: lpuart: add little endian 32 bit register
 support
Date: Wed, 17 May 2017 14:09:57 +0800
Message-ID: <20170517060957.GF9913@b29396-OptiPlex-7040>
References: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
 <fb9fe0cd-5ca7-74e6-33dc-7638e205b2e3@cogentembedded.com>
 <20170517033927.GC9913@b29396-OptiPlex-7040>
 <8f4cf45e-45ab-e6e6-d95c-f3d4243697f4@cogentembedded.com>
 <20170517054356.GE9913@b29396-OptiPlex-7040>
 <f096009a-9bcd-e575-2c81-49d08f99fc44@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f096009a-9bcd-e575-2c81-49d08f99fc44@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, linux-serial@vger.kernel.org, fugang.duan@nxp.com, gregkh@linuxfoundation.org, yangbo.lu@nxp.com, linux-kernel@vger.kernel.org, stefan@agner.ch, Mingkai.Hu@nxp.com, jslaby@suse.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, May 17, 2017 at 08:50:39AM +0300, Nikita Yushchenko wrote:
> >>>>>  static u32 lpuart32_read(void __iomem *addr)
> >>>>>  {
> >>>>> -	return ioread32be(addr);
> >>>>> +	return lpuart_is_be ? ioread32be(addr) : readl(addr);
> >>>>>  }
> >>>>>  
> >>>>>  static void lpuart32_write(u32 val, void __iomem *addr)
> >>>>>  {
> >>>>> -	iowrite32be(val, addr);
> >>>>> +	if (lpuart_is_be)
> >>>>> +		iowrite32be(val, addr);
> >>>>> +	else
> >>>>> +		writel(val, addr);
> >>>>>  }
> >>>>
> >>>> What if this is ever executed on big endian system?
> >>>>
> >>>
> >>> Sorry, not catching the point...
> >>>
> >>> What issues will meet?
> >>
> >> Isn't writel() in host endian?
> > 
> > On big endian systems, it is supposed to run iowrite32be.
> 
> Your code states, "force BE if lpuart_is_be, don't care otherwise".
> This semantics looks questionable for code reviewer.
> If driver handles endian, should't it be explicit in both cases?
> And if indeed driver means handling BE explicitly, but don't caring
> otherwise, maybe variable name should suggest that (i.e. "force_be")?
> 

For lpuart32, only two cases that LS platforms is Big endian while
IMX is little endian.

It's SoC IP native property, i don't think force_be is better.

Regards
Dong Aisheng

> Although driver maintainer could think differently. I won't insist on this.
> 
> Nikita
