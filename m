From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: man termios
Date: Fri, 21 Mar 2014 10:03:41 -0400
Message-ID: <532C46BD.1000208@hurleysoftware.com>
References: <532B3691.1070602@hurleysoftware.com> <CAKgNAkisMs4A15B7ts+bAkUY5bcoTTGdE81ur10K3hZoFLxbxw@mail.gmail.com> <532C20B7.2070806@hurleysoftware.com> <532C3B6F.2000300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:38898 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760353AbaCUODo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Mar 2014 10:03:44 -0400
In-Reply-To: <532C3B6F.2000300@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Ivan <athlon_@mail.ru>

On 03/21/2014 09:15 AM, Michael Kerrisk (man-pages) wrote:
> On 03/21/2014 12:21 PM, Peter Hurley wrote:
>> On 03/21/2014 06:45 AM, Michael Kerrisk (man-pages) wrote:

>>>> Finally, if the 'count' parameter is less than MIN, read() may ret=
urn before
>>>> MIN bytes have been received, if 'count' bytes have been received.
>>>
>>> Yes. But it's not clear to me here: do you mean that something in t=
he
>>> man page (or in TLPI) needs fixing?
>>
>> Well, what I mean here is that read() may also _not_ return until MI=
N bytes have
>> been received, even if 'count' bytes have been received.
>
> Ahh -- I see what you mean. And, it looks like there is a point here =
where Linux
> differs from POSIX and (at least) Solaris. See the current man-page t=
ext below,
> in particular the MIN>0, TIME>0 case. I've also attached a simple tes=
t program
> that I used, below.
>
>         In noncanonical mode input is available immediately (without =
 the
>         user  having  to  type a line-delimiter character), no input =
pro=E2=80=90
>         cessing is performed, and line editing is disabled.  The sett=
ings
>         of  MIN (c_cc[VMIN]) and TIME (c_cc[VTIME]) determine the cir=
cum=E2=80=90
>         stances in which a read(2) completes;  there  are  four  dist=
inct
>         cases:
>
>         MIN =3D=3D 0; TIME =3D=3D 0:
>                If  data  is  available, read(2) returns immediately, =
with
>                the lesser of the number of bytes available, or the nu=
mber
>                of  bytes  requested.   If  no  data is available, rea=
d(2)
>                returns 0.
>
>         MIN > 0; TIME =3D=3D 0:
>                read(2) blocks until MIN bytes are available, and  ret=
urns
>                up to the number of bytes requested.
>
>         MIN =3D=3D 0; TIME > 0:
>                TIME  specifies  the limit for a timer in tenths of a =
sec=E2=80=90
>                ond.   The  timer  is  started  when  read(2)  is  cal=
led.
>                read(2)  returns  either when at least one byte of dat=
a is
>                available, or  when  the  timer  expires.   If  the  t=
imer
>                expires  without  any  input  becoming  available, rea=
d(2)
>                returns 0.  If data is already available at  the  time=
  of
>                the call to read() the call behaves as though the data=
 was
>                received immediately after the call.
>
>         MIN > 0; TIME > 0:
>                TIME specifies the limit for a timer in tenths of  a  =
sec=E2=80=90
>                ond.  Once an initial byte of input becomes available,=
 the
>                timer is restarted after each further  byte  is  recei=
ved.
>                read(2)  returns  when  any of the following condition=
s is
>                met:
>
>                *  MIN bytes have been received.
>
>                *  The interbyte timer expires.
>
>                *  The number of  bytes  requested  by  read(2)  has  =
been
>                   received.   (POSIX  does  not  specify this termina=
tion
>                   condition, and on  some  other  implementations  re=
ad()
>                   does not return in this case.)
>
>                Because  the  timer is started only after the initial =
byte
>                becomes available, at least one byte  will  be  read. =
  If
>                data  is  already  available  at  the  time of the cal=
l to
>                read() the call behaves as though the  data  was  rece=
ived
>                immediately after the call.
>
>         POSIX does not specify whether the setting of the O_NONBLOCK =
file
>         status flag takes precedence over the MIN and TIME settings. =
  If
>         O_NONBLOCK is set, a read() in noncanonical mode may return i=
mme=E2=80=90
>         diately, regardless of the setting of MIN or TIME.   Furtherm=
ore,
>         if  no  data is available, POSIX permits a read() in noncanon=
ical
>         mode to return either 0, or -1 with errno set to EAGAIN.

All looks good.

Thanks again,
Peter Hurley

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
