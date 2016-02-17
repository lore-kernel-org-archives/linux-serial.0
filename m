From: Peter Hung <hpeter@gmail.com>
Subject: Re: [PATCH V3 2/4] gpio: gpio-f81504: Add Fintek F81504/508/512
 PCIE-to-UART/GPIO GPIOLIB support
Date: Wed, 17 Feb 2016 18:13:40 +0800
Message-ID: <56C447D4.4080506@gmail.com>
References: <1455605710-3724-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1455605710-3724-3-git-send-email-hpeter+linux_kernel@gmail.com>
 <CACRpkdYODcp5P7QT1b-9HNjA1j4X_UAVs+AfCgjfgpjAA2PnWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYODcp5P7QT1b-9HNjA1j4X_UAVs+AfCgjfgpjAA2PnWQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Lee Jones <lee.jones@linaro.org>, Jiri Slaby <jslaby@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter H <peter_hong@fintek.com.tw>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, Soeren Grunewald <soeren.grunewald@desy.de>, Wang YanQing <udknight@gmail.com>, Adam Lee <adam.lee@canonical.com>, Arnd Bergmann <arnd@arndb.de>, Joachim Eastwood <manabian@gmail.com>, Scott Wood <scottwood@freescale.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Paul Burton <paul.burton@imgtec.com>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, Matthias Brugger <matthias.bgg@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger
List-Id: linux-serial@vger.kernel.org

Hi Linus,

Linus Walleij =E6=96=BC 2016/2/16 =E4=B8=8B=E5=8D=88 11:22 =E5=AF=AB=E9=
=81=93:
> On Tue, Feb 16, 2016 at 7:55 AM, Peter Hung <hpeter@gmail.com> wrote:
>>
>> Suggested-by: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
>> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> It's fine with me if this is queued in MFD, serial or whatever tree, =
or
> we can wait until the MFD parts are in and take it for the next merge
> window.
>

Thanks for your review, but Andy give me some advice for 8250_f81504.c.
So I'll send V4 when I rewrite it.

--=20
With Best Regards,
Peter Hung
