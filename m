From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 1/3] printk: fix name/type/scope of preferred_console
 var
Date: Tue, 14 Mar 2017 17:52:44 +0100
Message-ID: <20170314165244.GH3977@pathway.suse.cz>
References: <20170302131153.22733-1-aleksey.makarov@linaro.org>
 <20170302131153.22733-2-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170302131153.22733-2-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu 2017-03-02 16:11:32, Aleksey Makarov wrote:
> The variable preferred_console is used only inside register_console()
> and its semantics is boolean.  It is negative when no console has been
> made preferred.
> 
> Make it static bool and rename to has_preferred.
> 
> Renaming was suggested by Peter Hurley
> 
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>

I am sorry for the late reply. I was sick.

The change looks fine to me.

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
