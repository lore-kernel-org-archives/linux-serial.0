From: "George Spelvin" <linux@horizon.com>
Subject: Re: serial8250_interrupt idea
Date: Mon, 17 Nov 2008 05:56:21 -0500
Message-ID: <20081117105621.27946.qmail@science.horizon.com>
References: <B98538A31FB14FC2A64239FC940CA0C1@acksys.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:18178 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753096AbYKQK4W (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Nov 2008 05:56:22 -0500
In-Reply-To: <B98538A31FB14FC2A64239FC940CA0C1@acksys.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: jp.tosoni@acksys.fr
Cc: linux@horizon.com, linux-serial@vger.kernel.org

"Tosoni" <jp.tosoni@acksys.fr> wrote:
> When I put this kind of improvement in my serial drivers I usually run into
> the following problem:
>
> If several ports are very busy receiving at the same time, one of them gets
> served much more often than the others, and the others start losing data.
>
> Do your changes take this into account ?
>
> Sorry, I didn't take the time to go through your code (I'm working on un
> unrelated project right now).

I don't quite understand.

First of all, the patch only affects serial ports sharing the same
interrupt.  Are you talking about serial ports sharing the same interrupt,
or serial ports with different interrupts?

If you're talking about the latter, this patch will have no effect; it only
affects the way that multiple ports share the same interrupt.

And I don't understand how a problem like you describe can happen when
an interrupt is shared.  In that case, the hardware requires that all of
them are checked on every interrupt, and the driver has always done that.

Further, ports that have data waiting the first time they are checked
have to be re-checked until they are empty.  All the patch does is try
to reduce the number of times that idle ports are re-checked.

If there's a problem, though, perhaps I can figure it out while I'm
looking at this part of the code.  Can you describe it in greater detail?
