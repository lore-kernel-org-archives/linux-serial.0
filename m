From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 18/25] serial: sh-sci: Prepare for multiple clocks and
 baud rate generators
Date: Fri, 20 Nov 2015 08:52:19 +0100
Message-ID: <CAMuHMdWZVZ-iVRKOjzszoJiBMxC-p=OTGWRb-EYHFV=eC3DiWQ@mail.gmail.com>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
	<1447958344-836-19-git-send-email-geert+renesas@glider.be>
	<3383903.1R72kZGx62@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <3383903.1R72kZGx62@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

On Thu, Nov 19, 2015 at 10:04 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday 19 November 2015 19:38:57 Geert Uytterhoeven wrote:
>> Refactor the clock and baud rate parameter code to ease adding support
>> for multiple clocks and baud rate generators later.
>> sci_scbrr_calc() now returns the bit rate error, so it can be compared
>> to the bit rate error for other baud rate generators.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  drivers/tty/serial/sh-sci.c | 176 +++++++++++++++++++++++++++--------------
>>  1 file changed, 120 insertions(+), 56 deletions(-)
>>
>> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> index 726c96d5a511c222..12800e52f41953dc 100644
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c

>> @@ -2252,33 +2301,48 @@ static struct uart_ops sci_uart_ops = {
>>
>>  static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
>>  {
>> -     /* Get the SCI functional clock. It's called "fck" on ARM. */
>> -     sci_port->fclk = devm_clk_get(dev, "fck");
>> -     if (PTR_ERR(sci_port->fclk) == -EPROBE_DEFER)
>> -             return -EPROBE_DEFER;
>> -     if (!IS_ERR(sci_port->fclk))
>> -             return 0;
>> +     const char *clk_names[] = {
>> +             [SCI_FCK] = "fck",
>> +     };
>> +     struct clk *clk;
>> +     unsigned int i;
>>
>> -     /*
>> -      * But it used to be called "sci_ick", and we need to maintain DT
>> -      * backward compatibility.
>> -      */
>> -     sci_port->fclk = devm_clk_get(dev, "sci_ick");
>> -     if (PTR_ERR(sci_port->fclk) == -EPROBE_DEFER)
>> -             return -EPROBE_DEFER;
>> -     if (!IS_ERR(sci_port->fclk))
>> -             return 0;
>> +     for (i = 0; i < SCI_NUM_CLKS; i++) {
>> +             clk = devm_clk_get(dev, clk_names[i]);
>> +             if (PTR_ERR(clk) == -EPROBE_DEFER)
>> +                     return -EPROBE_DEFER;
>>
>> -     /*
>> -      * Not all SH platforms declare a clock lookup entry for SCI devices,
>> -      * in which case we need to get the global "peripheral_clk" clock.
>> -      */
>> -     sci_port->fclk = devm_clk_get(dev, "peripheral_clk");
>> -     if (!IS_ERR(sci_port->fclk))
>> -             return 0;
>> +             if (IS_ERR(clk) && i == SCI_FCK) {
>> +                     /*
>> +                      * "fck" used to be called "sci_ick", and we need to
>> +                      * maintain DT backward compatibility.
>> +                      */
>> +                     clk = devm_clk_get(dev, "sci_ick");
>> +                     if (PTR_ERR(clk) == -EPROBE_DEFER)
>> +                             return -EPROBE_DEFER;
>> +
>> +                     if (!IS_ERR(clk))
>> +                             goto found;
>> +
>> +                     /*
>> +                      * Not all SH platforms declare a clock lookup entry
>> +                      * for SCI devices, in which case we need to get the
>> +                      * global "peripheral_clk" clock.
>> +                      */
>> +                     clk = devm_clk_get(dev, "peripheral_clk");
>> +                     if (!IS_ERR(clk))
>> +                             goto found;
>> +
>> +                     dev_err(dev, "failed to get functional clock\n");
>> +                     return PTR_ERR(clk);
>> +             }
>>
>> -     dev_err(dev, "failed to get functional clock\n");
>> -     return PTR_ERR(sci_port->fclk);
>> +found:
>> +             if (!IS_ERR(clk))
>> +                     dev_dbg(dev, "clk %u is %pC rate %pCr\n", i, clk, clk);
>> +             sci_port->clks[i] = IS_ERR(clk) ? NULL : clk;
>
> Isn't it an issue that we can't tell apart the case where there is no clock
> specified in DT and the case where we can't get the clock due to another error
> ?

All failures here are for optional clocks.
If the real failure is that the clock wasn't specified (or misspelled) in DT,
it should have been detected during the integration phase.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
