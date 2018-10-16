From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Date: Tue, 16 Oct 2018 12:57:21 -0400
Message-ID: <20181016125721.236ada82@gandalf.local.home>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
        <20181016112928.4b52afb5@gandalf.local.home>
        <8c2fb318-813d-81f1-1e2f-cdbc68353077@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8c2fb318-813d-81f1-1e2f-cdbc68353077@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Kees Cook <keescook@chromium.org>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, Geliang Tang <geliangtang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Tue, 16 Oct 2018 22:05:23 +0530
Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:

> On 10/16/2018 8:59 PM, Steven Rostedt wrote:
> > On Tue, 16 Oct 2018 17:08:25 +0530
> > Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> >   
> >> Hi,
> >>
> >> On dragonboard 410c, with "ftrace=function" boot args, the console
> >> output slows down and board resets without any backtrace as below. This
> >> is tested on latest kernel and seems to exist even in older kernels as well.  
> > 
> > So this only happens when ftrace=function is on the boot console.
> >   
> 
> Yes. If I do not use boot console, target does not crash.
> 


> > 
> > Does function tracing work after boot up? That is, without the
> > ftrace=function, can you do:
> > 
> >   echo function > /sys/kernel/debug/tracing/current_tracer
> > 
> > without any issue?
> >   
> 
> Yes ftrace in general works without any issue. I have also tested on 
> db820c and sdm845 where "ftrace=function" works fine. I am seeing this 
> issue only on db410c board.

OK, can you add to the command line:

 ftrace=function ftrace_filter=*schedule*

to see if it's a specific function that may be causing the issue (but
hopefully it's not one of the scheduling functions that caused it).

> 
> >>
> >> One more thing is for pstore dmesg-ramoops, I had to change
> >> late_initcall to postcore_initcall which brings the question as to why
> >> we changed to late_initcall?
> >> Simple git blame shows to support crypto compress api, but is it really
> >> helpful? A lot of boottime issues can be caught with pstore enabled at
> >> postcore_initcall rather than late_initcall, this backtrace
> >> is just one example. Is there any way we could change this?  
> > 
> > Does it break if the crypto is not initialized? Perhaps add a command
> > line flag to have it happen earlier:
> >  
> 
> I didnt see any breakage, have been using ramoops with postcore_initcall 
> for sometime now.
> 
> >   ramoops=earlyinit
> > 
> > and add a postcore_initcall that checks if that flag is set, and if so,
> > it does the work then, and the late_initcall() will do nothing.
> > 
> > That way, you can still have unmodified kernels use pstore when it
> > crashes at boot up.
> >   
> 
> Sounds good.

Great, I guess you can write a patch to do that ;-)

-- Steve
