From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 0/4] lib/vsprintf: Remove atomic-unsafe support for
 printk format %pCr
Date: Fri, 1 Jun 2018 17:19:05 +0200
Message-ID: <20180601151905.yilldc6vbachfw4k@pathway.suse.cz>
References: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
 <CA+55aFxHHSRnDbbNGq6SwNAwEt0EhX15n_pNqon3MzGYJgMJmA@mail.gmail.com>
 <20180601114738.kdoggkha2yosjgbv@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180601114738.kdoggkha2yosjgbv@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, baijiaju1990@gmail.com, Jonathan Corbet <corbet@lwn.net>, Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-clk@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kerne>
List-Id: linux-serial@vger.kernel.org

On Fri 2018-06-01 13:47:38, Petr Mladek wrote:
> On Fri 2018-06-01 06:00:47, Linus Torvalds wrote:
> > On Fri, Jun 1, 2018 at 4:29 AM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > >
> > > This patch series:
> > >   - Changes all existing users of "%pCr" to print the result of
> > >     clk_get_rate() directly, which is safe as they all do this in task
> > >     context only,
> > >   - Removes support for the "%pCr" printk format.
> > 
> > Looks good to me.
> > 
> > What tree will this go through? The normal printk one? Just checking
> > that this doesn't end up falling through the cracks because nobody
> > knows who would take it...
> 
> I will take it via printk.git. There already is bunch of vsprintf
> changes for-4.18.

It is in printk.git, branch for-4.18-vsprintf-pcr-removal now.

Also I have added Cc: stable@vger.kernel.org into the commit messages.

Best Regards,
Petr
