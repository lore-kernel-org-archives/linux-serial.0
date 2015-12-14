From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 07/25] serial: sh-sci: Convert from clk_get() to devm_clk_get()
Date: Mon, 14 Dec 2015 11:34:11 +0100
Message-ID: <CAMuHMdXPNziFbEDvn6VwXrQY4mftpwkyOojzkwCNqvBqFOTWCg@mail.gmail.com>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
	<3399561.8ERHTtILhO@avalon>
	<CAMuHMdXn4xa-0wfL8DXbhzfsPwymT5XXBR70eSL-OF5Fv67+mg@mail.gmail.com>
	<1466956.fL4LZVx6Ru@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466956.fL4LZVx6Ru@avalon>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Laurent,

On Sun, Dec 13, 2015 at 8:39 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday 10 December 2015 13:30:18 Geert Uytterhoeven wrote:
>> On Thu, Nov 19, 2015 at 9:38 PM, Laurent Pinchart wrote:
>> > On Thursday 19 November 2015 19:38:46 Geert Uytterhoeven wrote:
>> >> Transfer clock cleanup handling to the core device management code.
>> >>
>> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> >> ---
>> >>
>> >>  drivers/tty/serial/sh-sci.c | 8 +++-----
>> >>  1 file changed, 3 insertions(+), 5 deletions(-)
>> >>
>> >> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
>> >> index cba51da604253db6..9442961a198378c7 100644
>> >> --- a/drivers/tty/serial/sh-sci.c
>> >> +++ b/drivers/tty/serial/sh-sci.c
>> >> @@ -2216,7 +2216,7 @@ static struct uart_ops sci_uart_ops = {
>> >>
>> >>  static int sci_init_clocks(struct sci_port *sci_port, struct device
>> >>  *dev)
>> >>  {
>> >>
>> >>       /* Get the SCI functional clock. It's called "fck" on ARM. */
>> >>
>> >> -     sci_port->fclk = clk_get(dev, "fck");
>> >> +     sci_port->fclk = devm_clk_get(dev, "fck");
>> >
>> > Have you tested what happens if you unbind the device from the driver
>> > while userspace has the serial port open ?
>>
>> Yes I have. And I didn't notice any user-visible behavioral differences.
>>
>> There is a small ordering difference, though: with clk_get() and clk_put(),
>> the explicit clk_put() is done before removing the device from its PM
>> Domain (which involces another call to clk_put() on the module clock):
>>
>>     device_release_driver
>>         __device_release_driver
>>             platform_drv_remove
>>                 sci_remove
>>                     sci_cleanup_single
>>                         __clk_put
>>                 genpd_dev_pm_detach
>>                     pm_genpd_remove_device
>>                         pm_clk_destroy
>>                             __pm_clk_remove
>>                                 __clk_put
>>
>> When using devm_clk_get(), the managed cleanup is done after the device has
>> been removed from its PM Domain:
>>
>>     device_release_driver
>>         __device_release_driver
>>             platform_drv_remove
>>                 genpd_dev_pm_detach
>>                     pm_genpd_remove_device
>>                         pm_clk_destroy
>>                             __pm_clk_remove
>>                                 __clk_put
>>             release_nodes
>>                 __clk_put
>>
>> This shouldn't make a difference, and applies to all other drivers using
>> devm_*(), and devices that are part of a PM Domain.
>
> I was more concerned about the clk_disable_unprepare() calls. The function is
> called through the uart pm handler which is called when closing the uart
> (uart_close()). It's a bit difficult to follow the dynamic code paths as I'm
> not very familiar with the framework, but I was concerned that the would end
> up calling clk_disable_unprepare() on a clock for which we have no reference
> anymore. What prevents clk_disable_unprepare() from being called in the close
> path after the device has been unbound ? And what ensures that the clocks get
> unprepared when unbinding the device if the port is held open by a userspace
> process ?

Both questions are answered by uart_hangup():
  - uart_hangup() sets port->count to zero, hence uart_close() returns early
    (second return statement), long before it would call the uart pm handler.
  - uart_hangup() calls uart_change_pm(state, UART_PM_STATE_OFF);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
