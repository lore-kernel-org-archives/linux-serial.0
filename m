From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 2/3] tty: serial: msm: Only configure MND registers on hw
 that has it
Date: Sun, 5 Jun 2016 14:04:29 -0500
Message-ID: <20160605190429.GH13357@hector.attlocal.net>
References: <20160512010228.21548-1-sboyd@codeaurora.org>
 <20160512010228.21548-3-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160512010228.21548-3-sboyd@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Pramod Gurav <pramod.gurav@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Wed, May 11, 2016 at 06:02:27PM -0700, Stephen Boyd wrote:
> The registers that msm_serial_set_mnd_regs() writes only exist on
> the non-uartdm hardware, so let's return early here if this
> function is called on uartdm hardware. This also prevents us from
> messing up the uartclk variable if the uartclk rate happens to be
> 19.2 or 4.8 MHz.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Andy Gross <andy.gross@linaro.org>
