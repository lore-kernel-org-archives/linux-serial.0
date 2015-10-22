From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH/trivial] serial: pl011: Spelling s/clocks-names/clock-names/
Date: Thu, 22 Oct 2015 10:10:23 -0500
Message-ID: <CAL_JsqJgJZLyXrx-PgKhEzK5yKDiuLx_5M0q4c6Bn6g_Y9H0+Q@mail.gmail.com>
References: <1445005386-17962-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445005386-17962-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jiri Kosina <trivial@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 16, 2015 at 9:23 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/serial/pl011.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Rob

>
> diff --git a/Documentation/devicetree/bindings/serial/pl011.txt b/Documentation/devicetree/bindings/serial/pl011.txt
> index cbae3d9a02780768..77863aefe9ef1eaf 100644
> --- a/Documentation/devicetree/bindings/serial/pl011.txt
> +++ b/Documentation/devicetree/bindings/serial/pl011.txt
> @@ -19,7 +19,7 @@ Optional properties:
>            must correspond to the PCLK clocking the internal logic
>            of the block. Just listing one clock (the first one) is
>            deprecated.
> -- clocks-names:
> +- clock-names:
>            When present, the first clock listed must be named
>            "uartclk" and the second clock listed must be named
>            "apb_pclk"
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
