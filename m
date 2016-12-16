From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] serial: samsung: Simplify DMA engine initialization code
Date: Fri, 16 Dec 2016 11:50:33 +0100
Message-ID: <4075921b-ab30-7527-e96a-5bdfdc5893e3@samsung.com>
References: <CGME20161216095843epcas1p45f9de00cb1c809931da69ffab0c83279@epcas1p4.samsung.com>
 <1481882213-10856-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1481882213-10856-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On 12/16/2016 10:56 AM, Marek Szyprowski wrote:
> dma_request_slave_channel_compat() requires filter function and mask, which
> are not needed on device tree based platforms, so simplify the code by
> calling the more appropriate dma_request_chan() function. This additionally
> gives us proper error handling, because the new function returns error
> codes instead of NULL on failure.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
