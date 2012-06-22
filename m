From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 09/12] commit 22126843cb3c2a782c2d52614486115f3e9db478
Date: Fri, 22 Jun 2012 08:36:57 -0700
Message-ID: <20120622153657.GB6081@kroah.com>
References: <20120622153600.1405.15575.stgit@localhost.localdomain>
 <20120622154438.1405.43658.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120622154438.1405.43658.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 22, 2012 at 04:44:59PM +0100, Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> tty: move the termios object into the tty
> 
>     This will let us sort out a whole pile of tty related races. The
>     alternative would be to keep points and refcount the termios objects.
>     However
>     1. They are tiny anyway
>     2. Many devices don't use the stored copies
>     3. We can remove a pty special case
> 
>     Signed-off-by: Alan Cox <alan@linux.intel.com>

Odd subject line, and formatting, did something go wrong with your
scripts?
