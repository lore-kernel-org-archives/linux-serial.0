From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH 1/4] printk: Introduce per-console loglevel setting
Date: Thu, 14 Mar 2019 23:12:49 +0900
Message-ID: <c7a9c83c-524d-c0da-a355-6cd4b7ec690c@I-love.SAKURA.ne.jp>
References: <20190308150914.ifqp36en3pyd4ljy@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308150914.ifqp36en3pyd4ljy@pathway.suse.cz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Calvin Owens <calvinowens@fb.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Petr Mladek wrote:
> It might be even more straightforward when the per-console value
> defines the effective console level. I mean the following semantic:
> 
>    + "console_loglevel" would define the default loglevel used
>      by consoles at runtime.
> 
>    + the per-console loglevel could override the default
>      console_loglevel.
> 
>    + We would need a custom handler for the sysctl "console_loglevel".
>      It would write the given value to the global console_loglevel
>      variable and for all already registered consoles (con->loglevel).

But some functions change console_loglevel without sysctl (e.g.
console_verbose() when reporting hung tasks and panic()). Should
con->loglevel be changed (which might result in too much messages to
slow consoles) when console_loglevel changes?

> 
>      The value will be used also for all newly registered consoles
>      when they do not have any custom one.
> 
> 
>    + The handler for "loglevel" early param should behave the same
>      as the sysctl handler.
> 
> 
> IMHO, there is no perfect solution. The advantage of the above
> proposal is that you "see" and "use" exactly what you "set".
