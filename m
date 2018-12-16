From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Date: Sun, 16 Dec 2018 21:32:19 +0100
Message-ID: <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181216200833.27928-1-paul.burton@mips.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Burton <paul.burton@mips.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Burton <pburton@wavecomp.com>, Daniel Jedrychowski <avistel@gmail.com>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 12/16/2018 09:10 PM, Paul Burton wrote:
> Commit f6aa5beb45be ("serial: 8250: Fix clearing FIFOs in RS485 mode
> again") makes a change to FIFO clearing code which its commit message
> suggests was intended to be specific to use with RS485 mode, however:
> 
>  1) The change made does not just affect __do_stop_tx_rs485(), it also
>     affects other uses of serial8250_clear_fifos() including paths for
>     starting up, shutting down or auto-configuring a port regardless of
>     whether it's an RS485 port or not.
> 
>  2) It makes the assumption that resetting the FIFOs is a no-op when
>     FIFOs are disabled, and as such it checks for this case & explicitly
>     avoids setting the FIFO reset bits when the FIFO enable bit is
>     clear. A reading of the PC16550D manual would suggest that this is
>     OK since the FIFO should automatically be reset if it is later
>     enabled, but we support many 16550-compatible devices and have never
>     required this auto-reset behaviour for at least the whole git era.
>     Starting to rely on it now seems risky, offers no benefit, and
>     indeed breaks at least the Ingenic JZ4780's UARTs which reads
>     garbage when the RX FIFO is enabled if we don't explicitly reset it.
> 
>  3) By only resetting the FIFOs if they're enabled, the behaviour of
>     serial8250_do_startup() during boot now depends on what the value of
>     FCR is before the 8250 driver is probed. This in itself seems
>     questionable and leaves us with FCR=0 & no FIFO reset if the UART
>     was used by 8250_early, otherwise it depends upon what the
>     bootloader left behind.
> 
>  4) Although the naming of serial8250_clear_fifos() may be unclear, it
>     is clear that callers of it expect that it will disable FIFOs. Both
>     serial8250_do_startup() & serial8250_do_shutdown() contain comments
>     to that effect, and other callers explicitly re-enable the FIFOs
>     after calling serial8250_clear_fifos(). The premise of that patch
>     that disabling the FIFOs is incorrect therefore seems wrong.
> 
> For these reasons, this reverts commit f6aa5beb45be ("serial: 8250: Fix
> clearing FIFOs in RS485 mode again").
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Fixes: f6aa5beb45be ("serial: 8250: Fix clearing FIFOs in RS485 mode again").
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Daniel Jedrychowski <avistel@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: linux-mips@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: stable <stable@vger.kernel.org> # 4.10+
I am unable to test it on such a short notice as I'm currently ill, so I
cannot tell if your change breaks the OMAP3/AM335x boards or not. Given
that there are very few CI20 boards in use, I'd like to ask you for some
extra time to investigate this on the OMAP3 too.

btw what strikes me as curious is that this patch emerged shortly after
Ezequiel re-posted the CI20 U-Boot patches after an year-long hiatus, is
it somehow related ?

-- 
Best regards,
Marek Vasut
