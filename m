From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH linux-next v2 1/4] ARM: at91/dt: add a new DT property
 to support FIFOs on Atmel USARTs
Date: Mon, 29 Jun 2015 15:00:20 +0200
Message-ID: <55914164.1070800@atmel.com>
References: <cover.1434038494.git.cyrille.pitchen@atmel.com> <16bdcf0c3f710ca46df86eeea82c9840454cb7aa.1434038494.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <16bdcf0c3f710ca46df86eeea82c9840454cb7aa.1434038494.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, leilei.zhao-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, josh.wu-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Le 11/06/2015 18:20, Cyrille Pitchen a =E9crit :
> This patch adds a new DT property, "atmel,fifo-size", to enable and s=
et
> the maximum number of data the RX and TX FIFOs can store on FIFO capa=
ble
> USARTs.
>=20
> Please be aware that the VERSION register can not be used to guess th=
e
> size of FIFOs. Indeed, for a given hardware version, the USARTs can b=
e
> integrated on Atmel SoCs with different FIFO sizes. Also the
> "atmel,fifo-size" property is optional as older USARTs don't embed FI=
=46O at
> all.
>=20
> Besides, the FIFO size can not be read or guessed from other register=
s:
> When designing the FIFO feature, no dedicated registers were added to
> store this size. Unsed spaces in the I/O register range are limited a=
nd
> better reserved for future usages. Instead, the FIFO size of each
> peripheral is documented in the programmer datasheet.
>=20
> Finally, on a given SoC, there can be several instances of USART with
> different FIFO sizes. This explain why we'd rather use a dedicated DT
> property than use the "compatible" property.
>=20
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

> ---
>  Documentation/devicetree/bindings/serial/atmel-usart.txt | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt=
 b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> index 90787aa..e6e6142 100644
> --- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
> +++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> @@ -22,6 +22,8 @@ Optional properties:
>  		memory peripheral interface and USART DMA channel ID, FIFO configu=
ration.
>  		Refer to dma.txt and atmel-dma.txt for details.
>  	- dma-names: "rx" for RX channel, "tx" for TX channel.
> +- atmel,fifo-size: maximum number of data the RX and TX FIFOs can st=
ore for FIFO
> +  capable USARTs.
> =20
>  <chip> compatible description:
>  - at91rm9200:  legacy USART support
> @@ -57,4 +59,5 @@ Example:
>  		dmas =3D <&dma0 2 0x3>,
>  		       <&dma0 2 0x204>;
>  		dma-names =3D "tx", "rx";
> +		atmel,fifo-size =3D <32>;
>  	};
>=20


--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
