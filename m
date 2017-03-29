From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] serial: 8250_dw: Avoid "too much work" from bogus rx
 timeout interrupt
Date: Wed, 29 Mar 2017 12:11:33 +0300
Message-ID: <CAHp75VeND-85ze-zPqz3=8qfSQasK1LmLxcfC=_R1KvN-S7C+A@mail.gmail.com>
References: <20170206233000.3021-1-dianders@chromium.org>
 <obfpfg$h6e$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <obfpfg$h6e$1@blaine.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Cal Sullivan <california.l.sullivan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, guennadi.liakhovetski-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 29, 2017 at 10:58 AM, Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org> wrote:
> On 07-02-17 00:30, Douglas Anderson wrote:

First of all I didn't get why people from Cc list are suddenly
disappeared. Check your mail client settings.
Returning back some of them.

>> It appears that somehow we have a RX Timeout interrupt but there is no
>> actual data present to receive.  When we're in this state the UART
>> driver claims that it handled the interrupt but it actually doesn't
>> really do anything.  This means that we keep getting the interrupt
>> over and over again.

> I may be running into the same thing on an A20 SoC, but still in the stage
> of figuring out what is going on, as we get this error very occasionally. Do
> you have a way to externally induce this behavior other then suspend/resume?
> As we get it during uart-use and do not have (or I have never tried)
> suspend/resume on our platform.

On Intel platforms with this IP I can see similar when run loopback
test on high speeds.
California may correct me since he did a lot of investigation of the
issue on x86.

>>  static int dw8250_handle_irq(struct uart_port *p)
>>  {
>> +       struct uart_8250_port *up = up_to_u8250p(p);
>>         struct dw8250_data *d = p->private_data;
>>         unsigned int iir = p->serial_in(p, UART_IIR);
>> +       unsigned int status;
>> +       unsigned long flags;
>> +
>> +       /*
>> +        * There are ways to get Designware-based UARTs into a state where
>> +        * they are asserting UART_IIR_RX_TIMEOUT but there is no actual
>> +        * data available.  If we see such a case then we'll do a bogus
>> +        * read.  If we don't do this then the "RX TIMEOUT" interrupt will
>> +        * fire forever.
>
> I think what you are saying is 'do a bogus read as that is the only way to
> clear the interrupt, otherwise it will keep firing forever.'?

No, we don't know if this _the only way_. It looks like no one from us
can tell you a root cause, except may be Synopsys guys.

>> +               spin_lock_irqsave(&p->lock, flags);
>
> this is a bit above my knowledge of driver etc, but I don't any spinlocks in
> the 8250 handle_irq glue drivers, except in the OMAP's case where they are
> handeling a DMA IRQ. So I ask, because I don't know, why is it needed here?

They serialize IO accessors.

Regarding to the rest comments, the patch is already in upstream, if
you feel that something should be changed, send an incremental fix.

> Once I found a way to reproduce the problem (without suspend) I will test
> this to see if it fixes it for us too.

It would be appreciated, but better to get know the root cause and
what _hardware_ guys think about solutions.

-- 
With Best Regards,
Andy Shevchenko
