From: Sergei Ianovich <ynvich@gmail.com>
Subject: Re: [PATCH v5] serial: support for 16550A serial ports on LP-8x4x
Date: Sat, 19 Dec 2015 11:11:19 +0300
Message-ID: <1450512679.8428.12.camel@gmail.com>
References: <1397668667-27328-1-git-send-email-ynvich@gmail.com>
	 <1970812.j9fZPC5F1b@wuerfel> <1450253097.21989.78.camel@gmail.com>
	 <3230140.YE724HtqOd@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3230140.YE724HtqOd@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Scott Wood <scottwood@freescale.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Paul Burton <paul.burton@imgtec.com>, Joachim Eastwood <manabian@gmail.com>, Mans Rullgard <mans@mansr.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Hurley <peter@hurleysoftware.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>open list:
List-Id: linux-serial@vger.kernel.org

On Wed, 2015-12-16 at 11:26 +0100, Arnd Bergmann wrote:
> On Wednesday 16 December 2015 11:04:57 Sergei Ianovich wrote:
> > On Tue, 2015-12-15 at 22:51 +0100, Arnd Bergmann wrote:
> > > 'x' wildcards in the name of the board seem important. There are
> > devices
> > made by the same vendor without 8 or 4 in their name. Those devices
> > either are not shipped with linux or are base on a x86 platform.
> > 
> > Does this justify the choice of the compatible string?
> 
> What I meant was that you should use the specific numbers of one
> machine,
> precisely for the reason you list above.
> 
> If there is e.g. a LP-8040 and a LP-8141 today, and you use lp8x4x in
> the compatible string to cover both, this will no longer work when the
> vendor comes out with a LP8047 that is completely different.
> 
> Instead, what you should do is to use the compatible string to
> identify
> one particular board (e.g. the first one that used this setup), and
> then list the other ones as compatible with this. You can also add the
> other board names in addition, e.g.
> 
> compatible = "icpdas,uart-lp8041", "icpdas,uart-lp8040";
> 
> for a lp8041 that is compatible with the lp8040. If it turns out later
> that they are not entirely compatible, we can work around this in the
> driver by checking for the lp8041 string that will be matched first,
> while
> the lp8040 can be used by the driver to match the entire family of
> compatible machines (no need to list every one in the driver).

I'll try to be more specific. This driver will support ports on LP-8081, 
LP-8141, LP-8441, LP-8841. Last time I checked the vendor was announcing
a series with 3 as the last digit. They use lp8x4x name, eg. in
documentation like `LP-8x4x_ChangeLog.txt`. They ship their proprietary
SDK in `lp8x4x_sdk_for_linux.tar`. All of this implies that it is a
single board.
