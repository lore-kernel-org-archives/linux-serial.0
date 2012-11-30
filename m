From: Paul Fulghum <paulkf@microgate.com>
Subject: Re: [Suggestion] drivers/tty: drivers/char/:  for MAX_ASYNC_BUFFER_SIZE
Date: Fri, 30 Nov 2012 10:24:12 -0600
Message-ID: <50B8DDAC.8070901@microgate.com>
References: <50B6E751.9000000@asianux.com> <20121129051335.GA4375@kroah.com> <50B6F967.3050000@asianux.com> <20121129183207.GA4688@kroah.com> <50B81F76.8020508@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50B81F76.8020508@asianux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-serial@vger.kernel.org

On 11/29/2012 8:52 PM, Chen Gang wrote:
> =E4=BA=8E 2012=E5=B9=B411=E6=9C=8830=E6=97=A5 02:32, Greg KH =E5=86=99=
=E9=81=93:
>> On Thu, Nov 29, 2012 at 01:57:59PM +0800, Chen Gang wrote:
>>>> And, I really don't understand here, why do you want to change thi=
s?
>>>> What is it going to change?  And why?
>>>
>>> Why:
>>>   for the context MGSLPC_INFO *info in drivers/char/pcmcia/synclink=
_cs.c
>>>     info->max_frame_size can be the value between 4096 .. 65535 (ca=
n be
>>> set by its module input parameter)
>>>     info->flag_buf length is 4096 (MAX_ASYNC_BUFFER_SIZE)
>>>   in function rx_get_frame
>>>     the framesize is limit by info->max_frame_size, but may still b=
e
>>> larger that 4096.
>>>     when call function ldisc_receive_buf, info->flag_buf is equal t=
o
>>> 4096, but framesize can be more than 4096. it will cause memory ove=
r flow.

The confusion centers on calling the line discipline receive_buf
function with a data buffer larger than the flag buffer.

The synclink drivers support asynchronous and synchronous (HDLC)
serial communications.

In asynchronous mode, the tty flip buffer is used to feed
data to the line discipline. In this mode, the above argument
does not apply. The receive_buf function is not called directly.

In synchronous mode, the driver calls the line discipline
receive_buf function directly to feed one HDLC frame
of data per call. Maintaining frame boundaries is needed
in this mode. This is done only with the N_HDLC line
discipline which expects this format and ignores the flag buffer.
The flag buffer passed is just a place holder to meet the
calling conventions of the line discipline receive_buf function.

The only danger is if:
1. driver is configured for synchronous mode
2. driver is configured for frames > 4K
3. line discipline other than N_HDLC is selected

In this case the line discipline might try to access
beyond the end of the flag buffer. This is a non-functional
configuration that would not occur on purpose.

Increasing the flag buffer size would prevent a problem
in this degenerate case of purposeful misconfiguration.
This would be at the expense of larger allocations that are
not used.

I think the correct fix is for me to change the direct
calls to pass the same buffer for both data and flag and
add a comment describing the fact the flag buffer is ignored
when using N_HDLC. That way a misconfigured setup won't
cause problems and no unneeded allocations are made.

My suggestion is to leave it as is for now until I can make
those changes. I admit the current code is ugly enough to
cause confusion (sorry Chen Gang), but I don't see any immediate danger=
=2E

--=20
Paul Fulghum
MicroGate Systems, Ltd.
=3DCustomer Driven, by Design=3D
(800)444-1982 (US Sales)
(512)345-7791 x102 (Direct)
(512)343-9046 (Fax)
Central Time Zone (GMT -6h)
www.microgate.com
