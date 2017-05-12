From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/6] dt-bindings: serial: fsl-lpuart: add i.MX7ULP support
Date: Fri, 12 May 2017 15:12:16 -0500
Message-ID: <20170512201216.vaa2dbwjq7dmouku@rob-hp-laptop>
References: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
 <1494316248-24052-4-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1494316248-24052-4-git-send-email-aisheng.dong-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, fugang.duan-3arQi8VN3Tc@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, Mingkai.Hu-3arQi8VN3Tc@public.gmane.org, yangbo.lu-3arQi8VN3Tc@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, May 09, 2017 at 03:50:45PM +0800, Dong Aisheng wrote:
> The lpuart of imx7ulp is basically the same as ls1021a. It's also
> 32 bit width register, but unlike ls1021a, it's little endian.
> Besides that, imx7ulp lpuart has a minor different register layout
> from ls1021a.
> 
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
> Cc: Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>
> Cc: Fugang Duan <fugang.duan-3arQi8VN3Tc@public.gmane.org>
> Cc: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
> Cc: Mingkai Hu <Mingkai.Hu-3arQi8VN3Tc@public.gmane.org>
> Cc: Yangbo Lu <yangbo.lu-3arQi8VN3Tc@public.gmane.org>
> Signed-off-by: Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
