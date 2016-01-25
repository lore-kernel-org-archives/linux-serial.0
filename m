From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 1/3] printk: make preferred_console local static bool
Date: Mon, 25 Jan 2016 08:14:55 -0800
Message-ID: <56A649FF.1070505@hurleysoftware.com>
References: <1453722324-22407-1-git-send-email-aleksey.makarov@linaro.org>
 <1453722324-22407-2-git-send-email-aleksey.makarov@linaro.org>
 <1453725901.28952.53.camel@perches.com> <56A61A6F.10409@linaro.org>
 <1453728205.28952.62.camel@perches.com> <56A62314.3020803@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56A62314.3020803@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, Joe Perches <joe@perches.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>
List-Id: linux-serial@vger.kernel.org

On 01/25/2016 05:28 AM, Aleksey Makarov wrote:
> 
> 
> On 25.01.2016 19:23, Joe Perches wrote:
>> On Mon, 2016-01-25 at 18:51 +0600, Aleksey Makarov wrote:
>>>
>>> On 25.01.2016 18:45, Joe Perches wrote:
>>>> On Mon, 2016-01-25 at 17:45 +0600, Aleksey Makarov wrote:
>>>>> The variable preferred_console is used only inside register_console()
>>>>> and it's semantics is boolean.  Make it clear.
>>>>
>>>> This loses the index of the preferred console.
>>>> I'm not sure this is better.
>>>
>>> That index is not used anywhere.  I believe the patch makes things clear.
>>
>> Well, with this change the name and its use
>> is a bit misleading.  Maybe changing it to
>> something like use_selected_console is better.
> 
> Thank you. I will fix this in the next version.

Ideally, the transform should be

 preferred_console => has_preferred
 selected_console => preferred_console

This would match the actual use of add_preferred_console()

Regards,
Peter Hurley
