From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 4/5] drivers/tty/serial: make msm_serial.c explicitly
 non-modular
Date: Mon, 19 Oct 2015 12:44:25 -0700
Message-ID: <56254819.6030809@codeaurora.org>
References: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
 <1445206878-12455-5-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1445206878-12455-5-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Andy Gross <agross@codeaurora.org>, David Brown <davidb@codeaurora.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 10/18/2015 03:21 PM, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
>
> drivers/tty/serial/Kconfig:config SERIAL_MSM
> drivers/tty/serial/Kconfig:     bool "MSM on-chip serial port support"
>
> ...meaning that it currently is not being built as a module by anyone.
>
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
>
> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, and it allows us to drop the ".remove"
> code for non-modular drivers.
>
> Since module_init translates to device_initcall in the non-modular
> case, the init ordering remains unchanged with this commit.
>
> We don't replace module.h with init.h since the file already has that.
>
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Andy Gross <agross@codeaurora.org>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-soc@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---

I'd prefer we make the Kconfig a tristate. I'll test out that
configuration today, but I don't see why it wouldn't work.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
