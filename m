From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH] tty: serial: msm: Don't read off end of tx fifo
Date: Sun, 5 Jun 2016 13:44:43 -0500
Message-ID: <20160605184443.GD13357@hector.attlocal.net>
References: <1464914908-19059-1-git-send-email-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464914908-19059-1-git-send-email-bjorn.andersson@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: David Brown <david.brown@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Nicolas Dechesne <nicolas.dechesne@linaro.org>, Ivan Ivanov <iivanov.xz@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jun 02, 2016 at 05:48:28PM -0700, Bjorn Andersson wrote:
> For dm uarts in pio mode tx data is transferred to the fifo register 4
> bytes at a time, but care is not taken when these 4 bytes spans the end
> of the xmit buffer so the loop might read up to 3 bytes past the buffer
> and then skip the actual data at the beginning of the buffer.
> 
> Fix this by, analogous to the DMA case, make sure the chunk doesn't
> wrap the xmit buffer.
> 
> Fixes: 3a878c430fd6 ("tty: serial: msm: Add TX DMA support")
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: Ivan Ivanov <iivanov.xz@gmail.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: stable@vger.kernel.org
> Reported-by: Frank Rowand <frowand.list@gmail.com>
> Reported-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Acked-by: Andy Gross <andy.gross@linaro.org>
