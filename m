From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/4] serial: sh-sci: Replace printk() by pr_*()
Date: Tue, 11 Mar 2014 07:27:40 -0700
Message-ID: <1394548060.21085.45.camel@joe-AO722>
References: <1394532680-4264-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1394532680-4264-1-git-send-email-geert@linux-m68k.org>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms+renesas@verge.net.au>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

On Tue, 2014-03-11 at 11:11 +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Make banner const while we're at it

One thing to consider is to add

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

before any #include to make sure all messages
are appropriately prefixed by subsystem name.

One day, I'd very much like to avoid this
by making it the default.

http://comments.gmane.org/gmane.linux.kernel/1052288



