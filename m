From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v13 1/2] serial: exar: split out the exar code from 8250_pci
Date: Sat, 4 Feb 2017 16:51:10 +0200
Message-ID: <CAHp75VcZD0VS2PKC18RtV90qLkqATgjxWSoZoLti=J+ajGKrdA@mail.gmail.com>
References: <1485815302-5708-1-git-send-email-sudipm.mukherjee@gmail.com>
 <d77cf226-a1bc-0f55-9f2b-af6a97f2f74b@siemens.com> <5894F6A2.5000609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5894F6A2.5000609@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 3, 2017 at 11:31 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> On Friday 03 February 2017 02:02 PM, Jan Kiszka wrote:
>> On 2017-01-30 23:28, Sudip Mukherjee wrote:


>>> @@ -0,0 +1,396 @@
>>> +/*
>>> + *  Probe module for 8250/16550-type Exar chips PCI serial ports.
>>> + *
>>> + *  Based on drivers/tty/serial/8250/8250_pci.c,
>>> + *
>>> + *  Copyright (C) 2017 Sudip Mukherjee, All Rights Reserved.
>>
>>
>> It's legally cleaner to carry over the copyright notice from the
>> original file, unless you rewrote everything (unlikely on first glance).
>> You may still add yours to the list for the significant contributions.
>
> Should i send a separate patch to modify those? Andy?

Please, do.

-- 
With Best Regards,
Andy Shevchenko
