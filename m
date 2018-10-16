From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Date: Tue, 16 Oct 2018 13:51:08 -0700
Message-ID: <153972306834.5275.7510298070540576604@swboyd.mtv.corp.google.com>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
 <472db11e-49a6-a1ee-e298-791ee1bbb10b@codeaurora.org>
 <20181016141610.639b9000@gandalf.local.home>
 <accdce6d-8fd2-9f15-d4cd-704cbf0b32eb@codeaurora.org>
 <20181016144123.24c47b38@gandalf.local.home>
 <7781815e-cba2-9e36-db6d-268298747876@codeaurora.org>
 <20181016150328.3450d718@gandalf.local.home>
 <c94103d2-ed5d-bf43-fc71-c60e108f303e@codeaurora.org>
 <20181016151516.786b16cc@gandalf.local.home>
 <0b014d85-9988-0bf5-7b72-911dbbcdadfc@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0b014d85-9988-0bf5-7b72-911dbbcdadfc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, Kees Cook <keescook@chromium.org>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, Geliang Tang <geliangtang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

Quoting Sai Prakash Ranjan (2018-10-16 12:35:57)
> On 10/17/2018 12:45 AM, Steven Rostedt wrote:
> > On Wed, 17 Oct 2018 00:36:05 +0530
> > Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> > =

> >> On 10/17/2018 12:33 AM, Steven Rostedt wrote:
> >>> On Wed, 17 Oct 2018 00:31:03 +0530
> >>> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> >>>    =

> >>>> Haa seems like you are right! With "ftrace=3Dfunction
> >>>> ftrace_filter=3Dmsm_read" , I can trigger the crash, but
> >>>> sadly "ftrace_notrace=3Dmsm_read" also crashes.
> >>>
> >>> So there's more than one problem area.
> >>>
> >>> What about ftrace_notrace=3Dm*
> >>>
> >>> ?
> >>>    =

> >>
> >> That too crashes.
> >>
> > =

> > Which compiler are you using and can you send me your config.
> > =

> Config attached.
> =

> Compiler: aarch64-linux-gnu-gcc (Linaro GCC 6.3-2017.02) 6.3.1 20170109
> =

> > I wonder if there's something screwing up with the way ftrace nops are
> > working on this board.
> > =

> > A couple things of note, 1) it works fine after boot up. 2) it crashes
> > in the initcall code, so it's not due to ftrace being enabled too early.
> > =

> > I'd like to see the full command line as well. I bet if you remove the
> > qcom,msm-uartdm from the command line, and had just ftrace=3Dfunction, =
it
> > may also boot fine too. Can you try that?
> > =

> =

> Kernel command line: root=3D/dev/disk/by-partlabel/rootfs rw rootwait =

> ftrace=3Dfunction ftrace_notrace=3Dm* earlycon console=3DttyMSM0,115200n8
> =

> qcom,msm-uartdm is not in command line, it is the earlycon. So without =

> earlycon(bootconsole), board boots fine as we discussed earlier.
> =


Have you tried with earlycon and no ftrace things on the commandline?

 root=3D/dev/disk/by-partlabel/rootfs rw rootwait earlycon console=3DttyMSM=
0,115200n8

If earlycon is causing problems, it sounds like this may be another case
of earlycon uart handing off to the uart driver and that failing because
something gets printed while the uart is transitioning from the earlycon
console to the kernel boot console. I recall the uart would trample on
itself in interesting ways.
