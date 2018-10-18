From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Date: Thu, 18 Oct 2018 09:17:06 -0400
Message-ID: <20181018091706.62310b38@gandalf.local.home>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
        <20181016112928.4b52afb5@gandalf.local.home>
        <8c2fb318-813d-81f1-1e2f-cdbc68353077@codeaurora.org>
        <20181016125721.236ada82@gandalf.local.home>
        <cab1be04-be06-6f53-7fe9-159936893fc8@codeaurora.org>
        <20181016134803.1b9260c1@gandalf.local.home>
        <472db11e-49a6-a1ee-e298-791ee1bbb10b@codeaurora.org>
        <20181016141610.639b9000@gandalf.local.home>
        <accdce6d-8fd2-9f15-d4cd-704cbf0b32eb@codeaurora.org>
        <20181016144123.24c47b38@gandalf.local.home>
        <7781815e-cba2-9e36-db6d-268298747876@codeaurora.org>
        <20181016150328.3450d718@gandalf.local.home>
        <c94103d2-ed5d-bf43-fc71-c60e108f303e@codeaurora.org>
        <20181017223334.29ca2837@vmware.local.home>
        <58d2474c-53cd-e6cb-2d25-db38d1a88da6@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <58d2474c-53cd-e6cb-2d25-db38d1a88da6@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, Kees Cook <keescook@chromium.org>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, Geliang Tang <geliangtang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Thu, 18 Oct 2018 10:51:18 +0530
Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:

> > So something else is causing an issue besides just msm_read.
> > 
> > Can you do an objdump -dr of the entire vmlinux binary and gzip it and
> > post it somewhere. Not sure if it would be too big to email. You could
> > try sending it to me privately. I'd like to see the binary that you are
> > using.
> >   
> 
> I have sent the objdump and dot config to you privately.

Thanks. I don't see anything that pops out, but then again, my arm asm
foo is very rusty (it has been literally decades since I did any arm
asm). I wonder if it could simply be a timing issue?

ffff0000086eb538 <msm_read.isra.1>:
ffff0000086eb538:       a9be7bfd        stp     x29, x30, [sp,#-32]!
ffff0000086eb53c:       910003fd        mov     x29, sp
ffff0000086eb540:       a90153f3        stp     x19, x20, [sp,#16]
ffff0000086eb544:       aa0003f4        mov     x20, x0
ffff0000086eb548:       2a0103f3        mov     w19, w1
ffff0000086eb54c:       aa1e03e0        mov     x0, x30
ffff0000086eb550:       97e6bae4        bl      ffff00000809a0e0 <_mcount>

The above is changed to nop on boot, but then to:

	bl ftrace_caller

When ftrace is enabled.

ffff0000086eb554:       8b334280        add     x0, x20, w19, uxtw
ffff0000086eb558:       b9400000        ldr     w0, [x0]
ffff0000086eb55c:       a94153f3        ldp     x19, x20, [sp,#16]
ffff0000086eb560:       a8c27bfd        ldp     x29, x30, [sp],#32
ffff0000086eb564:       d65f03c0        ret



ffff00000809a0e4 <ftrace_caller>:
ffff00000809a0e4:       a9bf7bfd        stp     x29, x30, [sp,#-16]!
ffff00000809a0e8:       910003fd        mov     x29, sp
ffff00000809a0ec:       d10013c0        sub     x0, x30, #0x4
ffff00000809a0f0:       f94003a1        ldr     x1, [x29]
ffff00000809a0f4:       f9400421        ldr     x1, [x1,#8]
ffff00000809a0f8:       d1001021        sub     x1, x1, #0x4

ffff00000809a0fc <ftrace_call>:
ffff00000809a0fc:       d503201f        nop

The above nop gets patched to:

	bl ftrace_ops_no_ops

Which will iterate through all the registered functions.


ffff00000809a100 <ftrace_graph_call>:
ffff00000809a100:       d503201f        nop

The above only gets set when function graph tracer is enabled, which it
is not in this case.

ffff00000809a104:       a8c17bfd        ldp     x29, x30, [sp],#16
ffff00000809a108:       d65f03c0        ret


Anyone see any problems here?

-- Steve
