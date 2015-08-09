From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v5 05/11] drivers: PL011: refactor pl011_probe()
Date: Sat, 8 Aug 2015 17:59:00 -0700
Message-ID: <CAOZdJXVgRQZhEfYY9YdpiQ=n1D56yYL84s42V4hd2=YX2k48ZA@mail.gmail.com>
References: <1432225584-4655-1-git-send-email-andre.przywara@arm.com>
 <1432225584-4655-6-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1432225584-4655-6-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, G Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <moorray3@wp.pl>, GregKH <gregkh@linuxfoundation.org>, nareshgbhat@gmail.com, mlangsdo@redhat.com, linux-serial@vger.kernel.org, rmk+kernel@arm.linux.org.uk, Jiri Slaby <jslaby@suse.cz>, dave.martin@arm.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Thu, May 21, 2015 at 9:26 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> +static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
> +{
> +       struct uart_amba_port *uap;
> +       struct vendor_data *vendor = id->data;
> +       int portnr, ret;
> +
> +       portnr = pl011_find_free_port();
> +       if (portnr < 0)
> +               return portnr;
> +
> +       uap = devm_kzalloc(&dev->dev, sizeof(struct uart_amba_port),
> +                          GFP_KERNEL);
> +       if (!uap)
> +               return -ENOMEM;
> +
> +       uap->clk = devm_clk_get(&dev->dev, NULL);
> +       if (IS_ERR(uap->clk))
> +               return PTR_ERR(uap->clk);
> +
> +       = vendor;

I'm having trouble with this.  Specifically, I can't get SBSA early
console to work, because uap->vendor is uninitialized when
pl011_early_write() is called.

I don't have a non-SBSA system to test, but looking at the code, I'm
not sure how early console is supposed to work any more.  In both SBSA
and non-SBSA cases, uap->vendor is not initialized until the probe
function is called.  Isn't that too late?  I thought early console was
supposed to be running before the driver is probed.

If I make this change, then early console works on SBSA systems (with
earlycon=pl011,<address>).  But of course, this only works for SBSA
and breaks regular PL011.

--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2326,9 +2326,15 @@ static void pl011_early_write(struct console *con, const
 static int __init pl011_early_console_setup(struct earlycon_device *device,
                                            const char *opt)
 {
+       struct uart_amba_port *uap =
+           container_of(&device->port, struct uart_amba_port, port);
+
        if (!device->port.membase)
                return -ENODEV;
+       if (!uap->vendor)
+               uap->vendor = &vendor_sbsa;
+
        device->con->write = pl011_early_write;
        return 0;
 }

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
