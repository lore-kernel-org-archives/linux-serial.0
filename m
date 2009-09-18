From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH v5][bfin-sport-uart] fit blackfin uart over sport driver
	into common uart inftrastructure
Date: Fri, 18 Sep 2009 11:17:59 -0400
Message-ID: <8bd0f97a0909180817o3c0a80f9u3bf1f2cd95ef2192@mail.gmail.com>
References: <1253265502.22138.10.camel@eight.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vw0-f195.google.com ([209.85.212.195]:55186 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbZIRPSP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Sep 2009 11:18:15 -0400
In-Reply-To: <1253265502.22138.10.camel@eight.analog.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: sonic zhang <sonic.adi@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Serial <linux-serial@vger.kernel.org>

On Fri, Sep 18, 2009 at 05:18, sonic zhang wrote:
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -1451,6 +1451,30 @@ config SPORT_BAUD_RATE
> =C2=A0 =C2=A0 =C2=A0 =C2=A0default 19200 if (SERIAL_SPORT_BAUD_RATE_1=
9200)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0default 9600 if (SERIAL_SPORT_BAUD_RATE_96=
00)

are you sure this patch is coomplete ?  these Kconfig options should
be here anymore

> +config SERIAL_BFIN_SPORT0_UART
> + =C2=A0 =C2=A0 =C2=A0 bool "Enable UART over SPORT0"
> + =C2=A0 =C2=A0 =C2=A0 depends on SERIAL_BFIN_SPORT

BF542/BF544 dont have a SPORT0.  another good reason for pushing to
board resources.
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
