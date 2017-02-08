From: Rob Herring <robh@kernel.org>
Subject: Re: [patch] serdev: ttyport: check whether tty_init_dev() fails
Date: Wed, 8 Feb 2017 07:40:41 -0600
Message-ID: <CAL_Jsq+hznc9=iPguScORVuKBUviPUfjUY+2Ncdf5dnmdOPyNA@mail.gmail.com>
References: <20170208072324.GA12916@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170208072324.GA12916@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 8, 2017 at 1:23 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> My static checker complains that we don't have any error handling here.
> It's simple enough to add it.
>
> Fixes: bed35c6dfa6a ("serdev: add a tty port controller driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Rob Herring <robh@kernel.org>
