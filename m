From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] serial: samsung: Move uart_register_driver call to
 device probe
Date: Mon, 20 Jan 2014 23:47:34 +0000
Message-ID: <20140120234734.11b78578@www.etchedpixels.co.uk>
References: <1390208555-27770-1-git-send-email-tushar.behera@linaro.org>
	<1390208555-27770-2-git-send-email-tushar.behera@linaro.org>
	<20140120100530.GY15937@n2100.arm.linux.org.uk>
	<CAHbNUh3m=uNybv=3yxmr2on=Cc0UuGrYP8zf3GMR-9RQZ394dg@mail.gmail.com>
	<20140120214305.54f65ffa@www.etchedpixels.co.uk>
	<20140120231457.GZ17314@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20140120231457.GZ17314@sirena.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tushar Behera <tushar.behera@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, jslaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: linux-serial@vger.kernel.org

On Mon, 20 Jan 2014 23:14:57 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Mon, Jan 20, 2014 at 09:43:05PM +0000, Alan Cox wrote:
> 
> > The dynamic major/minor is the right patch. If the userspace breaks then
> > the userspace was broken, but I see no evidence in the discussion that
> > the userspace broke.
> 
> The userspace breakage is that if someone has a static /dev that doesn't
> handle any dynamic devices then renumbering the device will cause that
> static /dev to stop matching the kernel.

Diddums and you've only provided theoretical cases not real world ones.

They should have followed proper practice and reserved their minors. The
device number belongs to the Altix. The driver should just move.

> > Thats what the list says. Samsung should have followed the rules, they
> > didn't so they get to pick up the pieces. The Amba driver wants moving as
> > well. It's easy. If you want something to be ABI then make sure you get
> > it upstream first, if not you get to own all the pain down the line.
> 
> This stuff is all upstream already, a quick check suggests both drivers
> predate git - it's been noticed because the ARM multiplatform work has
> caused people to try booting kernels with both built in.

So ARM people didn't follow the policy on allocating device minors even
within their own community and got burned by it. That's despite having
previously been burned by abusing the ttyS0 8250 major/minor in the same
way, for the same purposes, and creating the same mess.

{facepalm...}

> > If the hardware isn't present then the driver shouldn't even register
> > with the tty layer in the first place so it doesn't make any resource
> > differeneces either for properly written code.
> 
> Right, that's not the idiom that has been followed by any of serial
> drivers though so needs fixing too.

Actally some drivers do get this right but not many. ehv-bc for example
does.

But yes I agree about the idiom, but a definite NAK to any attempts to
plaster over this grand screwup by crapping in the tty core. Your turd,
deal with it locally in the ARM code if you can't apply common sense and
just go dynamic.

And please, after screwing this up twice - *learn* from the mess.

Alan
