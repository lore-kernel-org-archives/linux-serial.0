From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 03/15] dmaengine: dw: rename masters to reflect actual
 topology
Date: Mon, 25 Jan 2016 10:35:02 +0200
Message-ID: <1453710902.2521.203.camel@linux.intel.com>
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
	 <1453663322-14474-4-git-send-email-mans@mansr.com>
	 <20160124223629.GI6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20160124223629.GI6588@sirena.org.uk>
Sender: linux-ide-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Mans Rullgard <mans@mansr.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, 2016-01-24 at 22:36 +0000, Mark Brown wrote:
> On Sun, Jan 24, 2016 at 07:21:50PM +0000, Mans Rullgard wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >=20
> > The source and destination masters are reflecting buses or their
> > layers to
> > where the different devices can be connected. The patch changes the
> > master
> > names to reflect which one is related to which independently on the
> > transfer
> > direction.
>=20
> This is patch 3 of a series but I don't have anything else in the
> series.=C2=A0=C2=A0What is going on with the rest of the series - wha=
t are the
> dependencies and so on?

Mark, sorry about that, but in this particular case you may consider
this patch is a standalone one. You are in the Cc list due to SPI
driver small change. This change isn't modifying functionality of the
driver.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

