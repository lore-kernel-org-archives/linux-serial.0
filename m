From: Claudio Scordino <claudio@evidence.eu.com>
Subject: Re: [PATCH] RS485 on Cris: use global value of TIOCSRS485
Date: Thu, 06 Jan 2011 17:58:16 +0100
Message-ID: <4D25F4A8.7050702@evidence.eu.com>
References: <4D257C87.4040400@evidence.eu.com> <20110106133455.2f6175c6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from borg.asidev.net ([95.141.38.199]:55006 "EHLO borg.asidev.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753661Ab1AFQ6a (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Jan 2011 11:58:30 -0500
In-Reply-To: <20110106133455.2f6175c6@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: starvik@axis.com, Jesper Nilsson <Jesper.Nilsson@axis.com>, linux-cris-kernel <linux-cris-kernel@axis.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Il 06/01/2011 14:34, Alan Cox ha scritto:
>> With this patch, TIOCSRS485 gets the same value across all
>> architectures, making maintenance and portability of user-level code
>> easier.
>
> I don't see why this is worth doing - no application code should ever
> hardcode the value.

I'm afraid this is true only in a theoretical world. But I hope I'm
wrong.

Actually, I can't see any reason to keep different values of TIOCSRS485
in the kernel code when we can have a single value across all
architectures.

But I trust your judgment: if you say it's not worth doing, let's
avoid it.

Many thanks,

	Claudio
