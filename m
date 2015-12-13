From: Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: [PATCH 0/9] Fix checkpatch errors
Date: Sun, 13 Dec 2015 20:31:17 +0000
Message-ID: <20151213203117.GA1012@milliways>
References: <1449830170-15096-1-git-send-email-frederik.voelkel@fau.de>
 <20151213070622.GA13621@kroah.com>
 <20151213174429.GB11792@faumail.uni-erlangen.de>
 <87poyamczv.fsf@gmail.com>
 <20151213182604.GC11792@faumail.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151213182604.GC11792@faumail.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Frederik <frederik.voelkel@fau.de>
Cc: Nicolai Stange <nicstange@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, linux-kernel@i4.cs.fau.de, lukas.braun@fau.de
List-Id: linux-serial@vger.kernel.org

On Sun, Dec 13, 2015 at 07:26:04PM +0100, Frederik wrote:
> On Sun, 13. Dec 19:15, Nicolai Stange wrote:
> > Frederik <frederik.voelkel@fau.de> writes:
> >=20
> > W/o your series applied (so line numbering might be slightly
> > different), checkpatch.pl says:
> >=20
> >   ERROR: trailing whitespace
> >   #270: FILE: -:270:
> >   +^I * This do { } while() loop will get ALL chars out of Rx FIFO =
$
> >=20
> > AFAICS, your patch [7/9] ("drivers: tty: 68328serial.c: remove trai=
ling
> > whitespaces") doesn't fix this one.
> >=20
> > In good old regexp tradition, the '$' sign denotes the end of line.=
 So,
> > there is a single space after "FIFO" and before the end of line.
> >=20
> > If you happen to be Emacs users, consider trying out whitespace-mod=
e.
> > If not, try to find another way to make your editor visualize white=
space
> > somehow.
>=20
> Oh right I see. We will fix that and resend.
>=20
> Thank you!
If you are using vim, I have the following in my .vimrc.  It was
originally posted here many years ago.  Seems to work on all my x86
boxes, but AFAIR it didn't work on a ppc, so might not work on other
architectures.

"for redundant whitespace, from Jeremy Kerr via Olof Johanson
highlight RedundantWhitespace ctermbg=3Dred guibg=3Dred
match RedundantWhitespace /\s\+$\| \+\ze\t/

HTH

=C4=B8en
--=20
This email was written using 100% recycled letters.
