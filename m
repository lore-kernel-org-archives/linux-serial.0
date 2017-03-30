From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v2] serdev: Replace serdev_device_write_buf with serdev_device_write
Date: Thu, 30 Mar 2017 05:40:23 -0700
Message-ID: <CAHQ1cqEsmLGjb8UpbCHSfEC31f0OFmcFayBuPWMANyjUJSb+=A@mail.gmail.com>
References: <20170328160139.7739-1-andrew.smirnov@gmail.com>
 <CAHp75VdHWE6jK12Q=2wGV-J5eCYWiAWnLFwz2r8AcJJQvAaztA@mail.gmail.com>
 <CAHQ1cqG8jD-aaoD2=jqierhx5+WfgqGQiO9b8qz2uzJyWxTPdQ@mail.gmail.com> <CAHp75Vc4HPSnw6XtUO3Sq3hMQFtaGvK2TmvnWX2q5B=ixBjiig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vc4HPSnw6XtUO3Sq3hMQFtaGvK2TmvnWX2q5B=ixBjiig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Chris Healy <cphealy@gmail.com>, Guenter Roeck <linux@roeck-us.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 29, 2017 at 7:43 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Mar 29, 2017 at 5:16 PM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>> On Tue, Mar 28, 2017 at 10:07 AM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Tue, Mar 28, 2017 at 7:01 PM, Andrey Smirnov
>>> <andrew.smirnov@gmail.com> wrote:
>
>>> So, what I would see if no one objects is patch series of two:
>>> 1) introduction of new API
>>> 2) removing old one.
>>>
>>> It will benefit for easier review and any potential code anthropologist.
>>>
>>
>> Second version of the patch preserves the old API an just
>> re-implements it in terms of a new one. I am not sure I see the
>> benefit in splitting it into two patches, but I'll leave it up to Rob
>> to decide.
>
> Sure. At least I posted benefits I see from splitting.
>
> + bisectability (in case we have to revert your new API by some reason
> it will be easier, hope will be not the case, though...)
>
>>>> +       } while (count &&
>>>> +                (timeout = wait_for_completion_timeout(&serdev->write_comp,
>>>> +                                                       timeout)));
>>>
>>> So, would it be better to support interrupts here and return a
>>> corresponding error code to the user?
>>>
>>
>> I don't have a use-case for that and as far as I can tell, neither SPI
>> nor I2C slave device API offer such functionality universally, so I am
>> inclined to say no. Since the change from wait_for_completion to
>> wait_for_completion_timeout was made per Rob's request, I'd leave it
>> up to him to decided about this change as well.
>
> OK.
>
>>> Besides that question, readability might be better if you use
>>> temporary variable and pack above on one line:
>>>
>>> unsigned long to = timeout;
>>>
>>> } while (count && (to = ...(to)));
>>>
>>
>> Even if you shorten 'timeout' to 'to', formatted as a single line,
>> it'd still exceed line length limitations.
>
> How many? If we are talking about 2-3 characters, that's okay to leave
> them on one line.

Even so, at this point we are definitely in "personal preference"
territory and I'd rather avoid line wrapping.

>
>>>> + * @write_lock Mutext used to esure exclusive access to the bus when
>>>> + *             writing data with serdev_device_write()
>>>
>>> checkpatch.pl has integrated spellchecker AFAIU.
>>
>> My bad, forgot to enable it as a git hook, will fix.
>>
>>> Moreover, can you try harder to make that description shorter?
>>>
>>
>> I am all ears for suggestions alternative phrasing, otherwise, no,
>> that's about as hard as I try.
>
> First of all, "used to" is (closer) equivalent to was.
> Second, Mutex is one letter longer than Lock (here is important that
> is just a kind of lock).
> Third, "exclusive" is implied by Mutex / Lock word.
> Fourth, "access to the bus when writing data" too verbose.
>
> So, my suggestion is (two variants):
> a) "Lock to serialize bus access when writing data."
> b) "Lock to serialize access when writing data with serdev_device_write()."
>

I'll use option "a". Option "b" still exceeds line limit, and I'd
rather not have that.

Thanks,
Andrey Smirnov
