From: Sergei Ianovich <ynvich@gmail.com>
Subject: Re: [PATCH v4 1/2] serial: rewrite pxa2xx-uart to use 8250_core
Date: Sat, 19 Dec 2015 23:12:35 +0300
Message-ID: <1450555955.15911.14.camel@gmail.com>
References: <1387309071-22382-1-git-send-email-ynvich@gmail.com>
	 <1449700088-28076-1-git-send-email-ynvich@gmail.com>
	 <1449700088-28076-2-git-send-email-ynvich@gmail.com>
	 <8737uyhaji.fsf@belgarion.home> <87y4cqfu2j.fsf@belgarion.home>
	 <1450550792.15911.5.camel@gmail.com> <87twnefd67.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87twnefd67.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-kernel@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sat, 2015-12-19 at 20:31 +0100, Robert Jarzmik wrote:
> Sergei Ianovich <ynvich@gmail.com> writes:
> Thanks for spotting this. This is caused by a change in the latest
> > version of the patch (SERIAL_8250_PXA instead of SERIAL_PXA). This
> > change could be reverted.
> Actually I'm against the revert.
> The name change looks very good to me, please keep it.

Is it worth adding an error if CONFIG_SERIAL_PXA is defined? Or is there
any other way of preventing this patch launching Linus' "flag days" as
Russel King named it?

I understand that people are afraid of taking this patch. If it starts
causing troubles at runtime, it will be difficult to diagnose. There
will be no console for most people. So it is probably good idea to fail
at boot time.

> > > But that can be handled in an subsequent patch to keep your acks
> > > and
> > > reviews.
> > I will respin the patch. Please comment on the acks and reviews.
> > They
> > were made at an earlier version of the patch. That version no longer
> > applies. Can the updated version carry on the flags?
> I don't get you. If you mean keeping CONFIG_SERIAL_8250_PXA, then yes,
> please
> keep it.

I mean should the patch be re-revied and re-acked?
