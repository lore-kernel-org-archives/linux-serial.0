From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ARM: bcm2835: override the HW UART periphid
Date: Tue, 21 May 2013 19:43:39 -0600
Message-ID: <519C22CB.5040009@wwwdotorg.org>
References: <519AD82A.6090809@wwwdotorg.org> <1369116149-2361-1-git-send-email-neidhard.kim@lge.com> <519BA209.6050407@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <519BA209.6050407@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jongsung Kim <neidhard.kim@lge.com>
Cc: linux@arm.linux.org.uk, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 05/21/2013 10:34 AM, Stephen Warren wrote:
> On 05/21/2013 12:02 AM, Jongsung Kim wrote:
>> Stephen Warren reported the recent commit 78506f2 (add support for
>> extended FIFO-size of PL011-r1p5) breaks the serial port on the
>> BCM2835 ARM SoC.
>>
>> A UART compatible with the ARM PL011-r1p5 should have 32-deep FIFOs.
>> The BCM2835 UART just looks like an ARM PL011-r1p5, but has 16-deep
>> FIFOs just like PL011-r1p4 or earlier revisions. As a workaround for
>> this compatibility issue, this patch overrides the HW UART periphid
>> register values with the actually compatible UART periphid 0x00241011
>> (r1p3 or r1p4).
>>
>> Reported-by: Stephen Warren <swarren@wwwdotorg.org>
>> Signed-off-by: Jongsung Kim <neidhard.kim@lge.com>
> 
> I know this will work, because I tried out the same thing last week.
> 
> However, I'm not convinced that it's the correct approach. What other
> changes exist between r1p4 and r1p5; can you check in the TRM?

Looking at the TRM, it seems this is really the only change, according
to the changelog in the documentation (although it's a little difficult
to tell since the document seems to have a bunch of changes that
presumably don't affect behaviour). So, faking the periphid seems OK.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>

Let's apply for 3.10.
