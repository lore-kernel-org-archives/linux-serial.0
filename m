From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: RFC: out-of-tree tty driver breakage (changing ASYNC_ bits)
Date: Tue, 28 Jun 2016 15:54:49 +0000 (UTC)
Message-ID: <nku6k9$1n3$2@ger.gmane.org>
References: <5692D054.7050203@hurleysoftware.com>
 <20160111044204.GB12741@kroah.com> <n70j5g$sem$1@ger.gmane.org>
 <5693D72D.6050501@hurleysoftware.com> <nku5nh$1n3$1@ger.gmane.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2016-06-28, Grant Edwards <grant.b.edwards@gmail.com> wrote:
> On 2016-01-11, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 01/11/2016 07:53 AM, Grant Edwards wrote:
>>> On 2016-01-11, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>> On Sun, Jan 10, 2016 at 01:42:44PM -0800, Peter Hurley wrote:
>>>>
>>>>> This will break out-of-tree drivers but I don't really see a
>>>>> realistic alternative. Also, I think the new symbol prefix ASY_ isn't
>>>>> great and I'd like to get some suggestions.
>>>>
>>>> Don't worry about breaking out-of-tree drivers, that's fine.
>>> 
>>> One request from this maintainer of several out-of-tree drivers: if
>>> you break something, break it such that it won't compile.  It would be
>>> nice to avoid changes that break functionality but still compile
>>> without warning.
>>
>> I was in the process of writing how I can't remove
>> ASYNC_INITIALIZED, et.al from the uapi header, when I realized that
>> I can just guard them with #ifndef _KERNEL_ which will trigger the
>> requisite out-of-tree build break.

> You know that _KERNEL_ is defined when when compiling kernel-space
> code (either in-tree or out-of-tree), right?

Ignore that.  I missed the 'n' in #ifndef.  My driver build should
fail due to ASYNC_INITIALIZED being undefined, but it isn't.  :/

For some reason _KERNEL_ is not defined when my module is being
compiled....

-- 
Grant Edwards               grant.b.edwards        Yow! JAPAN is a WONDERFUL
                                  at               planet -- I wonder if we'll
                              gmail.com            ever reach their level of
                                                   COMPARATIVE SHOPPING ...
