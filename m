From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 1/2] TTY: Add TTY slave enumeration support
Date: Fri, 25 Jan 2013 13:45:44 -0800
Message-ID: <20130125214544.GB30924@kroah.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <cover.1359022955.git.lv.zheng@intel.com>
 <12848b50e1096dc11a193694ee248d51d45ce093.1359022955.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <12848b50e1096dc11a193694ee248d51d45ce093.1359022955.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: Alan Cox <alan@linux.intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jan 24, 2013 at 06:30:21PM +0800, Lv Zheng wrote:
> +static void tty_slave_release(struct device *dev)
> +{
> +	struct tty_slave *tts = to_tty_slave(dev);
> +
> +	kfree(tts);
> +	/* Test code to see if slave device get released */
> +	BUG();
> +}

You send me a patch like this and expect me to apply it when it's
obvious you didn't even test it out?  That's the most _basic_ test for
any dynamic type of device (add it and remove it and make sure the
kernel still works.)  And obviously you didn't do it.

I need a really good reason why to take you seriously now.

Intel kernel developers who know better, please take this internally and
review it a bunch of times, I don't want to see it anytime soon again.

greg k-h
