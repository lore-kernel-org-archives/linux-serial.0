Return-Path: <SRS0=vVzV=XY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0807C4360C
	for <linux-serial@archiver.kernel.org>; Sun, 29 Sep 2019 18:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B1720815
	for <linux-serial@archiver.kernel.org>; Sun, 29 Sep 2019 18:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfI2SPF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 29 Sep 2019 14:15:05 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:45403 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbfI2SPF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 29 Sep 2019 14:15:05 -0400
Received: from host-78-144-222-197.as13285.net ([78.144.222.197] helo=[192.168.1.13])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iEdio-0000cv-46; Sun, 29 Sep 2019 19:15:02 +0100
Subject: Re: [PATCH v2 2/3] serial: 8250_exar: Refactor exar_shutdown()
From:   Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Robert Middleton <robert.middleton@rm5248.com>,
        Aaron Sierra <asierra@xes-inc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>
References: <20190805100518.9818-2-andriy.shevchenko@linux.intel.com>
 <CAKpcJVZTy963y3TOXSYSBFVOpVTWEOyJKUYxv1pHNGz3Y1aPTA@mail.gmail.com>
 <20190805142147.GK23480@smile.fi.intel.com>
 <CAKpcJVYfcVAmoB63EbmJaix6v+2JJ5BujAcdduQLcw-ES+f3ZQ@mail.gmail.com>
 <20190806152407.GF30120@smile.fi.intel.com>
 <20190806153110.GG30120@smile.fi.intel.com>
 <CAKpcJVYTC8MN6A51iip=cyvkfXVy2NS-c3FyhAi9qcxsgJkQRw@mail.gmail.com>
 <CAKpcJVaL-BqL0G=_hT6WHz6kCr05sHS1jDQnaM0s_WFWCb6n_A@mail.gmail.com>
 <20190807150425.GC30120@smile.fi.intel.com>
 <CAKpcJVYmTK-kw5eZJtcMWBSMmOk4ijqu-1oh9cEswi4q98QHAg@mail.gmail.com>
 <20190808121148.GT30120@smile.fi.intel.com>
 <d4ec5a0a-08e3-4da9-bf43-fb1269d0b996@codethink.co.uk>
Message-ID: <d64d54fd-5d21-f0a5-8804-b4a0ce486c59@codethink.co.uk>
Date:   Sun, 29 Sep 2019 19:15:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d4ec5a0a-08e3-4da9-bf43-fb1269d0b996@codethink.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Robert,

On 09/08/2019 10:17, Sudip Mukherjee wrote:
> 
> 
> On 08/08/2019 17:41, Andy Shevchenko wrote:
>> On Wed, Aug 07, 2019 at 02:41:47PM -0400, Robert Middleton wrote:
>>> On Wed, Aug 7, 2019 at 11:04 AM Andy Shevchenko
>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>>
>>>> On Wed, Aug 07, 2019 at 09:48:03AM -0400, Robert Middleton wrote:
>>>>>> I'll try to get some firm results in the morning; otherwise I won't be
>>>>>> able to check until early next week as I will be away from the
>>>>>> hardware.
>>>>>
>>>>> After doing more testing, I think that I finally have something that
>>>>> is working fully at all baud rates.  I've tested this at
>>>>> 115200,9600,and 4800, testing via: echo "the quick brown fox jumps
>>>>> over the lazy dog" > /dev/ttySx
>>>>>
>>>>> Removing the check to uart_circ_empty in the while loop makes it more
>>>>> reliable, however it will occasionally fail and only transmit the
>>>>> first part of the message(at 4800, it will transmit only "t", at
>>>>> 115200 it will transmit "the quick bro").
>>>>
>>>> I'm not sure about the loop for uart_circ_empty(). Can you try 2-3 kB of text
>>>> at lower baud rate, let's say 2400 or so?
>>>
> <snip>
>>
>>> At this point, this leads me to believe that there is actually a more
>>> fundamental problem with the 8250 driver and flushing data.  I was
>>> focusing more on the exar, since that is the only hardware that I have
>>> available that uses the 8250 driver.
>>
>> Hmm... It's weird that no-one else had noticed so far an issue.
> 
> Thats odd. I never saw this problem. Or even the people from "RTD
> Embedded Technologies" who tested my first driver submission also did
> not see any such problem.
> I am on holiday now and don't have access to the hardware. I can check
> it on my hardware after 2 weeks.

Sorry for the delay. I managed to test it today. My test file contained
70 lines of "The quick brown fox jumps over the lazy dog". I used upto
1200 Baudrate to send the text from the desktop using the Exar serial I
have and I did not notice any message loss on the receiving laptop.
Please let me know if you want me to test further.


-- 
Regards
Sudip
