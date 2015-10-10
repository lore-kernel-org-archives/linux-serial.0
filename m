From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 4/5] drivers/tty: make serial/mpsc.c driver explicitly
 non-modular
Date: Sat, 10 Oct 2015 15:18:03 -0400
Message-ID: <20151010191802.GT14103@windriver.com>
References: <1440020889-12120-1-git-send-email-paul.gortmaker@windriver.com>
 <1440020889-12120-5-git-send-email-paul.gortmaker@windriver.com>
 <20151009133832.GA19165@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151009133832.GA19165@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

[Re: [PATCH 4/5] drivers/tty: make serial/mpsc.c driver explicitly non-modular] On 09/10/2015 (Fri 15:38) Thierry Reding wrote:

> On Wed, Aug 19, 2015 at 05:48:08PM -0400, Paul Gortmaker wrote:

[...]

> >  static struct platform_driver mpsc_driver = {
> >  	.probe	= mpsc_drv_probe,
> > -	.remove	= mpsc_drv_remove,
> >  	.driver	= {
> >  		.name	= MPSC_CTLR_NAME,
> >  	},
> 
> I don't think this is right. The driver can always be unbound from the
> device via sysfs, in which case it will now leak resources and leave
> behind a dangling UART port.

I suppose it does open the window for root to do something else stupid
he shouldn't be doing anyway...

I think the right thing to do here is for me to send a follow on patch
that does also set:

	.suppress_bind_attrs = true

in the above block, since this is a console device used on 2005 vintage
74xx based powerpc embedded targets, and is essentially always used in
conjunction with SERIAL_MPSC_CONSOLE=y -- there is no sane reason anyone
would ever want to unbind the builtin driver and lose the console.

I'll send a follow on patch doing the above if folks are in agreement
with the above logic.

Thanks,
Paul.
--

> 
> Thierry
