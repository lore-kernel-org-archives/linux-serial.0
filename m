From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: man termios
Date: Fri, 21 Mar 2014 10:51:31 -0400
Message-ID: <532C51F3.8030205@hurleysoftware.com>
References: <532B3691.1070602@hurleysoftware.com> <CAKgNAkisMs4A15B7ts+bAkUY5bcoTTGdE81ur10K3hZoFLxbxw@mail.gmail.com> <532C20B7.2070806@hurleysoftware.com> <532C3B6F.2000300@gmail.com> <532C46BD.1000208@hurleysoftware.com> <CAKgNAkhg4-QLwQaVxve6KXR=yy0XQik_4+iz5XytE1d_6NjQaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:56084 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965290AbaCUOve (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Mar 2014 10:51:34 -0400
In-Reply-To: <CAKgNAkhg4-QLwQaVxve6KXR=yy0XQik_4+iz5XytE1d_6NjQaw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: mtk.manpages@gmail.com
Cc: linux kernel <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Ivan <athlon_@mail.ru>

On 03/21/2014 10:17 AM, Michael Kerrisk (man-pages) wrote:
> On Fri, Mar 21, 2014 at 3:03 PM, Peter Hurley <peter@hurleysoftware.c=
om> wrote:
>> On 03/21/2014 09:15 AM, Michael Kerrisk (man-pages) wrote:
>>>
>>> On 03/21/2014 12:21 PM, Peter Hurley wrote:
>>>>
>>>> On 03/21/2014 06:45 AM, Michael Kerrisk (man-pages) wrote:
>>
>>
>>>>>> Finally, if the 'count' parameter is less than MIN, read() may r=
eturn
>>>>>> before
>>>>>> MIN bytes have been received, if 'count' bytes have been receive=
d.
>>>>>
>>>>>
>>>>> Yes. But it's not clear to me here: do you mean that something in=
 the
>>>>> man page (or in TLPI) needs fixing?
>>>>
>>>>
>>>> Well, what I mean here is that read() may also _not_ return until =
MIN
>>>> bytes have
>>>> been received, even if 'count' bytes have been received.
>>>
>>>
>>> Ahh -- I see what you mean. And, it looks like there is a point her=
e where
>>> Linux
>>> differs from POSIX and (at least) Solaris. See the current man-page=
 text
>>> below,
>>> in particular the MIN>0, TIME>0 case. I've also attached a simple t=
est
>>> program
>>> that I used, below.
>>>
>>>          In noncanonical mode input is available immediately (witho=
ut  the
>>>          user  having  to  type a line-delimiter character), no inp=
ut pro=E2=80=90
>>>          cessing is performed, and line editing is disabled.  The s=
ettings
>>>          of  MIN (c_cc[VMIN]) and TIME (c_cc[VTIME]) determine the =
circum=E2=80=90
>>>          stances in which a read(2) completes;  there  are  four  d=
istinct
>>>          cases:
>>>
>>>          MIN =3D=3D 0; TIME =3D=3D 0:
>>>                 If  data  is  available, read(2) returns immediatel=
y, with
>>>                 the lesser of the number of bytes available, or the=
 number
>>>                 of  bytes  requested.   If  no  data is available, =
read(2)
>>>                 returns 0.
>>>
>>>          MIN > 0; TIME =3D=3D 0:
>>>                 read(2) blocks until MIN bytes are available, and  =
returns
>>>                 up to the number of bytes requested.
>>>
>>>          MIN =3D=3D 0; TIME > 0:
>>>                 TIME  specifies  the limit for a timer in tenths of=
 a sec=E2=80=90
>>>                 ond.   The  timer  is  started  when  read(2)  is  =
called.
>>>                 read(2)  returns  either when at least one byte of =
data is
>>>                 available, or  when  the  timer  expires.   If  the=
  timer
>>>                 expires  without  any  input  becoming  available, =
read(2)
>>>                 returns 0.  If data is already available at  the  t=
ime  of
>>>                 the call to read() the call behaves as though the d=
ata was
>>>                 received immediately after the call.
>>>
>>>          MIN > 0; TIME > 0:
>>>                 TIME specifies the limit for a timer in tenths of  =
a  sec=E2=80=90
>>>                 ond.  Once an initial byte of input becomes availab=
le, the
>>>                 timer is restarted after each further  byte  is  re=
ceived.
>>>                 read(2)  returns  when  any of the following condit=
ions is
>>>                 met:
>>>
>>>                 *  MIN bytes have been received.
>>>
>>>                 *  The interbyte timer expires.
>>>
>>>                 *  The number of  bytes  requested  by  read(2)  ha=
s  been
>>>                    received.   (POSIX  does  not  specify this term=
ination
>>>                    condition, and on  some  other  implementations =
 read()
>>>                    does not return in this case.)
>>>
>>>                 Because  the  timer is started only after the initi=
al byte
>>>                 becomes available, at least one byte  will  be  rea=
d.   If
>>>                 data  is  already  available  at  the  time of the =
call to
>>>                 read() the call behaves as though the  data  was  r=
eceived
>>>                 immediately after the call.
>>>
>>>          POSIX does not specify whether the setting of the O_NONBLO=
CK file
>>>          status flag takes precedence over the MIN and TIME setting=
s.   If
>>>          O_NONBLOCK is set, a read() in noncanonical mode may retur=
n imme=E2=80=90
>>>          diately, regardless of the setting of MIN or TIME.   Furth=
ermore,
>>>          if  no  data is available, POSIX permits a read() in nonca=
nonical
>>>          mode to return either 0, or -1 with errno set to EAGAIN.
>>
>>
>> All looks good.
>
> Peter, do you agree that Linux appears to differ from POSIX here? (No=
t
> sure if you tried my test program to verify...)

I did run the test program to validate that it's observed behavior is t=
hat
implemented by Linux, with which I'm very familiar.
I don't have a test setup for other *nixes.

I would be interested to know the results of

   ./noncanonical 0 5 3 0
   hello

and

   ./noncanonical 0 5 3 2
    hel

on other platforms.

With respect to POSIX compliance, it's hard to say. I'm not sure the
spec contemplates the degenerate case where max bytes < MIN. And specif=
ically
with regard to terminal i/o behavior, POSIX is essentially ex post fact=
o,
and is really documenting existing behavior.

Other than the degenerate case of max bytes < MIN, is there any other
variation between Solaris and Linux in non-canonical mode?

Regards,
Peter Hurley

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
