From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] serial: sh-sci: Remove redundant instances of
 EARLYCON_DECLARE()
Date: Mon, 15 Feb 2016 16:23:31 +0300
Message-ID: <56C1D153.6070709@cogentembedded.com>
References: <1455539792-23140-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1455539792-23140-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp
List-Id: linux-serial@vger.kernel.org

Hello.

On 2/15/2016 3:36 PM, Geert Uytterhoeven wrote:

> As of commit 2eaa790989e03900 ("earlycon: Use common framework for

    12-digt ID is enough

> earlycon declarations") it is no longer needer to specify both

    Needed?

> EARLYCON_DECLARE() and OF_EARLYCON_DECLARE().
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

[...]

MBR, Sergei
