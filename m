From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 0/2] serial: samsung: fix DMA for small FIFO sizes
Date: Mon, 03 Aug 2015 09:37:18 +0900
Message-ID: <55BEB7BE.9030606@samsung.com>
References: <1438333108-25822-1-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1438333108-25822-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>, gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, kmpark@infradead.org, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 31.07.2015 17:58, Robert Baldyga wrote:
> Hello,
> 
> This patch set fixes bug causing serial hang in DMA mode for FIFO sizes
> smaller than cache alignment. The first patch fixes DMA mode entering
> condition to avoid starting with buffer smaller than cache line size.
> Second patch fixes the serial hang bug, which was caused by unproper
> buffer aligning algorithm which assumed that there is always enough
> free space in FIFO for excessive bytes of buffer that is being alligned.
> 
> Best regards,
> Robert Baldyga
> 
> Changelog:
> 
> v2:
> - Add CC to stable
> - Add Reported-by: Krzysztof Kozlowski
> - Change title of the first patch to more relevant
> 
> v1: http://permalink.gmane.org/gmane.linux.kernel/2008281
> 
> Marek Szyprowski (1):
>   serial: samsung: fix DMA mode enter condition for small FIFO sizes
> 
> Robert Baldyga (1):
>   serial: samsung: fix DMA for FIFO smaller than cache line size
> 
>  drivers/tty/serial/samsung.c | 47 +++++++++++++++++++++++++++++---------------
>  drivers/tty/serial/samsung.h |  1 +
>  2 files changed, 32 insertions(+), 16 deletions(-)
> 

Tested on Trats2 (Exynos4412 with pl330, serial output on ttySAC2).
Patchset fixes the reported issue (hang after applying "ARM: dts:
exynos4: add DMA support for serial ports" [0]).

However with [0] dmatest cannot execute tests on dma0 channels. Just
silently passes but does not execute memcpy on any of dma0 channels.
I wonder why... the serial ports use only some of dma0 channels, not all
of them.

Any ideas?

[0] http://www.spinics.net/lists/linux-samsung-soc/msg45700.html

Best regards,
Krzysztof
