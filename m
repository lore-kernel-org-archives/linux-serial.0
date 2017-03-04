From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/1] serial: 8250_dw: Allow hardware flow control to be used
Date: Sat, 4 Mar 2017 04:56:48 +0200
Message-ID: <CAHp75Ved2h2WyWBokEOsDmAyB3w3iM=uh-9Bq01mU1ST4FapWQ@mail.gmail.com>
References: <1484164100-9805-1-git-send-email-jason.uy@broadcom.com>
 <1484164100-9805-2-git-send-email-jason.uy@broadcom.com> <CAAG0J9-n0toSJL8Ze8Esq81dYnpfrTd42bMiR94zw_btBLjsww@mail.gmail.com>
 <1488394220.20145.68.camel@linux.intel.com> <20170303002129.GS996@jhogan-linux.le.imgtec.org>
 <1488547866.20145.74.camel@linux.intel.com> <20170303232305.GU996@jhogan-linux.le.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20170303232305.GU996@jhogan-linux.le.imgtec.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: James Hogan <james.hogan@imgtec.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heiko Stuebner <heiko@sntech.de>, Jason Uy <jason.uy@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Noam Camus <noamc@ezchip.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Wang Hongcheng <annie.wang@amd.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>, Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org, Viresh Kumar <viresh.kumar@st.com>
List-Id: linux-serial@vger.kernel.org

On Sat, Mar 4, 2017 at 1:23 AM, James Hogan <james.hogan@imgtec.com> wrote:
> On Fri, Mar 03, 2017 at 03:31:06PM +0200, Andy Shevchenko wrote:
>> On Fri, 2017-03-03 at 00:21 +0000, James Hogan wrote:
>> > The CONFIG_HAVE_CLK=n implementation of devm_clk_get() in particular
>> > seems highly questionable to me, given that commit 93abe8e4b13a ("clk:
>> > add non CONFIG_HAVE_CLK routines") which added it 5 years ago says:

>> Btw, I hope you also noticed this one:
>>
>> http://www.spinics.net/lists/linux-serial/msg25314.html
>
> Interesting.
>
> Following Russel's past advise[1], the following patch on top of Heiko's
> patch also fixes things for me on Octeon:
>
> [1] https://lists.gt.net/linux/kernel/2102623
>
> If thats an acceptable fix I'll post it properly. Thoughts?

Fine by me. Looks definitely better than IS_ERR_OR_NULL().

Please, submit as usual with your SoB tag.

> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 223ac234ddb2..e65808c482f1 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -267,6 +267,8 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
>         rate = clk_round_rate(d->clk, baud * 16);
>         if (rate < 0)
>                 ret = rate;
> +       else if (rate == 0)
> +               ret = -ENOENT;
>         else
>                 ret = clk_set_rate(d->clk, rate);
>         clk_prepare_enable(d->clk);

-- 
With Best Regards,
Andy Shevchenko
