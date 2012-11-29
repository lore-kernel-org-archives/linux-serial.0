From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [Suggestion] drivers/tty: drivers/char/:  for MAX_ASYNC_BUFFER_SIZE
Date: Thu, 29 Nov 2012 13:57:59 +0800
Message-ID: <50B6F967.3050000@asianux.com>
References: <50B6E751.9000000@asianux.com> <20121129051335.GA4375@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121129051335.GA4375@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

=E4=BA=8E 2012=E5=B9=B411=E6=9C=8829=E6=97=A5 13:13, Greg KH =E5=86=99=E9=
=81=93:
> On Thu, Nov 29, 2012 at 12:40:49PM +0800, Chen Gang wrote:
>> Hello Greg Kroah-Hartman:
>>
>> for MAX_ASYNC_BUFFER_SIZE:
>>   it is defined as 4096;
>>   but for the max buffer size which it processes, is 65535.
>>   so suggest to #define MAX_ASYNC_BUFFER_SIZE 0x10000  (better than =
0xffff)
>=20
> Please, send tty questions to the linux-serial@vger.kernel.org list
> also.

  I cc to linux-serial@vger.kernel.org, in this reply.

  I referenced the file MAINTAINERS, before sent original mail:

  it seems all drivers/tty/serial/* are relative with
linux-serial@vger.kernel.org. but our case is not relative
drivers/tty/serial. so for not bother them, I am not send to them,
originally.

  in MAINTAINERS, line 7438, I find for common of driver/tty/*, can sen=
d
to you and no cc, so I send you and cc to linux-kernel@vger.kernel.org.

  next time, for all tty questions, I will cc to
linux-serial@vger.kernel.org (not cc to linux-kernel@vger.kernel.org).

>=20
> And, I really don't understand here, why do you want to change this?
> What is it going to change?  And why?
>=20

Why:
  for the context MGSLPC_INFO *info in drivers/char/pcmcia/synclink_cs.=
c
    info->max_frame_size can be the value between 4096 .. 65535 (can be
set by its module input parameter)
    info->flag_buf length is 4096 (MAX_ASYNC_BUFFER_SIZE)
  in function rx_get_frame
    the framesize is limit by info->max_frame_size, but may still be
larger that 4096.
    when call function ldisc_receive_buf, info->flag_buf is equal to
4096, but framesize can be more than 4096. it will cause memory over fl=
ow.

What:
  #define MAX_ASYNC_BUFFER_SIZE  0x10000 (instead of 4096, originally).
  let it match the max frame size.

At last:
  my suggestion may be incorrect, need relative member (who expert abou=
t
it) to help checking.


  welcome another suggestion or completions.

  thanks.

gchen.

> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20
>=20


--=20
Chen Gang

Asianux Corporation
