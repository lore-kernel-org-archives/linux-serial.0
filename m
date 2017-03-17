From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] serdev: Add serdev_device_write subroutine
Date: Fri, 17 Mar 2017 11:31:31 -0500
Message-ID: <CAL_JsqJG3=KiPASd4=yOLxC2CryBuZQPT4MPevXqQjBpdjzmXw@mail.gmail.com>
References: <20170314134819.19476-1-andrew.smirnov@gmail.com>
 <20170314134819.19476-2-andrew.smirnov@gmail.com> <CAL_JsqKxFBFz-SHRQaDS0P4P_emBVBpkQFb0jN3oH6WM99t59g@mail.gmail.com>
 <CAHQ1cqEb1vBX3dV2K9nmtV+7wTDFjAREJhViGWGp9HXB5VQDSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHQ1cqEb1vBX3dV2K9nmtV+7wTDFjAREJhViGWGp9HXB5VQDSw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>, Guenter Roeck <linux@roeck-us.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 16, 2017 at 8:33 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> On Wed, Mar 15, 2017 at 7:18 AM, Rob Herring <robh@kernel.org> wrote:
>> On Tue, Mar 14, 2017 at 8:48 AM, Andrey Smirnov
>> <andrew.smirnov@gmail.com> wrote:
>>> Add serdev_device_write() which is a blocking call allowing to transfer
>>> arbitraty amount of data (potentially exceeding amount that
>>> serdev_device_write_buf can process in a single call)
>>>
>>> Cc: cphealy@gmail.com
>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>> Cc: linux-serial@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>>> ---
>>>  drivers/tty/serdev/core.c | 37 +++++++++++++++++++++++++++++++++++++
>>>  include/linux/serdev.h    | 23 +++++++++++++++++------
>>>  2 files changed, 54 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
>>> index f4c6c90..759e834 100644
>>> --- a/drivers/tty/serdev/core.c
>>> +++ b/drivers/tty/serdev/core.c
>>> @@ -128,6 +128,41 @@ int serdev_device_write_buf(struct serdev_device *serdev,
>>>  }
>>>  EXPORT_SYMBOL_GPL(serdev_device_write_buf);
>>>
>>> +int serdev_device_write(struct serdev_device *serdev,
>>> +                       const unsigned char *buf, size_t count)
>>
>> _write vs. _write_buf are not all that clear what the difference is.
>> but I don't have a better name.
>>
>
> serdev_device_send?

send vs. write_buf? Still not that clear.

>> Perhaps a timeout param is needed? This could never complete if CTS
>> remains deasserted.
>
> Yeah, I think it is a good idea, I'll add that in v2.

Maybe just combine the 2 functions and a timeout of 0 follows the
original behavior of serdev_device_write_buf. I'm not sure if we could
handle write_wakeup in that case though.

Rob
