Return-Path: <SRS0=vVzV=XY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5D2C4360C
	for <linux-serial@archiver.kernel.org>; Sun, 29 Sep 2019 21:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BB520863
	for <linux-serial@archiver.kernel.org>; Sun, 29 Sep 2019 21:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfI2VnZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 29 Sep 2019 17:43:25 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:46618 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfI2VnZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 29 Sep 2019 17:43:25 -0400
Received: from host-78-144-222-197.as13285.net ([78.144.222.197] helo=[192.168.1.13])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iEgyQ-0003Jj-R2; Sun, 29 Sep 2019 22:43:22 +0100
Subject: Re: [PATCH v2 2/3] serial: 8250_exar: Refactor exar_shutdown()
To:     Robert Middleton <robert.middleton@rm5248.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aaron Sierra <asierra@xes-inc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <d64d54fd-5d21-f0a5-8804-b4a0ce486c59@codethink.co.uk>
 <CAKpcJVaNyv-D3eehF4rcE7ZvihRcsdHm+dOWAea0+6CETY6L=Q@mail.gmail.com>
From:   Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Message-ID: <29ab74c4-490b-ef4a-011a-ba75fc4321cb@codethink.co.uk>
Date:   Sun, 29 Sep 2019 22:43:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKpcJVaNyv-D3eehF4rcE7ZvihRcsdHm+dOWAea0+6CETY6L=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 29/09/2019 22:30, Robert Middleton wrote:
> On Sun, Sep 29, 2019 at 2:15 PM Sudip Mukherjee
> <sudip.mukherjee@codethink.co.uk> wrote:
>>
>> Hi Robert,
>>
>> Sorry for the delay. I managed to test it today. My test file contained
>> 70 lines of "The quick brown fox jumps over the lazy dog". I used upto
>> 1200 Baudrate to send the text from the desktop using the Exar serial I
>> have and I did not notice any message loss on the receiving laptop.
>> Please let me know if you want me to test further.
>>
> 
> Two questions:
> 1. What kernel version?  If you didn't have a problem, I can try with
> the exact version that you have as well and see if I can reproduce on
> my side.

v5.3.1

> 2. Did you test this via 'cat text-file.txt > /dev/ttySX' ?  I'm
> assuming that you are, but just want to make sure.

Yes. On the desktop which has the Exar hardware "cat fox.txt >
/dev/ttyS4" and on the laptop which is the receiver a terminal to read
from /dev/ttyUSB0.


-- 
Regards
Sudip
