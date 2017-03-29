From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] serdev: Replace serdev_device_write_buf with serdev_device_write
Date: Wed, 29 Mar 2017 16:25:06 -0500
Message-ID: <CAL_Jsq+e6jVko66vj+gM1GOUi_gaiwvj=DJRDMJFTJoo64uS8g@mail.gmail.com>
References: <20170328160139.7739-1-andrew.smirnov@gmail.com>
 <CAHp75VdHWE6jK12Q=2wGV-J5eCYWiAWnLFwz2r8AcJJQvAaztA@mail.gmail.com> <CAHQ1cqG8jD-aaoD2=jqierhx5+WfgqGQiO9b8qz2uzJyWxTPdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHQ1cqG8jD-aaoD2=jqierhx5+WfgqGQiO9b8qz2uzJyWxTPdQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Chris Healy <cphealy@gmail.com>, Guenter Roeck <linux@roeck-us.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 29, 2017 at 9:16 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> On Tue, Mar 28, 2017 at 10:07 AM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Tue, Mar 28, 2017 at 7:01 PM, Andrey Smirnov
>> <andrew.smirnov@gmail.com> wrote:
>>> Convert serdev_device_write_buf's code to be able to transfer amount of
>>> data potentially exceeding "write room" at the moment of invocation.
>>>
>>> To support that, also add serdev_device_write_wakeup.
>>>
>>> Drivers wanting to use full extent of serdev_device_write
>>> functionality are expected to provide serdev_device_write_wakeup as a
>>> sole handler of .write_wakeup event or call it as a part of driver's
>>> custom .write_wakeup code.
>>>
>>> Drivers wanting to retain old serdev_device_write_buf behaviour can
>>
>>> replace those call to calls to serdev_device_write with timeout of
>>> 0. Providing .write_wakeup handler in such case is optional.
>>
>> Some indentation would be better if, for example, 0 will be kept on
>> previous line.
>>
>
> OK, sure.
>
>> So, what I would see if no one objects is patch series of two:
>> 1) introduction of new API
>> 2) removing old one.
>>
>> It will benefit for easier review and any potential code anthropologist.
>>
>
> Second version of the patch preserves the old API an just
> re-implements it in terms of a new one. I am not sure I see the
> benefit in splitting it into two patches, but I'll leave it up to Rob
> to decide.

I think it is fine as-is, but maybe the subject now is a bit misleading.

>>> --- a/drivers/tty/serdev/core.c
>>> +++ b/drivers/tty/serdev/core.c
>>> @@ -116,17 +116,41 @@ void serdev_device_close(struct serdev_device *serdev)
>>>  }
>>>  EXPORT_SYMBOL_GPL(serdev_device_close);
>>>
>>> -int serdev_device_write_buf(struct serdev_device *serdev,
>>> -                           const unsigned char *buf, size_t count)
>>> +void serdev_device_write_wakeup(struct serdev_device *serdev)
>>> +{
>>> +       complete(&serdev->write_comp);
>>> +}
>>> +EXPORT_SYMBOL_GPL(serdev_device_write_wakeup);
>>> +
>>> +int serdev_device_write(struct serdev_device *serdev,
>>> +                       const unsigned char *buf, size_t count,
>>> +                       unsigned long timeout)
>>>  {
>>>         struct serdev_controller *ctrl = serdev->ctrl;
>>> +       int ret;
>>>
>>> -       if (!ctrl || !ctrl->ops->write_buf)
>>> +       if (!ctrl || !ctrl->ops->write_buf ||
>>> +           (timeout && !serdev->ops->write_wakeup))
>>>                 return -EINVAL;
>>>
>>> -       return ctrl->ops->write_buf(ctrl, buf, count);
>>> +       mutex_lock(&serdev->write_lock);
>>> +       do {
>>> +               reinit_completion(&serdev->write_comp);
>>> +
>>> +               ret = ctrl->ops->write_buf(ctrl, buf, count);
>>> +               if (ret < 0)
>>> +                       break;
>>> +
>>
>>> +               buf   += ret;
>>
>> Extra white spaces.
>
> Which is there on purpose to re-align "+=" with "-=" on the next line.
> I'll remove it.
>
>>
>>> +               count -= ret;
>>> +
>>
>>> +       } while (count &&
>>> +                (timeout = wait_for_completion_timeout(&serdev->write_comp,
>>> +                                                       timeout)));
>>
>> So, would it be better to support interrupts here and return a
>> corresponding error code to the user?
>>
>
> I don't have a use-case for that and as far as I can tell, neither SPI
> nor I2C slave device API offer such functionality universally, so I am
> inclined to say no. Since the change from wait_for_completion to
> wait_for_completion_timeout was made per Rob's request, I'd leave it
> up to him to decided about this change as well.

Honestly, I don't know. It's added easily enough if needed later.

Rob
