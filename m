From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH 1/2] serdev: Add serdev_device_write subroutine
Date: Thu, 16 Mar 2017 07:23:16 -0700
Message-ID: <CAHQ1cqH4uz2GZLkis16ZusYAcVKp8dcbXe_hA-jg_v2UB1E2tg@mail.gmail.com>
References: <20170314134819.19476-1-andrew.smirnov@gmail.com>
 <20170314134819.19476-2-andrew.smirnov@gmail.com> <CAHp75VfWCCS6L1fFi0Gq0r-CTQbaLk8pos+NWz5R_b0uBt6K1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfWCCS6L1fFi0Gq0r-CTQbaLk8pos+NWz5R_b0uBt6K1w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Chris Healy <cphealy@gmail.com>, Guenter Roeck <linux@roeck-us.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 14, 2017 at 4:17 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Mar 14, 2017 at 3:48 PM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>> Add serdev_device_write() which is a blocking call allowing to transfer
>> arbitraty amount of data (potentially exceeding amount that
>> serdev_device_write_buf can process in a single call)
>
>> +int serdev_device_write(struct serdev_device *serdev,
>> +                       const unsigned char *buf, size_t count)
>> +{
>
>> +       int ret = count;
>
> If count by some reason bigger than INT_MAX...
>

True, I was merely copying type signature of serdev_device_write_buf,
which would have the same problem. I can add an appropriate check to
the code, but at the same time, I'd love to know why it wasn't a
concern in the latter function.

>> +
>> +       if (serdev->ops->write_wakeup)
>> +               return -EINVAL;
>> +
>> +       mutex_lock(&serdev->write_lock);
>> +
>> +       for (;;) {
>> +               size_t chunk;
>> +
>> +               reinit_completion(&serdev->write_wakeup);
>> +
>> +               chunk = serdev_device_write_buf(serdev, buf, count);
>
>
>> +               if (chunk < 0) {
>
> This will never happen. What kind of test did you try?
>

None of my code using that function ever hit that condition, OTOH, I
am not sure why I should ignore the API's signed return type, which I
assume is so in order to facilitate negative error returns. My
thinking is that even if in the current codebase is incapable of ever
returning negative result today, that doesn't mean it won't ever be,
and IMHO the chances of that are no different from the chances of
someone passing 'count' that is bigger than INT_MAX. Given that I'd
rather keep the check until the type signature of
serdev_device_write_buf changes.

>> +                       ret = chunk;
>> +                       goto done;
>> +               }
>
>
>> +
>> +               buf   += chunk;
>> +               count -= chunk;
>> +
>
>> +               if (!count)
>
> What is supposed to be returned? Initial count? Does it make any sense?
>

That part of this code is not very well thought out. I think returning
number of bytes successfully written would make more sense. I'll
change it to do that in v2, but I am open to suggestions.

>> +                       break;
>
> Perhaps you need to refactor this function.
>
>> +
>> +               wait_for_completion(&serdev->write_wakeup);
>> +       }
>
>> +done:
>
> It would be nice to have a suffix, like
>
> done_unlock:
>
>
> But I'm pretty sure if you refactor the code in a smart way you will
> not need it.
>

Yeah, I agree, it should be possible to make that loop more concise.
I'll give it a try in v2.

>> +       mutex_unlock(&serdev->write_lock);
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(serdev_device_write);
>
>>  /**
>>   * struct serdev_device - Basic representation of an serdev device
>> - * @dev:       Driver model representation of the device.
>> - * @nr:                Device number on serdev bus.
>> - * @ctrl:      serdev controller managing this device.
>> - * @ops:       Device operations.
>> + * @dev:        Driver model representation of the device.
>> + * @nr:                 Device number on serdev bus.
>> + * @ctrl:       serdev controller managing this device.
>> + * @ops:        Device operations.
>
> Does it make sense to shift? I would think of shorter field names instead.

I can see how that might make the diff look nice, but OTOH, I'd rather
not limit myself to only ~4 letters.

>
>> + * @write_wakeup Completion used by serdev_device_write internally
>
> Colon is missed.
>
> Another filed is missed.

Yep, thank you, will fix in v2.

>
>>   */
>>  struct serdev_device {
>>         struct device dev;
>>         int nr;
>>         struct serdev_controller *ctrl;
>>         const struct serdev_device_ops *ops;
>> +       struct completion write_wakeup;
>> +       struct mutex write_lock;
>>  };
>>
>>  static inline struct serdev_device *to_serdev_device(struct device *d)
>> @@ -162,10 +165,13 @@ static inline void serdev_controller_write_wakeup(struct serdev_controller *ctrl
>>  {
>>         struct serdev_device *serdev = ctrl->serdev;
>>
>> -       if (!serdev || !serdev->ops->write_wakeup)
>> +       if (!serdev)
>>                 return;
>>
>> -       serdev->ops->write_wakeup(serdev);
>> +       if (serdev->ops->write_wakeup)
>> +               serdev->ops->write_wakeup(serdev);
>> +       else
>> +               complete(&serdev->write_wakeup);
>
> By the way does this changes the possible context of application
> (atomic / non-atomic)?

It should be possible to call complete() in atomic context, so I don't
think it does.

>
> --
> With Best Regards,
> Andy Shevchenko
