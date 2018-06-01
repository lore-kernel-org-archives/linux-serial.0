From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/4] lib/vsprintf: Remove atomic-unsafe support for printk
 format %pCr
Date: Fri, 1 Jun 2018 06:00:47 -0500
Message-ID: <CA+55aFxHHSRnDbbNGq6SwNAwEt0EhX15n_pNqon3MzGYJgMJmA@mail.gmail.com>
References: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: baijiaju1990@gmail.com, Jonathan Corbet <corbet@lwn.net>, Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-clk@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 1, 2018 at 4:29 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> This patch series:
>   - Changes all existing users of "%pCr" to print the result of
>     clk_get_rate() directly, which is safe as they all do this in task
>     context only,
>   - Removes support for the "%pCr" printk format.

Looks good to me.

What tree will this go through? The normal printk one? Just checking
that this doesn't end up falling through the cracks because nobody
knows who would take it...

               Linus
