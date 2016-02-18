From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1] tty: serial: Use GFP_ATOMIC instead of GFP_KERNEL in
 serial8250_em485_init()
Date: Thu, 18 Feb 2016 15:47:18 -0800
Message-ID: <20160218234718.GB4517@kroah.com>
References: <1455821240-5842-1-git-send-email-matwey@sai.msu.ru>
 <CAHp75VdLfOpsA-owMzOTJoo_iFmWiJjzC1p-NaqRO9LHcWu1Pg@mail.gmail.com>
 <CAJs94EbEOnQg0bQ8s-YD-AQfpKatovwyv81hJSbPpxy1RGhBBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJs94EbEOnQg0bQ8s-YD-AQfpKatovwyv81hJSbPpxy1RGhBBQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, =?utf-8?B?0JjQu9GM0Y/RgSDQk9Cw0YHQsNC90L7Qsg==?= <torso.nafi@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 18, 2016 at 11:29:07PM +0300, Matwey V. Kornilov wrote:
> 2016-02-18 23:21 GMT+03:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
> > On Thu, Feb 18, 2016 at 8:47 PM, Matwey V. Kornilov <matwey@sai.msu.ru> wrote:
> >> serial8250_em485_init() is supposed to be protected with
> >> p->port.lock spinlock.
> >> This may lead to issues when kmalloc sleeps, so it is better to use
> >> GFP_ATOMIC in this spinlocked context.
> >>
> >> Fixes: e490c9144cfa ("tty: Add software emulated RS485 support for 8250")
> >> Reported-by: <torso.nafi@gmail.com>
> >
> > Hmm... Can't we put Cyrillic characters to tags as name of a person?
> 
> I am afraid non-ASCII will break something eventually. I think it
> would be better to ask Ilias to put his name in proper latin
> transcription here.

Why, we accept non-ASCII names all the time, why would we not do so?

Please fix up and resend.

thansk,

greg k-h
