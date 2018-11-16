From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Date: Fri, 16 Nov 2018 09:09:20 +0530
Message-ID: <CAOh2x=kHQ_PfZqcoDE1+jx-ArMOh4hAFqXxiiKJ9=3JZUySQEw@mail.gmail.com>
References: <472db11e-49a6-a1ee-e298-791ee1bbb10b@codeaurora.org>
 <20181016141610.639b9000@gandalf.local.home> <accdce6d-8fd2-9f15-d4cd-704cbf0b32eb@codeaurora.org>
 <20181016144123.24c47b38@gandalf.local.home> <7781815e-cba2-9e36-db6d-268298747876@codeaurora.org>
 <20181016150328.3450d718@gandalf.local.home> <c94103d2-ed5d-bf43-fc71-c60e108f303e@codeaurora.org>
 <20181017223334.29ca2837@vmware.local.home> <58d2474c-53cd-e6cb-2d25-db38d1a88da6@codeaurora.org>
 <20181018091706.62310b38@gandalf.local.home> <20181019041740.GB141835@joelaf.mtv.corp.google.com>
 <8a75f2d5-f1bd-504e-b545-ae2e2f61ca8f@codeaurora.org> <20181019095122.0f1c0946@gandalf.local.home>
 <9cafe321-87f6-98a3-3bda-c2f7a3d7fc67@codeaurora.org> <20181019111205.5c8e98e8@gandalf.local.home>
 <1e6cc1fa5263b9edfcf7567d3f9f65fd@codeaurora.org> <38099043-f5ed-6d81-bf94-13f61cfa8507@linaro.org>
 <8f65f83b-8cd9-5e35-c324-30b86390906e@codeaurora.org> <ed648cc5-0748-8bcc-5ebb-ce6dbc7d4fee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ed648cc5-0748-8bcc-5ebb-ce6dbc7d4fee@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: saiprakash.ranjan@codeaurora.org, Steven Rostedt <rostedt@goodmis.org>, sboyd@kernel.org, joel@joelfernandes.org, bjorn.andersson@linaro.org, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, Kees Cook <keescook@chromium.org>, geliangtang@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, gpramod@codeaurora.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, vivek.gautam@codeaurora.org, sibis@codeaurora.org
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 15, 2018 at 4:23 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> Yes, this is not the solution, but it proves that the hand-off between
> booloaders and kernel is the issue.
>
> In general there is wider issue with resources hand-off between
> bootloader and kernel.
>
> There has been some proposal in the past by Viresh for a new framework
> called boot-constriants (https://lkml.org/lkml/2017/12/14/440) which am
> not sure if its still actively looked at. But something similar should
> be the way to address such issues.

It isn't dead code yet and I am waiting to gain few more use-cases
before I attempt
to convince Greg again :)

Here is the code..

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git boot-constraint

--
viresh
