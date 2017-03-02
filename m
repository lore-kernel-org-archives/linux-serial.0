From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v2 2/3] printk: rename selected_console ->
 preferred_console
Date: Fri, 3 Mar 2017 01:09:28 +0900
Message-ID: <20170302160928.GF488@tigerII.localdomain>
References: <20170302131153.22733-1-aleksey.makarov@linaro.org>
 <20170302131153.22733-3-aleksey.makarov@linaro.org>
 <20170302100153.410acdc9@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170302100153.410acdc9@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (03/02/17 10:01), Steven Rostedt wrote:
> > The variable selected_console is set in __add_preferred_console()
> > to point to the last console parameter that was added to the
> > console_cmdline array.
> > 
> > Rename it to preferred_console so that the name reflects the usage.
> 
> As I said previously, I prefer "selected_console" but since
> "__add_preferred_console()" sets it, I'm fine with this change.
> Although, I would probably have changed that function to
> "__add_selected_console()" :)
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

agree, I'd *probably* do a function rename. just 3 lines of code to
touch (afaics).

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
