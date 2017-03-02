From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 1/3] printk: fix name/type/scope of preferred_console
 var
Date: Thu, 2 Mar 2017 09:49:27 -0500
Message-ID: <20170302094927.72989efe@gandalf.local.home>
References: <20170302131153.22733-1-aleksey.makarov@linaro.org>
        <20170302131153.22733-2-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170302131153.22733-2-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu,  2 Mar 2017 16:11:32 +0300
Aleksey Makarov <aleksey.makarov@linaro.org> wrote:

> The variable preferred_console is used only inside register_console()
> and its semantics is boolean.  It is negative when no console has been
> made preferred.
> 
> Make it static bool and rename to has_preferred.
> 
> Renaming was suggested by Peter Hurley
> 

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> ---
