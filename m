From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/2] serial: samsung: Add missing checks for dma_map_single
 failure
Date: Thu, 23 Mar 2017 12:04:02 +0100
Message-ID: <3019209.fgIhMIWD3x@amdc3058>
References: <1490255131-9597-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170323074553eucas1p110829c4ad1570104297df39c02cc59e5@eucas1p1.samsung.com>
 <1490255131-9597-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-reply-to: <1490255131-9597-2-git-send-email-m.szyprowski@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Seung-Woo Kim <sw0312.kim@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Inki Dae <inki.dae@samsung.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thursday, March 23, 2017 08:45:22 AM Marek Szyprowski wrote:
> This patch adds missing checks for dma_map_single() failure and proper error
> reporting. While touching this part of the code, it also removes unnecessary
> spinlock calls around dma_map_single() for TX buffer. This finally solves all
> the issues reported by DMA API debug framework.
> 
> Reported-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> Fixes: 2c37eedb74c8 ("serial: samsung: add dma reqest/release functions")

The right commit id is 62c37eedb74c8.

> CC: stable@vger.kernel.org # v4.10+
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards,
