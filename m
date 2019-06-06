From: Erwan LE RAY <erwan.leray@st.com>
Subject: Re: [PATCH v3] serial: stm32: fix a recursive locking in
 stm32_config_rs485
Date: Thu, 6 Jun 2019 15:48:06 +0000
Message-ID: <e0f8d4b2-a622-3758-473b-b78bd8949323@st.com>
References: <erwan.leray@st.com> <20190606101901.31151-1-borut.seljak@t-2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190606101901.31151-1-borut.seljak@t-2.net>
Content-Language: en-US
Content-ID: <E7F0DC97BDB15B4E944187432787DEC1@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Borut Seljak <borut.seljak@t-2.net>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org


On 6/6/19 12:19 PM, Borut Seljak wrote:
> Remove spin_lock_irqsave in stm32_config_rs485, it cause recursive locking.
> Already locked in uart_set_rs485_config.
>
> fixes: 1bcda09d291081 ("serial: stm32: add support for RS485 hardware control mode")
>
> Signed-off-by: Borut Seljak <borut.seljak@t-2.net>

Hi Borut,

Thanks for your patch.

Acked-by: Erwan Le Ray <erwan.leray@st.com>

Please correct a typo in commit message: "Fixes" instead "fixes"

Erwan.

> ---
>   drivers/tty/serial/stm32-usart.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index e8d7a7bb4339..5d072ec61071 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -105,9 +105,7 @@ static int stm32_config_rs485(struct uart_port *port,
>   	struct stm32_usart_config *cfg = &stm32_port->info->cfg;
>   	u32 usartdiv, baud, cr1, cr3;
>   	bool over8;
> -	unsigned long flags;
>   
> -	spin_lock_irqsave(&port->lock, flags);
>   	stm32_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
>   
>   	port->rs485 = *rs485conf;
> @@ -147,7 +145,6 @@ static int stm32_config_rs485(struct uart_port *port,
>   	}
>   
>   	stm32_set_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
> -	spin_unlock_irqrestore(&port->lock, flags);
>   
>   	return 0;
>   }
