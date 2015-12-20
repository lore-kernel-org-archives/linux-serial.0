From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH RESEND 1/1] serial: 8250_pci: Fix real serial port count
 for F81504/508/512
Date: Sun, 20 Dec 2015 19:16:16 +0200
Message-ID: <CAHp75VdB0DnAz7TvsrqELJFLd6d9CT+4rjEyzJP7YcH5um_-oA@mail.gmail.com>
References: <1448952881-7871-1-git-send-email-hpeter+linux_kernel@gmail.com>
	<CAHp75Vd45Wogz83L8tB7XdvYO1bfn9C4sc3sHgr1Vskka-X3fw@mail.gmail.com>
	<566F8148.5020600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <566F8148.5020600@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hung <hpeter@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, tom_tsai@fintek.com.tw, Peter H <peter_hong@fintek.com.tw>, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Dec 15, 2015 at 4:56 AM, Peter Hung <hpeter@gmail.com> wrote:
> Andy Shevchenko =E6=96=BC 2015/12/13 =E4=B8=8A=E5=8D=88 09:08 =E5=AF=AB=
=E9=81=93:
>>
>> On Tue, Dec 1, 2015 at 8:54 AM, Peter Hung <hpeter@gmail.com> wrote:
>>> +/* The device is multi-function with UART & GPIO */
>>> +static u8 fintek_gpio_mapping[] =3D {2, 3, 8, 9, 10, 11};
>>
>>
>> Clearly you have bit combination here
>> Bit 1: 1
>> Bit 3: 1
>>
>> So, mask as 0x0a shall cover this IIAC.
>
>
> IMO, It maybe wrong. If we checked only with 0x0a mask,
> the 0x06 & 0x07 will be passed.

Ah, yes, it will be a bit more than just one check, something like:
(x & 0x0a) && (x & 0x0e !=3D 6)


--=20
With Best Regards,
Andy Shevchenko
