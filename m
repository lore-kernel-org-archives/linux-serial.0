From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 1/2] serial: samsung: Use right device for DMA-mapping
 calls
Date: Thu, 23 Mar 2017 21:51:55 +0200
Message-ID: <20170323195155.u3bfvuo6rxncsgzr@kozik-lap>
References: <CGME20170323120208eucas1p28df58f312314337e9750d23930de733b@eucas1p2.samsung.com>
 <1490270519-4046-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1490270519-4046-1-git-send-email-m.szyprowski@samsung.com>
Sender: stable-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Seung-Woo Kim <sw0312.kim@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Inki Dae <inki.dae@samsung.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 23, 2017 at 01:01:52PM +0100, Marek Szyprowski wrote:
> Driver should provide its own struct device for all DMA-mapping calls instead
> of extracting device pointer from DMA engine channel.
 
For the purpose of cc-stable it might be useful to answer here what
visible error is fixed (or why driver should not use DMA's device) but
on the other hand this is actually obvious... Anyway:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


> Reported-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> Fixes: 62c37eedb74c8 ("serial: samsung: add dma reqest/release functions")
> CC: stable@vger.kernel.org # v4.0+
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> v2:
> - fixed commit id in 'fixes' tag, added 'reviewed-by' tag
> ---
>  drivers/tty/serial/samsung.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
