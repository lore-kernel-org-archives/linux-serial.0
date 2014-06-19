From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 11/13] serial: asc: Adopt readl_/writel_relaxed()
Date: Thu, 19 Jun 2014 12:29:39 +0100
Message-ID: <53A2C9A3.9090507@linaro.org>
References: <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
 <1403174303-25456-12-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1403174303-25456-12-git-send-email-daniel.thompson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Thompson <daniel.thompson@linaro.org>, Jason Wessel <jason.wessel@windriver.com>
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, kgdb-bugreport@lists.sourceforge.net, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, patches@linaro.org, Anton Vorontsov <anton.vorontsov@linaro.org>, "David A. Long" <dave.long@linaro.org>, linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Colin Cross <ccross@android.com>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Maxime Coquelin <maxime.coquelin@st.com>, Greg
List-Id: linux-serial@vger.kernel.org

Hi Dan,

On 19/06/14 11:38, Daniel Thompson wrote:
> The architectures supported by this driver have expensive
> implementations of writel(), reliant on spin locks and explicit L2 cache
> management. These architectures provide a cheaper writel_relaxed() which
> is much better suited to peripherals that do not perform DMA. The
> situation with readl()/readl_relaxed()is similar although less acute.
>
> This driver does not use DMA and will be more power efficient and more
> robust (due to absense of spin locks during console I/O) if it uses the
> relaxed variants.
>
> This driver is cross compilable for testing purposes and remains
> compilable on all architectures by falling back to writel() when
> writel_relaxed() does not exist. We also include explicit compiler
> barriers. There are redundant on ARM and SH but important on
> x86 because it defines "relaxed" differently.
>
Why are we concern about x86 for this driver?
As per my understanding this IP is only seen on ARM and SH based CPUs so 
why cant we just use relaxed versions, why ifdefs?
I think, this would involve fixing the kconfig and make it depend on SH 
and ARM based platforms only.

On the other hand, This patch looks more generic and applicable to most 
of the drivers. Am not sure which way is the right one.


--srini

> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> Cc: Maxime Coquelin <maxime.coquelin@st.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: kernel@stlinux.com
> Cc: linux-serial@vger.kernel.org
> ---
>   drivers/tty/serial/st-asc.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> index 4f376d8..58aa1c6 100644
> --- a/drivers/tty/serial/st-asc.c
> +++ b/drivers/tty/serial/st-asc.c
> @@ -152,12 +152,21 @@ static inline struct asc_port *to_asc_port(struct uart_port *port)
>
>   static inline u32 asc_in(struct uart_port *port, u32 offset)
>   {
> -	return readl(port->membase + offset);
> +	u32 r;
> +
> +	r = readl_relaxed(port->membase + offset);
> +	barrier();
> +	return r;
>   }
>
>   static inline void asc_out(struct uart_port *port, u32 offset, u32 value)
>   {
> +#ifdef writel_relaxed
> +	writel_relaxed(value, port->membase + offset);
> +	barrier();
> +#else
>   	writel(value, port->membase + offset);
> +#endif
>   }
>
>   /*
>
