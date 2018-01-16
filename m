From: =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Avoid overflow in dw8250_set_termios
Date: Tue, 16 Jan 2018 09:48:14 +0100
Message-ID: <CAEXMXLSX0BrAP31iu_nVUKYcW_GfDfvAvmr0z=am0=En2rv72g@mail.gmail.com>
References: <20180112134507.9030-1-ed.blake@sondrel.com> <CAHp75VfBCTFcO=bysUQBaN-6sYa_1LO8XSzc4WY+X0_M_SZwsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfBCTFcO=bysUQBaN-6sYa_1LO8XSzc4WY+X0_M_SZwsQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ed Blake <ed.blake@sondrel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 15, 2018 at 9:30 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> It seems the change broke Bluetooth on some Intel platforms. I'm not
> sure yet, but
> see here:
>
> https://github.com/Dunedan/mbp-2016-linux/issues/29#issuecomment-357583782
>

Hi Andy,

I guess you mean de9e33b [1] and not this patch (which is not in
mainline). Can you double check?

Thanks,
Nuno

[1] https://github.com/torvalds/linux/commit/de9e33bdfa22e607a88494ff21e9196d00bf4550
