From: David Lawyer <dave@lafn.org>
Subject: Re: problems with serial driver
Date: Tue, 3 Sep 2002 12:17:35 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20020903121734.B337@lafn.org>
References: <Pine.LNX.4.44.0209031820330.24809-100000@scil.sinp.msu.ru> <017b01c2535e$c3befc60$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from davespc (mail@66-81-21-7-modem.o1.com [66.81.21.7])
	by zoon.lafn.org (8.11.3/8.11.3) with ESMTP id g83JGr185436
	for <linux-serial@vger.kernel.org>; Tue, 3 Sep 2002 12:16:54 -0700 (PDT)
	(envelope-from dave@lafn.org)
Received: from dave by davespc with local (Exim 3.35 #1 (Debian))
	id 17mJB9-00007D-00
	for <linux-serial@vger.kernel.org>; Tue, 03 Sep 2002 12:17:35 -0700
Content-Disposition: inline
In-Reply-To: <017b01c2535e$c3befc60$294b82ce@connecttech.com>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On Tue, Sep 03, 2002 at 11:29:59AM -0400, Stuart MacDonald wrote:
> From: <slack@slackware.ru>
> > It is clear. Not so clear, why it produces garbage when read from port, as
> > if it cannot sync with line.
> 
> It can't sync with the line. Serial transmission doesn't include a
> specific syncing marker.
> 
> Yes, I know about the start bit. However, when a uart starts looking
> at a line that already has data on it, how does it know which one is
> the start bit? It takes the first thing that looks like a start bit,
> which could be a bit in the middle of a character, and thus get
> mis-synced. This is the way serial transmission works.
> 
> If you try replugging the cable while the sender and receiver are
> running, you will notice that occasionally you'll get lucky and get a
> correct sync, but often you'll get a mis-sync and receive garbage.
> 
> > for()
> > usleep();
> > read();
> > }
> > read OK.
> >
> > for() {
> > // usleep()
> > read();
> > }
> > Garbage.
> 
> This shouldn't make a difference, but I suspect that the usleep() is
> luckily making the timing work out so that you get a correct sync
> instead of a mis-sync.

Could it be that usleep() somehow triggers a flow control stop?  Then
when transmission resumes, it will start on a byte boundary and all will
be in sync.  One way for flow control to happen is for the serial buffer
in main memory to fill since it's not being read.  But then there would
still be a lot of garbage bytes stored in the buffer, followed by valid
bytes when the flow resumes.  So could these garbage bytes be flushed or
could usleep() somehow immediately cause a flow control stop without the
buffer filling?

I notice that the man page says usleep() is obsolete.

			David Lawyer

> 
> However, if you've started the sender first, in the time it takes you
> to start the receiver, the uart is dropping data. Even when you don't
> get garbage you should notice that you're missing the first few bytes.
