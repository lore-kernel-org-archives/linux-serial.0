From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: How to enable output to serial console at run-time?
Date: Thu, 2 Nov 2017 17:53:22 +0100
Message-ID: <20171102165322.GA19434@kroah.com>
References: <3c348fe1-1474-6c19-691d-8130d4bd0d32@molgen.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3c348fe1-1474-6c19-691d-8130d4bd0d32@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Menzel <pmenzel+linux-serial@molgen.mpg.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 02, 2017 at 04:39:36PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> If I want to output the Linux kernel messages to the serial console, but the
> `console=ttyS…` line is missing on the Linux command line, is there a way to
> activate that during run-time by, for example, using the sysfs interface?

Why not change the command line to enable it properly?

thanks,

greg k-h
