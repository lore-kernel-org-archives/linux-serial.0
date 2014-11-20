From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [RFC PATCH] serial: mxs-auart: Take missing uart port locks
Date: Thu, 20 Nov 2014 10:17:08 +0100
Message-ID: <546DB194.40902@i2se.com>
References: <1416322001-28491-1-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:60836 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755905AbaKTJR3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Nov 2014 04:17:29 -0500
In-Reply-To: <1416322001-28491-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janusz Uzycki <j.uzycki@elproma.com.pl>, Fabio Estevam <festevam@gmail.com>, =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Hector Palacios <hector.palacios@digi.com>
Cc: fabio.estevam@freescale.com, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Craig McQueen <craig.mcqueen@beamcommunications.com>, linux-serial@vger.kernel.org, Viguera Javier <Javier.Viguera@digi.com>, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org

Hi Janusz,

Am 18.11.2014 um 15:46 schrieb Janusz Uzycki:
> The patch adds missing spin-locks and allows to change termios
> settings during tx.
> The patch also fixes direct call its enable_ms() according to
> commit d41510ce2f07
> ("serial: Take uart port lock for direct *_enable_ms()")

i think it's better to separate it in different patches.

Best regards
Stefan
