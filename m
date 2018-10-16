From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Date: Tue, 16 Oct 2018 13:48:03 -0400
Message-ID: <20181016134803.1b9260c1@gandalf.local.home>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
        <20181016112928.4b52afb5@gandalf.local.home>
        <8c2fb318-813d-81f1-1e2f-cdbc68353077@codeaurora.org>
        <20181016125721.236ada82@gandalf.local.home>
        <cab1be04-be06-6f53-7fe9-159936893fc8@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cab1be04-be06-6f53-7fe9-159936893fc8@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Kees Cook <keescook@chromium.org>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, Geliang Tang <geliangtang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Tue, 16 Oct 2018 23:06:24 +0530
Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:

> On 10/16/2018 10:27 PM, Steven Rostedt wrote:
> > 
> > OK, can you add to the command line:
> > 
> >   ftrace=function ftrace_filter=*schedule*
> > 
> > to see if it's a specific function that may be causing the issue (but
> > hopefully it's not one of the scheduling functions that caused it).
> >   
> 
> Target boots fine with this. So its not scheduling functions that is 
> causing it. Also I tried with ftrace_filter=*msm* just to be sure if
> tracing driver functions is causing any issue but its NOT.

OK, seems that something is being traced that shouldn't be.

When this happens after boot up, it's easy to bisect down to the
problem function. But since it's at boot up, it will take a lot longer.

I would suggest to start by going down the alphabet.

	ftrace_filter=a*
 	ftrace_filter=b*
	ftrace_filter=c*
	[...]

And at least find the letter the bad function starts with.

Note, it could be more than one function (I've had that a couple of
times), and to find that out, you can test with "ftrace_notrace". Say
you find that the problem function starts with 'x'. You can do:

	ftrace_notrace=x*

Which will trace all functions except those that start with an 'x', to
make sure it still boots.

Remember, you still need to have ftrace=function for all of this.

Once you find the letter of the function, you can try the next letter,
or perhaps come up with another method. I would say look at the
functions in /sys/kernel/debug/tracing/available_filter_functions, but
they don't list the init function (that can be traced). But you can
use /proc/kallsyms instead.

-- Steve
