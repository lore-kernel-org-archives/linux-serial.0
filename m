From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] serial: relocate remaining serial drivers from tty/ to
 tty/serial/
Date: Wed, 4 Jan 2012 16:07:52 -0500
Message-ID: <4F04BFA8.9010100@windriver.com>
References: <1325707287-31038-1-git-send-email-paul.gortmaker@windriver.com> <4F04B7DC.70809@suse.cz> <20120104205146.GA21430@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:48387 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756904Ab2ADVIX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Jan 2012 16:08:23 -0500
In-Reply-To: <20120104205146.GA21430@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Jiri Slaby <jslaby@suse.cz>, alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>

On 12-01-04 03:51 PM, Greg KH wrote:
> On Wed, Jan 04, 2012 at 09:34:36PM +0100, Jiri Slaby wrote:
>> On 01/04/2012 09:01 PM, Paul Gortmaker wrote:
>>>  rename drivers/tty/{ => serial}/amiserial.c (100%)
>>>  rename drivers/tty/{ => serial}/cyclades.c (100%)
>>>  rename drivers/tty/{ => serial}/isicom.c (100%)
>>>  rename drivers/tty/{ => serial}/moxa.c (100%)
>>>  rename drivers/tty/{ => serial}/moxa.h (100%)
>>>  rename drivers/tty/{ => serial}/mxser.c (100%)
>>>  rename drivers/tty/{ => serial}/mxser.h (100%)
>>>  rename drivers/tty/{ => serial}/rocket.c (100%)
>>>  rename drivers/tty/{ => serial}/rocket.h (100%)
>>>  rename drivers/tty/{ => serial}/rocket_int.h (100%)
>>>  rename drivers/tty/{ => serial}/synclink.c (100%)
>>>  rename drivers/tty/{ => serial}/synclink_gt.c (100%)
>>>  rename drivers/tty/{ => serial}/synclinkmp.c (100%)
>>
>> Hmm, tty/serial/* used to be for those using serial-core. And tty/ for
>> those who don't. But FWIW I don't mind the change.
> 
> Yes, that is what I used when splitting them up, so this patch doesn't
> make much sense.
> 
> Paul, why do you want these all mixed together?

My thinking was that having a drivers/tty/serial dir and then
not having all the serial drivers in that dir violated the
principle of least surprise.  Is there a reason why the dir should
be the exclusive domain of drivers with a dependency on SERIAL_CORE?

Paul.

> 
> greg k-h
