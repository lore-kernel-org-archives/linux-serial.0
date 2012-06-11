From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH] serial/imx: enable the clock when we really use the uart
 port
Date: Mon, 11 Jun 2012 10:13:31 +0800
Message-ID: <4FD5544B.5090200@freescale.com>
References: <1335946770-17120-1-git-send-email-b32955@freescale.com>	<20120502081902.GT4141@pengutronix.de> <CAOMZO5DtC3yK7RgtbjefepQXk2jE+tODmivw+CC_hd5TCCe-oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:37642 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751977Ab2FKCIf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 10 Jun 2012 22:08:35 -0400
In-Reply-To: <CAOMZO5DtC3yK7RgtbjefepQXk2jE+tODmivw+CC_hd5TCCe-oA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, gregkh@linuxfoundation.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, alan@linux.intel.com

=E4=BA=8E 2012=E5=B9=B406=E6=9C=8811=E6=97=A5 01:31, Fabio Estevam =E5=86=
=99=E9=81=93:
> Huang,
>
> On Wed, May 2, 2012 at 5:19 AM, Sascha Hauer<s.hauer@pengutronix.de> =
 wrote:
>> On Wed, May 02, 2012 at 04:19:30PM +0800, Huang Shijie wrote:
>>> The current code keeps the clock enabled even when we do not really
>>> use the uart port. But keep the clock enabled will consume some pow=
er.
>>>
>>> In order to save more power, disable the clock when we do not use
>>> the uart, and enable the clock when we really use the uart port.
>>>
>>> Signed-off-by: Huang Shijie<b32955@freescale.com>
>> This conflicts with my series converting i.MX to the common clock
>> framework. Please lets delay this until this has been merged.
> I think it is OK to resubmit this patch now.
>
ok, thanks.

Huang Shijie

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
