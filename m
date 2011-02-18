From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/5 v2] tty: serial: altera_jtaguart: Add device tree support
Date: Fri, 18 Feb 2011 00:59:24 -0700
Message-ID: <AANLkTikEPW2+0+NXhXRayX3_Ndd_dSaoNjJ7uuHfuT1O@mail.gmail.com>
References: <c28550ba11ed228f4137ced1ab34761c08ad38ad.1297974227.git.tklauser@distanz.ch>
 <1298015675-18719-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46485 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519Ab1BRH7o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Feb 2011 02:59:44 -0500
Received: by iyj8 with SMTP id 8so3238886iyj.19
        for <linux-serial@vger.kernel.org>; Thu, 17 Feb 2011 23:59:44 -0800 (PST)
In-Reply-To: <1298015675-18719-1-git-send-email-tklauser@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, nios2-dev@sopc.et.ntust.edu.tw

On Fri, Feb 18, 2011 at 12:54 AM, Tobias Klauser <tklauser@distanz.ch> =
wrote:
> Advertise the possibility to use this driver with device tree if
> CONFIG_OF is set.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
> =A0.../devicetree/bindings/altera_jtaguart.txt =A0 =A0 =A0 =A0| =A0 =A0=
4 ++++
> =A0drivers/tty/serial/altera_jtaguart.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 15 +++++++++++++--
> =A02 files changed, 17 insertions(+), 2 deletions(-)
> =A0create mode 100644 Documentation/devicetree/bindings/altera_jtagua=
rt.txt
>
> diff --git a/Documentation/devicetree/bindings/altera_jtaguart.txt b/=
Documentation/devicetree/bindings/altera_jtaguart.txt
> new file mode 100644
> index 0000000..c152f65
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/altera_jtaguart.txt

This should be in
Documentation/devicetree/bindings/serial/altera_jtaguart.txt, but
otherwise:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> @@ -0,0 +1,4 @@
> +Altera JTAG UART
> +
> +Required properties:
> +- compatible : should be "ALTR,juart-1.0"
> diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/seria=
l/altera_jtaguart.c
> index 8f014bb..60e049b 100644
> --- a/drivers/tty/serial/altera_jtaguart.c
> +++ b/drivers/tty/serial/altera_jtaguart.c
> @@ -466,12 +466,23 @@ static int __devexit altera_jtaguart_remove(str=
uct platform_device *pdev)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +#ifdef CONFIG_OF
> +static struct of_device_id altera_jtaguart_match[] =3D {
> + =A0 =A0 =A0 { .compatible =3D "ALTR,juart-1.0", },
> + =A0 =A0 =A0 {},
> +};
> +MODULE_DEVICE_TABLE(of, altera_jtaguart_match);
> +#else
> +#define altera_jtaguart_match NULL
> +#endif /* CONFIG_OF */
> +
> =A0static struct platform_driver altera_jtaguart_platform_driver =3D =
{
> =A0 =A0 =A0 =A0.probe =A0=3D altera_jtaguart_probe,
> =A0 =A0 =A0 =A0.remove =3D __devexit_p(altera_jtaguart_remove),
> =A0 =A0 =A0 =A0.driver =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D DRV_NAME,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D DRV_NAME,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODU=
LE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D altera_jtaguart_mat=
ch,
> =A0 =A0 =A0 =A0},
> =A0};
>
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
