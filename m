From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 5/8] gpio: exar: Fix reading of directions and values
Date: Thu, 18 May 2017 13:23:33 +0300
Message-ID: <CAHp75VdsL_bT-HN3yHxNwQTMfJnfDc1EPEmn+ARZSvZDts7W6g@mail.gmail.com>
References: <cover.1494660546.git.jan.kiszka@siemens.com> <1891081c09747965173fb03a7305e1c73033dac0.1494660546.git.jan.kiszka@siemens.com>
 <CAHp75Vdxoro-FoJY-t+FVk_9J6OBZMhJ9P9qjhq5a2bMOJMW9A@mail.gmail.com>
 <88c38a4c-f275-28d3-694e-e3089e56062e@siemens.com> <CAHp75Ve3wA6AUTRA7RwFVBS=w5ntdwak+mTJN5tE_n7oW+JQvw@mail.gmail.com>
 <160112c1-c80b-5b1b-6e54-4b3c22f554b6@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <160112c1-c80b-5b1b-6e54-4b3c22f554b6@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On Thu, May 18, 2017 at 1:16 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2017-05-18 12:11, Andy Shevchenko wrote:
>> On Thu, May 18, 2017 at 8:20 AM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

>> Full picture:
>>
>>  val = exar_get(chip, addr) & BIT(offset % 8);
>>
>>  return !!val;
>>
>> How it could be non-(1 or 0)?
>>
>
> Right - but what is the point of that other style?

gpio-exar.c is just 4th module which is using it, OTOH the rest of
GPIO drivers are using return !!val style.


-- 
With Best Regards,
Andy Shevchenko
