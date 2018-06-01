From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 2/4] thermal: bcm2835: Stop using printk format %pCr
Date: Fri, 1 Jun 2018 11:35:19 +0200
Message-ID: <49541212-0bf7-06ec-7a3d-f01f7b658481@i2se.com>
References: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
 <1527845302-12159-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527845302-12159-3-git-send-email-geert+renesas@glider.be>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Jia-Ju Bai <baijiaju1990@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Eric Anholt <eric@anholt.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



Am 01.06.2018 um 11:28 schrieb Geert Uytterhoeven:
> Printk format "%pCr" will be removed soon, as clk_get_rate() must not be
> called in atomic context.
>
> Replace it by printing the variable that already holds the clock rate.
> Note that calling clk_get_rate() is safe here, as the code runs in task
> context.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks
