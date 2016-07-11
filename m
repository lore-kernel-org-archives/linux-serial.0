From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v8 4/4] serial: pl011: add console matching function
Date: Mon, 11 Jul 2016 16:40:30 +0200
Message-ID: <5783AFDE.1090408@gmail.com>
References: <1463749405-11640-1-git-send-email-aleksey.makarov@linaro.org>
 <1463749405-11640-5-git-send-email-aleksey.makarov@linaro.org>
 <20160622121813.GA20023@yury-N73SV>
 <7CC4D455-323E-4B33-A931-2104E2DDDC0D@hurleysoftware.com>
 <20160622204548.GB28766@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160622204548.GB28766@yury-N73SV>
Sender: linux-acpi-owner@vger.kernel.org
To: Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Russell King <linux@arm.linux.org.uk>, Graeme Gregory <graeme.gregory@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-acpi@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Christopher Covington <cov@codeaurora.org>, linux-serial@vger.kernel.org, Mark Salter <msalter@redhat.com>, Jiri Slaby <jslaby@suse.com>, Al Stone <ahs3@redhat.com>, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org



On 22/06/16 22:45, Yury Norov wrote:
> Hi Peter,
>
> Nice to meet you.
>
> On Wed, Jun 22, 2016 at 07:08:33AM -0700, Peter Hurley wrote:
>>
>>
>>> On Jun 22, 2016, at 5:18 AM, Yury Norov <ynorov@caviumnetworks.com> wrote:
>>>
>>>> On Fri, May 20, 2016 at 04:03:23PM +0300, Aleksey Makarov wrote:
>>>> This patch adds function pl011_console_match() that implements
>>>> method match of struct console.  It allows to match consoles against
>>>> data specified in a string, for example taken from command line or
>>>> compiled by ACPI SPCR table handler.
>>>>
>>>> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
>>>> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
>>>> ---
>>>> drivers/tty/serial/amba-pl011.c | 56 +++++++++++++++++++++++++++++++++++++++++
>>>> 1 file changed, 56 insertions(+)
>>>>
>>>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>>>> index a2aa655..388edc8 100644
>>>> --- a/drivers/tty/serial/amba-pl011.c
>>>> +++ b/drivers/tty/serial/amba-pl011.c
>>>> @@ -2288,12 +2288,68 @@ static int __init pl011_console_setup(struct console *co, char *options)
>>>>     return uart_set_options(&uap->port, co, baud, parity, bits, flow);
>>>> }
>>>>
>>>> +/**
>>>> + *    pl011_console_match - non-standard console matching
>>>> + *    @co:      registering console
>>>> + *    @name:      name from console command line
>>>> + *    @idx:      index from console command line
>>>> + *    @options: ptr to option string from console command line
>>>> + *
>>>> + *    Only attempts to match console command lines of the form:
>>>> + *        console=pl011,mmio|mmio32,<addr>[,<options>]
>>>> + *        console=pl011,0x<addr>[,<options>]
>>>> + *    This form is used to register an initial earlycon boot console and
>>>> + *    replace it with the amba_console at pl011 driver init.
>>>> + *
>>>> + *    Performs console setup for a match (as required by interface)
>>>> + *    If no <options> are specified, then assume the h/w is already setup.
>>>> + *
>>>> + *    Returns 0 if console matches; otherwise non-zero to use default matching
>>>> + */
>>>> +static int __init pl011_console_match(struct console *co, char *name, int idx,
>>>> +                      char *options)
>>>> +{
>>>> +    char match[] = "pl011";    /* pl011-specific earlycon name */
>>>> +    unsigned char iotype;
>>>> +    unsigned long addr;
>>>> +    int i;
>>>> +
>>>> +    if (strncmp(name, match, 5) != 0)
>>>> +        return -ENODEV;
>>>> +
>>>> +    if (uart_parse_earlycon(options, &iotype, &addr, &options))
>>>> +        return -ENODEV;
>>>> +
>>>> +    /* try to match the port specified on the command line */
>>>> +    for (i = 0; i < ARRAY_SIZE(amba_ports); i++) {
>>>> +        struct uart_port *port;
>>>> +
>>>> +        if (!amba_ports[i])
>>>> +            continue;
>>>> +
>>>> +        port = &amba_ports[i]->port;
>>>> +
>>>> +        if (iotype != UPIO_MEM && iotype != UPIO_MEM32)
>>>> +            continue;
>>>
>>> So it looks like iotype is constant inside the loop, and UPIO_MEM
>>> and UPIO_MEM32 too, of course. It means you can move this check out of
>>> cycle and avoid ports traversing at all in specific case. Am I wrong?
>>>
>>
>> No you're not wrong but I'd prefer if we don't use assumptions like that in port enumeration.
>
> I don't think this is an assumption. I think this is solid fact.
> There's no a single chance for stack-allocated variable to be
> shared with other thread of execution, or be unexpectedly changed
> somehow else. So this code not only decreases performance (I don't
> think it's really hot path), but also confuses reader, and makes him
> spend more time on reading this than it deserves.

I agree with Yury on this. From my point of view, it makes no sense to 
check the iotype in every loop iteration.

I tried to apply these patches against linux-next. They needed some 
changes to apply, which is quite normal after such a long time. Apart 
from that the DBG2 subtype patch didn't end up in mainline, so this 
patches do not compile.

I followed up on that on the corresponding thread. Please don't forget 
to pin-point in the introduction mail to any other series which is 
needed for your patches to compile/work.

Thanks a lot,
Matthias


> If you still insist on current version, I'd ask you or Alexey to add
> clear description why we check the same condition again and again
> inside the loop.
>
> Yury.
>
>>>> +
>>>> +        if (port->mapbase != addr)
>>>> +            continue;
>>>> +
>>>> +        co->index = i;
>>>> +        port->cons = co;
>>>> +        return pl011_console_setup(co, options);
>>>> +    }
>>>> +
>>>> +    return -ENODEV;
>>>> +}
>>>> +
>>>> static struct uart_driver amba_reg;
>>>> static struct console amba_console = {
>>>>     .name        = "ttyAMA",
>>>>     .write        = pl011_console_write,
>>>>     .device        = uart_console_device,
>>>>     .setup        = pl011_console_setup,
>>>> +    .match        = pl011_console_match,
>>>>     .flags        = CON_PRINTBUFFER,
>>>>     .index        = -1,
>>>>     .data        = &amba_reg,
>>>> --
>>>> 2.8.2
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
