From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH/RFC 3/8] of: Add helper function to check MMIO register
 endianness
Date: Wed, 12 Nov 2014 10:23:36 +0100
Message-ID: <54632718.9030603@suse.cz>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com> <1415781993-7755-4-git-send-email-cernekee@gmail.com> <54631F64.8080009@suse.cz> <CAJiQ=7ADy1U60R-o1soMyqYWXqw2OqQg7vfB9L5pzeac+Yv=SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:38311 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbaKLJXk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 04:23:40 -0500
In-Reply-To: <CAJiQ=7ADy1U60R-o1soMyqYWXqw2OqQg7vfB9L5pzeac+Yv=SA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, tushar.behera@linaro.org, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, Grant Likely <grant.likely@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Maxime Bizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 11/12/2014, 10:04 AM, Kevin Cernekee wrote:
>> This should actually return bool and use true/false.
> 
> Well, the other APIs currently return an int:
> 
> extern int of_device_is_compatible(const struct device_node *device,
>                                    const char *);
> extern int of_device_is_available(const struct device_node *device);
> [...]
> extern int of_machine_is_compatible(const char *compat);
> 
> Do you think it is best to change all of them at once, or just the
> newly introduced function?

Possibly fix all these in a separate patch and then add the new one
fixed :).

-- 
js
suse labs
