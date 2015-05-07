From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial: imx: Revert "initialized DMA w/o HW flow enabled"
Date: Thu, 7 May 2015 19:11:14 -0300
Message-ID: <CAOMZO5BpDu=iS+tR=+TAo2Jz5QXKwh_ZHw9SLkvtX=gQ_evRnQ@mail.gmail.com>
References: <20150507202439.GA4717@breakpoint.cc>
	<CAOMZO5B1AKN8QXA5dhU7YoCGu2MXVXRq+mT2HXohv_wKXm-6-A@mail.gmail.com>
	<20150507211657.GA30982@breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150507211657.GA30982@breakpoint.cc>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, jiwang <jiada_wang@mentor.com>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, anton_bondarenko@mentor.com, Dirk Behme <dirk.behme@de.bosch.com>, Nicolae Rosia <nicolae.rosia@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>
List-Id: linux-serial@vger.kernel.org

On Thu, May 7, 2015 at 6:16 PM, Sebastian Andrzej Siewior
<sebastian@breakpoint.cc> wrote:
> On 2015-05-07 17:54:31 [-0300], Fabio Estevam wrote:
>> Thanks, this fixes Bluetooth operation on a imx6sl-warp running
>> without SDMA firmware.
>>
>> Two suggestions:
>>
>> 1. You should Cc stable as it affects 4.0 also
>
> I have the Fixes tag, doesn't this count?

According to Documentation/stable_kernel_rules.txt you need to Cc
stable so that it can go to the stable tree.

>> 2. It doesn't apply cleanly against linux-next, so I think Greg will
>> have problems applying it.
>
> It is on top of Greg's tty-next tree. Shouldn't this work?

Yes, this should be fine.
