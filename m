From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 2/2] kgdboc: Change printk to the right fashion
Date: Tue, 14 Aug 2018 15:41:32 +0100
Message-ID: <20180814144132.mpqzz3sxdbfzn7fe@holly.lan>
References: <1534250761-824-1-git-send-email-zhe.he@windriver.com>
 <1534250761-824-2-git-send-email-zhe.he@windriver.com>
 <20180814133536.bfpygzwnmlqfsee5@holly.lan>
 <1678613360b7aebbf1ab42dd89139cb666ee8cd9.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1678613360b7aebbf1ab42dd89139cb666ee8cd9.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <golf@perches.com>
Cc: zhe.he@windriver.com, jason.wessel@windriver.com, gregkh@linuxfoundation.org, jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 14, 2018 at 07:04:11AM -0700, Joe Perches wrote:
> On Tue, 2018-08-14 at 14:35 +0100, Daniel Thompson wrote:
> > On Tue, Aug 14, 2018 at 08:46:01PM +0800, zhe.he@windriver.com wrote:
> > > From: He Zhe <zhe.he@windriver.com>
> > > 
> > > pr_* is preferred according to scripts/checkpatch.pl.
> []
> > > diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> []
> > > @@ -136,7 +136,7 @@ static int kgdboc_option_setup(char *opt)
> > >  	}
> > >  
> > >  	if (strlen(opt) >= MAX_CONFIG_LEN) {
> > > -		printk(KERN_ERR "kgdboc: config string too long\n");
> > > +		pr_err("kgdboc: config string too long\n");
> > 
> > Looks like you should remove the tags from pr_err and use pr_fmt(fmt) to
> > put tags on the messages:
> > 
> > #define pr_fmt(fmt) "kgdboc: " fmt
> 
> True and it's probably better to use:
> 
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Good point! Thanks.


Daniel.
