From: Peter Hung <hpeter@gmail.com>
Subject: Re: [PATCH RESEND 1/1] serial: 8250_pci: Fix real serial port count
 for F81504/508/512
Date: Tue, 15 Dec 2015 10:56:08 +0800
Message-ID: <566F8148.5020600@gmail.com>
References: <1448952881-7871-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <CAHp75Vd45Wogz83L8tB7XdvYO1bfn9C4sc3sHgr1Vskka-X3fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd45Wogz83L8tB7XdvYO1bfn9C4sc3sHgr1Vskka-X3fw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, tom_tsai@fintek.com.tw, Peter H <peter_hong@fintek.com.tw>, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hello,

Andy Shevchenko =E6=96=BC 2015/12/13 =E4=B8=8A=E5=8D=88 09:08 =E5=AF=AB=
=E9=81=93:
> On Tue, Dec 1, 2015 at 8:54 AM, Peter Hung <hpeter@gmail.com> wrote:

> First of all, maybe you can consider to split this part of the driver
> to separate one? (Like we did for 8250_mid.c). It seems 8250_pci is
> too bloated. But it's just an idea, maybe for future.

It's a good idea. Our PCI-to-UART device is a multifunctional
(GPIO/UART) board, I need try to split it from 8250_pci.c to
implements all functions.

>>
>> +/* The device is multi-function with UART & GPIO */
>> +static u8 fintek_gpio_mapping[] =3D {2, 3, 8, 9, 10, 11};
>
> Clearly you have bit combination here
> Bit 1: 1
> Bit 3: 1
>
> So, mask as 0x0a shall cover this IIAC.

IMO, It maybe wrong. If we checked only with 0x0a mask,
the 0x06 & 0x07 will be passed.

I had try with k-map to reduce from 0~11 (12~15 for don't care).
The final boolean value is a + c b(bar) for a is MSB.

>> -       config_base =3D 0x40 + 0x08 * idx;
>> +       switch (pdev->device) {
>> +       case 0x1104: /* 4 ports */
>
> Maybe you can introduce constants for IDs.

I'll make the magic numbers with #define marco.

Thanks for your advices.
--=20
With Best Regards,
Peter Hung
