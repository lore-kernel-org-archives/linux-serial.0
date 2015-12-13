From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 16/16] serial: sh-sci: Drop the sci_fck clock fallback
Date: Sat, 12 Dec 2015 22:42:47 -0800
Message-ID: <20151213064247.GB16326@kroah.com>
References: <1447958173-543-1-git-send-email-geert+renesas@glider.be>
 <1447958173-543-17-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447958173-543-17-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 19, 2015 at 07:36:13PM +0100, Geert Uytterhoeven wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> All platforms that used to define an sci_fck clock have now switched to
> the fck name. Remove the fallback code.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
