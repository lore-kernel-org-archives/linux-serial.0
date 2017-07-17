From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/9] dt-bindings: serial: add compatible for stm32h7
Date: Mon, 17 Jul 2017 13:46:19 -0500
Message-ID: <20170717184619.ffvt4ebzyurke3h2@rob-hp-laptop>
References: <1499958494-19354-1-git-send-email-bich.hemon@st.com>
 <1499958494-19354-8-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1499958494-19354-8-git-send-email-bich.hemon-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bich HEMON <bich.hemon-qxv4g6HH51o@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre TORGUE <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Jul 13, 2017 at 03:08:29PM +0000, Bich HEMON wrote:
> From: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
> 
> Introduce new compatibles for "st,stm32h7-usart" and "st,stm32h7-uart".
> This new compatible allow to use optional wake-up interrupt.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: Bich Hemon <bich.hemon-qxv4g6HH51o@public.gmane.org>
> ---
>  .../devicetree/bindings/serial/st,stm32-usart.txt       | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
