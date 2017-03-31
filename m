From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] serial: samsung: Use right device for DMA-mapping
 calls
Date: Fri, 31 Mar 2017 15:35:36 +0200
Message-ID: <20170331133536.GB32267@kroah.com>
References: <CGME20170323120208eucas1p28df58f312314337e9750d23930de733b@eucas1p2.samsung.com>
 <1490270519-4046-1-git-send-email-m.szyprowski@samsung.com>
 <20170323195155.u3bfvuo6rxncsgzr@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170323195155.u3bfvuo6rxncsgzr@kozik-lap>
Sender: stable-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Inki Dae <inki.dae@samsung.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 23, 2017 at 09:51:55PM +0200, Krzysztof Kozlowski wrote:
> On Thu, Mar 23, 2017 at 01:01:52PM +0100, Marek Szyprowski wrote:
> > Driver should provide its own struct device for all DMA-mapping calls instead
> > of extracting device pointer from DMA engine channel.
>  
> For the purpose of cc-stable it might be useful to answer here what
> visible error is fixed (or why driver should not use DMA's device) but
> on the other hand this is actually obvious... Anyway:

No, please make it obvious on the next version of this series.

thanks,

greg k-h
