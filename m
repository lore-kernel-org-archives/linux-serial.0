From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3] serdev: Add serdev_device_write subroutine
Date: Fri, 31 Mar 2017 11:38:22 -0500
Message-ID: <CAL_JsqLE-+P5W3YmzDR-s++qCMijaspGFpzQYuz=2=_2ny6ubw@mail.gmail.com>
References: <20170330220035.26649-1-andrew.smirnov@gmail.com>
 <CAL_Jsq+W3UcmmRNuTALczAHCO_wHTDcDz4jXBJgJeB0X-3oGBA@mail.gmail.com> <CAHp75VdPg3K2+TYN7UTKi3aiq5NVn4gRnM+SwpE9uYwO89G_bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdPg3K2+TYN7UTKi3aiq5NVn4gRnM+SwpE9uYwO89G_bQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Guenter Roeck <linux@roeck-us.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 31, 2017 at 9:35 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Mar 31, 2017 at 4:22 PM, Rob Herring <robh@kernel.org> wrote:
>> On Thu, Mar 30, 2017 at 5:00 PM, Andrey Smirnov
>> <andrew.smirnov@gmail.com> wrote:
>
>>> +int serdev_device_write(struct serdev_device *serdev,
>>> +                       const unsigned char *buf, size_t count,
>>> +                       unsigned long timeout)
>>>  {
>>>         struct serdev_controller *ctrl = serdev->ctrl;
>>> +       int ret;
>>>
>>> +       if (!ctrl || !ctrl->ops->write_buf ||
>>> +           (timeout && !serdev->ops->write_wakeup))
>>>                 return -EINVAL;
>>>
>>> +       mutex_lock(&serdev->write_lock);
>>> +       do {
>>> +               reinit_completion(&serdev->write_comp);
>>> +
>>> +               ret = ctrl->ops->write_buf(ctrl, buf, count);
>>> +               if (ret < 0)
>>> +                       break;
>>> +
>>> +               buf += ret;
>>> +               count -= ret;
>>> +
>>> +       } while (count &&
>>> +                (timeout = wait_for_completion_timeout(&serdev->write_comp,
>>> +                                                       timeout)));
>>
>> Need to test for timeout < 0 here and return timeout when < 0.
>
> It can't be the case since the variable is of unsigned type.

Oh right, that's only the interruptible version. NM

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
