From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 09/13] serial: imx: Let device core handle pinctrl
Date: Sun, 26 May 2013 14:46:30 -0300
Message-ID: <CAOMZO5B+Le92n-0m2wwspW6iA_qP6d7M_YSAzmtFOhaBtbQyrQ@mail.gmail.com>
References: <1367863561-11534-1-git-send-email-fabio.estevam@freescale.com>
	<1367863561-11534-9-git-send-email-fabio.estevam@freescale.com>
	<20130520185012.GB24761@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170]:65022 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633Ab3EZRqb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 26 May 2013 13:46:31 -0400
Received: by mail-ve0-f170.google.com with SMTP id 15so4670988vea.29
        for <linux-serial@vger.kernel.org>; Sun, 26 May 2013 10:46:30 -0700 (PDT)
In-Reply-To: <20130520185012.GB24761@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, shawn.guo@linaro.org, kernel@pengutronix.de, linux-serial@vger.kernel.org

Hi Greg,

On Mon, May 20, 2013 at 3:50 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, May 06, 2013 at 03:05:57PM -0300, Fabio Estevam wrote:
>> Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
>> we can rely on device core for handling pinctrl.
>>
>> So remove devm_pinctrl_get_select_default() from the driver.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: <linux-serial@vger.kernel.org>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>>  drivers/tty/serial/imx.c |    9 ---------
>>  1 file changed, 9 deletions(-)
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Could you please apply this one and 10/13 in your tree?

Regards,

Fabio Estevam
