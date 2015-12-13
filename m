From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [PATCH 0/9] Fix checkpatch errors
Date: Sun, 13 Dec 2015 19:15:16 +0100
Message-ID: <87poyamczv.fsf@gmail.com>
References: <1449830170-15096-1-git-send-email-frederik.voelkel@fau.de>
	<20151213070622.GA13621@kroah.com>
	<20151213174429.GB11792@faumail.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151213174429.GB11792@faumail.uni-erlangen.de> (Frederik's
	message of "Sun, 13 Dec 2015 18:44:30 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Frederik <frederik.voelkel@fau.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, linux-kernel@i4.cs.fau.de, lukas.braun@fau.de
List-Id: linux-serial@vger.kernel.org

=46rederik <frederik.voelkel@fau.de> writes:

> On Sat, 12. Dec 23:06, Greg KH wrote:
>> On Fri, Dec 11, 2015 at 11:36:00AM +0100, Frederik V=C3=B6lkel wrote=
:
>> > This patch series fixes all checkpatch error in 68328serial.c exce=
pt
>> > 5 trailing whitespace errors we are unsure how to fix.
>>=20
>> What are the errors you are not sure how to fix?
>>=20
>> thanks,
>>=20
>> greg k-h
>
> All 5 errors are at comments. It is not clear to us where exactly the
> trailing whitespace is checkpatch complains(lines 271, 770, 889, 993
> and 1040).

W/o your series applied (so line numbering might be slightly
different), checkpatch.pl says:

  ERROR: trailing whitespace
  #270: FILE: -:270:
  +^I * This do { } while() loop will get ALL chars out of Rx FIFO $

AFAICS, your patch [7/9] ("drivers: tty: 68328serial.c: remove trailing
whitespaces") doesn't fix this one.

In good old regexp tradition, the '$' sign denotes the end of line. So,
there is a single space after "FIFO" and before the end of line.

If you happen to be Emacs users, consider trying out whitespace-mode.
If not, try to find another way to make your editor visualize whitespac=
e
somehow.
