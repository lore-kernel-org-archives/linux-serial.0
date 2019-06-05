From: Erwan LE RAY <erwan.leray@st.com>
Subject: Re: Fwd: [PATCH -next] serial: stm32: Make stm32_get_databits static
Date: Wed, 5 Jun 2019 09:52:27 +0000
Message-ID: <1eb3edf6-054d-be59-340c-312f57815912@st.com>
References: <20190528090449.22868-1-yuehaibing@huawei.com>
 <e7a74cb7-fd9f-89d2-8314-5e216eae2d13@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <e7a74cb7-fd9f-89d2-8314-5e216eae2d13@st.com>
Content-Language: en-US
Content-ID: <BB60DC7AEE09EE43BA33DB5BCAA320CD@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: YueHaibing <yuehaibing@huawei.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jslaby@suse.com" <jslaby@suse.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>YueHaibing <yuehaibing@huawei.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>
List-Id: linux-serial@vger.kernel.org

OK for me.

Erwan.


On 6/5/19 9:08 AM, Fabrice Gasnier wrote:
> Un autre qu'on avait pas vu...
>
>
> -------- Forwarded Message --------
> Subject: [PATCH -next] serial: stm32: Make stm32_get_databits static
> Date: Tue, 28 May 2019 17:04:49 +0800
> From: YueHaibing <yuehaibing@huawei.com>
> To: gregkh@linuxfoundation.org, jslaby@suse.com,
> mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
> CC: YueHaibing <yuehaibing@huawei.com>, linux-serial@vger.kernel.org,
> linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
> linux-stm32@st-md-mailman.stormreply.com
>
> Fix sparse warning:
>
> drivers/tty/serial/stm32-usart.c:603:14: warning:
>   symbol 'stm32_get_databits' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/tty/serial/stm32-usart.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/stm32-usart.c
> b/drivers/tty/serial/stm32-usart.c
> index 9c2b04e..4517f2b 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -600,7 +600,7 @@ static void stm32_shutdown(struct uart_port *port)
>   	free_irq(port->irq, port);
>   }
>   -unsigned int stm32_get_databits(struct ktermios *termios)
> +static unsigned int stm32_get_databits(struct ktermios *termios)
>   {
>   	unsigned int bits;
>   -- 2.7.4
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
