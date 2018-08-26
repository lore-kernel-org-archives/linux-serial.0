From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: spin_lock instead of spin_lock_irqsave in imx uart interuput
Date: Sun, 26 Aug 2018 19:04:30 +0200
Message-ID: <20180826170430.GA12776@kroah.com>
References: <20180826150042.GA7972@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180826150042.GA7972@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: QIANJUN <hangdianqj@163.com>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Aug 26, 2018 at 08:00:42AM -0700, QIANJUN wrote:
> spin_lock instead of spin_lock_irqsave in imx uart interuput

What does that mean?

> >From 6580790d7be51a78d1376b90df49b04019a1f944 Mon Sep 17 00:00:00 2001
> From: jun qian <hangdianqj@163.com>
> Date: Sun, 26 Aug 2018 06:58:35 -0700
> Subject: [PATCH] before the programe into the uart interuput's handler, the
>  system has already disabled the local cpu interuput. so the spin_lock
>  interface is More suitable for here.

Why is this here?  The changelog text belongs in the changelog, not in
the subject line :(

can you fix this all up and resend?

thanks,

greg k-h
