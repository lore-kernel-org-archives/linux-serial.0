From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v1 3/4] max3100: adds console support for MAX3100
Date: Mon, 5 Apr 2010 13:00:38 -0600
Message-ID: <r2sfa686aa41004051200l73c7725ajd3f1bd503fa73447@mail.gmail.com>
References: <1269340105-6503-1-git-send-email-chripell@fsfe.org>
	<cabda6421003282311x78051e1eq38ada68f2553609e@mail.gmail.com>
	<20100329150642.4a94e78a@feng-i7> <cabda6421003290555k70d13168y4beba2c3ae6e2ece@mail.gmail.com>
	<20100330101445.5c64dedb@feng-i7> <cabda6421003292349m2dd6125cp2bcc1060f5aa8741@mail.gmail.com>
	<20100330094637.325d3fb9@lxorguk.ukuu.org.uk> <cabda6421003300503t4fc7d3c4tc51167611180fef9@mail.gmail.com>
	<v2mfa686aa41003302304rd966efe0k204d78aef793f75c@mail.gmail.com>
	<u2qcabda6421004051119xe4b0753by4450d74a934e00b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.211.172]:56465 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098Ab0DETA6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Apr 2010 15:00:58 -0400
Received: by ywh2 with SMTP id 2so2604653ywh.33
        for <linux-serial@vger.kernel.org>; Mon, 05 Apr 2010 12:00:58 -0700 (PDT)
In-Reply-To: <u2qcabda6421004051119xe4b0753by4450d74a934e00b2@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: christian pellegrin <chripell@fsfe.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Feng Tang <feng.tang@intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "greg@kroah.com" <greg@kroah.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Mon, Apr 5, 2010 at 12:19 PM, christian pellegrin <chripell@fsfe.org=
> wrote:
> Hi,
>
> first of all I'm sorry for the late response, just now I found time t=
o
> work on this.
>
> On Wed, Mar 31, 2010 at 8:04 AM, Grant Likely <grant.likely@secretlab=
=2Eca> wrote:
>
>> Is checking the T bit really necessary if Linux instead tracks the
>> timing between bytes internally? =A0ie. =A0If the driver uses an hrt=
imer
>> to schedule the submission of SPI transfers such that the time betwe=
en
>> SPI submissions is always greater than the time required for a seria=
l
>> character to be transmitted?
>
> I think you have to check it anyway. For example the SPI bus may be
> shared with another device so we don't know when our char will be sen=
t
> (it might be delayed for more than the duration of a char being sent
> on the serial line if the initial execution of the SPI command is
> delayed). But using a hrtimer will be for sure more fair than polling
> T bit as far as resource usage is concerned. I was always hesitant
> about using hrtimers: I really don't know if all platforms support
> them with the needed granularity (at 115200 a char takes around 100us=
)
> and the aren't many users of them in the drivers directory (quite all
> of them are in the staging one). But it's definitely a good idea if
> hrtimers do work. I'll make some tests.

Another thing to think about: this device is never going to be high
performance.  If tx gets delayed, then it isn't a big deal because
there won't be any data loss.  The real concern is RX where if you
don't process fast enough then characters get dropped.  Fortunately
you have an 8 byte deep buffer.  So if each timer fire schedules more
than one transfer (even if only one char is actually transmitted),
then it is okay if the timer granularity is 300-400us at 115200.

>
>>
>> You may be able to set this up into a free-running state machine.
>> Submit the SPI transfers asynchronously, and use a callback to be
>> notified when the transfer is completed. =A0In most cases, the trans=
fer
>> will be completed every time, but if it is not, then the state machi=
ne
>> can just wait another time period before submitting. =A0By doing it =
this
>> way, all the work can be handled at the atomic context without any
>> workqueues or threaded IRQ handlers.
>>
>
> yes a completely async design could improve performance (the greatest
> culprit for low performance (not mentioning slow SPI master drivers)
> is the latency in the delayed work being started). When I first wrote
> this driver I wanted to keep it simple so I was a bit frightened by a
> state-machine like design, but it can be done for sure. My concern
> here is: everything is the kernel is moving to doing as much as
> possible in a delayed work mechanics (see the introduction of threade=
d
> interrupts (which could became the default) or the "coming soon" deat=
h
> of IRQF_DISABLED). Is doing a big part of the work (of course I would
> use spi_async directly in the interrupt handler and handle the
> incoming/outgoing chars in spi_async callback which is usually called
> in an interrupt context) in an interrupt context "antihistorical",
> isn't it?

If you only use spi_async (which must be atomic), and you don't do any
heavy data processing or udelay()s in the irq path, then your driver
will not be adding major latency.  Use a ring buffer for both the tx
and rx paths so that the console processing can be done in a workqueue
or something and you should be just fine.

> BTW: both of the design changes you mentioned seem sensible to me for
> better performance of the driver. But they don't do any form of
> batching and won't help if the underlying SPI master driver uses some
> form of delayed work itself.

Then the SPI master driver is broken.  It must be fixed.  :-)
Submission of SPI transfers via spi_async() is supposed to always be
atomic.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
