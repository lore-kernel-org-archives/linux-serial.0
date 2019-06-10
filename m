From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v3] tty: serial: msm_serial: avoid system lockup condition
Date: Mon, 10 Jun 2019 10:53:09 -0700
Message-ID: <CAF6AEGuAPurGcRh42iRkt3paD=kWLJw-ic_LL1QGY=ws8_00XA@mail.gmail.com>
References: <20190610172308.21129-1-jorge.ramirez-ortiz@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610172308.21129-1-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, agross@kernel.org, David Brown <david.brown@linaro.org>, jslaby@suse.com, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, khasim.mohammed@linaro.org, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 10, 2019 at 10:23 AM Jorge Ramirez-Ortiz
<jorge.ramirez-ortiz@linaro.org> wrote:
>
> The function msm_wait_for_xmitr can be taken with interrupts
> disabled. In order to avoid a potential system lockup - demonstrated
> under stress testing conditions on SoC QCS404/5 - make sure we wait
> for a bounded amount of time.
>
> Tested on SoC QCS404.
>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>


I had observed that heavy UART traffic would lockup the system (on
sdm845, but I guess same serial driver)?

But a comment from the peanut gallary:  wouldn't this fix lead to TX
corruption, ie. writing more into TX fifo before hw is ready?  I
haven't looked closely at the driver, but a way to wait without irqs
disabled would seem nicer..

BR,
-R

> ---
>  v2: fix exit condition (timeout --> !timeout)
>  v3: add these clarification messages
>
>  drivers/tty/serial/msm_serial.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 23833ad952ba..3657a24913fc 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -383,10 +383,14 @@ static void msm_request_rx_dma(struct msm_port *msm_port, resource_size_t base)
>
>  static inline void msm_wait_for_xmitr(struct uart_port *port)
>  {
> +       unsigned int timeout = 500000;
> +
>         while (!(msm_read(port, UART_SR) & UART_SR_TX_EMPTY)) {
>                 if (msm_read(port, UART_ISR) & UART_ISR_TX_READY)
>                         break;
>                 udelay(1);
> +               if (!timeout--)
> +                       break;
>         }
>         msm_write(port, UART_CR_CMD_RESET_TX_READY, UART_CR);
>  }
> --
> 2.21.0
>
