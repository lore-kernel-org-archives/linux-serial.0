From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] serdev: Restore serdev_device_write_buf for atomic
 context
Date: Wed, 17 May 2017 13:38:40 +0200
Message-ID: <8a24cad2-26d7-3394-509a-a0c038345d13@i2se.com>
References: <1493380041-14710-1-git-send-email-stefan.wahren@i2se.com>
 <20170502090638.GB2973@localhost>
 <CAL_Jsq+QOv6G2EFX8RpE1gk2S9M5VrndwQNNCjM0GqZ+2PXz3A@mail.gmail.com>
 <20170502131854.GA17710@localhost>
 <b62674e7-5c50-585b-eade-7cef0a400d02@i2se.com>
 <CAL_JsqLCiyU8kU2NaLQRz9aS-k7TNr3Tf45Wt3H3DuSyMAuvDg@mail.gmail.com>
 <20170508151858.GB30445@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170508151858.GB30445@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Andy Shevchenko <andy.shevchenko@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Greg,

Am 08.05.2017 um 17:18 schrieb Johan Hovold:
> On Thu, May 04, 2017 at 03:32:53PM -0500, Rob Herring wrote:
>> On Thu, May 4, 2017 at 11:22 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>>> Am 02.05.2017 um 15:18 schrieb Johan Hovold:
>>>> On Tue, May 02, 2017 at 07:41:34AM -0500, Rob Herring wrote:
>>>>> On Tue, May 2, 2017 at 4:06 AM, Johan Hovold <johan@kernel.org> wrote:
>>>>>> On Fri, Apr 28, 2017 at 01:47:21PM +0200, Stefan Wahren wrote:
>>>>>>> Starting with commit 6fe729c4bdae ("serdev: Add serdev_device_write
>>>>>>> subroutine") the function serdev_device_write_buf cannot be used in
>>>>>>> atomic context anymore (mutex_lock is sleeping). So restore the old
>>>>>>> behavior.
>>>>>> Yeah, preventing use in atomic context seems unnecessary, although any
>>>>>> clients writing must now deal with serialisation themselves (as before,
>>>>>> and as they should).
>>>>> We could just remove the mutex for serdev_device_write and always make
>>>>> the client responsible for serialization.
>>>> That sounds reasonable.
>>> So it's unwanted to have 2 write functions (non-atomic, atomic)?
>> No, it's unwanted to have more than we need.
>>
>> Looking closer, we'd also have to ensure the wait for completion is
>> not called also. So probably better to just leave it as you have done
>> it.
> Indeed. Sorry if my reply above was unclear on that point (i.e. that
> Stefan's patch is still needed regardless of whether we keep the mutex
> or not).
>
> Thanks,
> Johan

are you okay with this patch and can you please apply it?

Stefan
