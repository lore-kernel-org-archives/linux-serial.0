From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5] serial: 8250: add gpio support to exar
Date: Tue, 19 Jan 2016 13:39:07 +0200
Message-ID: <CAHp75VcOQSqe1aw4GS3LhRgFhBmOg4rn0DnP7KsSKrwqVpESfg@mail.gmail.com>
References: <1453183595-17996-1-git-send-email-sudipm.mukherjee@gmail.com>
	<CAHp75VdopyRUcwSFY=qowoiq6Twkg686oQHed8WU5Ep8QQtL+A@mail.gmail.com>
	<20160119111344.GA23168@sudip-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160119111344.GA23168@sudip-pc>
Sender: linux-gpio-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Cc: Peter Hung <hpeter@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Rob Groner <rgroner@rtd.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 19, 2016 at 1:14 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> On Tue, Jan 19, 2016 at 12:09:08PM +0200, Andy Shevchenko wrote:
>> On Tue, Jan 19, 2016 at 8:06 AM, Sudip Mukherjee
>> <sudipm.mukherjee@gmail.com> wrote:
>> > Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs which
>> > can be controlled using gpio interface.
>> > Add support to use these pins.
>>
>> + Peter Hung.
>>
>> Seems Fintek HW is going similar way you, guys, have to decide how to
>> proceed in general. I like this way Sudip made here, though I still
>> few comments below.
>
> Just had a look at the Fintek patch. Interestingly high baudrate was our
> next plan. :)
>
>>
>> First of all, can we split it to two patches like cooking GPIO driver
>> first, then extend Exar piece of serial driver?
>>
>> I also would like to vote for splitting out first Exar parts from
>> 8250_pci like Peter did for Fintek.
>
> Then maybe instead of splitting out if we have the provision of high
> baudrate in 8250_pci? And the way I have done, it is just a matter of few
> function calls from 8250_pci in case the hardware is present. So then,
> what may be the advantage of splitting out?

+ Heikki.
When we considered what to do with extension to 8250_mid (at that time
it was just a set of functions in the 8250_pci) we decided not to blow
up 8250_pci anymore. At that time it was something like 6k+ LOCs.
One of the example is how sdhci is split (2 level scheme: core <- glue
bus driver <- particular hw). This might not work for 8250. But I'm
thinking something like core <- specific hw core <- bus driver.
Heikki, do you have your vision about this?

> But now the question is should I split out? What advantage
> will be there in splitting out?

You already asked it above.

-- 
With Best Regards,
Andy Shevchenko
