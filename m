From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 4/6] serial: 8250/uniphier: fix modular build
Date: Fri, 12 Feb 2016 11:07:11 +0100
Message-ID: <3557175.oOjJgCHd2P@wuerfel>
References: <1455205297-1021302-1-git-send-email-arnd@arndb.de> <1455205297-1021302-5-git-send-email-arnd@arndb.de> <CAK7LNAR8fJWPubucjw28gAPpF-4yvVMWZZ0F3j6VN4whGF9Yhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNAR8fJWPubucjw28gAPpF-4yvVMWZZ0F3j6VN4whGF9Yhw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Friday 12 February 2016 18:37:08 Masahiro Yamada wrote:
> >  };
> >
> > -#ifdef CONFIG_SERIAL_8250_CONSOLE
> > +#if defined(CONFIG_SERIAL_8250_CONSOLE) && !defined(MODULE)
> >  static int __init uniphier_early_console_setup(struct earlycon_device *device,
> >                                                const char *options)
> >  {
> > --
> > 2.7.0
> >
> 
> I noticed commit 2eaa790989e03900298ad24f77f1086dbbc1aebd
> revived this link error, but I am not happy with seeing
> this patch again and again.
> 
> 
> Can you check this patch?
> https://patchwork.kernel.org/patch/8289231/
> 
> 
> 

Yes, I think your patch is nicer than mine. Let's see what the others
think, then I can resend my remaining patches on top of yours.

	Arnd
