From: Olliver Schinagl <o.schinagl-U3FVU11NWA554TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH] serial: 8250_dw: Minor code cleanup
Date: Wed, 29 Mar 2017 19:10:06 +0200
Message-ID: <86fcc347-6b9b-5046-b9fb-63a2c81f0a20@schinagl.nl>
References: <20170329100424.7439-1-oliver@schinagl.nl>
 <CAD=FV=XZFuZ-Zqv75wF7wj6AY35o9n4-zrbsVjNcFZ+DxS=fbQ@mail.gmail.com>
Reply-To: o.schinagl-U3FVU11NWA554TAoqtyWWQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBD7M3SWL7UKRB46U57DAKGQECTP3JBA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAD=FV=XZFuZ-Zqv75wF7wj6AY35o9n4-zrbsVjNcFZ+DxS=fbQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jason Uy <jason.uy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Ed Blake <ed.blake-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hey Doug,

On 29-03-17 17:50, Doug Anderson wrote:
> Hi,
>
> On Wed, Mar 29, 2017 at 3:04 AM, Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org> wrote:
>> Commit 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
>> added a bit check with quite a wide mask. To be concise with the other
>> similar calls in this driver, change it to mask against the flag we want to
>> check only. This thus removes a magic value/mask.
>
> How certain are you that your patch is correct?  You are now basically
> checking to see if the bits "0xc" are set in the IIR.  Previously the
> patch ensured that the bits 0x33 were clear.

You raise a good point. And after writing two replies that made perfect 
sense, I just realized looking at the table you wisely posted below, I 
should have spotted that the interrupts are not bits! So very good catch 
and my bad indeed.

>
> Have you tried looking through the kernel for other places where
> UART_IIR_RX_TIMEOUT is referenced?  In 8250_omap.c and 8250_port.c I
> believe you'll find it masking against 0x3f.  In omap-serial.c you'll
> see a mask against 0x3e.
>
> Looking at the TRM for rk3399, I see that bits 4 and 5 (bitmask 0x30)
> as "reserved".  I see the following definitions for bits 3:0:
>
> 0000 = modem status
> 0001 = no interrupt pending
> 0010 = THR empty
> 0100 = received data available
> 0110 = receiver line status
> 0111 = busy detect
> 1100 = character timeout
>
> ...so while your patch will probably function OK, it would also
> function equally well to simply test bit 3 (0x80) and ignore
> everything else.  ...but IMHO it is more correct to at least mask the
> IIR with 0x0F and confirm that bits 2 and 3 are set and bits 0 and 1
> are zero.  ...and since the main 8250 code uses 0x3f, that seems even
> better to me (despite the fact that it seems to be relying on the fact
> that the "reserved" bits come back as 0).

I strongly agree with you here, I did it wrong, but 0x3f really is wrong 
too imo. The bits to look at are 3:0, bits 4:5 are reserved and we 
should never look at those, as as you rightfully put it are being relied 
on to be 0 (which may always be the case) but imo is still wrong and 
thus the mask should be 0x0f.

Going to the horse's mouth [0] which is the documentation of the IP 
block used in all these designs, they also say the same thing. 4 bits 
and while I don't have any of the other datasheets of other 8250 cores, 
I bet they are the same?

And then, the following is actually wrong on the same grounds, from the 
8250_dw.c


if ((iir & UART_IIR_BUSY) == UART_IIR_BUSY) {

This just happens to work as it is the only way this can match, but 
clearly it is wrong then, right?

I'll check against the same mask of 0x0f here as well.
>
>
> If you want to make a fix, I'd suggest adding a #define for 0x3f and
> using it in various places.
Yeah I'll do that, add the define next to the others for 0x0f, unless 
someone says it is a good idea (or needed idea) to mask against the 
reserved bits as well.

>
>
>> Some very minor code cleanups, such as including the bitops header for
>> DW_UART_MCR_SIRE, use the BIT() macro as suggested by checkpatc and
>> removed a whitespace to match other invocations.
>
> Maybe it's just me, but it seems like a bad idea to combine these
> cleanups in the same patch with a functional change..
Well with the oversight of the bit check above, it becomes obvious that 
it is a bigger change indeed. I will change it!

Olliver

>

[0] http://linux-sunxi.org/images/d/d2/Dw_apb_uart_db.pdf
