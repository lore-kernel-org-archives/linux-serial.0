From: Frederik <frederik.voelkel@fau.de>
Subject: Re: [PATCH 0/9] Fix checkpatch errors
Date: Sun, 13 Dec 2015 19:26:04 +0100
Message-ID: <20151213182604.GC11792@faumail.uni-erlangen.de>
References: <1449830170-15096-1-git-send-email-frederik.voelkel@fau.de>
 <20151213070622.GA13621@kroah.com>
 <20151213174429.GB11792@faumail.uni-erlangen.de>
 <87poyamczv.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87poyamczv.fsf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, linux-kernel@i4.cs.fau.de, lukas.braun@fau.de
List-Id: linux-serial@vger.kernel.org

On Sun, 13. Dec 19:15, Nicolai Stange wrote:
> Frederik <frederik.voelkel@fau.de> writes:
>=20
> > On Sat, 12. Dec 23:06, Greg KH wrote:
> >> On Fri, Dec 11, 2015 at 11:36:00AM +0100, Frederik V=F6lkel wrote:
> >> > This patch series fixes all checkpatch error in 68328serial.c ex=
cept
> >> > 5 trailing whitespace errors we are unsure how to fix.
> >>=20
> >> What are the errors you are not sure how to fix?
> >>=20
> >> thanks,
> >>=20
> >> greg k-h
> >
> > All 5 errors are at comments. It is not clear to us where exactly t=
he
> > trailing whitespace is checkpatch complains(lines 271, 770, 889, 99=
3
> > and 1040).
>=20
> W/o your series applied (so line numbering might be slightly
> different), checkpatch.pl says:
>=20
>   ERROR: trailing whitespace
>   #270: FILE: -:270:
>   +^I * This do { } while() loop will get ALL chars out of Rx FIFO $
>=20
> AFAICS, your patch [7/9] ("drivers: tty: 68328serial.c: remove traili=
ng
> whitespaces") doesn't fix this one.
>=20
> In good old regexp tradition, the '$' sign denotes the end of line. S=
o,
> there is a single space after "FIFO" and before the end of line.
>=20
> If you happen to be Emacs users, consider trying out whitespace-mode.
> If not, try to find another way to make your editor visualize whitesp=
ace
> somehow.

Oh right I see. We will fix that and resend.

Thank you!
