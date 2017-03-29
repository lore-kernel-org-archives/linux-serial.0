From: Olliver Schinagl <o.schinagl-U3FVU11NWA554TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH v2] serial: 8250_dw: Avoid "too much work"
 from bogus rx timeout interrupt
Date: Wed, 29 Mar 2017 11:45:41 +0200
Message-ID: <19bcb511-1417-5d37-7fce-47b66c78d17e@schinagl.nl>
References: <20170206233000.3021-1-dianders@chromium.org>
 <obfpfg$h6e$1@blaine.gmane.org>
 <CAHp75VeND-85ze-zPqz3=8qfSQasK1LmLxcfC=_R1KvN-S7C+A@mail.gmail.com>
Reply-To: o.schinagl-U3FVU11NWA554TAoqtyWWQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBD7M3SWL7UKRBSME53DAKGQE36B6X5Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAHp75VeND-85ze-zPqz3=8qfSQasK1LmLxcfC=_R1KvN-S7C+A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Cal Sullivan <california.l.sullivan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, guennadi.liakhovetski-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, eric.gao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.orglinux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, noamc-d5a29ZRxExrQT0dZR+AlfA@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jason.uy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, ed.blake-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.orgguennadi.liakhovetski-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hey Andy,

On 29-03-17 11:11, Andy Shevchenko wrote:
> On Wed, Mar 29, 2017 at 10:58 AM, Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org> wrote:
>> On 07-02-17 00:30, Douglas Anderson wrote:
>
> First of all I didn't get why people from Cc list are suddenly
> disappeared. Check your mail client settings.
> Returning back some of them.
Appologies, I replied via gmane's news feed to Douglas's initial post as 
I did not have the original post and I failed to check the other 
recipients. My fault. Sorry. I've added the original others as well.

>
>>> It appears that somehow we have a RX Timeout interrupt but there is no
>>> actual data present to receive.  When we're in this state the UART
>>> driver claims that it handled the interrupt but it actually doesn't
>>> really do anything.  This means that we keep getting the interrupt
>>> over and over again.
>
>> I may be running into the same thing on an A20 SoC, but still in the stage
>> of figuring out what is going on, as we get this error very occasionally. Do
>> you have a way to externally induce this behavior other then suspend/resume?
>> As we get it during uart-use and do not have (or I have never tried)
>> suspend/resume on our platform.
>
> On Intel platforms with this IP I can see similar when run loopback
> test on high speeds.
> California may correct me since he did a lot of investigation of the
> issue on x86.
>
>>>  static int dw8250_handle_irq(struct uart_port *p)
>>>  {
>>> +       struct uart_8250_port *up = up_to_u8250p(p);
>>>         struct dw8250_data *d = p->private_data;
>>>         unsigned int iir = p->serial_in(p, UART_IIR);
>>> +       unsigned int status;
>>> +       unsigned long flags;
>>> +
>>> +       /*
>>> +        * There are ways to get Designware-based UARTs into a state where
>>> +        * they are asserting UART_IIR_RX_TIMEOUT but there is no actual
>>> +        * data available.  If we see such a case then we'll do a bogus
>>> +        * read.  If we don't do this then the "RX TIMEOUT" interrupt will
>>> +        * fire forever.
>>
>> I think what you are saying is 'do a bogus read as that is the only way to
>> clear the interrupt, otherwise it will keep firing forever.'?
>
> No, we don't know if this _the only way_. It looks like no one from us
> can tell you a root cause, except may be Synopsys guys.
Has anybody tried to contact synopsis/dw about this issue at all?

true, it is not the only way (maybe only as far as we know for now) but 
it is 'the' way currently.
>
>>> +               spin_lock_irqsave(&p->lock, flags);
>>
>> this is a bit above my knowledge of driver etc, but I don't any spinlocks in
>> the 8250 handle_irq glue drivers, except in the OMAP's case where they are
>> handeling a DMA IRQ. So I ask, because I don't know, why is it needed here?
>
> They serialize IO accessors.
>
> Regarding to the rest comments, the patch is already in upstream, if
> you feel that something should be changed, send an incremental fix.
Ah, I thought I checked, but thought I didn't see it. I'll probably 
forgot to fetch. I'll send a patch for the small mask fix.
>
>> Once I found a way to reproduce the problem (without suspend) I will test
>> this to see if it fixes it for us too.
>
> It would be appreciated, but better to get know the root cause and
> what _hardware_ guys think about solutions.
>
I read over the docs of the IP block (I know a little FPGA programming) 
(dw_apb_uart of 2006) but found nothing yet that would warn for this 
behavior. I suppose hardware/fgpa guys can give more background here 
potentially, but it may also be simply an IP bug?

Olliver
