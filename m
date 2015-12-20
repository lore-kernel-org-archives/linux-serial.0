From: Sergei Ianovich <ynvich@gmail.com>
Subject: Re: [PATCH v4 1/2] serial: rewrite pxa2xx-uart to use 8250_core
Date: Sun, 20 Dec 2015 14:24:25 +0300
Message-ID: <1450610665.15911.53.camel@gmail.com>
References: <1387309071-22382-1-git-send-email-ynvich@gmail.com>
	 <1449700088-28076-1-git-send-email-ynvich@gmail.com>
	 <1449700088-28076-2-git-send-email-ynvich@gmail.com>
	 <8737uyhaji.fsf@belgarion.home> <87y4cqfu2j.fsf@belgarion.home>
	 <1450550792.15911.5.camel@gmail.com> <87twnefd67.fsf@belgarion.home>
	 <1450555955.15911.14.camel@gmail.com> <87poy2f2xw.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87poy2f2xw.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>, Kevin Hilman <khilman@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, 2015-12-20 at 00:12 +0100, Robert Jarzmik wrote:
> Sergei Ianovich <ynvich@gmail.com> writes:
>=20
> > On Sat, 2015-12-19 at 20:31 +0100, Robert Jarzmik wrote:
> > > Sergei Ianovich <ynvich@gmail.com> writes:
> > > Thanks for spotting this. This is caused by a change in the lates=
t
> > > > version of the patch (SERIAL_8250_PXA instead of SERIAL_PXA).
> > > > This
> > > > change could be reverted.
> > > Actually I'm against the revert.
> > > The name change looks very good to me, please keep it.
> >=20
> > Is it worth adding an error if CONFIG_SERIAL_PXA is defined?
> I don't think so.

=2E..

>=20
> > I understand that people are afraid of taking this patch. If it
> > starts
> > causing troubles at runtime, it will be difficult to diagnose. Ther=
e
> > will be no console for most people. So it is probably good idea to
> > fail
> > at boot time.
> Who are "the people" ?=20

I think "the people" are at least Greg Kroah-Hartman and=C2=A0Russell K=
ing.

> If it's about something already written in a mailing
> list, please point me to it so that it can help me think about it.

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/216=
7
73.html

I can explain why I think so. Greg acked the patch, but hasn't merged i=
t
since then. He has good reasons for this most probably. Russell's
comment pointed by the link seems to be the reason.

I think the problem raised by Russell could be addressed. My best guess
is compile time error, despite your comment above.

I have one more plan. For transition period, we can introduce a
temporary Kconfig option SERIAL_8250_PXA_OFF, and fail at build time if
neither SERIAL_8250_PXA nor SERIAL_8250_PXA_OFF is set. This way all
interested parties will be notified of this driver update.
