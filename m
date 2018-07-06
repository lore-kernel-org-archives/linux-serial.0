From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3] uart: fix race between uart_put_char() and uart_shutdown()
Date: Fri, 6 Jul 2018 23:48:58 +0300
Message-ID: <CAHp75VeAoL9aN4pX4G9WGPS4Oxi=G6PyF7qCCyZ1fNH=gKHYiw@mail.gmail.com>
References: <20180706143919.GA2344@kroah.com> <20180706162457.20489-1-tycho@tycho.ws>
 <CAHp75Vfbh5SzpqP=2LfeXteEGrBG46dPfeHsU0ac5SiJSjZOXw@mail.gmail.com> <20180706183928.GA3583@cisco.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180706183928.GA3583@cisco.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Tycho Andersen <tycho@tycho.ws>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jul 6, 2018 at 9:39 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> On Fri, Jul 06, 2018 at 07:49:09PM +0300, Andy Shevchenko wrote:
>> On Fri, Jul 6, 2018 at 7:24 PM, Tycho Andersen <tycho@tycho.ws> wrote:

>  but without the initialization I get,
>
>   CC      drivers/tty/serial/serial_core.o
> In file included from ./include/linux/seqlock.h:36:0,
>                  from ./include/linux/time.h:6,
>                  from ./include/linux/stat.h:19,
>                  from ./include/linux/module.h:10,
>                  from drivers/tty/serial/serial_core.c:10:
> drivers/tty/serial/serial_core.c: In function =E2=80=98uart_startup.part.=
20=E2=80=99:
> ./include/linux/spinlock.h:260:3: warning: =E2=80=98flags=E2=80=99 may be=
 used uninitialized in this function  -Wmaybe-uninitialized]
>    _raw_spin_unlock_irqrestore(lock, flags); \
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/tty/serial/serial_core.c:184:22: note: =E2=80=98flags=E2=80=99 wa=
s declared here
>   unsigned long page, flags;
>                       ^~~~~

Hmm... I didn't see such warning. How you run make?

Btw, you adding the only places with such assignments in this file.
So, I would not do in your case, until entire file would be fixed.

(But warning looks bogus, or you have some patches on top of current
vanilla / next)

--=20
With Best Regards,
Andy Shevchenko
