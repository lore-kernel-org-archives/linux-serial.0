From: Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH] serial: SERIAL_STM32 should depend on HAS_DMA
Date: Thu, 6 Oct 2016 16:08:21 +0200
Message-ID: <b679c594-d16b-3339-3606-e152107053e0@st.com>
References: <1475762124-16609-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475762124-16609-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Geert,

On 10/06/2016 03:55 PM, Geert Uytterhoeven wrote:
> If NO_DMA=y:
>
>     drivers/built-in.o: In function `stm32_serial_remove':
>     stm32-usart.c:(.text+0xcea1a): undefined reference to `bad_dma_ops'
>     stm32-usart.c:(.text+0xcea7a): undefined reference to `bad_dma_ops'
>
> Add a dependency on HAS_DMA to fix this.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/tty/serial/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index c7831407a882d2bb..25c1d7bc010043b1 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1625,6 +1625,7 @@ config SERIAL_SPRD_CONSOLE
>  config SERIAL_STM32
>  	tristate "STMicroelectronics STM32 serial port support"
>  	select SERIAL_CORE
> +	depends on HAS_DMA
>  	depends on ARM || COMPILE_TEST
>  	help
>  	  This driver is for the on-chip Serial Controller on
>
I sent same kind of patch this morning (but mine have a bad copy paste).
I will abandon my patch.

However for this one:
Acked-by: Alexandre Torgue <alexandre.torgue@st.com>

regards
Alex
