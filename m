From: Gerald Baeza <gerald.baeza@st.com>
Subject: Re: [patch] serial: stm32: fix a type issue
Date: Wed, 12 Oct 2016 09:40:05 +0200
Message-ID: <2e281be5-986d-21fd-7a9d-b451b1d82d4a@st.com>
References: <20161012062103.GS12841@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161012062103.GS12841@mwanda>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre TORGUE <alexandre.torgue@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, kernel-janitors@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

Hi Dan and thanks for the patch

On 10/12/2016 08:21 AM, Dan Carpenter wrote:
> We store UNDEF_REG in a u8.  It causes a problem in functions like
> stm32_tx_dma_complete() where we check "if (ofs->icr == UNDEF_REG)".
>
> Fixes: 3489187204eb ('serial: stm32: adding dma support')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
> index 41d9749..f9887cc 100644
> --- a/drivers/tty/serial/stm32-usart.h
> +++ b/drivers/tty/serial/stm32-usart.h
> @@ -31,7 +31,7 @@ struct stm32_usart_info {
>  	struct stm32_usart_config cfg;
>  };
>
> -#define UNDEF_REG ~0
> +#define UNDEF_REG 0xFF
>
>  /* Register offsets */
>  struct stm32_usart_info stm32f4_info = {
>

Reviewed-by: Gerald Baeza <gerald.baeza@st.com>
