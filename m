From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: restart callback not supposed to sleep?
Date: Mon, 20 Aug 2012 10:44:55 +0100
Message-ID: <20120820094455.GS18957@n2100.arm.linux.org.uk>
References: <20120820082423.GJ2232@pengutronix.de> <20529.64510.403690.325993@ipc1.ka-ro> <20120820090546.GR18957@n2100.arm.linux.org.uk> <20120820092145.GM2232@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41113 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab2HTJpH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Aug 2012 05:45:07 -0400
Content-Disposition: inline
In-Reply-To: <20120820092145.GM2232@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Aug 20, 2012 at 11:21:45AM +0200, Uwe Kleine-K=F6nig wrote:
> Just for the log: The restart works ok.

Restart with a command or restart with sysrq ?
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
