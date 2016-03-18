From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] serial-uartlite: fix build warning
Date: Fri, 18 Mar 2016 13:48:06 +0100
Message-ID: <CAMuHMdXcBTVQc-r4uEru1eHrzv80JQ6R+epr_aOZWMM0X0g_-g@mail.gmail.com>
References: <1457615688-27406-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457615688-27406-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 10, 2016 at 2:14 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> We were getting build warnings about:
> drivers/tty/serial/uartlite.c: In function =E2=80=98ulite_request_por=
t=E2=80=99:
> drivers/tty/serial/uartlite.c:348:21: warning: assignment discards
>         'const' qualifier from pointer target type
> port->private_data =3D &uartlite_be;
>                      ^
> drivers/tty/serial/uartlite.c:354:22: warning: assignment discards
>         'const' qualifier from pointer target type
> port->private_data =3D &uartlite_le;
>                       ^
>
> Fixes: 2905697a82ea ("serial-uartlite: Constify uartlite_be/uartlite_=
le")
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert
