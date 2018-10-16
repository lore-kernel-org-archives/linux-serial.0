From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Date: Tue, 16 Oct 2018 15:16:11 -0400
Message-ID: <20181016151611.0b59ef3d@gandalf.local.home>
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
        <20181016151516.786b16cc@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016151516.786b16cc@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Jiri Slaby <jslaby@suse.com>, Kees Cook <keescook@chromium.org>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, Geliang Tang <geliangtang@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Tue, 16 Oct 2018 15:15:16 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I'd like to see the full command line as well. I bet if you remove the
> qcom,msm-uartdm from the command line, and had just ftrace=function, it
> may also boot fine too. Can you try that?

Note, I probably wont respond for the rest of the day.

-- Steve
