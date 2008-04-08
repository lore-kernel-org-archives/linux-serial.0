From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [PATCH] drivers/char/specialix.c: stop inlining largish static functions
Date: Wed, 9 Apr 2008 00:18:53 +0200
Message-ID: <200804090018.53053.vda.linux@googlemail.com>
References: <200804081244.53894.vda.linux@googlemail.com> <47FBE5C3.1040105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:2858 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbYDHWTR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 Apr 2008 18:19:17 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2067105fgb.17
        for <linux-serial@vger.kernel.org>; Tue, 08 Apr 2008 15:19:15 -0700 (PDT)
In-Reply-To: <47FBE5C3.1040105@gmail.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, R.E.Wolff@bitwizard.nl

On Tuesday 08 April 2008 23:38, Jiri Slaby wrote:
> > drivers/char/specialix.c has unusually large number
> > of static inline functions - 22.
> > 
> > I looked through them. The file is positively inline-happy.
> > Inlines with udelay() calls. Inlines with complex loops.
> > Nested inlines. Rarely called inlines (e.g. with request_region
> > inside).
> > 
> > This patch removes "inline" from 15 static functions
> > (regardless of number of callsites - gcc nowadays auto-inlines
> > statics with one callsite).
> > 
> > Size difference for 32bit x86:
> >    text    data     bss     dec     hex filename
> >   21669     204    8780   30653    77bd linux-2.6-ALLYES/drivers/char/specialix.o
> >   18470     204    8780   27454    6b3e linux-2.6.inline-ALLYES/drivers/char/specialix.o
> > 
> > 
> > Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>
> 
> -	static const char *badmagic =
> +	static const char badmagic[] =
>   		KERN_ERR "sx: Warning: bad specialix port magic number for device %s in %s\n";
> -	static const char *badinfo =
> +	static const char badinfo[] =
>   		KERN_ERR "sx: Warning: null specialix port for device %s in %s\n";
> 
> 
> BTW what's this good for? I mean, why we need this as a variable not directly as 
> a parameter?
> 
>   	if (!port) {
>   		printk(badinfo, name, routine);
>   		return 1;
>   	}
>   	if (port->magic != SPECIALIX_MAGIC) {
>   		printk(badmagic, name, routine);
>   		return 1;
>   	}

I am sure these strings can be used directly in printk,
there should be no size difference (sans gcc adding padding
to string arrays "just because").

I chose to make minimal change which only eliminates the waste
of having a pinter to these strings (char *msg = "xxx"
versus char msg[] = "xxx"), leaving more extensive editing
to someone who wants to attack specialix.c on the wider front.
--
vda
