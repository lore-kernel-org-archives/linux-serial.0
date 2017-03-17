From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH 1/2] serdev: Add serdev_device_write subroutine
Date: Fri, 17 Mar 2017 06:33:22 -0700
Message-ID: <CAHQ1cqE4m9jF_XvJcn64WEOzvrwhM3g6PHJEXmQOoX+6=UjV9g@mail.gmail.com>
References: <20170314134819.19476-1-andrew.smirnov@gmail.com>
 <20170314134819.19476-2-andrew.smirnov@gmail.com> <CAHp75VfWCCS6L1fFi0Gq0r-CTQbaLk8pos+NWz5R_b0uBt6K1w@mail.gmail.com>
 <CAHQ1cqH4uz2GZLkis16ZusYAcVKp8dcbXe_hA-jg_v2UB1E2tg@mail.gmail.com> <CAHp75Vd=bD6H3yLCtwtBcw+AxG-F6sWKvCqz3NwZ8+G-5gFcUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd=bD6H3yLCtwtBcw+AxG-F6sWKvCqz3NwZ8+G-5gFcUw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Chris Healy <cphealy@gmail.com>, Guenter Roeck <linux@roeck-us.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 16, 2017 at 8:09 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Mar 16, 2017 at 4:23 PM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>> On Tue, Mar 14, 2017 at 4:17 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Tue, Mar 14, 2017 at 3:48 PM, Andrey Smirnov
>>> <andrew.smirnov@gmail.com> wrote:
>
>>>> +int serdev_device_write(struct serdev_device *serdev,
>>>> +                       const unsigned char *buf, size_t count)
>>>> +{
>>>
>>>> +       int ret = count;
>>>
>>> If count by some reason bigger than INT_MAX...
>
>> True, I was merely copying type signature of serdev_device_write_buf,
>> which would have the same problem. I can add an appropriate check to
>> the code, but at the same time, I'd love to know why it wasn't a
>> concern in the latter function.
>
> Perhaps we may survive without changing it, just document that count
> should not be bigger than INT_MAX.
> OTOH it's counter intuitive to have size_t type which is used as int.
>
>>>> +       for (;;) {
>>>> +               size_t chunk;
>>>> +
>>>> +               reinit_completion(&serdev->write_wakeup);
>>>> +
>>>> +               chunk = serdev_device_write_buf(serdev, buf, count);
>>>
>>>
>>>> +               if (chunk < 0) {
>>>
>>> This will never happen. What kind of test did you try?
>
>> None of my code using that function ever hit that condition, OTOH, I
>> am not sure why I should ignore the API's signed return type, which I
>> assume is so in order to facilitate negative error returns. My
>> thinking is that even if in the current codebase is incapable of ever
>> returning negative result today, that doesn't mean it won't ever be,
>> and IMHO the chances of that are no different from the chances of
>> someone passing 'count' that is bigger than INT_MAX. Given that I'd
>> rather keep the check until the type signature of
>> serdev_device_write_buf changes.
>
> You missed the point
>
> size_t is *unsigned* type!
>

Ah! I did miss the point! Yes, that's a bug for sure, will fix in v2.
Good catch, thank you!

>>>> +               if (!count)
>>>
>>> What is supposed to be returned? Initial count? Does it make any sense?
>
>> I'll change it to do that in v2, but I am open to suggestions.
>
> Since function lacks of description (or I missed it?) I am out of
> knowledge what you are trying to achieve here.
>

There's a description of what I had in mind for this function in
commit message. It does need to be documented in the code, I agree.

Thanks,
Andrey Smirnov
