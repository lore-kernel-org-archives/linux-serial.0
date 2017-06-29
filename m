From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 00/10] serial/gpio: exar: Fixes and support for IOT2000
Date: Thu, 29 Jun 2017 14:43:38 +0300
Message-ID: <CAHp75VfGLEXirr7sPX37rSxfpax7XYWoxWMR3moCNy7hzKRuww@mail.gmail.com>
References: <cover.1497033197.git.jan.kiszka@siemens.com> <CACRpkdZYSFTa63BF5u-J=pu2XwUbVZiQGAtZybhjQno6vVbe=g@mail.gmail.com>
 <9520074b-3731-7bbe-d59d-cbed90ac16bb@siemens.com> <CACRpkdbNPnNbk_r0NWEs4e7PuKmMf9KTjeRPRnxTOHuK-+ki2Q@mail.gmail.com>
 <c0a29540-7946-4e95-1b59-3a2f478757da@siemens.com> <d52a1a65-842c-9c73-17f7-5574fcefab2a@siemens.com>
 <CACRpkdZ1atVQLuDio6PVk4Xg+DUBDt2F2OH+2UjVkue8rKNbcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZ1atVQLuDio6PVk4Xg+DUBDt2F2OH+2UjVkue8rKNbcA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Jun 29, 2017 at 12:51 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Fri, Jun 23, 2017 at 10:09 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> On 2017-06-21 08:29, Jan Kiszka wrote:

>> http://git.kiszka.org/?p=linux.git;a=shortlog;h=refs/heads/queues/gpio-iot2000
>>
>> If you want me to resend anything, just let me know. Would be great to
>> have the remaining pieces lined up in time for the next merge window.
>
> I could just pull it in, but then I want a clear indication that Greg and
> say Andy are happy with this.

All patches that have my tag already are good from my point of view.
The rest, i.e.
"platform: Accept const properties", needs a slightly more attention.

This one on one hand does the right thing, though I would like to hear
Mika on this.

We still have platform_device_info and mfd_cell that doesn't define
the properties with const.
(I believe they should, though is it matter of this patch?)

P.S. I have looked at the current state of the use of the API in
question and rather agree with the patch, thus

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
