From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH V2 01/10] tty: Fallback to use dynamic major number
Date: Thu, 27 Nov 2014 13:50:01 +0000
Message-ID: <CACxGe6uLWZav=AfaK2w17PW6vtxF8S0=OUvCMB-uFSvhs2cLtw@mail.gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
 <1415825647-6024-2-git-send-email-cernekee@gmail.com> <20141125203431.GA9385@kroah.com>
 <CAJiQ=7DOxK2NzmC9gGsnARxGMN8wRQyGX+5u5YC_vt00ADVsDg@mail.gmail.com>
 <20141126133306.659E9C4099B@trevor.secretlab.ca> <5475E4EC.7090309@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:37293 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbaK0NuW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 27 Nov 2014 08:50:22 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so4586183iec.39
        for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2014 05:50:21 -0800 (PST)
In-Reply-To: <5475E4EC.7090309@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Kevin Cernekee <cernekee@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, tushar.b@samsung.com

On Wed, Nov 26, 2014 at 2:34 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 11/26/2014 08:33 AM, Grant Likely wrote:
>> On Tue, 25 Nov 2014 15:37:16 -0800
>> , Kevin Cernekee <cernekee@gmail.com>
>>  wrote:
>>> On Tue, Nov 25, 2014 at 12:34 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>> On Wed, Nov 12, 2014 at 12:53:58PM -0800, Kevin Cernekee wrote:
>>>>> From: Tushar Behera <tushar.behera@linaro.org>
>>>>
>>>> This email bounces, so I'm going to have to reject this patch.  I can't
>>>> accept a patch from a "fake" person, let alone something that touches
>>>> core code like this.
>>>>
>>>> Sorry, I can't accept anything in this series then.
>>>
>>> Oops, guess I probably should have updated his address after the V1
>>> emails bounced...
>>>
>>> Before I send a new version, what do you think about the overall
>>> approach?  Should we try to make serial8250 coexist with the other
>>> "ttyS / major 4 / minor 64" drivers (possibly at the expense of
>>> compatibility) or is it better to start with a simpler, cleaner driver
>>> like serial/pxa?
>>
>> Co-existing really needs to be fixed.
>
> What are the requirements for co-existence?
> Is it sufficient to provide 1st come-1st served minor allocation?

Should be sufficient. Basically, if the hardware doesn't exist, the
driver shouldn't be trying to grab the minor numbers.

Also, on hardware where both exists, there should be some sane
fallback so that all UARTs get assigned numbers. On DT systems we can
also use /aliases to ensure consistent assignment of numbers.

g.
