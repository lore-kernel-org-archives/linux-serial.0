From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v7 1/3] gpio: exar: add gpio for exar cards
Date: Mon, 09 Jan 2017 21:18:20 +0000
Message-ID: <5873FE1C.8060407@gmail.com>
References: <1483833469-11422-1-git-send-email-sudipm.mukherjee@gmail.com> <1483833469-11422-2-git-send-email-sudipm.mukherjee@gmail.com> <CACRpkdaBJteocVSUazhz0zYtXeBKSVekEkxGfpDNAoqN04A77Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdaBJteocVSUazhz0zYtXeBKSVekEkxGfpDNAoqN04A77Q@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Monday 09 January 2017 10:35 AM, Linus Walleij wrote:
> On Sun, Jan 8, 2017 at 12:57 AM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
>
>> Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs which
>> can be controlled using gpio interface.
>>
>> Add the gpio specific code.
>>
>> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>
> Will I be able to merge this independently to the GPIO trees
> once we are done with review? (Looks like so...)

Yes, there should not be any dependency on the tty.

>
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> Is this really useful?

no, initially I used pr_*, but then that was converted to dev_*.

>
>> +#include <linux/device.h>
>> +#include <linux/gpio.h>
>
> No use:
> #include <linux/gpio/driver.h>
> ONLY
>
>> +static LIST_HEAD(exar_list);
>> +static DEFINE_MUTEX(exar_list_mtx);
>> +DEFINE_IDA(ida_index);
>
> What is this? A local list? I can understand the IDA index but in
> general, follow the state container pattern instead:
> Documentation/driver-model/design-patterns.txt

The local list is not doing anything now, after I have moved to using 
ida. But I will need the ida_index here to have the device number incase 
of multiple devices.

regards
sudip
