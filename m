From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] serial: 8250_dw: Allow hardware flow control to
 be used
Date: Wed, 01 Mar 2017 20:50:20 +0200
Message-ID: <1488394220.20145.68.camel@linux.intel.com>
References: <1484164100-9805-1-git-send-email-jason.uy@broadcom.com>
         <1484164100-9805-2-git-send-email-jason.uy@broadcom.com>
         <CAAG0J9-n0toSJL8Ze8Esq81dYnpfrTd42bMiR94zw_btBLjsww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <CAAG0J9-n0toSJL8Ze8Esq81dYnpfrTd42bMiR94zw_btBLjsww@mail.gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: James Hogan <james.hogan@imgtec.com>, Jason Uy <jason.uy@broadcom.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Noam Camus <noamc@ezchip.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Wang Hongcheng <annie.wang@amd.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, Linux MIPS Mailing List <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>
List-Id: linux-serial@vger.kernel.org

On Wed, 2017-03-01 at 18:02 +0000, James Hogan wrote:
> On 11 January 2017 at 19:48, Jason Uy <jason.uy@broadcom.com> wrote:
> > In the most common use case, the Synopsys DW UART driver does not
> > set the set_termios callback function.  This prevents UPSTAT_AUTOCTS
> > from being set when the UART flag CRTSCTS is set.  As a result, the
> > driver will use software flow control as opposed to hardware flow
> > control.
> > 
> > To fix the problem, the set_termios callback function is set to the
> > DW specific function.  The logic to set UPSTAT_AUTOCTS is moved so
> > that any clock error will not affect setting the hardware flow
> > control.

> Bisection shows that this patch, commit
> 6a171b29937984a5e0bf29d6577b055998f03edb, has broken boot of the
> Cavium Octeon III based UTM-8 board (MIPS architecture).
> 
> I now get the following warning:

> [<ffffffff8149c2e4>] uart_get_baud_rate+0xfc/0x1f0
> [<ffffffff814a5098>] serial8250_do_set_termios+0xb0/0x440
> [<ffffffff8149c710>] uart_set_options+0xe8/0x190
> [<ffffffff814a6cdc>] serial8250_console_setup+0x84/0x158
> [<ffffffff814a11ec>] univ8250_console_setup+0x54/0x70
> [<ffffffff811901a0>] register_console+0x1c8/0x418
> [<ffffffff8149f004>] uart_add_one_port+0x434/0x4b0
> [<ffffffff814a1af8>] serial8250_register_8250_port+0x2d8/0x440
> [<ffffffff814aa620>] dw8250_probe+0x388/0x5e8

> Then it hangs and the watchdog restarts the machine.
> 
> Any ideas?

1. Does it use clock on that platform?
2. Check if termios is not NULL there.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
