From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Subject: Re: [PATCH] drivers/char/specialix.c: stop inlining largish static functions
Date: Wed, 9 Apr 2008 00:15:17 +0200
Message-ID: <20080408221517.GB24755@bitwizard.nl>
References: <200804081244.53894.vda.linux@googlemail.com> <47FBE5C3.1040105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from dtp.xs4all.nl ([80.126.206.180]:60449 "HELO abra2.bitwizard.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752881AbYDHWPT (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 Apr 2008 18:15:19 -0400
Content-Disposition: inline
In-Reply-To: <47FBE5C3.1040105@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Denys Vlasenko <vda.linux@googlemail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, R.E.Wolff@bitwizard.nl

On Tue, Apr 08, 2008 at 11:38:11PM +0200, Jiri Slaby wrote:
> 
> -	static const char *badmagic =
> +	static const char badmagic[] =
>  		KERN_ERR "sx: Warning: bad specialix port magic number for 
>  		device %s in %s\n";
[...]
>  	if (port->magic != SPECIALIX_MAGIC) {
>  		printk(badmagic, name, routine);
>  		return 1;
>  	}

In a galaxy, far, far away, someone thought that this would save
memory. Especially if you print a message multiple times, the compiler
usually doesn't merge the string constants of two copies of: 

	printk (KERN_ERR "Bad magic number...");

Maybe it does now. (I don't think I came up with this. I probably
copied it over from somewhere....)

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
**    Delftechpark 26 2628 XH  Delft, The Netherlands. KVK: 27239233    **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
