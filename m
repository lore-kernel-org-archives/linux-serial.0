From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 4/4] arm64: dts: r8a7796: salvator-x: add SCIF1
 (DEBUG1)
Date: Wed, 8 Feb 2017 11:54:26 +0100
Message-ID: <20170208105426.GE26982@verge.net.au>
References: <1486118300-12633-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1486118300-12633-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1486118300-12633-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org, gregkh@linuxfoundation.org, wsa@the-dreams.de, linux-serial@vger.kernel.org, magnus.damm@gmail.com, sergei.shtylyov@cogentembedded.com
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 03, 2017 at 11:38:20AM +0100, Ulrich Hecht wrote:
> Enables the SCIF hooked up to the DEBUG1 connector.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Hi Ulrich,

could you clarify the dependency of this patch on earlier ones in the
series. Is it safe to queue this up independently of the other patches?
