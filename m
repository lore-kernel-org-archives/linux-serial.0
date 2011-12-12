From: Claudio Scordino <claudio@evidence.eu.com>
Subject: Re: [PATCH RESEND 0/8] serial: 8250: support hw-based RS485 direction
 control
Date: Mon, 12 Dec 2011 15:42:43 +0100
Message-ID: <4EE612E3.1010801@evidence.eu.com>
References: <1323450440-414-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:32859 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752693Ab1LLOmt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Dec 2011 09:42:49 -0500
In-Reply-To: <1323450440-414-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>

Il 09/12/2011 18:07, Wolfram Sang ha scritto:
> Some 8250-variants control the direction pin for RS485 in hardware. Linux has
> RS485 support these days, so update the 8250-driver to adhere to that.
>
> Code is based on 3.2-rc4, tested on a OMAP-based custom board with a 16V2750.
> A git tree can be found here:
>
> 	git://git.pengutronix.de/git/wsa/linux-2.6.git 8250_rs485
>
> There is no code change since the initial post of this series. I updated some
> of the patch descriptions, though. A kind-of-ack from Claudio can be found here
> [1]. Please consider for inclusion.


Hi Wolfram,

	since the code has not been changed, my opinion remains that it is fine 
and it should enter mainline.

Best regards,

	Claudio
