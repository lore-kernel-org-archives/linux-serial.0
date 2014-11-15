From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] serial: mxs-auart: Fix mxs_auart_set_ldisc()
Date: Sat, 15 Nov 2014 13:51:39 -0200
Message-ID: <CAOMZO5Bso8CrDQKaN8F4hgGu==cuss72UX4sFtE3=HoNge04gg@mail.gmail.com>
References: <1415831569-6904-1-git-send-email-festevam@gmail.com>
	<546687DA.6010503@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:35401 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009AbaKOPvl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 15 Nov 2014 10:51:41 -0500
In-Reply-To: <546687DA.6010503@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?UTF-8?Q?Janusz_U=C5=BCycki?= <j.uzycki@elproma.com.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>

Hi Janusz,

On Fri, Nov 14, 2014 at 8:53 PM, Janusz U=C5=BCycki <j.uzycki@elproma.c=
om.pl> wrote:
> Hi,
>
> Procedure of the test:
> * PPS source connected to a DCD line of the driver (gpio)
> * ldattach PPS /dev/ttyAPPn
> * watch -n 1 cat /sys/class/pps/pps0/assert
> * watch -n 1 cat /sys/class/pps/pps0/clear
>
> I just tested and finally it works on my hardware and
> 3.18.0-rc4-next-20141114+.

In this case, can you provide your Tested-by tag in reply to my patch? =
Thanks
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
