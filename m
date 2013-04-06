From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MIPS: BCM63XX: merge bcm63xx_clk.h into bcm63xx/clk.c
Date: Sat, 6 Apr 2013 08:20:44 -0700
Message-ID: <20130406152044.GA12202@kroah.com>
References: <1365247862-19358-1-git-send-email-jogo@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1365247862-19358-1-git-send-email-jogo@openwrt.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Jonas Gorski <jogo@openwrt.org>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, John Crispin <blogic@openwrt.org>, Maxime Bizon <mbizon@freebox.fr>, Florian Fainelli <florian@openwrt.org>, Kevin Cernekee <cernekee@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Sat, Apr 06, 2013 at 01:31:02PM +0200, Jonas Gorski wrote:
> All the header file does is provide the internal structure of clk,
> which shouldn't be used by anyone except clk.c itself anyway.
> 
> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
> ---
>  arch/mips/bcm63xx/clk.c                          |    8 +++++++-
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_clk.h |   11 -----------
>  drivers/tty/serial/bcm63xx_uart.c                |    1 -
>  3 files changed, 7 insertions(+), 13 deletions(-)
>  delete mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_clk.h

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
