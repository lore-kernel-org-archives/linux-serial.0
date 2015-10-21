From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: console vs earlycon ?
Date: Thu, 22 Oct 2015 00:54:28 +0200
Message-ID: <4134303.BAT7dSJRN3@wuerfel>
References: <CAK7LNARem16fTim8Ds_y8ezMusz_aRtv6c59KoxyC0rLV-RBWw@mail.gmail.com> <3890353.0icCv0Zeuq@wuerfel> <5627E679.1050207@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5627E679.1050207@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Peter Hurley <peter@hurleysoftware.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stefan Agner <stefan@agner.ch>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wednesday 21 October 2015 15:24:41 Peter Hurley wrote:
> On 10/21/2015 03:00 PM, Arnd Bergmann wrote:

> > Yes, I see this as a tradeoff: we want the console to be as early as
> > possible in order to report boot-time errors to the user, but not so early
> > to require hacks that can cause problems themselves. earlycon has to
> > do some scary stuff and is relatively recent, while the hacks
> > necessary for console_init() are much older and better tested.
> 
> I assume you mean the hacks necessary to get _earlycon_ working at
> console_init() time, because the hacks necessary to get non-8250
> serial consoles working at console_init() would be extensive and
> brand new.
> 

No, I was just being slow and assumed that the 51 drivers that come with
a console_initcall() do something in there to actually start the console,
but you are right that most of them don't actually do that. They just
call register_console() and wait for the device to show up later.

	Arnd
