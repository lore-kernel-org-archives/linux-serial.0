From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [RESEND PATCH v3 2/2] serial: uartps: Change uart ID port
 allocation
Date: Wed, 26 Sep 2018 12:43:05 +0200
Message-ID: <c92386bf-ccdc-5c38-faed-75ff5e9718a6@xilinx.com>
References: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537443710.git.michal.simek@xilinx.com>
 <39e840d1f727fe6338ea14b882ca9bf831f53e32.1537443710.git.michal.simek@xilinx.com>
 <CAMuHMdWQcc+ZD238e13fBcVW77304u2nqq2K9A9-wsDVAPEa4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWQcc+ZD238e13fBcVW77304u2nqq2K9A9-wsDVAPEa4A@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <michal.simek@xilinx.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Geert,

On 24.9.2018 09:37, Geert Uytterhoeven wrote:
> Hi Michal,
> 
> On Thu, Sep 20, 2018 at 1:42 PM Michal Simek <michal.simek@xilinx.com> wrote:
>> For IPs which have alias algorightm all the time using that alias and
>> minor number. It means serial20 alias ends up as ttyPS20.
>>
>> If alias is not setup for probed IP instance the first unused position is
>> used but that needs to be checked if it is really empty because another
>> instance doesn't need to be probed at that time. of_alias_get_alias_list()
>> fills alias bitmap which exactly shows which ID is free.
>> If alias pointing to different not compatible IP, it is free to use.
>>
>> cdns_get_id() call is placed below structure allocation to simplify
>> error path.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> JFTR, for sh-sci, I used a different approach, as all ports in the static DTB
> can have an alias (if aliases are needed at all), and only DT overlays cannot
> have them. Cfr. commit 7678f4c20fa7670f ("serial: sh-sci: Add support for
> dynamic instances").

if you look at all patches I have done for uartps you can find out that
I am creating uart_driver for every instance separately.
It means that there is still a limit for number of consoles exactly as
yours CONFIG_SERIAL_SH_SCI_NR_UARTS but every instance is separated.

Thanks,
Michal
