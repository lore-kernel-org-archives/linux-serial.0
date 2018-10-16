From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Date: Tue, 16 Oct 2018 13:44:48 +0200
Message-ID: <20181016114448.GB21790@kroah.com>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Kees Cook <keescook@chromium.org>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, Geliang Tang <geliangtang@gmail.com>, Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 16, 2018 at 05:08:25PM +0530, Sai Prakash Ranjan wrote:
> Hi,
> 
> On dragonboard 410c, with "ftrace=function" boot args, the console output
> slows down and board resets without any backtrace as below. This is tested
> on latest kernel and seems to exist even in older kernels as well.
> 
> [    2.949164] EINJ: ACPI disabled.
> [    3.133001] Serial: 8250/16550 dri
> Format: Log Type - Time(microsec) - Message - Optional Info
> Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
> 
> But with pstore enabled, able to get the below backtrace:
> 
> <4>[    2.949164] EINJ: ACPI disabled.
> <6>[    3.133001] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> <6>[    3.164097] SuperH (H)SCI(F) driver initialized
> <0>[    3.164471] Internal error: synchronous external abort: 96000010 [#1]
> PREEMPT SMP
> <4>[    3.164479] Modules linked in:
> <4>[    3.164495] CPU: 2 PID: 1 Comm: swapper/0 Not tainted
> 4.19.0-rc8-00008-ge033b9909fff-dirty #175
> <4>[    3.164501] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC
> (DT)
> <4>[    3.164508] pstate: 40000085 (nZcv daIf -PAN -UAO)
> <4>[    3.164514] pc : msm_read.isra.2+0x20/0x50
> <4>[    3.164520] lr : msm_read.isra.2+0x1c/0x50
> <4>[    3.164526] sp : ffff000008033a50
> <4>[    3.164531] x29: ffff000008033a50 x28: ffff000009486018
> <4>[    3.164548] x27: 0000000000000001 x26: ffff7dfffe7ff070
> <4>[    3.164565] x25: 0000000000000034 x24: ffff000009486000
> <4>[    3.164582] x23: 0000000000000000 x22: ffff00000978e190
> <4>[    3.164599] x21: ffff0000095e8228 x20: 0000000000000034
> <4>[    3.164616] x19: ffff7dfffe7ff008 x18: ffffffffffffffff
> <4>[    3.164632] x17: 0000000000000000 x16: 0000000000000000
> <4>[    3.164649] x15: ffff0000094a96c8 x14: ffff00008978e6bf
> <4>[    3.164666] x13: ffff00000978e6cd x12: 0000000000000038
> <4>[    3.164683] x11: ffff0000094c6000 x10: 0000000000000c24
> <4>[    3.164699] x9 : ffff80003c89b400 x8 : ffff000008033970
> <4>[    3.164716] x7 : ffff80000eb04100 x6 : 00000000000af304
> <4>[    3.164732] x5 : 0000000000000c40 x4 : ffff80003c06f000
> <4>[    3.164750] x3 : ffff80003c89b498 x2 : 0000000000000000
> <4>[    3.164766] x1 : ffff80003ca68000 x0 : 0000000000000800
> <0>[    3.164785] Process swapper/0 (pid: 1, stack limit =
> 0x(____ptrval____))
> <4>[    3.164791] Call trace:
> <4>[    3.164797]  msm_read.isra.2+0x20/0x50
> <4>[    3.164804]  msm_reset_dm_count+0x44/0x80
> <4>[    3.164810]  __msm_console_write+0x1c8/0x1d0
> <4>[    3.164816]  msm_serial_early_write_dm+0x3c/0x50
> <4>[    3.164823]  console_unlock.part.6+0x468/0x528
> <4>[    3.164829]  vprintk_emit+0x210/0x218
> <4>[    3.164835]  vprintk_default+0x48/0x58
> <4>[    3.164841]  vprintk_func+0xf0/0x1c0
> <4>[    3.164847]  printk+0x74/0x94
> <4>[    3.164853]  sci_init+0x24/0x3c
> <4>[    3.164859]  do_one_initcall+0x54/0x248
> <4>[    3.164866]  kernel_init_freeable+0x210/0x378
> <4>[    3.164872]  kernel_init+0x18/0x118
> <4>[    3.164878]  ret_from_fork+0x10/0x1c
> <0>[    3.164884] Code: aa1e03e0 8b214273 97e616f7 d503201f (b9400260)
> 
> Seems to be issue with the msm serial driver and not ftrace.
> Could someone look into it.

As you have the hardware to reproduce this, and it has always been an
issue, you are the best placed to help resolve this.

Good luck!

greg k-h
