From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1] tty: serial: Use GFP_ATOMIC instead of GFP_KERNEL in serial8250_em485_init()
Date: Thu, 18 Feb 2016 22:21:54 +0200
Message-ID: <CAHp75VdLfOpsA-owMzOTJoo_iFmWiJjzC1p-NaqRO9LHcWu1Pg@mail.gmail.com>
References: <1455821240-5842-1-git-send-email-matwey@sai.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455821240-5842-1-git-send-email-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 18, 2016 at 8:47 PM, Matwey V. Kornilov <matwey@sai.msu.ru> wrote:
> serial8250_em485_init() is supposed to be protected with
> p->port.lock spinlock.
> This may lead to issues when kmalloc sleeps, so it is better to use
> GFP_ATOMIC in this spinlocked context.
>
> Fixes: e490c9144cfa ("tty: Add software emulated RS485 support for 8250")
> Reported-by: <torso.nafi@gmail.com>

Hmm... Can't we put Cyrillic characters to tags as name of a person?

-- 
With Best Regards,
Andy Shevchenko
