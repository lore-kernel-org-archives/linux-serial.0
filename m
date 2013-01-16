From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: Re: [PATCH v2] TTY: serial, add pm function
Date: Wed, 16 Jan 2013 09:33:09 +0100
Message-ID: <50F665C5.9020603@stericsson.com>
References: <1355316051-2425-1-git-send-email-rickard.andersson@stericsson.com> <20130116070521.GB2527@kroah.com> <50F65C5E.9090804@stericsson.com> <20130116075813.GA30819@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:53066 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758732Ab3APIdW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 03:33:22 -0500
In-Reply-To: <20130116075813.GA30819@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linus WALLEIJ <linus.walleij@stericsson.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>

On 01/16/2013 08:58 AM, Greg KH wrote:
> On Wed, Jan 16, 2013 at 08:53:02AM +0100, Rickard Andersson wrote:
>> On 01/16/2013 08:05 AM, Greg KH wrote:
>>> On Wed, Dec 12, 2012 at 01:40:51PM +0100, Rickard Andersson wrote:
>>>> Add power management function to tty driver interface
>>>> and add implementation for serial core.
>>>>
>>>> Signed-off-by: Rickard Andersson<rickard.andersson@stericsson.com>
>>>> ---
>>>> ChangeLog v1->v2
>>>> - add mutex handling
>>> As no one is using this, why add it?
>>>
>>> greg k-h
>> We want to use this pm function from our bluetooth driver to save
>> current when possible. So in our case when the bluetooth driver sees
>> that the serial communication to the bluetooth chip will not be used
>> it can tell the pl011 serial driver to turn off clocks.
> Is that driver in the tree already?
>
The bluetooth cg2900 driver is on its way towards "staging".

