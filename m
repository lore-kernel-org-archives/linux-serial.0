From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [patch 1/5] AST2500 DMA UART driver
Date: Mon, 10 Jun 2019 18:50:40 +0200
Message-ID: <20190610165040.GB32085@kroah.com>
References: <1559737395-28542-1-git-send-email-open.sudheer@gmail.com>
 <1559737395-28542-2-git-send-email-open.sudheer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1559737395-28542-2-git-send-email-open.sudheer@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "sudheer.v" <open.sudheer@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, sudheer.veliseti@aspeedtech.com, linux-aspeed@lists.ozlabs.org, andrew@aj.id.au, benh@kernel.crashing.org, shivahshankar.shankarnarayanrao@aspeedtech.com, robh+dt@kernel.org, joel@jms.id.au, linux-serial@vger.kernel.org, jslaby@suse.com, mchehab+samsung@kernel.org, linux-arm-kernel@lists.infradead.org, sudheer Kumar veliseti <sudheer.open@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 05, 2019 at 05:53:11PM +0530, sudheer.v wrote:
> +
> +#define CONFIG_UART_DMA_DEBUG
> +
> +#ifdef CONFIG_UART_DMA_DEBUG
> +#define UART_DBG(fmt, args...) pr_debug("%s() " fmt, __func__, ## args)
> +#else
> +#define UART_DBG(fmt, args...)
> +#endif
> +
> +#define  CONFIG_UART_TX_DMA_DEBUG 1
> +
> +#ifdef CONFIG_UART_TX_DMA_DEBUG
> +#define UART_TX_DBG(fmt, args...) pr_debug("%s()"fmt, __func__, ## args)
> +#else
> +#define UART_TX_DBG(fmt, args...)
> +#endif

Why have you left debugging on here?

Why does your tiny driver have custom debug macros?  Please always use
the in-kernel standard ones so you can dynamically enable/disable them
as needed without having to rebuild the code.

I stopped reading here, sorry.

greg k-h
