From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCHv2 1/2] amba pl011: workaround for uart registers lockup
Date: Thu, 9 Jun 2011 21:46:26 +0200
Message-ID: <BANLkTik18mT-AYU=myEohquwgJ12hXZzcA@mail.gmail.com>
References: <20110516172958.GA13011@kroah.com>
	<1305609617-9524-1-git-send-email-shreshthakumar.sahu@stericsson.com>
	<20110517182356.GA17703@kroah.com>
	<20110517185133.GB9105@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110517185133.GB9105@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Shreshtha Kumar SAHU <shreshthakumar.sahu@stericsson.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, rmk+kernel@arm.linux.org.uk, linus.walleij@stericsson.com, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

On Tue, May 17, 2011 at 8:51 PM, Greg KH <greg@kroah.com> wrote:

> Do you still want me to take this patch through the serial tree, or will
> both be going through some ARM tree?

Hm these two patches appear to be stuck in limbo, missing the
merge window and all.

Which is sad, because they fix real issues to us.

How do we proceed?

Thanks,
Linus Walleij
