From: Muni Sekhar <munisekharrms@gmail.com>
Subject: serial: start_tx & buffer handling
Date: Thu, 3 May 2018 20:08:48 +0530
Message-ID: <CAHhAz+iPbNjeHH72Omi7VCUVL_cOUnQjrqbyJKQstUSL6J1hCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>, linux-kernel@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: linux-serial@vger.kernel.org

Hi All,

I=E2=80=99m trying to understand how user mode buffer is written to low lev=
el
serial hardware registers.

For this I read the kernel code and I came to know that from user mode
write() API lands into kernel=E2=80=99s tty_write() ("drivers/tty/tty_io.c"=
)
and then it calls a uart_write() ("drivers/tty/serial/serial_core.c").

In uart_write(), the buffer is copied to circ_buf and then it calls
low level serial hardware driver=E2=80=99s start_tx() (struct uart_ops
.start_tx). But here I could not find how the buffer kept in circ_buf
is copied to serial port=E2=80=99s TX_FIFO registers?



Can someone take a moment to explain me on this?



--=20
Thanks,
Sekhar
