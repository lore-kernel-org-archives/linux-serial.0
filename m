From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 3/3] tty: serial: msm: Cleanup include usage
Date: Sun, 5 Jun 2016 14:05:18 -0500
Message-ID: <20160605190518.GI13357@hector.attlocal.net>
References: <20160512010228.21548-1-sboyd@codeaurora.org>
 <20160512010228.21548-4-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160512010228.21548-4-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Pramod Gurav <pramod.gurav@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Wed, May 11, 2016 at 06:02:28PM -0700, Stephen Boyd wrote:
> The hrtimer include isn't used and neither is serial. Drop those
> ones. The irq.h header really should be interrupt.h because this
> is an interrupt user and not an interrupt chip. Finally add
> wait.h for the wake_up*() usage in this driver and kernel.h for
> container_of().
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Andy Gross <andy.gross@linaro.org>
