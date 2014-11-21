From: =?UTF-8?B?SmFudXN6IFXFvHlja2k=?= <j.uzycki@elproma.com.pl>
Subject: Re: [RFC PATCH] serial: mxs-auart: Take missing uart port locks
Date: Fri, 21 Nov 2014 12:32:43 +0100
Message-ID: <546F22DB.3060703@elproma.com.pl>
References: <1416322001-28491-1-git-send-email-j.uzycki@elproma.com.pl> <546DB194.40902@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from v032797.home.net.pl ([89.161.177.31]:61042 "HELO
	v032797.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751175AbaKULcc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Nov 2014 06:32:32 -0500
In-Reply-To: <546DB194.40902@i2se.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Fabio Estevam <festevam@gmail.com>, =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Hector Palacios <hector.palacios@digi.com>
Cc: fabio.estevam@freescale.com, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Craig McQueen <craig.mcqueen@beamcommunications.com>, linux-serial@vger.kernel.org, Viguera Javier <Javier.Viguera@digi.com>, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org


Hi Stefan,

W dniu 2014-11-20 o 10:17, Stefan Wahren pisze:
>
> Am 18.11.2014 um 15:46 schrieb Janusz Uzycki:
>> The patch adds missing spin-locks and allows to change termios
>> settings during tx.
>> The patch also fixes direct call its enable_ms() according to
>> commit d41510ce2f07
>> ("serial: Take uart port lock for direct *_enable_ms()")
> i think it's better to separate it in different patches.

OK, I separated them. I will send the patch again in near future but now I'm
waiting for more comments/tests.

thanks,
Janusz

