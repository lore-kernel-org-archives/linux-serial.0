From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 0/2] serial: sh-sci: Prepare for CCF migration
Date: Fri, 29 Nov 2013 11:15:10 +0900
Message-ID: <CANqRtoQ6psafVPdJL9usgxJj3uecphfDoknG3+mL_ywM3A1eOQ@mail.gmail.com>
References: <1385658706-20093-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1385658706-20093-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-serial@vger.kernel.org

On Fri, Nov 29, 2013 at 2:11 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Hello,
>
> This patch set prepares the driver to CCF migration by replacing clk_enable()
> and clk_disable() by clk_prepare_enable() and clk_disable_unprepare()
> respectively (2/2). In order to do so it first ensures that the clk_enable()
> and clk_disable() calls will only take place from non-atomic context (1/2).
>
> Greg, these patches are dependencies for a bunch of ARM patches that will go
> through Simon's tree. Would you be fine if Simon merged all sh-sci patches
> through his tree for v3.14 ?
>
> Laurent Pinchart (2):
>   serial: sh-sci: Don't enable/disable port from within break timer
>   serial: sh-sci: Convert to clk_prepare/unprepare
>
>  drivers/tty/serial/sh-sci.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

Looking good, thanks for hacking this up! For this series:

Acked-by: Magnus Damm <damm@opensource.se>

Cheers,

/ magnus
