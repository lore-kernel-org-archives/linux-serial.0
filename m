From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [Nios2-dev] [PATCH 0/5] tty: serial: Updates for altera_jtaguart driver
Date: Fri, 18 Feb 2011 10:20:50 -0700
Message-ID: <AANLkTik6iHf8YrOdmg4xZSUkeNYpsk_KxYbU0pTWqnME@mail.gmail.com>
References: <cover.1297974227.git.tklauser@distanz.ch> <20110217221504.GA10686@kroah.com>
 <20110218072324.GS4076@distanz.ch> <4D5E1FF6.20805@wytron.com.tw>
 <20110218074542.GA759@distanz.ch> <AANLkTimv8xB7KF14C1ttjPorbXeo=nWX0P=a5TUcNCbG@mail.gmail.com>
 <20110218081108.GB759@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65188 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665Ab1BRRVK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Feb 2011 12:21:10 -0500
Received: by iwn9 with SMTP id 9so3846598iwn.19
        for <linux-serial@vger.kernel.org>; Fri, 18 Feb 2011 09:21:10 -0800 (PST)
In-Reply-To: <20110218081108.GB759@distanz.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Thomas Chou <thomas@wytron.com.tw>, nios2-dev@sopc.et.ntust.edu.tw, Greg KH <greg@kroah.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org

On Fri, Feb 18, 2011 at 1:11 AM, Tobias Klauser <tklauser@distanz.ch> wrote:
> On 2011-02-18 at 09:06:15 +0100, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Fri, Feb 18, 2011 at 12:45 AM, Tobias Klauser <tklauser@distanz.ch> wrote:
>> > On 2011-02-18 at 08:29:58 +0100, Thomas Chou <thomas@wytron.com.tw> wrote:
>> >> On 02/18/2011 03:23 PM, Tobias Klauser wrote:
>> >>> On 2011-02-17 at 23:15:04 +0100, Greg KH<greg@kroah.com>  wrote:
>> >>>> On Thu, Feb 17, 2011 at 09:28:23PM +0100, Tobias Klauser wrote:
>> >>>>> This patchset adds updates taken from the Nios2 Linux port (currently
>> >>>>> out-of-tree) repository to the altera_jtaguart driver.
>> >>>>>
>> >>>>> And this time with the correct cover letter right away :-)
>> >>>>>
>> >>>>> Tobias Klauser (5):
>> >>>>>    tty: serial: altera_jtaguart: Don't use plain integer as NULL pointer
>> >>>>>    tty: serial: altera_jtaguart: Remove unused function
>> >>>>>      early_altera_jtaguart_setup
>> >>>>>    tty: serial: altera_jtaguart: Support getting mapbase and IRQ from
>> >>>>>      resources
>> >>>>>    tty: serial: altera_jtaguart: Fixup type usage of port flags
>> >>>>>    tty: serial: altera_jtaguart: Add device tree support
>> >>>>
>> >>>> After this series, I get the following build error:
>> >>>>       CC [M]  drivers/tty/serial/altera_jtaguart.o
>> >>>>       drivers/tty/serial/altera_jtaguart.c:485:3: error: unknown field ???of_match_table??? specified in initializer
>> >>>
>> >>> Strange, I didn't get that one when compile testing against linux-next
>> >>> on x86_64. Though it seems I didn't correctly test it on nios2 and I got
>> >>> a compile error about a missing semicolon in the definition of
>> >>> altera_jtaguart_match there.
>> >>
>> >> It might be that the of_match_table patch is available in Grant's branch
>> >> only, which is for v3.6.39. Maybe you can ask Grant to take this patch
>> >> 5/5.
>> >
>> > That explains it, thanks Thomas.
>> >
>> > Greg, care to take only patches 1/5 to 4/5 for now? I'll resubmit 5/5
>> > for the 2.6.39 merge window, unless Grant already wants to take this to
>> > his tree.
>>
>> I'm happy to take this patch if it doesn't depend on the first 4.
>> Alternately Greg, you could merge commit c9e358dfc "driver-core:
>> remove conditionals around devicetree pointers" from my
>> devicetree/test branch on git://git.secretlab.ca/git/linux-2.6.  I
>> won't be rebasing that commit and it is the first commit on top of
>> 2.6.38-rc1.
>
> The patch doesn't depend on the first 4, so you could take it if Greg
> doesn't oppose.

Okay, I'll merge the ones that depend on my tree and that Greg acks.

g.
