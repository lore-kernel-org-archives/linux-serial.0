From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>
Subject: Re: [PATCH v2] sc16is7xx: spi interface is added
Date: Thu, 14 May 2015 11:39:05 +0200
Message-ID: <20150514113905.638dd163@north>
References: <BLU436-SMTP5618D721DB5945207A778BE7D90@phx.gbl>
	<20150513142112.32fb6781@north>
	<SNT151-W2631587836D659058C19A7E7D80@phx.gbl>
	<20150514100316.75e23c2f@north>
	<SNT151-W14BC72C1F2CACF46C6BF1FE7D80@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <SNT151-W14BC72C1F2CACF46C6BF1FE7D80@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
To: ram kiran <indrakanti_ram@hotmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "indrakanti.ram@gmail.com" <indrakanti.ram@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu, 14 May 2015 14:45:47 +0530, ram kiran wrote:
> > I know little about kbuild but I'm worried that someone doing oldconfig
> > can still get SERIAL_SC16IS7XX selected while saying no to all the
> > others.
> >
> > Other option would be to swap the names between SERIAL_SC16IS7XX and
> > SERIAL_SC16IS7XX_SELECT, oldconfig would run smoother.  
> I think, with the above, there would need a configuration change for sure.
> It should be okay, as I2C is default Y.

Exactly, but with what you proposed we need a configuration change as
well, no?  SERIAL_SC16IS7XX_SELECT is new so users would have to know
that it's what SERIAL_SC16IS7XX used to be.

> Swap names would need Makefile changes, i was just thinking to avoid this.
> obj-$(CONFIG_SERIAL_SC16IS7XX) += sc16is7xx.o
> would be 
> obj-$(CONFIG_SERIAL_SC16IS7XX_SELECT) += sc16is7xx.o
> 
> I think its some that need not be there. Do suggest..

Perhaps *_SELECT is not the best name then but we could use something
like *_CORE or *_BASE.  Changes to the Makefile are not user-visible so
no worries.  It would be nice if people who run oldconfig by default got
the same behaviour as they did so far (i2c if SC16IS7XX was enabled in
previous config).  I think with names swapped and modification of
Makefile we would get exactly that.
