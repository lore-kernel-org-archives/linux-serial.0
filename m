From: slack@slackware.ru
Subject: Re: problems with serial driver
Date: Tue, 3 Sep 2002 19:34:42 +0400 (MSD)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0209031920570.25130-100000@scil.sinp.msu.ru>
References: <017b01c2535e$c3befc60$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <017b01c2535e$c3befc60$294b82ce@connecttech.com>
List-Id: linux-serial@vger.kernel.org
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: alan@redhat.com, linux-serial@vger.kernel.org


On Tue, 3 Sep 2002, Stuart MacDonald wrote:

> From: <slack@slackware.ru>
> > It is clear. Not so clear, why it produces garbage when read from port, as
> > if it cannot sync with line.
> It can't sync with the line. Serial transmission doesn't include a
> specific syncing marker.
I see. :)
> Yes, I know about the start bit. However, when a uart starts looking
> at a line that already has data on it, how does it know which one is
> the start bit?
yes, we cannot detect that.

> If you try replugging the cable while the sender and receiver are
> running, you will notice that occasionally you'll get lucky and get a
> correct sync, but often you'll get a mis-sync and receive garbage.
Everything is clear, not a problem. The problem is with overruns.
I have no idea on how to debug such events. And I cannot detect, what is
OK and what is not OK (maybe, problems with interrupt, or, port cannot
detect the start bit etc.), When I put some code between the read()s, it
brings delays, everything works, more, can sync without any problem with
start bit (mystic, I see, but... cannot debug). Also, cannot catch the
overrun.

> However, if you've started the sender first, in the time it takes you
> to start the receiver, the uart is dropping data. Even when you don't
> get garbage you should notice that you're missing the first few bytes.
it is not a problem, if only few. but I've got a stable garbage (frequency
is higher, than of normal data - the fact put me in a strange state;
statistics must say 50/50, but real life 90/10...) or stable normal data.

and, also, overruns. is it normal, when we like to read data from the port
with frequency, that is higher, than bus freq.? I think, no. is it
possible to eliminate such problems? it is hard to control such behaviour
of the system, it becomes unstable. ordinary user can put such calculator
in off state. :)

