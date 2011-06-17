From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [Resend with Signed-off-by]: Add new FT232H chip to drivers/usb/serial/ftdi_sio.c
Date: Fri, 17 Jun 2011 21:15:24 +0400
Message-ID: <4DFB8BAC.5080901@ru.mvista.com>
References: <19963.29455.319574.581029@elektron.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48395 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755212Ab1FQRRJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Jun 2011 13:17:09 -0400
In-Reply-To: <19963.29455.319574.581029@elektron.ikp.physik.tu-darmstadt.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Cc: linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

Hello.

Uwe Bonnes wrote:

> Hello,

    Greetings shouldn't be a part of the patch description. Just omit them, for 
the future.

> appended patch adds support for the new FTDI FT232H chip. This chip is a
> single channel version of the dual FT2232H/quad FT4232H, coming with it's
> own default PID 0x6014 (FT2232H uses the same PID 0x6010 like FT2232C,
> FT4232H has also it's own PID). 

> The patch was checked on an UM232H module and a terminal program with TX/RX
> shorted to that typing in the terminal reproduced the characters. The patch
> was written against the running  2.6.37.6 kernel, but applies to git-head
> without errors.

    The last sentence should really be placed after the --- tear line.

> Please review and let me know(CC) of any problems.

> Signed-off-by: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>

> -- 
> Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

> Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
> --------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
> From 8a6a023dfc616a53bb1dd9b989d01276499ce6a4 Mon Sep 17 00:00:00 2001
> From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
> Date: Fri, 17 Jun 2011 15:59:07 +0200
> Subject: Add new FT232H chip

    The signature (if any) should be after the patch, not before. Now Greg will 
have to hand edit your patch to remove it.

> ---
>  drivers/usb/serial/ftdi_sio.c     |   19 ++++++++++++++-----
>  drivers/usb/serial/ftdi_sio.h     |    3 ++-
>  drivers/usb/serial/ftdi_sio_ids.h |    1 +
>  3 files changed, 17 insertions(+), 6 deletions(-)

> diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> index 1627289..2e06b90 100644
> --- a/drivers/usb/serial/ftdi_sio.c
> +++ b/drivers/usb/serial/ftdi_sio.c
[...]
> @@ -1559,7 +1565,8 @@ static int create_sysfs_attrs(struct usb_serial_port *port)
>  		     priv->chip_type == FT2232C ||
>  		     priv->chip_type == FT232RL ||
>  		     priv->chip_type == FT2232H ||
> -		     priv->chip_type == FT4232H)) {
> +		     priv->chip_type == FT4232H ||
> +		     priv->chip_type == FT232H)) {
>  			retval = device_create_file(&port->dev,
>  						    &dev_attr_latency_timer);
>  		}
> @@ -1580,7 +1587,8 @@ static void remove_sysfs_attrs(struct usb_serial_port *port)
>  		    priv->chip_type == FT2232C ||
>  		    priv->chip_type == FT232RL ||
>  		    priv->chip_type == FT2232H ||
> -		    priv->chip_type == FT4232H) {
> +		    priv->chip_type == FT4232H ||
> +                    priv->chip_type == FT232H) {

    Please use tabs for indenting, like above. scripts/checkpatch.pl should have 
warned you here...

WBR, Sergei

