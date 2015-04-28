From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 1/3] tty: serial: msm: Add mask value for UART_DM
 registers
Date: Tue, 28 Apr 2015 13:26:28 +0200
Message-ID: <20150428112628.GA8228@kroah.com>
References: <1428668396-6955-1-git-send-email-gpramod@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428668396-6955-1-git-send-email-gpramod@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <gpramod@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, bryanh@codeaurora.org, sboyd@codeaurora.org, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 10, 2015 at 05:49:54PM +0530, Pramod Gurav wrote:
> The bit masks for RFR_LEVEL1 and STALE_TIMEOUT_MSB values in MR1 and
> IPR registers respectively are different for UART and UART_DM hardware
> cores. We have been using UART core mask values for these. Add the same
> for UART_DM core.
> 
> There is no bit setting as UART_IPR_RXSTALE_LAST for UART_DM core so do
> it only for UART core.
> 
> Signed-off-by: Pramod Gurav <gpramod@codeaurora.org>
> ---
> Changes since v2:
> 
>  - Changed the sequnce of code to avoid duplication of code.
> 
>  drivers/tty/serial/msm_serial.c | 26 ++++++++++++++++++++------
>  drivers/tty/serial/msm_serial.h |  2 ++
>  2 files changed, 22 insertions(+), 6 deletions(-)

I only have patch 1/3 in my inbox, please resend all of them, not just
individual ones you have redone, as that makes it impossible to keep
track of patches in series.

thanks,

greg k-h
