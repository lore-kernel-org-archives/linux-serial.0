From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v4 2/9] gpio-exar/8250-exar: Do not even instantiate a
 GPIO device for Commtech cards
Date: Wed, 31 May 2017 18:34:16 +0200
Message-ID: <6ded8dab-caec-70e3-daf0-16622f89970a@siemens.com>
References: <cover.1496127684.git.jan.kiszka@siemens.com>
 <f7e7da1ae81aab7f53faa32260d4ee0f930048fe.1496127684.git.jan.kiszka@siemens.com>
 <CAHp75Vc0t5t8O5cPaxX_oQJQKsN3OWNFfqnA_K3GW4qpfY+N5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vc0t5t8O5cPaxX_oQJQKsN3OWNFfqnA_K3GW4qpfY+N5Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On 2017-05-30 20:33, Andy Shevchenko wrote:
> On Tue, May 30, 2017 at 10:01 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> Commtech adapters need the MPIOs for internal purposes, and the
>> gpio-exar driver already refused to pick them up. But there is actually
>> no point in even creating the underlying platform device.
> 
> It still feels that partially you may do stuff here, like
> renaming to
> __xr17v35x_register_gpio()
> and creating
> xr17v35x_register_gpio() wrapper.

Sorry, that remains unrelated to the topic of this patch and would be
unclean. If you want me to pull those refactorings out of patch 9, I
need to write a separate patch - no problem.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
