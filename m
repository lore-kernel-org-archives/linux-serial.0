From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v10 1/3] gpio: exar: add gpio for exar cards
Date: Fri, 20 Jan 2017 23:50:49 +0000
Message-ID: <5882A259.8050103@gmail.com>
References: <1484864602-5266-1-git-send-email-sudipm.mukherjee@gmail.com> <CAHp75VcSmfBrD+242ZZvm6v3D4D8cOOTHDZdmjLq-F_xQNciRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcSmfBrD+242ZZvm6v3D4D8cOOTHDZdmjLq-F_xQNciRw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Friday 20 January 2017 10:02 PM, Andy Shevchenko wrote:
> On Fri, Jan 20, 2017 at 12:23 AM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
>> From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>>
>> Exar XR17V352/354/358 chips have 16 multi-purpose inputs/outputs which
>> can be controlled using gpio interface.
>>
>> Add the gpio specific code.
>>
>
> Looks nice and clean!
>
> FWIW:
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Hi Linus,

It looks like the patch 2/3 will have one more revision. Do you want me 
to send this patch again as part of v11 series or will you take it in 
your tree and I send a v11 series of the remaining 2 patches?

Regards
Sudip
