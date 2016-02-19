From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH v1] tty: serial: Use GFP_ATOMIC instead of GFP_KERNEL in serial8250_em485_init()
Date: Fri, 19 Feb 2016 08:36:02 +0300
Message-ID: <CAJs94EY5cRQhsoJtcQ23b11sDaFvm_MkcuzW_utLg8=6AvExtg@mail.gmail.com>
References: <1455821240-5842-1-git-send-email-matwey@sai.msu.ru>
 <CAHp75VdLfOpsA-owMzOTJoo_iFmWiJjzC1p-NaqRO9LHcWu1Pg@mail.gmail.com>
 <CAJs94EbEOnQg0bQ8s-YD-AQfpKatovwyv81hJSbPpxy1RGhBBQ@mail.gmail.com> <20160218234718.GB4517@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160218234718.GB4517@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, =?UTF-8?B?0JjQu9GM0Y/RgSDQk9Cw0YHQsNC90L7Qsg==?= <torso.nafi@gmail.com>
List-Id: linux-serial@vger.kernel.org

2016-02-19 2:47 GMT+03:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Thu, Feb 18, 2016 at 11:29:07PM +0300, Matwey V. Kornilov wrote:
>> 2016-02-18 23:21 GMT+03:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
>> > On Thu, Feb 18, 2016 at 8:47 PM, Matwey V. Kornilov <matwey@sai.msu.ru> wrote:
>> >> serial8250_em485_init() is supposed to be protected with
>> >> p->port.lock spinlock.
>> >> This may lead to issues when kmalloc sleeps, so it is better to use
>> >> GFP_ATOMIC in this spinlocked context.
>> >>
>> >> Fixes: e490c9144cfa ("tty: Add software emulated RS485 support for 8250")
>> >> Reported-by: <torso.nafi@gmail.com>
>> >
>> > Hmm... Can't we put Cyrillic characters to tags as name of a person?
>>
>> I am afraid non-ASCII will break something eventually. I think it
>> would be better to ask Ilias to put his name in proper latin
>> transcription here.
>
> Why, we accept non-ASCII names all the time, why would we not do so?
>
> Please fix up and resend.

Sure, I've just sent v2.
I am used that non-ASCIIs break things, as they did it 20 years ago,
as they do it in 2016. GhostView stole all my Cyrillic characters from
PDF when I tried to embed fonts two days ago .

>
> thansk,
>
> greg k-h
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119991, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
