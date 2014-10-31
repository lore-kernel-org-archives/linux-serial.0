From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RESEND] tty: serial: 8250_mtk: Fix quot calculation
Date: Fri, 31 Oct 2014 17:48:14 +0100
Message-ID: <9001280.dDNTE2ykLV@wuerfel>
References: <1414773395-9916-1-git-send-email-matthias.brugger@bq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:52606 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbaJaQsv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 31 Oct 2014 12:48:51 -0400
In-Reply-To: <1414773395-9916-1-git-send-email-matthias.brugger@bq.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Matthias Brugger <matthias.bgg@gmail.com>, gregkh@linuxfoundation.org, heiko@sntech.de, yingjoe.chen@gmail.com, linux-kernel@vger.kernel.org, ibanezchen@gmail.com, linux-serial@vger.kernel.org, jslaby@suse.cz, alan@linux.intel.com

On Friday 31 October 2014 17:36:35 Matthias Brugger wrote:
> -               quot = DIV_ROUND_CLOSEST(port->uartclk, 256 * baud);
> +               quot = (port->uartclk / (256 * baud)) + 1;

Should this be DIV_ROUND_UP then?

	Arnd
