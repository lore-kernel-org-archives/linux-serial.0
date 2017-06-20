From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6 00/10] serial/gpio: exar: Fixes and support for IOT2000
Date: Tue, 20 Jun 2017 13:38:28 +0200
Message-ID: <CACRpkdbNPnNbk_r0NWEs4e7PuKmMf9KTjeRPRnxTOHuK-+ki2Q@mail.gmail.com>
References: <cover.1497033197.git.jan.kiszka@siemens.com> <CACRpkdZYSFTa63BF5u-J=pu2XwUbVZiQGAtZybhjQno6vVbe=g@mail.gmail.com>
 <9520074b-3731-7bbe-d59d-cbed90ac16bb@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9520074b-3731-7bbe-d59d-cbed90ac16bb@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 20, 2017 at 10:54 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2017-06-20 10:19, Linus Walleij wrote:
>> On Fri, Jun 9, 2017 at 8:33 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>>> This makes the gpio-exar driver usable, which was prevented by a number
>>> of fatal bugs, and adds support for the SIMATIC IOT2040 to the 8250-exar
>>> driver and, indirectly, to gpio-exar as well. It's a cross-subsystem
>>> series, so I'm also cross-posting to the serial and gpio lists.
>>>
>>> Changes in v6:
>>
>> I merged some of the patches, that applied. Let's see if they survive
>> in linux-next, else I guess we need to fix this in the -rcs or for the next
>> kernel cycle.
>
> Weird that things did not apply. I just did a cherry-pick for all those
> 10 patches on top of 5c996b7eb52c, and that went smoothly. Please let me
> know which baseline is needed, and I will rebase.

This was on the "devel" branch of my GPIO tree:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=devel

Yours,
Linus Walleij
