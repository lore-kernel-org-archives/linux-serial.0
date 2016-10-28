From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] uart_close related fixes
Date: Fri, 28 Oct 2016 08:13:49 -0400
Message-ID: <20161028121349.GA11555@kroah.com>
References: <20161028120748.27763-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161028120748.27763-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Mike Galbraith <mgalbraith@suse.de>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Geert Uytterhoeven <geert+renesas@glider.be>, Mugunthan V N <mugunthanvnm@ti.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 28, 2016 at 07:07:46AM -0500, Rob Herring wrote:
> Greg,
> 
> As discussed, these are the 2 fixes needed to fix regressions with 
> 761ed4a94582ab29 ("tty: serial_core: convert uart_close to use 
> tty_port_close"). Hopefully these fix all the fallout.
> 
> These apply on top of the previous patch from me which you applied.

Thanks for them, all now applied.

greg k-h
