From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] tracing: fix typos in code and comments
Date: Tue, 21 May 2019 10:59:26 -0400
Message-ID: <20190521105926.5fa601da@gandalf.local.home>
References: <20190521144740.22490-1-houweitao@xiaomi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190521144740.22490-1-houweitao@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: houweitao <houweitaoo@gmail.com>
Cc: linus.walleij@linaro.org, yamada.masahiro@socionext.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, baohua@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net, mingo@redhat.com, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org, houweitao <houweitao@xiaomi.com>
List-Id: linux-serial@vger.kernel.org

On Tue, 21 May 2019 22:47:40 +0800
houweitao <houweitaoo@gmail.com> wrote:

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 2c92b3d9ea30..bfa5ab0663e7 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8554,7 +8554,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
>  	ftrace_init_tracefs(tr, d_tracer);
>  }
>  
> -static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
> +static struct vfsmount *trace_automount(struct dentry *mntpt, void *ignore)

"ingore we trust"

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

>  {
>  	struct vfsmount *mnt;
>  	struct file_system_type *type;
> -- 
