From: Robert Baldyga <r.baldyga@samsung.com>
Subject: Re: [PATCH 0/2] serial: samsung: fix DMA for small FIFO sizes
Date: Fri, 31 Jul 2015 10:17:13 +0200
Message-ID: <55BB2F09.8000501@samsung.com>
References: <1438247656-24695-1-git-send-email-r.baldyga@samsung.com>
 <CAJKOXPfwnYVyJCPPyG5L0B2kw9nG1KNgj7L6Sy2hJEbihf-b2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAJKOXPfwnYVyJCPPyG5L0B2kw9nG1KNgj7L6Sy2hJEbihf-b2Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-serial@vger.kernel.org

On 07/31/2015 10:04 AM, Krzysztof Kozlowski wrote:
> 2015-07-30 18:14 GMT+09:00 Robert Baldyga <r.baldyga@samsung.com>:
>> Hello,
>>
>> This patch set fixes bug causing serial hang in DMA mode for FIFO sizes
>> smaller than cache alignment. The first patch fixes DMA mode entering
>> condition to avoid starting with buffer smaller than cache line size.
>> Second patch fixes the serial hang bug, which was caused by unproper
>> buffer aligning algorithm which assumed that there is always enough
>> free space in FIFO for excessive bytes of buffer that is being alligned.
>>
>> Best regards,
>> Robert Baldyga
>>
>> Marek Szyprowski (1):
>>   serial: samsung: calculate min_dma_size
>>
>> Robert Baldyga (1):
>>   serial: samsung: fix DMA for FIFO smaller than cache line size
>>
>>  drivers/tty/serial/samsung.c | 47 +++++++++++++++++++++++++++++---------------
>>  drivers/tty/serial/samsung.h |  1 +
>>  2 files changed, 32 insertions(+), 16 deletions(-)
> 
> Does this apply for stable backporting? Or at least fixes tag
> indicating a bug? I could not figure this out from description of
> first patch. For second patch it seems it applies.

These patches are two steps of fixing the bug, so they both apply for
stable backporting.

> 
> Anyway I would appreciate a reported-by credits.

Sure ;)

Thanks,
Robert
