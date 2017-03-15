From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 2/3] printk: rename selected_console ->
 preferred_console
Date: Wed, 15 Mar 2017 10:00:51 +0100
Message-ID: <20170315090050.GC2538@linux.suse>
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
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu 2017-03-02 10:01:53, Steven Rostedt wrote:
> On Thu,  2 Mar 2017 16:11:33 +0300
> Aleksey Makarov <aleksey.makarov@linaro.org> wrote:
> 
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

If I get it correctly, the selected_console/preferred_console
value is used to keep the console first in the console_drivers list.
IMHO, the main effect is that each line will first appear on this
console, see call_console_drivers(). But the message will still
appear also on all other enabled consoles. From this point,
the name "preferred" sounds better to me. More consoles
are selected (enabled) and only one is preferred (first).

Well, I am not a native speaker and might be wrong. Also
it is possible that I missed something.

Anyway, the change looks fine to me.

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
