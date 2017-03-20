From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [RFC PATCH] tty/serial: atmel: fix TX path in
 atmel_console_write()
Date: Mon, 20 Mar 2017 11:33:30 +0100
Message-ID: <05f5c67b-67d8-02b4-e170-52f2484d0927@gmail.com>
References: <CACQ1gAgW4aGJSxSAXDWL7td9eV12UV=Xv=PZR58BqqHxEeRH0g@mail.gmail.com>
 <20170315152948.10978-1-nicolas.ferre@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170315152948.10978-1-nicolas.ferre@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>, linux-serial@vger.kernel.org
Cc: "stable # 4 . 4+" <stable@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 15/03/2017 16:29, Nicolas Ferre wrote:
> A side effect of 89d8232411a8 ("tty/serial: atmel_serial: BUG: stop DMA
> from transmitting in stop_tx") is that the console can be called with
> TX path disabled. Then the system would hang trying to push charecters
> out in atmel_console_putchar().
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Fixes: 89d8232411a8 ("tty/serial: atmel_serial: BUG: stop DMA from transmitting
> in stop_tx")
> Cc: stable <stable@vger.kernel.org> # 4.4+
> ---
> Hi Richard,
> 
> I found this to fix the problem with system hang in my linux-4.4-at91 branch
> (in the atmel_console_putchar() waiting loop actually). I'm open to more
> insignt.
> As we cannot figure out if this bit is set or not, I didn't preserve the
> current status...
> 
> Regards,
> 
>  drivers/tty/serial/atmel_serial.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index dcebb28ffbc4..7372dbdb7a4c 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2483,6 +2483,9 @@ static void atmel_console_write(struct console *co, const char *s, u_int count)
>  	pdc_tx = atmel_uart_readl(port, ATMEL_PDC_PTSR) & ATMEL_PDC_TXTEN;
>  	atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTDIS);
>  
> +	/* Make sure that tx path is actually able to send characters */
> +	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN);
> +
>  	uart_console_write(port, s, count, atmel_console_putchar);
>  
>  	/*
> 
Acked-by: Richard Genoud <richard.genoud@gmail.com>
