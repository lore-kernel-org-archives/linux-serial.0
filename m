From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v7 3/3] printk: fix double printing with earlycon
Date: Mon, 20 Mar 2017 15:16:58 +0900
Message-ID: <20170320061206.GA594@jagdpanzerIV.localdomain>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170317134352.5725-1-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317134352.5725-1-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>
List-Id: linux-serial@vger.kernel.org

Hello,

On (03/17/17 16:43), Aleksey Makarov wrote:
[..]
> +static void ensure_preferred_is_last(int i)
> +{
> +	int last;
> +
> +	for (last = MAX_CMDLINECONSOLES - 1;
> +	     last >= 0 && !console_cmdline[last].name[0];
> +	     last--)
> +		;
> +
> +	BUG_ON(last < 0);

let's not panic().


a nitpick, console swap can be done as

	if (i != last)
		swap(console_cmdline[i], console_cmdline[last]);
	preferred_console = last;


		-ss
