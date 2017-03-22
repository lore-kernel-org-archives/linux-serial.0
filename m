From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [REGRESSION next-20170321] acbdad8dd1ab ("serial: 8250_dw:
 simplify optional reset handling") causes silent kernel.
Date: Wed, 22 Mar 2017 15:33:47 +0100
Message-ID: <1490193227.2285.39.camel@pengutronix.de>
References: <20170322152445.0b25f78c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170322152445.0b25f78c@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Ralph,

On Wed, 2017-03-22 at 15:24 +0100, Ralph Sennhauser wrote:
> Hi Philipp,
> 
> Commit acbdad8dd1ab ("serial: 8250_dw: simplify optional reset
> handling") causes the kernel to no longer print anything to the serial
> console on a Linksys WRT3200ACM (Armada-385, a similar board would
> be ./arch/arm/boot/dts/armada-385-linksys-cobra.dts). The last message
> from uboot is "Starting kernel ..." and then silence. The device boots
> all the way nonetheless.
> 
> Reverting the above commit gets the console output back.
> 
> Ralph

Thank you for the report. I assume that you are compiling with the
RESET_CONTROLLER Kconfig option disabled? Does commit 0ca10b60ceeb
("reset: fix optional reset_control_get stubs to return NULL") [1] in
the arm-soc fixes branch help with this issue?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/commit/?h=fixes&id=0ca10b60ceeb5372da01798ca68c116ae45a6eb6

regards
Philipp
