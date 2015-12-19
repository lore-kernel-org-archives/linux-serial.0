From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v4 1/2] serial: rewrite pxa2xx-uart to use 8250_core
Date: Sun, 20 Dec 2015 00:12:27 +0100
Message-ID: <87poy2f2xw.fsf@belgarion.home>
References: <1387309071-22382-1-git-send-email-ynvich@gmail.com>
	<1449700088-28076-1-git-send-email-ynvich@gmail.com>
	<1449700088-28076-2-git-send-email-ynvich@gmail.com>
	<8737uyhaji.fsf@belgarion.home> <87y4cqfu2j.fsf@belgarion.home>
	<1450550792.15911.5.camel@gmail.com> <87twnefd67.fsf@belgarion.home>
	<1450555955.15911.14.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450555955.15911.14.camel@gmail.com> (Sergei Ianovich's message
	of "Sat, 19 Dec 2015 23:12:35 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Ianovich <ynvich@gmail.com>, Kevin Hilman <khilman@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Sergei Ianovich <ynvich@gmail.com> writes:

> On Sat, 2015-12-19 at 20:31 +0100, Robert Jarzmik wrote:
>> Sergei Ianovich <ynvich@gmail.com> writes:
>> Thanks for spotting this. This is caused by a change in the latest
>> > version of the patch (SERIAL_8250_PXA instead of SERIAL_PXA). This
>> > change could be reverted.
>> Actually I'm against the revert.
>> The name change looks very good to me, please keep it.
>
> Is it worth adding an error if CONFIG_SERIAL_PXA is defined?
I don't think so.

> Or is there any other way of preventing this patch launching Linus' "flag
> days" as Russel King named it?
I must think about it, and test a bit more.
Ah and a small hint : if you include back Russell in the conversation, don't
forget the double "ll" if you wish him to answer.

> I understand that people are afraid of taking this patch. If it starts
> causing troubles at runtime, it will be difficult to diagnose. There
> will be no console for most people. So it is probably good idea to fail
> at boot time.
Who are "the people" ? If it's about something already written in a mailing
list, please point me to it so that it can help me think about it.

>> > > But that can be handled in an subsequent patch to keep your acks
>> > > and
>> > > reviews.
>> > I will respin the patch. Please comment on the acks and reviews.
>> > They
>> > were made at an earlier version of the patch. That version no longer
>> > applies. Can the updated version carry on the flags?
>> I don't get you. If you mean keeping CONFIG_SERIAL_8250_PXA, then yes,
>> please
>> keep it.
>
> I mean should the patch be re-revied and re-acked?
Well it depends on what was since then. If it's a trivial commit message fix or
a typo, I don't think it's necessary. If it's the algorithm, the code logic, or
even I think you should ask again.

For a name change in CONFIG_SERIAL_PXA into CONFIG_SERIAL_8250_PXA (change from
v3 to v4), I must admit I don't know. Maybe Kevin or Arnd might give a clue.

Cheers.

-- 
Robert
