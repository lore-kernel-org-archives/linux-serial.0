From: Jason Uy <jason.uy@broadcom.com>
Subject: RE: [PATCH v2 1/1] serial: 8250_dw: Allow hardware flow control to be used
Date: Fri, 3 Mar 2017 09:43:55 -0800
Message-ID: <3e45a0582dd91dab1a6e9bd6f4339e12@mail.gmail.com>
References: <1484164100-9805-1-git-send-email-jason.uy@broadcom.com>
 <1484164100-9805-2-git-send-email-jason.uy@broadcom.com> <CAAG0J9-n0toSJL8Ze8Esq81dYnpfrTd42bMiR94zw_btBLjsww@mail.gmail.com>
 <1488394220.20145.68.camel@linux.intel.com> <20170303002129.GS996@jhogan-linux.le.imgtec.org>
 <1488547866.20145.74.camel@linux.intel.com> <ab064967-e362-d9be-3040-3260e9b5c426@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <ab064967-e362-d9be-3040-3260e9b5c426@broadcom.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Ray Jui <ray.jui@broadcom.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, James Hogan <james.hogan@imgtec.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Noam Camus <noamc@ezchip.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Wang Hongcheng <annie.wang@amd.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com, Linux MIPS Mailing List <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>, Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org, Viresh Kumar <viresh.kumar@st.com>
List-Id: linux-serial@vger.kernel.org

James,

Can you verify that changing the code to the following fixes your problem?

if (IS_ERR_OR_NULL(d->clk) || !old)
    goto out;

Regards,
Jason

-----Original Message-----
From: Ray Jui [mailto:ray.jui@broadcom.com]
Sent: March-03-17 9:34 AM
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; James Hogan
<james.hogan@imgtec.com>; Heiko Stuebner <heiko@sntech.de>
Cc: Jason Uy <jason.uy@broadcom.com>; Greg Kroah-Hartman
<gregkh@linuxfoundation.org>; Jiri Slaby <jslaby@suse.com>; Kefeng Wang
<wangkefeng.wang@huawei.com>; Noam Camus <noamc@ezchip.com>; Heikki Krogerus
<heikki.krogerus@linux.intel.com>; Wang Hongcheng <annie.wang@amd.com>;
linux-serial@vger.kernel.org; LKML <linux-kernel@vger.kernel.org>;
bcm-kernel-feedback-list@broadcom.com; Linux MIPS Mailing List
<linux-mips@linux-mips.org>; David Daney <david.daney@cavium.com>; Russell
King <linux@armlinux.org.uk>; linux-clk@vger.kernel.org; Viresh Kumar
<viresh.kumar@st.com>
Subject: Re: [PATCH v2 1/1] serial: 8250_dw: Allow hardware flow control to
be used

Hi Andy/Jason,

On 3/3/2017 5:31 AM, Andy Shevchenko wrote:
> Heiko, you might be interested in this as well.
>
> On Fri, 2017-03-03 at 00:21 +0000, James Hogan wrote:
>> On Wed, Mar 01, 2017 at 08:50:20PM +0200, Andy Shevchenko wrote:
>>> On Wed, 2017-03-01 at 18:02 +0000, James Hogan wrote:
>>>> On 11 January 2017 at 19:48, Jason Uy <jason.uy@broadcom.com>
>>>> wrote:
>>>>> In the most common use case, the Synopsys DW UART driver does not
>>>>> set the set_termios callback function.  This prevents
>>>>> UPSTAT_AUTOCTS from being set when the UART flag CRTSCTS is set.
>>>>> As a result, the driver will use software flow control as opposed
>>>>> to hardware flow control.
>>>>>
>>>>> To fix the problem, the set_termios callback function is set to
>>>>> the DW specific function.  The logic to set UPSTAT_AUTOCTS is
>>>>> moved so that any clock error will not affect setting the hardware
>>>>> flow control.
>>>> Bisection shows that this patch, commit
>>>> 6a171b29937984a5e0bf29d6577b055998f03edb, has broken boot of the
>>>> Cavium Octeon III based UTM-8 board (MIPS architecture).
>>>>
>>>> I now get the following warning:
>>>> [<ffffffff8149c2e4>] uart_get_baud_rate+0xfc/0x1f0
>>>> [<ffffffff814a5098>] serial8250_do_set_termios+0xb0/0x440
>>>> [<ffffffff8149c710>] uart_set_options+0xe8/0x190
>>>> [<ffffffff814a6cdc>] serial8250_console_setup+0x84/0x158
>>>> [<ffffffff814a11ec>] univ8250_console_setup+0x54/0x70
>>>> [<ffffffff811901a0>] register_console+0x1c8/0x418
>>>> [<ffffffff8149f004>] uart_add_one_port+0x434/0x4b0
>>>> [<ffffffff814a1af8>] serial8250_register_8250_port+0x2d8/0x440
>>>> [<ffffffff814aa620>] dw8250_probe+0x388/0x5e8 Then it hangs and the
>>>> watchdog restarts the machine.
>>>>
>>>> Any ideas?
>>>
>>> 1. Does it use clock on that platform?
>
>> I've now dug a little deeper. Essentially what is going on is:
>>
>> 1) CONFIG_HAVE_CLK=n (Octeon doesn't select it)
>> 2) The CONFIG_HAVE_CLK=n implementation of devm_clk_get() returns
>> NULL
>> 3) The "if (IS_ERR(d->clk) || !old) {" check in dw8250_set_termios()
>>    doesn't match, since !IS_ERR(NULL)
>> 4) The CONFIG_HAVE_CLK=n implementation of clk_round_rate() returns 0
>> 5) The CONFIG_HAVE_CLK=n implementation of clk_set_rate(d->clk, 0)
>>    returns 0
>> 6) dw8250_set_termios() thinks the frequency for that baud rate has
>> been
>>    set successfully and writes 0 into uartclk
>> 7) it all goes wrong from there...
>
> So, it means we have need special care of NULL case here, and
> honestly, I don't like it. But it seems the only feasible (quick) fix
> right now.

I agree. I think it should have been:

if (IS_ERR_OR_NULL(d->clk) || !old)
    goto out;

I think it makes sense to validate to make sure the 'clk' pointer is valid
before proceeding any further down below (regardless of how well or how not
well the clock framework handles it).

Thanks,

Ray

>
>> The CONFIG_HAVE_CLK=n implementation of devm_clk_get() in particular
>> seems highly questionable to me, given that commit 93abe8e4b13a ("clk:
>> add non CONFIG_HAVE_CLK routines") which added it 5 years ago says:
>>
>>> These calls will return error for platforms that don't select
>>> HAVE_CLK
>>
>> And NULL isn't an error in this API.
>
> Which is okay. I dunno what should be returned from clk_round_rate()
> if clk is NULL. I would fix CLK framework, though I would like to
> gather more details.
>
> Btw, I hope you also noticed this one:
>
> http://www.spinics.net/lists/linux-serial/msg25314.html
>
