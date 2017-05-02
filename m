From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] tty: serdev: fix serdev_device_write return value
Date: Tue, 2 May 2017 07:30:30 -0500
Message-ID: <CAL_Jsq+hz_MSUyZnSrNiCps44ZqpKxVqeW3kmVibjmCEweAHdw@mail.gmail.com>
References: <20170502001714.11576-1-robh@kernel.org> <20170502092527.GC2973@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170502092527.GC2973@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrey Smirnov <andrew.smirnov@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue, May 2, 2017 at 4:25 AM, Johan Hovold <johan@kernel.org> wrote:
> On Mon, May 01, 2017 at 07:17:14PM -0500, Rob Herring wrote:
>> Commit 6fe729c4bdae ("serdev: Add serdev_device_write subroutine")
>> provides a compatibility wrapper for the existing
>> serdev_device_write_buf, but it fails to return the number of bytes
>> written causing users to timeout.
>
> So this would also be fixed for serdev_device_write_buf() by Stefan
> Wahren's patch restoring that function implementation, but returning the
> amount written is perhaps desirable also for blocking writes for
> consistency reasons.

Yes, I saw it after I wrote this. We should apply both IMO.

>> Fixes: 6fe729c4bdae ("serdev: Add serdev_device_write subroutine")
>> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>  drivers/tty/serdev/core.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
>> index 433de5ea9b02..ccfe56355c4f 100644
>> --- a/drivers/tty/serdev/core.c
>> +++ b/drivers/tty/serdev/core.c
>> @@ -127,7 +127,7 @@ int serdev_device_write(struct serdev_device *serdev,
>>                       unsigned long timeout)
>>  {
>>       struct serdev_controller *ctrl = serdev->ctrl;
>> -     int ret;
>> +     int ret, wr_cnt = 0;
>>
>>       if (!ctrl || !ctrl->ops->write_buf ||
>>           (timeout && !serdev->ops->write_wakeup))
>> @@ -143,12 +143,13 @@ int serdev_device_write(struct serdev_device *serdev,
>>
>>               buf += ret;
>>               count -= ret;
>> +             wr_cnt += ret;
>>
>>       } while (count &&
>>                (timeout = wait_for_completion_timeout(&serdev->write_comp,
>>                                                       timeout)));
>>
>>       mutex_unlock(&serdev->write_lock);
>> -     return ret < 0 ? ret : (count ? -ETIMEDOUT : 0);
>> +     return ret < 0 ? ret : (count ? -ETIMEDOUT : wr_cnt);
>
> That's some nasty use of the ternary operator. Ditching it completely
> would be more readable.
>
>         if (ret < 0)
>                 return ret;
>
>         if (count)
>                 return -ETIMEDOUT;
>
>         return wr_count;
>
> and here wr_count is the value of count passed to the function (and
> could just be stored on entry instead).

Okay.

I'll wait for Greg to apply Stefan's patch and respin on top of it.

Rob
