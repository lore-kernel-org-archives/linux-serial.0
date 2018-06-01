From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/4] clk: renesas: cpg-mssr: Stop using printk format %pCr
Date: Fri, 01 Jun 2018 09:37:33 -0700
Message-ID: <152787105335.144038.419639779875099925@swboyd.mtv.corp.google.com>
References: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
 <1527845302-12159-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527845302-12159-2-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Eric Anholt <eric@anholt.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jia-Ju Bai <baijiaju1990@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Michael Turquette <mturquette@baylibre.com>, Stefan Wahren <stefan.wahren@i2se.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Quoting Geert Uytterhoeven (2018-06-01 02:28:19)
> Printk format "%pCr" will be removed soon, as clk_get_rate() must not be
> called in atomic context.
> =

> Replace it by open-coding the operation.  This is safe here, as the code
> runs in task context.
> =

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
