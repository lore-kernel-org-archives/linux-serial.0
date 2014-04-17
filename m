From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/8] tty/serial: add generic serial earlycon
Date: Thu, 17 Apr 2014 21:16:44 +0100
Message-ID: <20140417211644.39353c0d@www.etchedpixels.co.uk>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
	<9368307.RXEGmQia1C@wuerfel>
	<CAL_JsqJh1R8wxReCvTfE7GecZa0vMaAqnGa0ZoRBMace9qtzvQ@mail.gmail.com>
	<21117957.8m9iUdR1VN@wuerfel>
	<CAL_JsqJwKQ_KuWWQNZHrMh8NwwiubB2jR+g-Y2n_dH4kJ5zVow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:48551 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbaDQURw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Apr 2014 16:17:52 -0400
In-Reply-To: <CAL_JsqJwKQ_KuWWQNZHrMh8NwwiubB2jR+g-Y2n_dH4kJ5zVow@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "x86@kernel.org" <x86@kernel.org>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>

> At some point it was believed to be needed on the 8250 driver. Perhaps
> Alan can comment since the commit message tells us nothing:

Don't remember sorry - I guess at the time someone had ioremap on their
plaform acting as cached. It was a long time ago 8)
