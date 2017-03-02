From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v2 1/3] printk: fix name/type/scope of preferred_console
 var
Date: Fri, 3 Mar 2017 00:59:37 +0900
Message-ID: <20170302155937.GE488@tigerII.localdomain>
References: <20170302131153.22733-1-aleksey.makarov@linaro.org>
 <20170302131153.22733-2-aleksey.makarov@linaro.org>
 <20170302094927.72989efe@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170302094927.72989efe@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (03/02/17 09:49), Steven Rostedt wrote:
> > The variable preferred_console is used only inside register_console()
> > and its semantics is boolean.  It is negative when no console has been
> > made preferred.
> > 
> > Make it static bool and rename to has_preferred.
> > 
> > Renaming was suggested by Peter Hurley
> > 
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
