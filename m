From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2] tty: serial: msm_serial: Fix XON/XOFF
Date: Tue, 21 May 2019 16:01:17 +0530
Message-ID: <20190521103117.GD15118@vkoul-mobl>
References: <20190520183848.27719-1-jorge.ramirez-ortiz@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190520183848.27719-1-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc: agross@kernel.org, david.brown@linaro.org, gregkh@linuxfoundation.org, sboyd@kernel.org, bjorn.andersson@linaro.org, jslaby@suse.com, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 20-05-19, 20:38, Jorge Ramirez-Ortiz wrote:
> When the tty layer requests the uart to throttle, the current code
> executing in msm_serial will trigger "Bad mode in Error Handler" and
> generate an invalid stack frame in pstore before rebooting (that is if
> pstore is indeed configured: otherwise the user shall just notice a
> reboot with no further information dumped to the console).
> 
> This patch replaces the PIO byte accessor with the word accessor
> already used in PIO mode.
> 
> Fixes: 68252424a7c7 ("tty: serial: msm: Support big-endian CPUs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
