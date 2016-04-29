From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2 03/11] serial: sh-sci: Always set TIOCM_CTS in
 .get_mctrl() callback
Date: Fri, 29 Apr 2016 08:38:09 -0700
Message-ID: <57237FE1.8030200@hurleysoftware.com>
References: <1461934714-18681-1-git-send-email-geert+renesas@glider.be>
 <1461934714-18681-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461934714-18681-4-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 04/29/2016 05:58 AM, Geert Uytterhoeven wrote:
> Documentation/serial/driver clearly states:
> 
>     If the port does not support CTS, DCD or DSR, the driver should
>     indicate that the signal is permanently active.
> 
> Hence always set TIOCM_CTS, as we currently don't look at the CTS
> hardware line state at all.
> 
> FWIW, this fixes the transmit path when hardware-assisted flow control
> is enabled, and userspace enables CRTSCTS.
> The receive path is still broken, as RTS is never asserted.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
