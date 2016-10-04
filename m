From: Ley Foon Tan <lftan-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv2 4/4] nios2: dts: 10m50: Add tx-threshold parameter
Date: Tue, 4 Oct 2016 14:17:58 +0800
Message-ID: <CAFiDJ5_Cyw3jQSMyThRow8iY_dDPELR-e-EHRD3CTY0zaCvo_Q@mail.gmail.com>
References: <1474574177-4984-1-git-send-email-tthayer@opensource.altera.com> <1474574177-4984-5-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1474574177-4984-5-git-send-email-tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, jslaby-IBi9RG/b67k@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, anton.wuerfel-d40JDW7QUjc@public.gmane.org, phillip.raffeck-d40JDW7QUjc@public.gmane.org, yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, dongsheng.wang-3arQi8VN3Tc@public.gmane.org, luis-HiykPkW1eAzzDCI4PIEvbQC/G2K4zDHf@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, "nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org" <nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Sep 23, 2016 at 3:56 AM,  <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org> wrote:
> From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
>
> The tx-threshold parameter sets the TX FIFO low water threshold
> trigger for the Altera 16550-FIFO32 soft IP.
>
> Signed-off-by: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
> ---
> v2   Change from tx-loadsz to tx-threshold
> ---
>  arch/nios2/boot/dts/10m50_devboard.dts |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/nios2/boot/dts/10m50_devboard.dts b/arch/nios2/boot/dts/10m50_devboard.dts
> index 3e411c6..f362b22 100755
> --- a/arch/nios2/boot/dts/10m50_devboard.dts
> +++ b/arch/nios2/boot/dts/10m50_devboard.dts
> @@ -83,6 +83,7 @@
>                         fifo-size = <32>;
>                         reg-io-width = <4>;
>                         reg-shift = <2>;
> +                       tx-threshold = <16>;
>                 };
>
>                 sysid: sysid@18001528 {

Acked-by: Ley Foon Tan <lftan-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
