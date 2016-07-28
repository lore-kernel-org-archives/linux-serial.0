From: David Miller <davem@davemloft.net>
Subject: Re: [patch -old] sparc: serial: sunhv: fix a double lock bug
Date: Wed, 27 Jul 2016 22:55:33 -0700 (PDT)
Message-ID: <20160727.225533.598242834832960771.davem@davemloft.net>
References: <20160715111733.GB13153@mwanda>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20160715111733.GB13153@mwanda>
Sender: sparclinux-owner@vger.kernel.org
To: dan.carpenter@oracle.com
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 15 Jul 2016 14:17:33 +0300

> We accidentally take the "port->lock" twice in a row.  This old code
> was supposed to be deleted.
> 
> Fixes: e58e241c1788 ('sparc: serial: Clean up the locking for -rt')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied and queued up for -stable, thanks Dan.
