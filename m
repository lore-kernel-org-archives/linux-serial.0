From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v4 1/2] serial: rewrite pxa2xx-uart to use 8250_core
Date: Sat, 19 Dec 2015 20:31:28 +0100
Message-ID: <87twnefd67.fsf@belgarion.home>
References: <1387309071-22382-1-git-send-email-ynvich@gmail.com>
	<1449700088-28076-1-git-send-email-ynvich@gmail.com>
	<1449700088-28076-2-git-send-email-ynvich@gmail.com>
	<8737uyhaji.fsf@belgarion.home> <87y4cqfu2j.fsf@belgarion.home>
	<1450550792.15911.5.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450550792.15911.5.camel@gmail.com> (Sergei Ianovich's message
	of "Sat, 19 Dec 2015 21:46:32 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Ianovich <ynvich@gmail.com>
Cc: linux-kernel@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Sergei Ianovich <ynvich@gmail.com> writes:

> On Sat, 2015-12-19 at 14:26 +0100, Robert Jarzmik wrote:
>> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>> 
>> > Sergei Ianovich <ynvich@gmail.com> writes:
>> > 
>> > > pxa2xx-uart was a separate uart platform driver. It was declaring
>> > > the same device names and numbers as 8250 driver. As a result,
>> > > it was impossible to use 8250 driver on PXA SoCs.
>> > > 
>> > > Upon closer examination pxa2xx-uart turned out to be a clone of
>> > > 8250_core driver.
>> > > 
>> > > Workaround for Erratum #19 according to Marvel(R) PXA270M
>> > > Processor
>> > > Specification Update (April 19, 2010) is dropped. 8250_core reads
>> > > from FIFO immediately after checking DR bit in LSR.
>> > > 
>> > > Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
>> > > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> > > Reviewed-by: James Cameron <quozl@laptop.org>
>> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> 
>> Shrunk the list, the following is rather mach-pxa specific.
>> 
>> Actually there is a small glitch ...
>> Have a look at arch/arm/mach-pxa/viper.c, line 490:
>> 	#ifndef CONFIG_SERIAL_PXA
>> 	...
>
> Thanks for spotting this. This is caused by a change in the latest
> version of the patch (SERIAL_8250_PXA instead of SERIAL_PXA). This
> change could be reverted.
Actually I'm against the revert.
The name change looks very good to me, please keep it.

>> But that can be handled in an subsequent patch to keep your acks and
>> reviews.
> I will respin the patch. Please comment on the acks and reviews. They
> were made at an earlier version of the patch. That version no longer
> applies. Can the updated version carry on the flags?
I don't get you. If you mean keeping CONFIG_SERIAL_8250_PXA, then yes, please
keep it.

Cheers.
-- 
Robert
