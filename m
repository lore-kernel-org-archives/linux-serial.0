From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 3/3] serial: samsung: Remove useless spinlock
Date: Tue, 4 Apr 2017 11:36:35 +0200
Message-ID: <20170404093635.GB28551@kozik-book>
References: <1491200468-28463-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170403062120eucas1p1369bcd47ca09d99c955baa551cdb1e06@eucas1p1.samsung.com>
 <1491200468-28463-3-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1491200468-28463-3-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Seung-Woo Kim <sw0312.kim@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 03, 2017 at 08:21:01AM +0200, Marek Szyprowski wrote:
> Spinlock taken only for dma_map_single() for TX buffer is completely
> useless and doesn't protect anything, so remove it to simplify the code.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/tty/serial/samsung.c | 4 ----
>  1 file changed, 4 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
