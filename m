From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH 3.17-rc3 v2] serial: asc: Adopt readl_/writel_relaxed()
Date: Tue, 09 Sep 2014 12:15:16 +0100
Message-ID: <540EE144.8030504@linaro.org>
References: <1409745651-3247-1-git-send-email-daniel.thompson@linaro.org>	<1410257037-20030-1-git-send-email-daniel.thompson@linaro.org> <CALNtEFgd=Lw3AdO2cq_X66_kVdjRyu8sVKN5UX3tzKS5c6d_JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALNtEFgd=Lw3AdO2cq_X66_kVdjRyu8sVKN5UX3tzKS5c6d_JA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, Jiri Slaby <jslaby@suse.cz>, kernel@stlinux.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 09/09/14 12:08, Srinivas Kandagatla wrote:
> Hi Dan,
> 
> After Greg's comment, Am ok with the patch and sorry for the noise.
> Good that you removed the barier() too.

Yes.

I got interested in Greg's question about which architectures don't have
readl_relaxed() and, in the process, discovered I was wrong about that
being needed anyway.


> You can have my Ack.
> 
> --srini
> 
> On Tue, Sep 9, 2014 at 11:03 AM, Daniel Thompson
> <daniel.thompson@linaro.org <mailto:daniel.thompson@linaro.org>> wrote:
> 
>     The architectures supported by this driver, arm and sh, have expensive
>     implementations of writel(), reliant on spin locks and explicit L2 cache
>     management. These architectures provide a cheaper writel_relaxed() which
>     is much better suited to peripherals that do not perform DMA. The
>     situation with readl()/readl_relaxed()is similar although less acute.
> 
>     This driver does not use DMA and will be more power efficient and more
>     robust (due to absence of spin locks during console I/O) if it uses the
>     relaxed variants.
> 
>     The driver supports COMPILE_TEST and therefore falls back to writel()
>     when writel_relaxed() does not exist.
> 
>     Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org
>     <mailto:daniel.thompson@linaro.org>>
>     Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com
>     <mailto:srinivas.kandagatla@gmail.com>>
>     Cc: Maxime Coquelin <maxime.coquelin@st.com
>     <mailto:maxime.coquelin@st.com>>
>     Cc: Patrice Chotard <patrice.chotard@st.com
>     <mailto:patrice.chotard@st.com>>
>     Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org
>     <mailto:gregkh@linuxfoundation.org>>
>     Cc: Jiri Slaby <jslaby@suse.cz <mailto:jslaby@suse.cz>>
>     Cc: kernel@stlinux.com <mailto:kernel@stlinux.com>
>     Cc: linux-serial@vger.kernel.org <mailto:linux-serial@vger.kernel.org>
>     ---
> 
>     Notes:
>         Changes since v1:
> 
>         * Added fallback to writel() to permit COMPILE_TESTing (review
>           of Greg Kroah-Hartmam).
> 
>      drivers/tty/serial/st-asc.c | 6 +++++-
>      1 file changed, 5 insertions(+), 1 deletion(-)
> 
>     diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
>     index 8b2d735..a3fc167 100644
>     --- a/drivers/tty/serial/st-asc.c
>     +++ b/drivers/tty/serial/st-asc.c
>     @@ -151,12 +151,16 @@ static inline struct asc_port
>     *to_asc_port(struct uart_port *port)
> 
>      static inline u32 asc_in(struct uart_port *port, u32 offset)
>      {
>     -       return readl(port->membase + offset);
>     +       return readl_relaxed(port->membase + offset);
>      }
> 
>      static inline void asc_out(struct uart_port *port, u32 offset, u32
>     value)
>      {
>     +#ifdef writel_relaxed
>     +       writel_relaxed(value, port->membase + offset);
>     +#else
>             writel(value, port->membase + offset);
>     +#endif
>      }
> 
>      /*
>     --
>     1.9.3
> 
> 
