From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Date: Fri, 19 Oct 2018 11:12:05 -0400
Message-ID: <20181019111205.5c8e98e8@gandalf.local.home>
References: <472db11e-49a6-a1ee-e298-791ee1bbb10b@codeaurora.org>
        <20181016141610.639b9000@gandalf.local.home>
        <accdce6d-8fd2-9f15-d4cd-704cbf0b32eb@codeaurora.org>
        <20181016144123.24c47b38@gandalf.local.home>
        <7781815e-cba2-9e36-db6d-268298747876@codeaurora.org>
        <20181016150328.3450d718@gandalf.local.home>
        <c94103d2-ed5d-bf43-fc71-c60e108f303e@codeaurora.org>
        <20181017223334.29ca2837@vmware.local.home>
        <58d2474c-53cd-e6cb-2d25-db38d1a88da6@codeaurora.org>
        <20181018091706.62310b38@gandalf.local.home>
        <20181019041740.GB141835@joelaf.mtv.corp.google.com>
        <8a75f2d5-f1bd-504e-b545-ae2e2f61ca8f@codeaurora.org>
        <20181019095122.0f1c0946@gandalf.local.home>
        <9cafe321-87f6-98a3-3bda-c2f7a3d7fc67@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9cafe321-87f6-98a3-3bda-c2f7a3d7fc67@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, Kees Cook <keescook@chromium.org>, Geliang Tang <geliangtang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Fri, 19 Oct 2018 20:18:19 +0530
Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:


> > You said that if you add 'ftrace_filter=msm_read' to the command line,
> > it still crashes?
> > 
> > So only tracing that function we have an issue, right?
> >   
> 
> Tracing msm_read does cause the crash, but that is not the only one 
> causing the crash because even after "ftrace_notrace=msm_read" the board 
> crashes which is why I suspect msm earlycon and not ftrace.

I'm saying there's a combination of the two. Because when ftrace is not
involved, early con doesn't crash.

I would focus on why earlycon crashes when only msm_read is traced.
That should help narrow down the cause.

What we know is:

	earlycon -> boots

	ftrace=function -> boots

 	earlycon ftrace=function ftrace_filter=msm_read -> crashes

If we remove the "ftrace=function ftrace_filter=msm_read" it boots
fine, and I'm assuming that if we just remove earlycon (keeping the
ftrace_filter), it also boots too.

Thus, ftrace tracing msm_read is causing earlycon to do something that
triggers the crash.

-- Steve
