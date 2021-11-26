Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB41DC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 14:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346871AbhKZOno (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 09:43:44 -0500
Received: from fieber.vanmierlo.com ([84.243.197.177]:38720 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1353358AbhKZOlm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 09:41:42 -0500
X-Greylist: delayed 1819 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2021 09:41:41 EST
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by kerio9.vanmierlo.com (Kerio Connect 9.3.1 patch 1) with ESMTPA;
        Fri, 26 Nov 2021 15:07:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Nov 2021 15:07:44 +0100
From:   Maarten Brock <m.brock@vanmierlo.com>
To:     Shubhrajyoti Datta <shubhraj@xilinx.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, jacmet@sunsite.dk, git <git@xilinx.com>,
        michal.simek@xilinx.com
Subject: Re: [PATCH v2] serial-uartlite: Remove an un-necessary read of
 control register
In-Reply-To: <MN2PR02MB664063C64EA9C8BC59C3E566AA619@MN2PR02MB6640.namprd02.prod.outlook.com>
References: <20211123131348.26295-1-shubhrajyoti.datta@xilinx.com>
 <YZ4O+qnkVyhGzuDy@kroah.com>
 <MN2PR02MB664063C64EA9C8BC59C3E566AA619@MN2PR02MB6640.namprd02.prod.outlook.com>
Message-ID: <cd14525f12ea09fe85d9db18712ae20a@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

+ Michal

On 2021-11-24 13:37, Shubhrajyoti Datta wrote:
>> -----Original Message-----
>> From: Greg KH <gregkh@linuxfoundation.org>
>> Sent: Wednesday, November 24, 2021 3:38 PM
>> To: Shubhrajyoti Datta <shubhraj@xilinx.com>
>> Cc: linux-serial@vger.kernel.org; jirislaby@kernel.org; 
>> jacmet@sunsite.dk; git
>> <git@xilinx.com>
>> Subject: Re: [PATCH v2] serial-uartlite: Remove an un-necessary read 
>> of control
>> register
>> 
>> On Tue, Nov 23, 2021 at 06:43:48PM +0530, Shubhrajyoti Datta wrote:
>> > The control register is a writeonly register that's why reading it
>> > doesn't make any sense.
>> > The manual states "This is a write-only register. Issuing a read
>> > request to the control register generates the read acknowledgment with zero
>> data."
>> 
>> Are you sure this is ok to remove?  Usually you have to do a read 
>> after a write to
>> ensure that the write succeeded.
>> 
>> What ensures that the write succeeded now if you remove this read?
> 
> I do not find the mention of a read requirement in the manual.
> Also in the current code in ulite_console_write and in ulite_startup
> we are writing without a read.
> 
> Thanks and Regards,
> Shubhrajyoti

I suggest to confer with Michal Simek. He introduced the read in 
ulite_request_port()
in the past. The other one in ulite_shutdown() has been there since its 
inception in
2006.

Maarten

