From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH] serial: imx: fix clk_prepare/unprepare usage
Date: Mon, 16 Nov 2015 15:11:27 +0100
Message-ID: <20151116141127.GB14555@gmail.com>
References: <1447322328-5171-1-git-send-email-marcus.folkesson@gmail.com>
 <CAOMZO5D0r6vsMA-XZMxzhfbCL0SzqTfd_gh=oOLWTZK5gctA0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5D0r6vsMA-XZMxzhfbCL0SzqTfd_gh=oOLWTZK5gctA0w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 16, 2015 at 10:49:01AM -0200, Fabio Estevam wrote:
> On Thu, Nov 12, 2015 at 7:58 AM, Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> > clk_prepare/unprapare APIs are not allowed in atomic context, so
> > move prepare/unprepare to probe/remove and use clk_enable/disable
> > instead.
> >
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> 
> Looks like you are using an older kernel.
> 
> Please check 0c727a42043f79db2.


You are right, the bug does not seems to exist anymore.

Thanks
