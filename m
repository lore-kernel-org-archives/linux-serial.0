From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH 1/2] imx: Add save/restore functions for UART control
 regs
Date: Mon, 19 Dec 2011 07:49:56 +0100
Message-ID: <4EEEDE94.3080804@googlemail.com>
References: <1324229655-5538-1-git-send-email-dirk.behme@gmail.com> <20111219034902.GC4962@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37458 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab1LSGuT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Dec 2011 01:50:19 -0500
Received: by eekc4 with SMTP id c4so5144892eek.19
        for <linux-serial@vger.kernel.org>; Sun, 18 Dec 2011 22:50:18 -0800 (PST)
In-Reply-To: <20111219034902.GC4962@S2100-06.ap.freescale.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Dirk Behme <dirk.behme@gmail.com>, linux-serial@vger.kernel.org, =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Saleem Abdulrasool <compnerd@compnerd.org>

On 19.12.2011 04:49, Shawn Guo wrote:
> On Sun, Dec 18, 2011 at 06:34:14PM +0100, Dirk Behme wrote:
>> Factor out the uart save/restore functionality instead of
>> having the same code several times in the driver.
>>
>> Signed-off-by: Dirk Behme<dirk.behme@gmail.com>
>> CC: Saleem Abdulrasool<compnerd@compnerd.org>
>> CC: Sascha Hauer<s.hauer@pengutronix.de>
>> CC: Fabio Estevam<festevam@gmail.com>
>> CC: Uwe Kleine-K=F6nig<u.kleine-koenig@pengutronix.de>
>> CC: linux-serial@vger.kernel.org
>> ---
>>   drivers/tty/serial/imx.c |   38 +++++++++++++++++++++++++++++++---=
----
>>   1 files changed, 31 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 163fc90..6a01c2a 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -260,6 +260,31 @@ static inline int is_imx21_uart(struct imx_port=
 *sport)
>>   }
>>
>>   /*
>> + * Save and restore functions for UCR1, UCR2 and UCR3 registers
>> + */
>> +static void imx_console_mode(struct uart_port *port,
>
> Function name imx_console_mode seems not like a couple with
> imx_console_restore.  And I guess something like
> imx_port_ucrs_save[restore] would be better?
>
>> +			     unsigned int *ucr1,
>> +			     unsigned int *ucr2,
>> +			     unsigned int *ucr3)
>
> Can we define something like 'struct imx_port_ucrs' to contains these=
?

Yes, we could have different function names above and use a struct.

I implemented what Sascha asked for in

http://www.spinics.net/lists/arm-kernel/msg144960.html

though:

-- Sascha wrote: --
I'm thinking about:

imx_console_mode(struct uart_port *port, u32 *ucr1, u32 *ucr2, u32 *ucr=
2);
imx_console_restore(struct uart_port *port, u32 ucr1, u32 ucr2, u32 ucr=
3);
-- Sascha end --

It seems Shawn proposes

imx_port_ucrs_save(struct uart_port *port, struct *imx_port_ucrs);
imx_port_ucrs_restore(struct uart_port *port, struct *imx_port_ucrs);

(?)

Sascha, Shawn: Could you agree on what we should use?

Once you agreed, I will send an update of both two patches.

Many thanks and best regards

Dirk
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
