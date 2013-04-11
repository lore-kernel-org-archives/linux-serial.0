From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] drivers: tty: serial: tegra: use devm_ioremap_resource()
Date: Thu, 11 Apr 2013 13:24:34 -0700
Message-ID: <20130411202434.GA31078@kroah.com>
References: <1365710337-12251-1-git-send-email-silviupopescu1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1365710337-12251-1-git-send-email-silviupopescu1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Stephen Warren <swarren@wwwdotorg.org>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 11, 2013 at 10:58:57PM +0300, Silviu-Mihai Popescu wrote:
> Convert  use of devm_request_and_ioremap() to the newly introduced
> devm_ioremap_resource() which provides more consistent error handling.
> 
> devm_ioremap_resource() provides its own error messages so all explicit
> error messages can be removed from the failure code paths.
> 
> This was found with coccinelle.

And it's already in my tree, please always work off of linux-next to
avoid doing the same thing that others have done.

sorry,

greg k-h
