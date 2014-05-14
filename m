From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: Re: [PATCH] serial: imx: Disable new features of autobaud detection
Date: Wed, 14 May 2014 12:38:11 -0700
Message-ID: <5373C623.4030203@boundarydevices.com>
References: <1400093703-10128-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:62153 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbaENTiQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 May 2014 15:38:16 -0400
Received: by mail-pb0-f41.google.com with SMTP id uo5so20083pbc.28
        for <linux-serial@vger.kernel.org>; Wed, 14 May 2014 12:38:15 -0700 (PDT)
In-Reply-To: <1400093703-10128-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, gregkh@linuxfoundation.org
Cc: troy.kisky@boundarydevices.com, shawn.guo@freescale.com, kernel@pengutronix.de, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fabio Estevam <fabio.estevam@freescale.com>

On 05/14/2014 11:55 AM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Bit 7 of UCR3 is described in the i.MX reference manuals (with the exception
> of i.MX1) as follows:
>
> ADNIMP: Autobaud Detection Not Improved-. Disables new features of
> 	autobaud detection (See Baud Rate Automatic Detection
> 	Protocol, for more details).
>
> 	0 Autobaud detection new features selected
> 	1 Keep old autobaud detection mechanism
>
> The "new features" mechanism occasionally cause the receiver to get out of sync
> and continuously produce received characters of '\xff'.
>
> In order to reproduce the problem:
>
> $ stty -F /dev/ttymxc0 19200
>
> - Change the terminal baudrate to 19200
>
> - Type in the console and it should look good
>
> - Change the terminal baudrate back to 115200
>
> - Type 'b' in the console, then a stream of garbage characters is seen.
>
> Also rename the bit definition as per the reference manual.
>
> Tested on mx6q, mx6dl, mx6solo and mx53.
>
> Based on a patch from Eric Nelson for U-boot.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>   drivers/tty/serial/imx.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>

Tested-by: Eric Nelson <eric.nelson@boundarydevices.com>


