From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v2 10/10] drivers: PL011: add support for the ARM SBSA
 generic UART
Date: Mon, 9 Mar 2015 15:59:48 +0000
Message-ID: <20150309155935.GA3984@e103592.cambridge.arm.com>
References: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
 <1425491994-23913-11-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1425491994-23913-11-git-send-email-andre.przywara@arm.com>
Content-Disposition: inline
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
Cc: rob.herring@linaro.org, linux@arm.linux.org.uk, arnd@arndb.de, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, jslaby@suse.cz, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 04, 2015 at 05:59:54PM +0000, Andre Przywara wrote:
> The ARM Server Base System Architecture[1] document describes a
> generic UART which is a subset of the PL011 UART.
> It lacks DMA support, baud rate control and modem status line
> control, among other things.
> The idea is to move the UART initialization and setup into the
> firmware (which does this job today already) and let the kernel just
> use the UART for sending and receiving characters.
> 
> We use the recent refactoring to build a new struct uart_ops
> variable which points to some new functions avoiding access to the
> missing registers. We reuse as much existing PL011 code as possible.
> 
> In contrast to the PL011 the SBSA UART does not define any AMBA or
> PrimeCell relations, so we go with a pretty generic probe function
> which only uses platform device functions.
> A DT binding is provided, but other systems can easily attach to it,
> too (hint, hint!).
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

[...]

> +MODULE_DEVICE_TABLE(of, sbsa_uart_match);
> +
> +static struct platform_driver arm_sbsa_uart_platform_driver = {
> +	.probe		= sbsa_uart_probe,
> +	.remove		= sbsa_uart_remove,
> +	.driver	= {
> +		.name	= "sbsa-uart",
> +		.of_match_table = of_match_ptr(sbsa_uart_match),
> +	},
> +};
> +
> +module_platform_driver(arm_sbsa_uart_platform_driver);

Hmmm, this seems to break with CONFIG_MODULE -- it tries to create its
own module_{init,exit} that just register/unregister the platform
driver.

Instead, I think the existing init/exit functions need to register/
unregister both drivers.

Module initialisation shouldn't fail unless neither registration
succeeds (?) -- if only one succeeds we can carry on, but it's worth
a printk.  Or can the failure of either registration just be fatal?

Cheers
---Dave
