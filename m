From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] serial-uartlite: fix build warning
Date: Fri, 18 Mar 2016 20:20:01 +0100
Message-ID: <CAMuHMdXCo2Vfd+2cWB3WEcheRdFXWT4DfTowyp=ya=ab+-A+RA@mail.gmail.com>
References: <20160318184856.c289c591@kerio.vanmierlo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160318184856.c289c591@kerio.vanmierlo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maarten Brock <m.brock@vanmierlo.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Peter Korsgaard <jacmet@sunsite.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 18, 2016 at 6:48 PM, Maarten Brock <m.brock@vanmierlo.com> =
wrote:
> ----- Original Message -----
> From: Geert Uytterhoeven [mailto:geert@linux-m68k.org]
> To: Sudip Mukherjee [mailto:sudipm.mukherjee@gmail.com]
> Cc: Peter Korsgaard [mailto:jacmet@sunsite.dk], Greg Kroah-Hartman [m=
ailto:gregkh@linuxfoundation.org], Jiri Slaby [mailto:jslaby@suse.com],=
 linux-kernel@vger.kernel.org [mailto:linux-kernel@vger.kernel.org], li=
nux-serial@vger.kernel.org [mailto:linux-serial@vger.kernel.org]
> Sent: Fri, 18 Mar 2016 13:48:06 +0100
> Subject: Re: [PATCH] serial-uartlite: fix build warning
>
>> On Thu, Mar 10, 2016 at 2:14 PM, Sudip Mukherjee
>> <sudipm.mukherjee@gmail.com> wrote:
>> > We were getting build warnings about:
>> > drivers/tty/serial/uartlite.c: In function =E2=80=98ulite_request_=
port=E2=80=99:
>> > drivers/tty/serial/uartlite.c:348:21: warning: assignment discards
>> >         'const' qualifier from pointer target type
>> > port->private_data =3D &uartlite_be;
>> >                      ^
>> > drivers/tty/serial/uartlite.c:354:22: warning: assignment discards
>> >         'const' qualifier from pointer target type
>> > port->private_data =3D &uartlite_le;
>> >                       ^
>> >
>> > Fixes: 2905697a82ea ("serial-uartlite: Constify uartlite_be/uartli=
te_le")
>> > Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>>
>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Reverting is not the same as fixing.
>
> Rant:
> It is a stupid warning IMHO, but being a compiler writer myself (SDCC=
) I
> understand how it can arise. If you assign some const pointer to a vo=
id
> pointer without an explicit cast gcc does not complain about the comp=
lete
> loss of type, but it does warn about losing constness. In general I'd=
 say:
> make up your mind; either warn about both or don't warn about either.

You're right, I was a bit too hasty adding my Acked-by.

Hereby I would like to withdraw my Acked-by.

Gr{oetje,eeting}s,

                        Geert
