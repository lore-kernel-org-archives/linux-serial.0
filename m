From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 4/4] printk: Add a device attribute for the per-console
 loglevel
Date: Mon, 4 Mar 2019 17:06:30 +0900
Message-ID: <20190304080630.GA4495@jagdpanzerIV>
References: <cover.1551486732.git.calvinowens@fb.com>
 <4f71564063a07837e3c4df41326bad25e7dc4db4.1551486733.git.calvinowens@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4f71564063a07837e3c4df41326bad25e7dc4db4.1551486733.git.calvinowens@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Calvin Owens <calvinowens@fb.com>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On (03/01/19 16:48), Calvin Owens wrote:
> +static ssize_t loglevel_store(struct device *dev, struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	struct console *con = container_of(dev, struct console, dev);
> +	ssize_t ret;
> +	int tmp;
> +
> +	ret = kstrtoint(buf, 10, &tmp);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (tmp < LOGLEVEL_EMERG)
> +		return -ERANGE;
> +
> +	/*
> +	 * Mimic the behavior of /dev/kmsg with respect to minimum_loglevel.
> +	 */
> +	if (tmp < minimum_console_loglevel)
> +		tmp = minimum_console_loglevel;
> +
> +	con->level = tmp;
> +	return ret;
> +}
> +
> +static DEVICE_ATTR_RW(loglevel);
> +
> +static struct attribute *console_sysfs_attrs[] = {
> +	&dev_attr_loglevel.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(console_sysfs);
> +
>  static struct bus_type console_subsys = {
>  	.name = "console",
> +	.dev_groups = console_sysfs_groups,
>  };

Do we really need to change this dynamically? Console options are
traditionally static (boot param or DT). Can we also be happy with
the static per-console loglevel?

	-ss
