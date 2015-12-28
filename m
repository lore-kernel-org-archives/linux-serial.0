From: Peter Hung <hpeter@gmail.com>
Subject: Re: [PATCH RESEND 1/1] serial: 8250_pci: Fix real serial port count
 for F81504/508/512
Date: Mon, 28 Dec 2015 11:42:51 +0800
Message-ID: <5680AFBB.3080108@gmail.com>
References: <1448952881-7871-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <CAHp75Vd45Wogz83L8tB7XdvYO1bfn9C4sc3sHgr1Vskka-X3fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd45Wogz83L8tB7XdvYO1bfn9C4sc3sHgr1Vskka-X3fw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, jslaby@suse.com, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, tom_tsai@fintek.com.tw, Peter H <peter_hong@fintek.com.tw>, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi Greg,

Andy Shevchenko =E6=96=BC 2015/12/13 =E4=B8=8A=E5=8D=88 09:08 =E5=AF=AB=
=E9=81=93:
> First of all, maybe you can consider to split this part of the driver
> to separate one? (Like we did for 8250_mid.c). It seems 8250_pci is
> too bloated. But it's just an idea, maybe for future.
>

Did you have reviewed this patch? Please skip this patch if not
reviewed.

The F81504/508/512 is multi-function card. It contains
Serial/GPIO functions. It maybe enlarge the scale of 8250_pci.c and
make it less maintainable if we add GPIOLIB support into 8250_pci.c

Could I split the F81504/508/512 driver from 8250_pci.c into a
new module file and implements GPIOLIB?

Thanks
--=20
With Best Regards,
Peter Hung
