From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v13 1/2] serial: exar: split out the exar code from 8250_pci
Date: Fri, 3 Feb 2017 16:08:18 +0200
Message-ID: <CAHp75VfDCVwd5Zim+dov4QtMBNyUGHP-HnmEHjKgWy7SsTBNag@mail.gmail.com>
References: <1485815302-5708-1-git-send-email-sudipm.mukherjee@gmail.com> <d77cf226-a1bc-0f55-9f2b-af6a97f2f74b@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d77cf226-a1bc-0f55-9f2b-af6a97f2f74b@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 3, 2017 at 4:02 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2017-01-30 23:28, Sudip Mukherjee wrote:
>> From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>>
>> Add the serial driver for the Exar chips. And also register the
>> platform device for the GPIO provided by the Exar chips.
>
> "Also" means you are doing two things in one patch - was this already
> discussed and accepted in previous review rounds? If so, ignore my
> comment, but I would have asked for two patches, one that just
> translates the existing code and another that adds this new feature.

Since it's already in Greg's tty-next, no point to fix anymore this
particular part.
However, you are right that few lines of code might be split to a
separate change.

>> +/*
>> + *  Probe module for 8250/16550-type Exar chips PCI serial ports.
>> + *
>> + *  Based on drivers/tty/serial/8250/8250_pci.c,
>> + *
>> + *  Copyright (C) 2017 Sudip Mukherjee, All Rights Reserved.
>
> It's legally cleaner to carry over the copyright notice from the
> original file, unless you rewrote everything (unlikely on first glance).
> You may still add yours to the list for the significant contributions.
>
> BTW, are you personally the copyright holder or your employer Codethink?
> Depends on your contractual situation, but the former is less common.

This is good comment and I think it needs to be addressed (as a
separate change due to above).

-- 
With Best Regards,
Andy Shevchenko
