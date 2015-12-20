From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3] serial: 8250: add gpio support to exar
Date: Sun, 20 Dec 2015 19:46:27 +0200
Message-ID: <CAHp75VdkGoJ+YfgkwUVR7YYxkjGa3oh0TZsf5CSSn16GSG3paw@mail.gmail.com>
References: <1450617891-26167-1-git-send-email-sudipm.mukherjee@gmail.com>
	<20151220164353.6ef29f77@lxorguk.ukuu.org.uk>
	<20151220172841.GB8471@sudip-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151220172841.GB8471@sudip-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Dec 20, 2015 at 7:28 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> On Sun, Dec 20, 2015 at 04:43:53PM +0000, One Thousand Gnomes wrote:
>> > v3: Alan commented on v2, few things like NULL check, name of the gpio chip,
>> > moving some more code into the gpio code. He also commented on it being
>> > a separate module, but since this will not be needed by someone who is not
>> > using Exar chip, and even those who are using, some of them may not need it.
>> > This is optional for only those who wants to use the gpio capability of that
>> > chip. So kept it as a separate module. Waiting for your comments on that.
>>
>> That doesn't work because you reference the methods in it so it will
>> always be dragged in. You would have to make the exar driver an MFD that
>> provided a serial and a gpio binding to fix that up I think, or instead
>> of having the serial driver call into your gpio driver (thus forcing the
>> module into memory) you would have the serial driver create a platform
>> device or similar that the GPIO device bound to.
>
> So then should I rewrite it as MFD

Once we split 8250_mid.c (which is actually supports real MFD on one
of newer Intel SoCs) from 8250_pci.c, but it is a comprehensive driver
that uses 8250_core/port.c as a library.

> or should it be like the way you
> suggested in the other mail to have it as bool in the Kconfig and combine
> the file with 8250_pci.c when the symbol is selected?

 As far as I can see, you did other way around: use your module as a lib.
In that case you have to compile 8250_pci as
8250_pci.o and your 8250_exar.o, though you can't use the same name
for resulting module and one of its objects AFAIR.

-- 
With Best Regards,
Andy Shevchenko
