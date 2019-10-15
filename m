From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] serial: core: Use cons->index for preferred console
 registration
Date: Tue, 15 Oct 2019 11:19:25 +0200
Message-ID: <CAMuHMdWY2VsY-CyAxSvpm1XYicAWqU7NORSQofQ+T195DwyLUg@mail.gmail.com>
References: <4a877f1c7189a7c45b59a6ebfc3de607e8758949.1567434470.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4a877f1c7189a7c45b59a6ebfc3de607e8758949.1567434470.git.michal.simek@xilinx.com>
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
Cc: Michal Simek <monstr@monstr.eu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Michal,

On Mon, Sep 2, 2019 at 4:29 PM Michal Simek <michal.simek@xilinx.com> wrote:
> The reason for this patch is xilinx_uartps driver which create one dynamic
> instance per IP with unique major and minor combinations. drv->nr is in
> this case all the time setup to 1. That means that uport->line is all the
> time setup to 0 and drv->tty_driver->name_base is doing shift in name to
> for example ttyPS3.
>
> register_console() is looping over console_cmdline array and looking for
> proper name/index combination which is in our case ttyPS/3.
> That's why every instance of driver needs to be registered with proper
> combination of name/number (ttyPS/3). Using uport->line is doing
> registration with ttyPS/0 which is wrong that's why proper console index
> should be used which is in cons->index field.
>
> Also it is visible that recording console should be done based on
> information about console not about the port but in most cases numbers are
> the same and xilinx_uartps is only one exception now.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

This is now commit 91daae03188e0dd1 ("serial: core: Use cons->index
for preferred console registration") in tty-next.

This has been bisected to break the serial console on (at least)
r8a7791/koelsch and r8a7795/h3-salvator-xs.

The line "printk: console [ttySC0] enabled" is no longer printed.
The system continues booting without any serial console output, and the
login prompt never appears on the serial console.

Reverting this commit fixes the issue.

> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2825,7 +2825,8 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
>                 lockdep_set_class(&uport->lock, &port_lock_key);
>         }
>         if (uport->cons && uport->dev)
> -               of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
> +               of_console_check(uport->dev->of_node, uport->cons->name,
> +                                uport->cons->index);
>
>         uart_configure_port(drv, state, uport);

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
