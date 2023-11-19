Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD700C072A2
	for <linux-serial@archiver.kernel.org>; Sun, 19 Nov 2023 12:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjKSMs3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 19 Nov 2023 07:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSMs2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 19 Nov 2023 07:48:28 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EA6C2
        for <linux-serial@vger.kernel.org>; Sun, 19 Nov 2023 04:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700398100; x=1701002900; i=linosanfilippo@gmx.de;
        bh=ZDfW/mNTlNvdhGTgeNvfP3cOF3yjUSW5L66gUZ9Oqq8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CPA7nK/nVzx0erAlhRJ8Wk3Ie+mRZfxyCfAuuCi1+SlIy2I6+VZJDRa1SM5Y+r96
         FX84WHivVdE+avAspEOo+KNctBxRGFsw3Z1BYZXFpeb41jJQeBI8D9T830M+7A6vp
         e6jg56mSusgD8+xSvsNVdnUQj9I6/jqnzmW+osIEVEKhs7vv/14F9Wauw+VlBsTnW
         bToGUAAFfFSVXCVGo608RrJ9ypgziHUy3CEmJkAwPdVASA7ln8pdqPnEWtns6FEeI
         Ui18KfEHwigqjV0ODMTFrwjuYgTRwyXq2py32YibGGaZm2wD/tqUkDaeouBxWsVYH
         wV34J5cd4kcmIjjBEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.37] ([84.162.21.41]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6DWi-1qy7e02xc8-006bbH; Sun, 19
 Nov 2023 13:48:20 +0100
Subject: Re: [PATCH] serial: core: Add option to enable RS485 mode via GPIO
To:     Tomas Paukrt <tomaspaukrt@email.cz>, linux-serial@vger.kernel.org
References: <VY.ZZnz.2Km1cHBSh2}.1bLIJa@seznam.cz>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <476876ca-806f-a5ad-1eeb-435c8a3111a2@gmx.de>
Date:   Sun, 19 Nov 2023 13:48:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <VY.ZZnz.2Km1cHBSh2}.1bLIJa@seznam.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dvoN6k/mVd17d37tLXa1MCh34+iQK5yccgQAVa1faS0pY8bAZKH
 5BfH/1udSwUADN7yhsktZEmHFHz8SBMDHC99hf4KahArbiha1isydZIhVQMCx56eMFVVoLq
 if7Bi6IuSwpsfU0/sqtMEG6Kjavz873o71Fk4IoAyjSn/5ee69vCXf2tMguJ70W9je/qfQH
 ecLPB0w5FHsLAWdlcr2YA==
UI-OutboundReport: notjunk:1;M01:P0:FNKAGxv7FPk=;o9c9GPtPqGOF1i6F9GJAILwaBHy
 FsFk9WEN4uNTiM8m7P5yLw/8ZRU+a2NvnrCSSnvnWbje0FoFALYnqHn6vbkt1NF06/VbD/tf5
 DtRRv92L5oGhoPfh25nTwjWofFBJHSkkTsS+HaePP6nxuGYW1e22tItIdBvL8dfZvTS9Au+RK
 YTvN86I0nn/1B1vZPjAtpvaiYbgxhJEDBHwRWC1oX9RFyEqRUZ1qxLBvaqv0FPTkwCjsuuefd
 tOMEJspkni36JB7nQ9nryG4gP2GrEIwHENRqGSMWU0Fai1mAycGDvTMFDEglfEpE4IPnej3Gr
 4GL2DLjvvkuHV+S7PmVg2W1zIzatb1WJM6g/Ue2p2TQ03MX5+lJN6rCSoXCAt/I//h0dYn2KT
 Wp+K1uEo6LiVTVi02AYRaCwAUnn53nex05OQJMaa91xa9/1GnKBNyGFGbOv4EUQuBxYnAGV7u
 /dfeDqu2ZZxQkHdqVxKWycmW+93Wy4W0YgbDu8yAnfucuTHTW+4L3aKOTVZTfsr2PFfhFiwVE
 WkrM7240ZNhgeV+AE3JdJDGAjp3il9XSzlH6+atHqlMuJMQ7V/R+WvwtOVN97938SQzGZlGfE
 SW5lQ1J3m+poAmzbg/WJcFcBXAIcLbBkfNh2A8NVdhvcnSMNkcYLtyvHMphjIW1FkdZYMia01
 zLo0HzRTYMXj3bzRrYdjn3fgzaYe51tY22VF3cdZ1RJC6MXkYwXOYyQZKhqKfWn7WE2MFuaky
 JFaEhphfzskC+IS3IZUX6HhDjm1M0TlyvP9nsrbdGs82bLDiAkS8pstNxILwCtLiF+Iww5XU+
 kFbEeNlcDjPiulLCVnAYIU2v68p4D6lUOkxD8M8wFqpmTKZNzy8gm+8j4FrVgdZaTK2uDXgEc
 Uxxzx4ngRZvRpMCwlu8hNflagH7D8I4+9zZKQu6U7RtYCHNPLRSmua9e/rb1Y8oh2gAuNHnGc
 cpztSA==
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On 15.11.23 at 21:07, Tomas Paukrt wrote:
> This patch provides an option to enable the RS485 mode at boot time
> based on the state of a GPIO pin (DIP switch or configuration jumper).
> The GPIO is defined by the device tree property "rs485-mode-gpio".

This needs documentation in rs485.yaml.

>
> Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
> ---
>  drivers/tty/serial/serial_core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seria=
l_core.c
> index f1348a5..444d7fd 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3603,6 +3603,18 @@ int uart_get_rs485_mode(struct uart_port *port)
>  	}
>
>  	/*
> +	 * Enable the RS485 mode based on the state of a GPIO pin.
> +	 */
> +	desc =3D devm_gpiod_get_optional(dev, "rs485-mode", GPIOD_IN);
> +	if (IS_ERR(desc))
> +		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-mode-gpio\=
n");
> +	if (desc) {
> +		if (gpiod_get_value(desc))
> +			rs485conf->flags |=3D SER_RS485_ENABLED;
> +		devm_gpiod_put(dev, desc);
> +	}

So this means RS485 cannot be disabled any more after that. Then we must n=
ot allow
to unset SER_RS485_ENABLED if userspace tries to do so via TIOCSRS485.

Regards,
Lino

