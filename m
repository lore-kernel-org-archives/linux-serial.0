From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 3/3] serial: 8250_pci: remove exar code
Date: Sun, 15 Jan 2017 17:46:32 +0200
Message-ID: <CAHp75VfBqi2RoT9i5=+XNXyid=3CcA5fVGX_L45dTFx+iXMbrw@mail.gmail.com>
References: <1484434252-7663-1-git-send-email-sudipm.mukherjee@gmail.com> <1484434252-7663-3-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484434252-7663-3-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Jan 15, 2017 at 12:50 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>
> Remove the Exar specific codes from 8250_pci and blacklist those chips
> so that the new Exar serial driver binds to the devices.

>  #define UART_EXAR_MPIOINT_7_0  0x8f    /* MPIOINT[7:0] */
>  #define UART_EXAR_MPIOLVL_7_0  0x90    /* MPIOLVL[7:0] */
>  #define UART_EXAR_MPIO3T_7_0   0x91    /* MPIO3T[7:0] */

>  #define UART_EXAR_MPIOINV_15_8 0x98    /* MPIOINV[15:8] */
>  #define UART_EXAR_MPIOSEL_15_8 0x99    /* MPIOSEL[15:8] */
>  #define UART_EXAR_MPIOOD_15_8  0x9a    /* MPIOOD[15:8] */

>  #define PCI_DEVICE_ID_COMMTECH_4222PCI335 0x0004
>  #define PCI_DEVICE_ID_COMMTECH_4224PCI335 0x0002
>  #define PCI_DEVICE_ID_COMMTECH_2324PCI335 0x000a

So, this is left here.

I would expect patch 4 in this series which moves the rest of EXAR
based devices as well.
I.e. devices using pci_fastcom335_setup().


-- 
With Best Regards,
Andy Shevchenko
