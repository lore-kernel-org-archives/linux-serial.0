From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] tty: serial: msm_serial: avoid system lockup condition
Date: Mon, 10 Jun 2019 19:05:35 +0200
Message-ID: <20190610170535.GA1337@kroah.com>
References: <20190610075554.24979-1-jorge.ramirez-ortiz@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190610075554.24979-1-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc: agross@kernel.org, david.brown@linaro.org, jslaby@suse.com, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, khasim.mohammed@linaro.org, bjorn.andersson@linaro.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jun 10, 2019 at 09:55:54AM +0200, Jorge Ramirez-Ortiz wrote:
> The function msm_wait_for_xmitr can be taken with interrupts
> disabled. In order to avoid a potential system lockup - demonstrated
> under stress testing conditions on SoC QCS404/5 - make sure we wait
> for a bounded amount of time.
> 
> Tested on SoC QCS404.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  drivers/tty/serial/msm_serial.c | 4 ++++
>  1 file changed, 4 insertions(+)

What changed from v1?  Always put that below the --- line.

v3 please.

thanks,

greg k-h
