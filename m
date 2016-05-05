From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [BUG] drivers/tty: read() on a noncanonical blocking tty randomly
 fails when VMIN > received >= buf
Date: Wed, 4 May 2016 17:50:56 -0700
Message-ID: <572A98F0.3040306@hurleysoftware.com>
References: <16504442-9e91-aaab-1f2b-9b4aa9c219f5@farjump.io>
 <572A80C0.4080704@hurleysoftware.com>
 <3319f492-9b1b-d006-e903-7de761a87a53@farjump.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3319f492-9b1b-d006-e903-7de761a87a53@farjump.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Julio Guerra <julio@farjump.io>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 05/04/2016 04:27 PM, Julio Guerra wrote:
>>> When a tty (here a slave pty) is set in noncanonical input and bloc=
king read modes, a read() randomly blocks when:
>>> "VMIN > kernel received >=3D user buffer size > 0".
>>>
>>> The standard says that read() should block until VMIN bytes are rec=
eived [1][2]. Whether this is an implementation defined case not really=
 specified by POSIX or not, it should not behave randomly (otherwise it=
 really should be documented in termios manpage).
>>
>> This is not a bug.
>>
>> From the termios(3) man page:
>>
>>        * MIN > 0; TIME =3D=3D 0: read(2) blocks until the lesser of =
MIN bytes or the number of bytes requested are avail=E2=80=90
>>          able, and returns the lesser of these two values.
>>
>=20
> This does not appear in my man...
>=20
> Anyway, how do you explain the random behavior then?

A long standing bug in this read mode allows the asynchronous input
processing thread to race with the read() thread and become confused
about how much data remains.

I fixed this in 4.6; when I run your test on 4.6, it consistently
returns the full user buffer.

Regards,
Peter Hurley
