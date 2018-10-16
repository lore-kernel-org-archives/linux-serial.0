From: Kees Cook <keescook@chromium.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Date: Tue, 16 Oct 2018 10:02:53 -0700
Message-ID: <CAGXu5jLBtBU1eX7tGX1gOVKSFKeLMeoke3bGHUuqxk86dLSnng@mail.gmail.com>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org> <20181016112928.4b52afb5@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016112928.4b52afb5@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, Geliang Tang <geliangtang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 16, 2018 at 8:29 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 16 Oct 2018 17:08:25 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
>> One more thing is for pstore dmesg-ramoops, I had to change
>> late_initcall to postcore_initcall which brings the question as to why
>> we changed to late_initcall?
>> Simple git blame shows to support crypto compress api, but is it really
>> helpful? A lot of boottime issues can be caught with pstore enabled at
>> postcore_initcall rather than late_initcall, this backtrace
>> is just one example. Is there any way we could change this?
>
> Does it break if the crypto is not initialized? Perhaps add a command
> line flag to have it happen earlier:
>
>  ramoops=earlyinit
>
> and add a postcore_initcall that checks if that flag is set, and if so,
> it does the work then, and the late_initcall() will do nothing.
>
> That way, you can still have unmodified kernels use pstore when it
> crashes at boot up.

Even better, if we could find a way to make it work with a late
initialization of compression (i.e. postcore_initcall() by default
means anything caught would be uncompressed, but anything after
late_initcall() would be compressed). I'd be very happy to review
patches for that!

-Kees

-- 
Kees Cook
Pixel Security
