From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2 6/6] serial: exar: Add support for IOT2040 device
Date: Mon, 22 May 2017 18:40:08 +0200
Message-ID: <494f2b9e-3f74-36ad-5e1f-1d13862bf006@siemens.com>
References: <cover.1495119548.git.jan.kiszka@siemens.com>
 <f0d2245527bc5700be7a4ac707a81db798cb5519.1495119548.git.jan.kiszka@siemens.com>
 <CACRpkdbeXdOWiYpmtQTU1B66mxq1gGpukZWvUepgzNk5LLa1PQ@mail.gmail.com>
 <5aaf3441-2cbb-fc9e-6df3-80b62fc044f8@siemens.com>
 <CAHp75Ve-Y3VrjrAOOMkEs4OkAGG-EFJY=FhGmsi8ryL-dNZXUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAHp75Ve-Y3VrjrAOOMkEs4OkAGG-EFJY=FhGmsi8ryL-dNZXUw@mail.gmail.com>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Courbot <gnurou@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

On 2017-05-22 18:34, Andy Shevchenko wrote:
> On Mon, May 22, 2017 at 7:28 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> On 2017-05-22 17:46, Linus Walleij wrote:
>>> On Thu, May 18, 2017 at 4:59 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> 
>> This patch has to come last. It depends on patch 5, e.g., and that has
>> dependencies as well.
> 
> Btw, what about patch 1? I thought it might be shifted close to the
> end of the series.

Why? Patch 1 is the first step to fix the gpio-exar driver breakages.

But maybe I should split up those fixes and cleanups from the
preparations and enabling of the IOT2000.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
