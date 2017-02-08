From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 3/4] serial: sh-sci: make RX FIFO parameters tunable
 via sysfs
Date: Wed, 8 Feb 2017 11:38:00 +0100
Message-ID: <CAMuHMdWBLkoHFJxn693thnUyCVvM+cn-ANhcf7FxSHFiuEw+Aw@mail.gmail.com>
References: <1486118300-12633-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1486118300-12633-4-git-send-email-ulrich.hecht+renesas@gmail.com>
 <CAMuHMdVc3eyXCZfASUst4Kd93WWNVi05q-L32yta8rDDrBLhOQ@mail.gmail.com> <CAO3366zSvO=q+nZT+QfKefuH7+x7vy1HttoXPDCeA7a4f5MKSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAO3366zSvO=q+nZT+QfKefuH7+x7vy1HttoXPDCeA7a4f5MKSA@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
List-Id: linux-serial@vger.kernel.org

Hi Uli,

On Wed, Feb 8, 2017 at 11:04 AM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> On Tue, Feb 7, 2017 at 3:40 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Fri, Feb 3, 2017 at 11:38 AM, Ulrich Hecht
>> <ulrich.hecht+renesas@gmail.com> wrote:
>>> Allows tuning of the RX FIFO fill threshold and timeout. (The latter is
>>> only applicable to SCIFA and SCIFB).
>>>
>>> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> ---
>>>  drivers/tty/serial/sh-sci.c | 87 +++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 87 insertions(+)
>>>
>>> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>>> index 4a165ed..f95a56c 100644
>>> --- a/drivers/tty/serial/sh-sci.c
>>> +++ b/drivers/tty/serial/sh-sci.c
>>> @@ -1055,6 +1055,66 @@ static void rx_fifo_timer_fn(unsigned long arg)
>>>         scif_set_rtrg(port, 1);
>>>  }
>>>
>>> +static ssize_t rx_trigger_show(struct device *dev,
>>> +                              struct device_attribute *attr,
>>> +                              char *buf)
>>> +{
>>> +       struct uart_port *port = dev_get_drvdata(dev);
>>> +       struct sci_port *sci = to_sci_port(port);
>>> +
>>> +       return sprintf(buf, "%d\n", sci->rx_trigger);
>>> +}
>>> +
>>> +static ssize_t rx_trigger_store(struct device *dev,
>>> +                               struct device_attribute *attr,
>>> +                               const char *buf,
>>> +                               size_t count)
>>> +{
>>> +       struct uart_port *port = dev_get_drvdata(dev);
>>> +       struct sci_port *sci = to_sci_port(port);
>>> +       long r;
>>> +
>>> +       if (kstrtol(buf, 0, &r) == -EINVAL)
>>> +               return -EINVAL;
>>> +       sci->rx_trigger = scif_set_rtrg(port, r);
>>> +       scif_set_rtrg(port, 1);
>>
>> I seem to have missed the above function call during my earlier review.
>> What's the purpose of resetting the trigger immediately to 1?
>
> For the software timeout case, the timeout and the trigger levels are
> set in the interrupt handler. Setting the threshold to 1 will trigger
> that when the next byte of data comes in, and it is easier than
> duplicating the logic here.

OK.

> (There actually is a bug here, in that the threshold should only be
> reset to 1 for software timeout IPs (SCIFA and SCIFB), but that is not
> what breaks SCIFA, of course.)

I guess you'll send a patch to fix that, too?

>> I.e. "echo 1 > /sys/class/tty/ttySC0/device/rx_fifo_trigger" fixes serial
>> console input on e.g. armadillo, but echoing 32 into rx_fifo_trigger doesn't
>> break it again.
>
> This is intended to work that way. For software timeout devices (SCIFA
> and SCIFB), the trigger level is not set in hardware unless an
> rx_fifo_timeout > 0 is set as well.
>
> The bug that breaks the SCIFA console is in sci_reset(), which sets a
> hardware threshold > 1 for devices for software timeout devices even
> though the rx_fifo_timeout is 0. Something like this should fix it:
>
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2179,7 +2179,11 @@ static void sci_reset(struct uart_port *port)
>                         setup_timer(&s->rx_fifo_timer, rx_fifo_timer_fn,
>                                     (unsigned long)s);
>                 } else {
> -                       scif_set_rtrg(port, s->rx_trigger);
> +                       if (port->type == PORT_SCIFA ||
> +                           port->type == PORT_SCIFB)
> +                               scif_set_rtrg(port, 1);
> +                       else
> +                               scif_set_rtrg(port, s->rx_trigger);
>                 }
>         }
>  }
>
> Could you try and check if that works for you?

Thanks, that unbroke serial console input on all my boards with SCIFA consoles.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
