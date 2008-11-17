From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: serial8250_interrupt idea
Date: Mon, 17 Nov 2008 13:45:03 +0100
Message-ID: <16F7A0434C94480694C28863602B42A0@acksys.local>
References: <20081117105621.27946.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp05.msg.oleane.net ([62.161.4.5]:51499 "EHLO
	smtp05.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbYKQMqz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Nov 2008 07:46:55 -0500
In-Reply-To: <20081117105621.27946.qmail@science.horizon.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'George Spelvin' <linux@horizon.com>
Cc: linux-serial@vger.kernel.org

I am talking about serial ports sharing the same interrupt.
Here are more details.

Let's say that you have N ports sharing the same interrupt. When the data
rate is very high, or the processor is slow, the following may happen
depending on how you prioritize the ports:

say that high-speed frames of 150 chars arrive on ports X and Y.

1/ enter ISR
2/ test port X => process reception of a char, put it ahead of list
3/ during processing of 2/ another char arrived on X ; goto 2
4/ during processing of loop 2/ and 3/ many chars arrived on port Y, some
were lost
4/ process Y and other ports
5/ All N ports are now quiet; exit ISR

Now you have lost data on port Y because you prioritized X over Y.

Got it ?




> -----Original Message-----
> From: linux-serial-owner@vger.kernel.org
> [mailto:linux-serial-owner@vger.kernel.org]On Behalf Of George Spelvin
> Sent: Monday, November 17, 2008 11:56 AM
> To: jp.tosoni@acksys.fr
> Cc: linux@horizon.com; linux-serial@vger.kernel.org
> Subject: Re: serial8250_interrupt idea
>
>
> "Tosoni" <jp.tosoni@acksys.fr> wrote:
> > When I put this kind of improvement in my serial drivers I
> usually run into
> > the following problem:
> >
> > If several ports are very busy receiving at the same time,
> one of them gets
> > served much more often than the others, and the others
> start losing data.
> >
> > Do your changes take this into account ?
> >
> > Sorry, I didn't take the time to go through your code (I'm
> working on un
> > unrelated project right now).
>
> I don't quite understand.
>
> First of all, the patch only affects serial ports sharing the same
> interrupt.  Are you talking about serial ports sharing the
> same interrupt,
> or serial ports with different interrupts?
>
> If you're talking about the latter, this patch will have no
> effect; it only
> affects the way that multiple ports share the same interrupt.
>
> And I don't understand how a problem like you describe can happen when
> an interrupt is shared.  In that case, the hardware requires
> that all of
> them are checked on every interrupt, and the driver has
> always done that.
>
> Further, ports that have data waiting the first time they are checked
> have to be re-checked until they are empty.  All the patch does is try
> to reduce the number of times that idle ports are re-checked.
>
> If there's a problem, though, perhaps I can figure it out while I'm
> looking at this part of the code.  Can you describe it in
> greater detail?
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

