From: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: Re: problems with serial driver
Date: Tue, 3 Sep 2002 11:29:59 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <017b01c2535e$c3befc60$294b82ce@connecttech.com>
References: <Pine.LNX.4.44.0209031820330.24809-100000@scil.sinp.msu.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: slack@slackware.ru
Cc: alan@redhat.com, linux-serial@vger.kernel.org

From: <slack@slackware.ru>
> It is clear. Not so clear, why it produces garbage when read from port, as
> if it cannot sync with line.

It can't sync with the line. Serial transmission doesn't include a
specific syncing marker.

Yes, I know about the start bit. However, when a uart starts looking
at a line that already has data on it, how does it know which one is
the start bit? It takes the first thing that looks like a start bit,
which could be a bit in the middle of a character, and thus get
mis-synced. This is the way serial transmission works.

If you try replugging the cable while the sender and receiver are
running, you will notice that occasionally you'll get lucky and get a
correct sync, but often you'll get a mis-sync and receive garbage.

> for()
> usleep();
> read();
> }
> read OK.
>
> for() {
> // usleep()
> read();
> }
> Garbage.

This shouldn't make a difference, but I suspect that the usleep() is
luckily making the timing work out so that you get a correct sync
instead of a mis-sync.

However, if you've started the sender first, in the time it takes you
to start the receiver, the uart is dropping data. Even when you don't
get garbage you should notice that you're missing the first few bytes.

..Stu

--
We make multiport serial boards.
<http://www.connecttech.com>
(800) 426-8979


