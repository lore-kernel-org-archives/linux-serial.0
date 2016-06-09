From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH] tty: serial: msm: fix definition of msm_stop_dma
Date: Thu, 9 Jun 2016 14:21:01 -0500
Message-ID: <20160609192101.GK13357@hector.attlocal.net>
References: <1465323112-32366-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465323112-32366-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, David Brown <david.brown@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tue, Jun 07, 2016 at 07:11:52PM +0100, Ben Dooks wrote:
> The msm_stop_dma() is not exported from the driver, so make
> it static to stop the following warning:
> 
> drivers/tty/serial/msm_serial.c:84:6: warning: symbol 'msm_stop_dma' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Good find.

Acked-by: Andy Gross <andy.gross@linaro.org>
