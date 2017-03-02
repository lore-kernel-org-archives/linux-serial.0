From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 2/3] printk: rename selected_console ->
 preferred_console
Date: Thu, 2 Mar 2017 10:01:53 -0500
Message-ID: <20170302100153.410acdc9@gandalf.local.home>
References: <20170302131153.22733-1-aleksey.makarov@linaro.org>
        <20170302131153.22733-3-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170302131153.22733-3-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu,  2 Mar 2017 16:11:33 +0300
Aleksey Makarov <aleksey.makarov@linaro.org> wrote:

> The variable selected_console is set in __add_preferred_console()
> to point to the last console parameter that was added to the
> console_cmdline array.
> 
> Rename it to preferred_console so that the name reflects the usage.

As I said previously, I prefer "selected_console" but since
"__add_preferred_console()" sets it, I'm fine with this change.
Although, I would probably have changed that function to
"__add_selected_console()" :)

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Suggested-by: Peter Hurley <peter@hurleysoftware.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
