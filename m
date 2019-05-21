From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] tty: serial: msm_serial: Fix XON/XOFF
Date: Tue, 21 May 2019 12:11:31 +0200
Message-ID: <20190521101131.GC13612@kroah.com>
References: <20190520183848.27719-1-jorge.ramirez-ortiz@linaro.org>
 <20190520185008.GX2085@tuxbook-pro>
 <ef705e54-78bb-27e2-5060-31056234dad3@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ef705e54-78bb-27e2-5060-31056234dad3@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, agross@kernel.org, david.brown@linaro.org, sboyd@kernel.org, jslaby@suse.com, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, May 20, 2019 at 08:57:39PM +0200, Jorge Ramirez wrote:
> On 5/20/19 20:50, Bjorn Andersson wrote:
> > On Mon 20 May 11:38 PDT 2019, Jorge Ramirez-Ortiz wrote:
> > 
> >> When the tty layer requests the uart to throttle, the current code
> >> executing in msm_serial will trigger "Bad mode in Error Handler" and
> >> generate an invalid stack frame in pstore before rebooting (that is if
> >> pstore is indeed configured: otherwise the user shall just notice a
> >> reboot with no further information dumped to the console).
> >>
> >> This patch replaces the PIO byte accessor with the word accessor
> >> already used in PIO mode.
> >>
> >> Fixes: 68252424a7c7 ("tty: serial: msm: Support big-endian CPUs")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> >> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > You missed Stephen's
> > 
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> 
> argh sorry Stephen. can the maintainer add it when it gets merged or
> shall I post V3?

I'll fix it up...
