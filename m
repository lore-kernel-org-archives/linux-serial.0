From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] serial: xuartps: Enable OF earlycon support
Date: Sat, 5 Mar 2016 14:19:49 -0800
Message-ID: <20160305221949.GA19842@kroah.com>
References: <09f2c419994281fca7968142e52d969542370d1c.1455782238.git.michal.simek@xilinx.com>
 <56C5F670.50005@hurleysoftware.com>
 <56CEFBD7.40008@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56CEFBD7.40008@monstr.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: Peter Hurley <peter@hurleysoftware.com>, Michal Simek <michal.simek@xilinx.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Feb 25, 2016 at 02:04:23PM +0100, Michal Simek wrote:
> Hi Greg,
> 
> On 18.2.2016 17:50, Peter Hurley wrote:
> > On 02/17/2016 11:57 PM, Michal Simek wrote:
> >> Support early console setup via DT for all listed compatible strings.
> >> Remove EARLYCON_DECLARE which was done by:
> >> "Use common framework for earlycon declarations"
> >> (sha1: 2eaa790989e03900298ad24f77f1086dbbc1aebd)
> >> when OF_EARLYCON_DECLARE is defined.
> > 
> > Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
> 
> Can you please add it your queue for 4.6?
> Or can we merge it via arm-soc tree as was suggested by Arnd here?
> https://lkml.org/lkml/2016/2/16/315

I can take it, thanks.

greg k-h
