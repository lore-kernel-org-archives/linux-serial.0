From: Julio Guerra <julio@farjump.io>
Subject: Re: [BUG] drivers/tty: read() on a noncanonical blocking tty randomly
 fails when VMIN > received >= buf
Date: Thu, 5 May 2016 01:27:28 +0200
Message-ID: <3319f492-9b1b-d006-e903-7de761a87a53@farjump.io>
References: <16504442-9e91-aaab-1f2b-9b4aa9c219f5@farjump.io>
 <572A80C0.4080704@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <572A80C0.4080704@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

>> When a tty (here a slave pty) is set in noncanonical input and block=
ing read modes, a read() randomly blocks when:
>> "VMIN > kernel received >=3D user buffer size > 0".
>>
>> The standard says that read() should block until VMIN bytes are rece=
ived [1][2]. Whether this is an implementation defined case not really =
specified by POSIX or not, it should not behave randomly (otherwise it =
really should be documented in termios manpage).
>
> This is not a bug.
>
> From the termios(3) man page:
>
>        * MIN > 0; TIME =3D=3D 0: read(2) blocks until the lesser of M=
IN bytes or the number of bytes requested are avail=E2=80=90
>          able, and returns the lesser of these two values.
>

This does not appear in my man...

Anyway, how do you explain the random behavior then?

--=20
Julio Guerra
