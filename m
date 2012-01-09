From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] Updated TTY MAINTAINERS info
Date: Mon, 9 Jan 2012 14:52:23 -0800
Message-ID: <20120109225223.GA11356@suse.de>
References: <1326137964-10671-1-git-send-email-lucaskt@linux.vnet.ibm.com>
 <20120109200751.GA8337@suse.de>
 <4F0B4F66.8000302@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F0B4F66.8000302@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 09, 2012 at 06:34:46PM -0200, Lucas Kannebley Tavares wrote:
> On 01/09/2012 06:07 PM, Greg KH wrote:
> >On Mon, Jan 09, 2012 at 05:39:24PM -0200, Lucas Kannebley Tavares wrote:
> >>Greg Kroah-Hartman is the current TTY maintainer, however he wouldn't appear
> >>listed as such upon running get_maintainers.pl for drivers under
> >>drivers/tty/serial.
> >>
> >>Signed-off-by: Lucas Kannebley Tavares<lucaskt@linux.vnet.ibm.com>
> >>---
> >>  MAINTAINERS |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >>diff --git a/MAINTAINERS b/MAINTAINERS
> >>index cc6a466..6a856df 100644
> >>--- a/MAINTAINERS
> >>+++ b/MAINTAINERS
> >>@@ -6641,7 +6641,7 @@ TTY LAYER
> >>  M:	Greg Kroah-Hartman<gregkh@suse.de>
> >>  S:	Maintained
> >>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty-2.6.git
> >>-F:	drivers/tty/*
> >>+F:	drivers/tty/
> >
> >Isn't this just a bug in the get_maintainers.pl script?  Why does this
> >patch fix the problem?
> >
> >greg k-h
> >
> 
> To quote from MAINTAINERS
> 
> >	F: Files and directories with wildcard patterns.
> >	   A trailing slash includes all files and subdirectory files.
> >	   F:	drivers/net/	all files in and below drivers/net
> >	   F:	drivers/net/*	all files in drivers/net, but not below
> 
> In this case I believe you are the maintainer for the entire tree,
> or am I mistaken? If so, the documentation states that it shouldn't
> have an asterisk.

Ah, I missed that, you are correct.  I'll queue this up for the next
round of tty patches to go to Linus (after 3.3-rc1 is out.)

thanks,

greg k-h
