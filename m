From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] serial: samsung: Move uart_register_driver call to
 device probe
Date: Mon, 20 Jan 2014 21:43:05 +0000
Message-ID: <20140120214305.54f65ffa@www.etchedpixels.co.uk>
References: <1390208555-27770-1-git-send-email-tushar.behera@linaro.org>
	<1390208555-27770-2-git-send-email-tushar.behera@linaro.org>
	<20140120100530.GY15937@n2100.arm.linux.org.uk>
	<CAHbNUh3m=uNybv=3yxmr2on=Cc0UuGrYP8zf3GMR-9RQZ394dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAHbNUh3m=uNybv=3yxmr2on=Cc0UuGrYP8zf3GMR-9RQZ394dg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tushar Behera <tushar.behera@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, jslaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Mark Brown <broonie@kernel.org>
List-Id: linux-serial@vger.kernel.org

> I had earlier submitted a patch [1] to remove the hard coded
> major/minor number for Samsung UART driver, but that was rejected
> because of userspace breakage. Without this patch, Samsung UART driver
> can't bind to the hard-coded device node. Changing the default
> major/minor will also not help to fix the objections raised in [1].
> 
> Would you please suggest a way forward?
> 
> [1] https://lkml.org/lkml/2013/12/27/2

The dynamic major/minor is the right patch. If the userspace breaks then
the userspace was broken, but I see no evidence in the discussion that
the userspace broke.

204,64 belongs to Altix so neither of the clashing drivers should use it.
We had a table to stop messes like this, and we have dynamic numbering
to stop the table being needed for the future

           50 = /dev/ttyIOC0              Altix serial card
                    ...
           81 = /dev/ttyIOC31             Altix serial card


Thats what the list says. Samsung should have followed the rules, they
didn't so they get to pick up the pieces. The Amba driver wants moving as
well. It's easy. If you want something to be ABI then make sure you get
it upstream first, if not you get to own all the pain down the line.

Hacking up the core code to paper over this crap is not on. We've been
insisting firmly and robustly for years that people don't keep borrowing
names and numbers they are not allocated, and use dynamic values whenever
possible.

If the hardware isn't present then the driver shouldn't even register
with the tty layer in the first place so it doesn't make any resource
differeneces either for properly written code.

Alan
