From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial: sh-sci: Remove redundant instances of
 EARLYCON_DECLARE()
Date: Tue, 16 Feb 2016 09:13:24 -0800
Message-ID: <56C358B4.9060908@hurleysoftware.com>
References: <1455539792-23140-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1455539792-23140-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp
List-Id: linux-serial@vger.kernel.org

On 02/15/2016 04:36 AM, Geert Uytterhoeven wrote:
> As of commit 2eaa790989e03900 ("earlycon: Use common framework for
> earlycon declarations") it is no longer needer to specify both
> EARLYCON_DECLARE() and OF_EARLYCON_DECLARE().

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

