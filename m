From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] serial: 8250_uniphier: call clk_disable_unprepare() on failure path
Date: Fri, 24 Jul 2015 13:23:09 +0200
Message-ID: <2473660.NnHIN4Y0gO@ubix>
References: <1437721108-19037-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437721108-19037-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Friday, July 24, 2015 03:58:28 PM Masahiro Yamada wrote:
> If serial8250_register_8250_port() fails, disable and unprepare the
> clock before exiting.
> 
> Fixes: 1a8d2903cb6a ("serial: 8250_uniphier: add UniPhier serial driver")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
