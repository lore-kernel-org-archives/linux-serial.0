From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 1/3] tty: serial: msm: Move header file into driver
Date: Sun, 5 Jun 2016 14:03:34 -0500
Message-ID: <20160605190334.GG13357@hector.attlocal.net>
References: <20160512010228.21548-1-sboyd@codeaurora.org>
 <20160512010228.21548-2-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160512010228.21548-2-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Pramod Gurav <pramod.gurav@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Wed, May 11, 2016 at 06:02:26PM -0700, Stephen Boyd wrote:
> This header file is only used by the driver, so let's merge the
> two together to reduce files and make it easier to see the whole
> driver without flipping through two files. This also makes it
> easier to use the structures defined in msm_serial.c in the
> functions that are defined in msm_serial.h by placing them in the
> proper locations.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Andy Gross <andy.gross@linaro.org>
