From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 00/10] serial/gpio: exar: Fixes and support for IOT2000
Date: Wed, 31 May 2017 02:01:19 +0200
Message-ID: <CACRpkdbxW7sRqNpkPCRFascE5-hJtyKAhZVK4s1Qq9=aM-k49Q@mail.gmail.com>
References: <cover.1495814557.git.jan.kiszka@siemens.com> <CACRpkdZzDmigd8X-VsJqHTQSMK6k+w+qbPH+N9qNY05pX8eifQ@mail.gmail.com>
 <835df887-2782-29f4-dfc9-a0fbbbb3019f@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <835df887-2782-29f4-dfc9-a0fbbbb3019f@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Mon, May 29, 2017 at 3:41 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2017-05-29 14:39, Linus Walleij wrote:

>> Should I merge them all? Should Greg merge them all?
>> Should one of us produce an immutable branch?
>
> Half of the patch are affecting both serial and GPIO subsystem, most
> have GPIO focus, though. Just patch 10 or more serial than GPIO. All in
> all, maybe Greg can ack and things can flow through the GPIO tree?

OK with me, let's see what Greg says.

Yours,
Linus Walleij
