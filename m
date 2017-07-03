From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PULL] serial/gpio: exar: Fixes and support for IOT2000
Date: Mon, 3 Jul 2017 10:10:32 +0200
Message-ID: <CACRpkda4v+2oQjYzGXsNZsUeJ8qwF30SLM3mL-JFyDnGiZdx8A@mail.gmail.com>
References: <cover.1497033197.git.jan.kiszka@siemens.com> <CACRpkdZYSFTa63BF5u-J=pu2XwUbVZiQGAtZybhjQno6vVbe=g@mail.gmail.com>
 <9520074b-3731-7bbe-d59d-cbed90ac16bb@siemens.com> <CACRpkdbNPnNbk_r0NWEs4e7PuKmMf9KTjeRPRnxTOHuK-+ki2Q@mail.gmail.com>
 <c0a29540-7946-4e95-1b59-3a2f478757da@siemens.com> <d52a1a65-842c-9c73-17f7-5574fcefab2a@siemens.com>
 <CACRpkdZ1atVQLuDio6PVk4Xg+DUBDt2F2OH+2UjVkue8rKNbcA@mail.gmail.com>
 <20170629144940.GD23512@kroah.com> <CACRpkdYEvc2De88sy-FWOOkU8-O4KwX00rLZ7dBk6H2H0Q0+LQ@mail.gmail.com>
 <5de2f417-02e2-b983-67bd-7d82232956b0@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <5de2f417-02e2-b983-67bd-7d82232956b0@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 3, 2017 at 9:21 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

> The following changes since commit 85bb4646f8908eb786dfa19a6bb2ff1423dc8aa4:
>
>   gpio: rcar: Add R8A7743 (RZ/G1M) support (2017-06-29 14:22:38 +0200)
>
> are available in the git repository at:
>
>   git://git.kiszka.org/linux.git queues/gpio-iot2000
>
> for you to fetch changes up to 413058df4331ce29f9934a5870d582c7e71fe15f:
>
>   serial: exar: Add support for IOT2040 device (2017-07-03 08:33:20 +0200)
>
> This corresponds to v6 of the series with additional review and ack
> tags.

Thanks Jan, pulled in for v4.13.

Also thanks for your tireless and gritty work in hashing this out
and get the right fix out there!

Yours,
Linus Walleij
