From: Andreas Schwab <schwab@suse.de>
Subject: Re: Don't cross the (tty) streams
Date: Thu, 20 Sep 2007 23:29:31 +0200
Message-ID: <jer6ktt490.fsf@sykes.suse.de>
References: <20070920210221.GC10625@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38587 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbXITV3e (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Sep 2007 17:29:34 -0400
In-Reply-To: <20070920210221.GC10625@parisc-linux.org> (Matthew Wilcox's
	message of "Thu\, 20 Sep 2007 15\:02\:22 -0600")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org

Matthew Wilcox <matthew@wil.cx> writes:

> Connect two machines with a serial cable.  On the victim:
>
> willy@rowlf:~$ cat </dev/ttyS1
>
> Now, let's find out which ttyS on the other machine is connected ...
>
> willy@teeth:~$ echo foo >/dev/ttyS1
> -bash: echo: write error: Input/output error
>
> Oops, that's not a serial port.  No output on rowlf, as expected.
> OK, carrying on ...
>
> willy@teeth:~$ echo bar >/dev/ttyS0
>
> And yet on rowlf, we now see:
>
> foo
> bar
>
> Looks like there's an error path that doesn't throw away data on -EIO=
=2E

Read the thread starting here:
<http://lists.gnu.org/archive/html/bug-bash/2007-09/msg00020.html>.

Andreas.

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
-
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
