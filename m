From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: [PATCH 1/2] serial: samsung: Move uart_register_driver call to
 device probe
Date: Mon, 20 Jan 2014 17:23:21 +0530
Message-ID: <CAHbNUh3m=uNybv=3yxmr2on=Cc0UuGrYP8zf3GMR-9RQZ394dg@mail.gmail.com>
References: <1390208555-27770-1-git-send-email-tushar.behera@linaro.org>
	<1390208555-27770-2-git-send-email-tushar.behera@linaro.org>
	<20140120100530.GY15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:60177 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181AbaATLxV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Jan 2014 06:53:21 -0500
Received: by mail-ob0-f180.google.com with SMTP id wp4so1939447obc.39
        for <linux-serial@vger.kernel.org>; Mon, 20 Jan 2014 03:53:21 -0800 (PST)
In-Reply-To: <20140120100530.GY15937@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, jslaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Mark Brown <broonie@kernel.org>

On 20 January 2014 15:35, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 20, 2014 at 02:32:34PM +0530, Tushar Behera wrote:
>> uart_register_driver call binds the driver to a specific device
>> node through tty_register_driver call. This should typically happen
>> during device probe call.
>>
>> In a multiplatform scenario, it is possible that multiple serial
>> drivers are part of the kernel. Currently the driver registration fails
>> if multiple serial drivers with same default major/minor numbers are
>> included in the kernel.
>>
>> A typical case is observed with amba-pl011 and samsung-uart drivers.
>
> The samsung-uart driver is at fault here - the major/minor numbers were
> officially registered to amba-pl011.  Samsung needs to be fixed properly.
>

I had earlier submitted a patch [1] to remove the hard coded
major/minor number for Samsung UART driver, but that was rejected
because of userspace breakage. Without this patch, Samsung UART driver
can't bind to the hard-coded device node. Changing the default
major/minor will also not help to fix the objections raised in [1].

Would you please suggest a way forward?

[1] https://lkml.org/lkml/2013/12/27/2

-- 
Tushar Behera
