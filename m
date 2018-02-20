From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 9/9] serial: xuartps: Fix out-of-bounds access through DT
 alias
Date: Tue, 20 Feb 2018 11:38:43 +0100
Message-ID: <CAMuHMdUOKMM5mSrnnrxCi0gX_TbjYkj7vwn11b2D5p7XigM+Ag@mail.gmail.com>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-10-git-send-email-geert+renesas@glider.be>
 <c16b025a-a302-8515-2697-f7eca478e939@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <c16b025a-a302-8515-2697-f7eca478e939@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Barry Song <baohua@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Vineet Gupta <vgupta@synopsys.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, arcml <linux-snps-arc@lists.infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Michal,

On Tue, Feb 20, 2018 at 11:22 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 20.2.2018 10:40, Geert Uytterhoeven wrote:
>> The cdns_uart_port[] array is indexed using a value derived from the
>> "serialN" alias in DT, which may lead to an out-of-bounds access.
>>
>> Fix this by adding a range check.
>>
>> Fixes: 1f118c02a1819856 ("serial: xuartps: Fix out-of-bounds access through DT alias")
>
> I didn't find this sha1 - patch name is this one.

Bummer, I totally screwed up my scripting...

Fixes: 928e9263492069ee ("tty: xuartps: Initialize ports according to aliases")

>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  drivers/tty/serial/xilinx_uartps.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
>> index b9b2bc76bcac606c..abcb4d09a2d866d0 100644
>> --- a/drivers/tty/serial/xilinx_uartps.c
>> +++ b/drivers/tty/serial/xilinx_uartps.c
>> @@ -1110,7 +1110,7 @@ static struct uart_port *cdns_uart_get_port(int id)
>>       struct uart_port *port;
>>
>>       /* Try the given port id if failed use default method */
>> -     if (cdns_uart_port[id].mapbase != 0) {
>> +     if (id < CDNS_UART_NR_PORTS && cdns_uart_port[id].mapbase != 0) {
>>               /* Find the next unused port */
>>               for (id = 0; id < CDNS_UART_NR_PORTS; id++)
>>                       if (cdns_uart_port[id].mapbase == 0)
>>
>
> Below should be better fix for this driver.

I considered that, too, but...

> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1109,6 +1109,9 @@ static struct uart_port *cdns_uart_get_port(int id)
>  {
>         struct uart_port *port;
>
> +       if (id >= CDNS_UART_NR_PORTS)
> +               return NULL;
> +
>         /* Try the given port id if failed use default method */
>         if (cdns_uart_port[id].mapbase != 0) {
>                 /* Find the next unused port */
> @@ -1117,9 +1120,6 @@ static struct uart_port *cdns_uart_get_port(int id)
>                                 break;
>         }
>
> -       if (id >= CDNS_UART_NR_PORTS)
> -               return NULL;
> -

... the above check cannot be removed, as it is needed to support the loop
above to find an unused port.

>         port = &cdns_uart_port[id];
>
>         /* At this point, we've got an empty uart_port struct,
> initialize it */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
