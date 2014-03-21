From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: man termios
Date: Fri, 21 Mar 2014 15:17:28 +0100
Message-ID: <CAKgNAkhg4-QLwQaVxve6KXR=yy0XQik_4+iz5XytE1d_6NjQaw@mail.gmail.com>
References: <532B3691.1070602@hurleysoftware.com> <CAKgNAkisMs4A15B7ts+bAkUY5bcoTTGdE81ur10K3hZoFLxbxw@mail.gmail.com>
 <532C20B7.2070806@hurleysoftware.com> <532C3B6F.2000300@gmail.com> <532C46BD.1000208@hurleysoftware.com>
Reply-To: mtk.manpages@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:34826 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbaCUOR7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Mar 2014 10:17:59 -0400
In-Reply-To: <532C46BD.1000208@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Ivan <athlon_@mail.ru>

On Fri, Mar 21, 2014 at 3:03 PM, Peter Hurley <peter@hurleysoftware.com=
> wrote:
> On 03/21/2014 09:15 AM, Michael Kerrisk (man-pages) wrote:
>>
>> On 03/21/2014 12:21 PM, Peter Hurley wrote:
>>>
>>> On 03/21/2014 06:45 AM, Michael Kerrisk (man-pages) wrote:
>
>
>>>>> Finally, if the 'count' parameter is less than MIN, read() may re=
turn
>>>>> before
>>>>> MIN bytes have been received, if 'count' bytes have been received=
=2E
>>>>
>>>>
>>>> Yes. But it's not clear to me here: do you mean that something in =
the
>>>> man page (or in TLPI) needs fixing?
>>>
>>>
>>> Well, what I mean here is that read() may also _not_ return until M=
IN
>>> bytes have
>>> been received, even if 'count' bytes have been received.
>>
>>
>> Ahh -- I see what you mean. And, it looks like there is a point here=
 where
>> Linux
>> differs from POSIX and (at least) Solaris. See the current man-page =
text
>> below,
>> in particular the MIN>0, TIME>0 case. I've also attached a simple te=
st
>> program
>> that I used, below.
>>
>>         In noncanonical mode input is available immediately (without=
  the
>>         user  having  to  type a line-delimiter character), no input=
 pro=E2=80=90
>>         cessing is performed, and line editing is disabled.  The set=
tings
>>         of  MIN (c_cc[VMIN]) and TIME (c_cc[VTIME]) determine the ci=
rcum=E2=80=90
>>         stances in which a read(2) completes;  there  are  four  dis=
tinct
>>         cases:
>>
>>         MIN =3D=3D 0; TIME =3D=3D 0:
>>                If  data  is  available, read(2) returns immediately,=
 with
>>                the lesser of the number of bytes available, or the n=
umber
>>                of  bytes  requested.   If  no  data is available, re=
ad(2)
>>                returns 0.
>>
>>         MIN > 0; TIME =3D=3D 0:
>>                read(2) blocks until MIN bytes are available, and  re=
turns
>>                up to the number of bytes requested.
>>
>>         MIN =3D=3D 0; TIME > 0:
>>                TIME  specifies  the limit for a timer in tenths of a=
 sec=E2=80=90
>>                ond.   The  timer  is  started  when  read(2)  is  ca=
lled.
>>                read(2)  returns  either when at least one byte of da=
ta is
>>                available, or  when  the  timer  expires.   If  the  =
timer
>>                expires  without  any  input  becoming  available, re=
ad(2)
>>                returns 0.  If data is already available at  the  tim=
e  of
>>                the call to read() the call behaves as though the dat=
a was
>>                received immediately after the call.
>>
>>         MIN > 0; TIME > 0:
>>                TIME specifies the limit for a timer in tenths of  a =
 sec=E2=80=90
>>                ond.  Once an initial byte of input becomes available=
, the
>>                timer is restarted after each further  byte  is  rece=
ived.
>>                read(2)  returns  when  any of the following conditio=
ns is
>>                met:
>>
>>                *  MIN bytes have been received.
>>
>>                *  The interbyte timer expires.
>>
>>                *  The number of  bytes  requested  by  read(2)  has =
 been
>>                   received.   (POSIX  does  not  specify this termin=
ation
>>                   condition, and on  some  other  implementations  r=
ead()
>>                   does not return in this case.)
>>
>>                Because  the  timer is started only after the initial=
 byte
>>                becomes available, at least one byte  will  be  read.=
   If
>>                data  is  already  available  at  the  time of the ca=
ll to
>>                read() the call behaves as though the  data  was  rec=
eived
>>                immediately after the call.
>>
>>         POSIX does not specify whether the setting of the O_NONBLOCK=
 file
>>         status flag takes precedence over the MIN and TIME settings.=
   If
>>         O_NONBLOCK is set, a read() in noncanonical mode may return =
imme=E2=80=90
>>         diately, regardless of the setting of MIN or TIME.   Further=
more,
>>         if  no  data is available, POSIX permits a read() in noncano=
nical
>>         mode to return either 0, or -1 with errno set to EAGAIN.
>
>
> All looks good.

Peter, do you agree that Linux appears to differ from POSIX here? (Not
sure if you tried my test program to verify...)

Cheers,

Michael


--=20
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
