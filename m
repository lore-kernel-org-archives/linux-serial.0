From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 10/10] drivers: PL011: add support for the ARM SBSA
 generic UART
Date: Thu, 12 Mar 2015 10:52:10 +0000
Message-ID: <20150312105210.GK8656@n2100.arm.linux.org.uk>
References: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
 <1425491994-23913-11-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1425491994-23913-11-git-send-email-andre.przywara@arm.com>
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
Cc: rob.herring@linaro.org, arnd@arndb.de, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, jslaby@suse.cz, Dave.Martin@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 04, 2015 at 05:59:54PM +0000, Andre Przywara wrote:
> +static struct uart_ops sbsa_uart_pops = {
> +	.tx_empty	= pl011_tx_empty,
> +	.set_mctrl	= sbsa_uart_set_mctrl,
> +	.get_mctrl	= sbsa_uart_get_mctrl,
> +	.stop_tx	= pl011_stop_tx,
> +	.start_tx	= pl011_start_tx,
> +	.stop_rx	= pl011_stop_rx,
> +	.enable_ms	= NULL,
> +	.break_ctl	= NULL,

It is generally accepted that we don't mention pointers/values which are
initialised to NULL/0 in initialisers.

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

No need to open code the initialisation, rather than using the
module_*_driver() helper macros to avoid the problem which Dave mentioned.

These macros are only there to avoid having to write out the same boiler
plate in loads of simple drivers.  As soon as a driver has more than one
device driver structure in it, it needs to be open coded.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
