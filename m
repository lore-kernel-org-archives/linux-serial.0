From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 4/4] printk: Add a device attribute for the per-console
 loglevel
Date: Fri, 8 Mar 2019 12:11:21 +0900
Message-ID: <20190308031121.GA2480@jagdpanzerIV>
References: <cover.1551486732.git.calvinowens@fb.com>
 <4f71564063a07837e3c4df41326bad25e7dc4db4.1551486733.git.calvinowens@fb.com>
 <20190304080630.GA4495@jagdpanzerIV>
 <20190304191006.GA51516@calvinowens-mba.dhcp.thefacebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190304191006.GA51516@calvinowens-mba.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Calvin Owens <calvinowens@fb.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On (03/04/19 19:10), Calvin Owens wrote:
> On Monday 03/04 at 17:06 +0900, Sergey Senozhatsky wrote:
> > On (03/01/19 16:48), Calvin Owens wrote:
> > > +static struct attribute *console_sysfs_attrs[] = {
> > > +	&dev_attr_loglevel.attr,
> > > +	NULL,
> > > +};
> > > +ATTRIBUTE_GROUPS(console_sysfs);
> > > +
> > >  static struct bus_type console_subsys = {
> > >  	.name = "console",
> > > +	.dev_groups = console_sysfs_groups,
> > >  };
> > 
> > Do we really need to change this dynamically? Console options are
> > traditionally static (boot param or DT). Can we also be happy with
> > the static per-console loglevel?
> 
> It really does need to be runtime configurable: there are a lot of usecases
> that enables, like turning the fast console up to KERN_DEBUG on a pile of
> machines you want to take a closer look at. The 'kernel.printk' global
> loglevel is also already changable at runtime, and since that setting
> interacts with this one it would be strange if only the former were able
> to be changed.

Fair enough.

	-ss
