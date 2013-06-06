From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v6] tty: serial: add Freescale lpuart driver support
Date: Thu, 6 Jun 2013 20:06:04 -0300
Message-ID: <CAOMZO5D+NLMc=10=iF6bd=3aav9ePZBQEJY7WKJpkp+fA=Cp1w@mail.gmail.com>
References: <1370309270-21019-1-git-send-email-b35083@freescale.com>
	<20130606200519.GA1644@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f49.google.com ([209.85.212.49]:32859 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab3FFXGG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Jun 2013 19:06:06 -0400
Received: by mail-vb0-f49.google.com with SMTP id q13so2322056vbe.36
        for <linux-serial@vger.kernel.org>; Thu, 06 Jun 2013 16:06:05 -0700 (PDT)
In-Reply-To: <20130606200519.GA1644@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jingchang Lu <b35083@freescale.com>, s.hauer@pengutronix.de, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

Hi Jingchang,

On Thu, Jun 6, 2013 at 5:05 PM, Greg KH <gregkh@linuxfoundation.org> wr=
ote:
> On Tue, Jun 04, 2013 at 09:27:50AM +0800, Jingchang Lu wrote:
>> Add Freescale lpuart driver support. The lpuart device
>> can be found on Vybrid VF610 and Layerscape LS-1 SoCs.
>>
>> Signed-off-by: Jingchang Lu <b35083@freescale.com>
>
> This breaks the build on x86 systems with:
>   CC [M]  drivers/tty/serial/fsl_lpuart.o
> drivers/tty/serial/fsl_lpuart.c: In function =E2=80=98lpuart_probe=E2=
=80=99:
> drivers/tty/serial/fsl_lpuart.c:751:2: error: implicit declaration of=
 function =E2=80=98of_alias_get_id=E2=80=99 [-Werror=3Dimplicit-functio=
n-declaration]
>
> so I can't take this :(

On imx serial driver this build error is avoided by protecting the
serial_imx_probe_dt() with "#ifdef CONFIG_OF" and you could so the
same on the fsl_lpaurt driver to avoid the build issue that Greg
reported.

Regards,

=46abio Estevam
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
