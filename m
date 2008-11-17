From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: serial8250_interrupt idea
Date: Mon, 17 Nov 2008 16:25:45 +0100
Message-ID: <D0393E26DEF64A21B3FA255589AC9A54@acksys.local>
References: <20081117134504.22912.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp03.msg.oleane.net ([62.161.4.3]:60578 "EHLO
	smtp03.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbYKQP1j (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Nov 2008 10:27:39 -0500
In-Reply-To: <20081117134504.22912.qmail@science.horizon.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'George Spelvin' <linux@horizon.com>
Cc: linux-serial@vger.kernel.org

Hi again,

I read your code more carefully and I believe that it does not
exhibit the problem I talked about. Sorry for argueing.

Please note however that these chips can be - and have been indeed -
used at much higher baudrates than the 115200 you mention. Once, I
have been using 1.8 Mbps on 2 ports, over RS422 links.

> I don't see how this means that "one of them gets served much
> more often than the others"; both get served equally often.
 
My wording was wrong, sorry. I rather meant "one of them gets served
before the others can get a chance to be served" so the first one, if
it is continually receiving, many delay service to the next ones, thus
loosing data.

Regards

> -----Original Message-----
> From: linux-serial-owner@vger.kernel.org
> [mailto:linux-serial-owner@vger.kernel.org]On Behalf Of George Spelvin
> Sent: Monday, November 17, 2008 2:45 PM
> To: jp.tosoni@acksys.fr
> Cc: linux@horizon.com; linux-serial@vger.kernel.org
> Subject: Re: serial8250_interrupt idea
> 
> 
> "Tosoni" <jp.tosoni@acksys.fr> wrote:
> 
> > I am talking about serial ports sharing the same interrupt.
> > Here are more details.
> >
> > Let's say that you have N ports sharing the same interrupt. 
> When the data
> > rate is very high, or the processor is slow, the following 
> may happen
> > depending on how you prioritize the ports:
> >
> > say that high-speed frames of 150 chars arrive on ports X and Y.
> >
> > 1/ enter ISR
> > 2/ test port X => process reception of a char, put it ahead of list
> > 3/ during processing of 2/ another char arrived on X ; goto 2
> > 4/ during processing of loop 2/ and 3/ many chars arrived 
> on port Y, some
> > were lost
> > 4/ process Y and other ports
> > 5/ All N ports are now quiet; exit ISR
> >
> > Now you have lost data on port Y because you prioritized X over Y.
> >
> > Got it ?
> 
> I see how some port has to be checked first, so if others share the
> same interrupt, they have to be checked second.  I don't see how this
> means that "one of them gets served much more often than the others";
> both get served equally often.
> 
> I also don't understand how the above can be a serious problem.
> Although slow relative to CPU speeds, the I/O port accesses 
> are extremely
> fast relative to serial data transmission rates.  Even at 
> 115,200 baud,
> characters arrive every 86.8 us.  Once the interrupt handler 
> is executing,
> bytes are removed from the serial FIFO at around 1 per us.  
> So not even
> a full character can arrive at port Y in the time it takes to 
> completely
> empty 64 bytes out of port X's FIFO.
> 
> In other words, your step 4/ cannot actually happen.  If one more
> character is enough to cause port Y to overflow, it's perilously close
> to overflowing without port X.
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
