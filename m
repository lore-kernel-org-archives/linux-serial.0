From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] serial: 8250_dw: Minor code cleanup
Date: Wed, 29 Mar 2017 08:50:34 -0700
Message-ID: <CAD=FV=XZFuZ-Zqv75wF7wj6AY35o9n4-zrbsVjNcFZ+DxS=fbQ@mail.gmail.com>
References: <20170329100424.7439-1-oliver@schinagl.nl>
Reply-To: dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDR6JO4Q7MHRBTFP57DAKGQEHWFTZDA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
In-Reply-To: <20170329100424.7439-1-oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jason Uy <jason.uy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Ed Blake <ed.blake-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi,

On Wed, Mar 29, 2017 at 3:04 AM, Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org> wrote:
> Commit 424d79183af0 ("serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt")
> added a bit check with quite a wide mask. To be concise with the other
> similar calls in this driver, change it to mask against the flag we want to
> check only. This thus removes a magic value/mask.

How certain are you that your patch is correct?  You are now basically
checking to see if the bits "0xc" are set in the IIR.  Previously the
patch ensured that the bits 0x33 were clear.

Have you tried looking through the kernel for other places where
UART_IIR_RX_TIMEOUT is referenced?  In 8250_omap.c and 8250_port.c I
believe you'll find it masking against 0x3f.  In omap-serial.c you'll
see a mask against 0x3e.

Looking at the TRM for rk3399, I see that bits 4 and 5 (bitmask 0x30)
as "reserved".  I see the following definitions for bits 3:0:

0000 = modem status
0001 = no interrupt pending
0010 = THR empty
0100 = received data available
0110 = receiver line status
0111 = busy detect
1100 = character timeout

...so while your patch will probably function OK, it would also
function equally well to simply test bit 3 (0x80) and ignore
everything else.  ...but IMHO it is more correct to at least mask the
IIR with 0x0F and confirm that bits 2 and 3 are set and bits 0 and 1
are zero.  ...and since the main 8250 code uses 0x3f, that seems even
better to me (despite the fact that it seems to be relying on the fact
that the "reserved" bits come back as 0).


If you want to make a fix, I'd suggest adding a #define for 0x3f and
using it in various places.


> Some very minor code cleanups, such as including the bitops header for
> DW_UART_MCR_SIRE, use the BIT() macro as suggested by checkpatc and
> removed a whitespace to match other invocations.

Maybe it's just me, but it seems like a bad idea to combine these
cleanups in the same patch with a functional change..
