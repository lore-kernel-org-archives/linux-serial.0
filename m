From: Robert Baldyga <r.baldyga@samsung.com>
Subject: Re: [PATCH 0/3] serial: samsung: Fix UART status handling and other
 fixes
Date: Wed, 09 Sep 2015 11:15:04 +0200
Message-ID: <55EFF898.7060205@samsung.com>
References: <1441705127-24125-1-git-send-email-r.baldyga@samsung.com>
 <55EF7395.2000702@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <55EF7395.2000702@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com
List-Id: linux-serial@vger.kernel.org

On 09/09/2015 01:47 AM, Krzysztof Kozlowski wrote:
> On 08.09.2015 18:38, Robert Baldyga wrote:
>> Hello,
>>
>> This patch set contains three patches: two minor fixes and one quite
>> important bugfix enabling UART status handling in DMA mode, which was
>> missing so far. It enables, among others, 'break' contition handling,
>> which is necessary if we want to use Magic SysRq. So this patch fixes
>> Magic SysRq handling for serial consoles using UART in DMA mode,
> 
> Is it even worth using UART for serial console in DMA mode? How many
> benefits it brings? Anyone measured real data?
> 
> The patch which enabled DMA for all serial ports on Exynos4 uncovered
> some issues. That is one benefit... but was it worth it?

Well, UART in DMA mode should work at least as good as in PIO, so there
is nothing wrong in having serial console configured in DMA. Sure, it
rather barely reduces number of interrupts while used as typical serial
console, but in some cases (eg. using zmodem) it can be more profitable.

To be honest, I have no strong feeling about that. I've decided to
utilize new possibility opened by introducing DMA mode in serial driver,
so I've send patch enabling it for each port on Exynos4. But if it
turned out to be unneeded I will not insist on it.

Best regards,
Robert
