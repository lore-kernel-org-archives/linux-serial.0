From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3] serial: 8250: add gpio support to exar
Date: Tue, 22 Dec 2015 12:15:18 +0200
Message-ID: <CAHp75Ve_Hsj9YbV3bQ16qRQrVRo+HE2RJukuH=Mpq5AVLzhaDw@mail.gmail.com>
References: <1450617891-26167-1-git-send-email-sudipm.mukherjee@gmail.com>
	<20151220164353.6ef29f77@lxorguk.ukuu.org.uk>
	<20151220172841.GB8471@sudip-laptop>
	<20151220174208.1447d2f3@lxorguk.ukuu.org.uk>
	<20151221151904.GA23780@sudip-pc>
	<CAHp75VfF_f=4MFmk9D1eLYanVyQyr+Fr8RBY81Pw+dyGZ7e0xw@mail.gmail.com>
	<20151222042707.GA3250@sudip-pc>
	<CAHp75VfU74zvwBef682bVqL-aSYVRYeEyPjyarE_KRyLr+8NQw@mail.gmail.com>
	<20151222100859.GA24622@sudip-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151222100859.GA24622@sudip-pc>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Dec 22, 2015 at 12:08 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> On Tue, Dec 22, 2015 at 11:58:17AM +0200, Andy Shevchenko wrote:

>> > The only downside is
>> > that the module gets loaded even if the device is not there.
>>
>> How is that?
>
> Alan explained that in https://lkml.org/lkml/2015/12/20/103
>
> Quoting from his mail "you reference the methods in it so it will
> always be dragged in".
>
> And I wanted to verify that so I tested today morning after removing the
> card from my local system and after booting I saw having 8250_gpi loaded.

Ah, it is in case "exar as a library".

In case "exar as a separate driver" other way around: it will drag
methods from 8250_pci if any.

-- 
With Best Regards,
Andy Shevchenko
