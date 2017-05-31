From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 2/9] gpio-exar/8250-exar: Do not even instantiate a
 GPIO device for Commtech cards
Date: Wed, 31 May 2017 21:02:27 +0300
Message-ID: <CAHp75VcGeF4NTB=gGBvg2rsQe=z_TvOPbWidmpDR5gauDa=G6Q@mail.gmail.com>
References: <cover.1496127684.git.jan.kiszka@siemens.com> <f7e7da1ae81aab7f53faa32260d4ee0f930048fe.1496127684.git.jan.kiszka@siemens.com>
 <CAHp75Vc0t5t8O5cPaxX_oQJQKsN3OWNFfqnA_K3GW4qpfY+N5Q@mail.gmail.com> <6ded8dab-caec-70e3-daf0-16622f89970a@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6ded8dab-caec-70e3-daf0-16622f89970a@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Wed, May 31, 2017 at 7:34 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2017-05-30 20:33, Andy Shevchenko wrote:
>> On Tue, May 30, 2017 at 10:01 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>> Commtech adapters need the MPIOs for internal purposes, and the
>>> gpio-exar driver already refused to pick them up. But there is actually
>>> no point in even creating the underlying platform device.
>>
>> It still feels that partially you may do stuff here, like
>> renaming to
>> __xr17v35x_register_gpio()
>> and creating
>> xr17v35x_register_gpio() wrapper.
>
> Sorry, that remains unrelated to the topic of this patch and would be
> unclean. If you want me to pull those refactorings out of patch 9, I
> need to write a separate patch - no problem.

Okay, I would go with separate patch, if maintainers are okay with
this approach.

-- 
With Best Regards,
Andy Shevchenko
