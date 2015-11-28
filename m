From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: The console log is doubled if earlycon is enabled
Date: Fri, 27 Nov 2015 16:04:51 -0800
Message-ID: <20151128000451.GB22297@kroah.com>
References: <CAK7LNAT5L2uxJ6i-QEYqw9qFLyvADu_E0F5VVTOPqyHbLodTCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK7LNAT5L2uxJ6i-QEYqw9qFLyvADu_E0F5VVTOPqyHbLodTCg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robherring2@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Nov 27, 2015 at 07:21:06PM +0900, Masahiro Yamada wrote:
> Hi,
> 
> 
> If I add "earlycon" to the kernel parameter, the log message
> on the earlycon is also displayed to the regular console.
> In other words, the same log messages are displayed twice.
> 
> I noticed this problem on v4.4-rc1.
> It has not been fixed in the mainline yet, I think.
> 
> Anybody who has a clue?
> (I have not done git-bisect yet.)

Can you do 'git bisect'?

thanks,

greg k-h
