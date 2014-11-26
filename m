From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH V2 01/10] tty: Fallback to use dynamic major number
Date: Wed, 26 Nov 2014 09:34:20 -0500
Message-ID: <5475E4EC.7090309@hurleysoftware.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>	<1415825647-6024-2-git-send-email-cernekee@gmail.com>	<20141125203431.GA9385@kroah.com>	<CAJiQ=7DOxK2NzmC9gGsnARxGMN8wRQyGX+5u5YC_vt00ADVsDg@mail.gmail.com> <20141126133306.659E9C4099B@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:42144 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbaKZOeY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Nov 2014 09:34:24 -0500
Received: by mail-qa0-f49.google.com with SMTP id s7so1937982qap.22
        for <linux-serial@vger.kernel.org>; Wed, 26 Nov 2014 06:34:23 -0800 (PST)
In-Reply-To: <20141126133306.659E9C4099B@trevor.secretlab.ca>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>, Kevin Cernekee <cernekee@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, daniel@zonque.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, tushar.b@samsung.com

On 11/26/2014 08:33 AM, Grant Likely wrote:
> On Tue, 25 Nov 2014 15:37:16 -0800
> , Kevin Cernekee <cernekee@gmail.com>
>  wrote:
>> On Tue, Nov 25, 2014 at 12:34 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>> On Wed, Nov 12, 2014 at 12:53:58PM -0800, Kevin Cernekee wrote:
>>>> From: Tushar Behera <tushar.behera@linaro.org>
>>>
>>> This email bounces, so I'm going to have to reject this patch.  I can't
>>> accept a patch from a "fake" person, let alone something that touches
>>> core code like this.
>>>
>>> Sorry, I can't accept anything in this series then.
>>
>> Oops, guess I probably should have updated his address after the V1
>> emails bounced...
>>
>> Before I send a new version, what do you think about the overall
>> approach?  Should we try to make serial8250 coexist with the other
>> "ttyS / major 4 / minor 64" drivers (possibly at the expense of
>> compatibility) or is it better to start with a simpler, cleaner driver
>> like serial/pxa?
> 
> Co-existing really needs to be fixed.

What are the requirements for co-existence?
Is it sufficient to provide 1st come-1st served minor allocation?

Anything done should be designed to solve this name problem forever,
not some expeditious band-aid.
