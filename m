From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] drivers/tty/serial: avoid double free after call ioc4_serial_remove_one
Date: Thu, 10 Jan 2013 16:03:38 +0800
Message-ID: <50EE75DA.6000505@asianux.com>
References: <50DACC2F.5080302@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:20200 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932645Ab3AJICs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 10 Jan 2013 03:02:48 -0500
In-Reply-To: <50DACC2F.5080302@asianux.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-serial@vger.kernel.org

Hello Alan Cox:

  can you have time to give a glance for it ?

  I send it according to the MAINTAINER file,
  if I send to an incorrect member, please tell me.

  thanks.

gchen

=D3=DA 2012=C4=EA12=D4=C226=C8=D5 18:06, Chen Gang =D0=B4=B5=C0:
>=20
>   before goto out5,  soft, control, serial are all assigned to idd
>   after finish call ioc4_serial_remove_one, all resources are release=
d
>   we need return instead of go on, or double free
>=20
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  drivers/tty/serial/ioc4_serial.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/tty/serial/ioc4_serial.c b/drivers/tty/serial/io=
c4_serial.c
> index 3e7da10..c4e30b8 100644
> --- a/drivers/tty/serial/ioc4_serial.c
> +++ b/drivers/tty/serial/ioc4_serial.c
> @@ -2883,6 +2883,7 @@ ioc4_serial_attach_one(struct ioc4_driver_data =
*idd)
>  	/* error exits that give back resources */
>  out5:
>  	ioc4_serial_remove_one(idd);
> +	return ret;
>  out4:
>  	kfree(soft);
>  out3:
>=20


--=20
Chen Gang

Asianux Corporation
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
