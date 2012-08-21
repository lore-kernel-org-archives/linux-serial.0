From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC/PATCH 05/13] serial: omap: drop DMA support
Date: Tue, 21 Aug 2012 15:14:19 +0530
Message-ID: <CAMQu2gw93ES=u9J1FfWK_CKkgUq8V487+tmKtQ34p8O7VJ6aHA@mail.gmail.com>
References: <1345540555-24359-1-git-send-email-balbi@ti.com> <1345540555-24359-6-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1345540555-24359-6-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: alan@linux.intel.com, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shubhrajyoti Datta <shubhrajyoti@ti.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 21, 2012 at 2:45 PM, Felipe Balbi <balbi@ti.com> wrote:
> The current support is known to be broken and
> a later patch will come re-adding it using
> dma engine API.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
Thanks Felipe !!
One less driver now towards OMAP DMA
engine conversion.

FWIW,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
