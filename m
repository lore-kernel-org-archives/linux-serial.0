From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v2] TTY: serial, add pm function
Date: Thu, 17 Jan 2013 13:16:14 +0000
Message-ID: <20130117131614.30b9089e@bob.linux.org.uk>
References: <1355316051-2425-1-git-send-email-rickard.andersson@stericsson.com>
	<20130116070521.GB2527@kroah.com>
	<50F65C5E.9090804@stericsson.com>
	<20130116075813.GA30819@kroah.com>
	<50F665C5.9020603@stericsson.com>
	<20130116152440.GA1101@kroah.com>
	<CACRpkdax3znJg_8W-B=1mHTiZwtbiqx1B6hMrxVk4UXEK2NpGw@mail.gmail.com>
	<20130117023214.GB20928@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:2622 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752388Ab3AQM4L (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Jan 2013 07:56:11 -0500
In-Reply-To: <20130117023214.GB20928@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rickard Andersson <rickard.andersson@stericsson.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linus WALLEIJ <linus.walleij@stericsson.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>

> Also, why does this driver need something that the hundreds of other
> serial drivers we have in-kernel today do not?  What makes it special
> over everything else?

We certainly will need power management hooks on the tty layer -
probably they belong on the tty_port operations.

Several things have happened that make it more relevant

- power levels have come down to the point that serial ports are no
  longer off the radar

- quite a few embedded and tablet devices have internal serial busses
  where turning off ports and stuff behind them matters.


Alan
