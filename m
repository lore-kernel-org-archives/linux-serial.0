From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] serial: samsung: Move uart_register_driver call to
 device probe
Date: Tue, 21 Jan 2014 09:03:40 +0000
Message-ID: <20140121090340.6e067d2d@www.etchedpixels.co.uk>
References: <1390208555-27770-1-git-send-email-tushar.behera@linaro.org>
	<1390208555-27770-2-git-send-email-tushar.behera@linaro.org>
	<20140120100530.GY15937@n2100.arm.linux.org.uk>
	<CAHbNUh3m=uNybv=3yxmr2on=Cc0UuGrYP8zf3GMR-9RQZ394dg@mail.gmail.com>
	<20140120214305.54f65ffa@www.etchedpixels.co.uk>
	<20140120231457.GZ17314@sirena.org.uk>
	<20140120234734.11b78578@www.etchedpixels.co.uk>
	<20140121001657.GO15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20140121001657.GO15937@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Brown <broonie@kernel.org>, Tushar Behera <tushar.behera@linaro.org>, lkml <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, jslaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

On Tue, 21 Jan 2014 00:16:57 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

[I did post a reply to this while on my phone but it got rejected]

> On Mon, Jan 20, 2014 at 11:47:34PM +0000, Alan Cox wrote:
> > But yes I agree about the idiom, but a definite NAK to any attempts to
> > plaster over this grand screwup by crapping in the tty core. Your turd,
> > deal with it locally in the ARM code if you can't apply common sense and
> > just go dynamic.
> 
> I believe at the time there was no one maintaining the device list to
> _do_ that allocation - AMBA PL011 came along in 2005 after (I believe)
> hpa stopped looking after that list.

git log Documentation/devices.txt

> So, please tell me how a number could be allocated properly without the
> device numbers list being maintained?

It was being maintained

> I've no problem with going dynamic, and I suggest that you get a sense
> of perspective rather than just spouting rubbish from on high.

I suggest you take a harder look at the actual history rather than your
revisionist one and then apologise.

The "simple" way to sort this out is to go dynamic as first proposed. The
more complicated way *IFF* Ben can show an actual systems that break is
for the ARM folks to bury a "Use ancient static device mapping" KConfig
entry into the arch Kconfig - which can then go away after a while.

Alan
