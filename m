From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 05/12] tty: amba-pl011: add register lookup table
Date: Thu, 24 Dec 2015 09:50:16 -0600
Message-ID: <CAOZdJXWdbbxT7jQ1=xatnunNnzRqbECAtvw-cVhrJUKuUx-mVw@mail.gmail.com>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
 <E1ZyNlS-0003jg-46@rmk-PC.arm.linux.org.uk>
 <20151224065437.GA18445@robwan01-pc.asiapac.arm.com>
 <CAOZdJXWmBYrjgC2GcY2NSeuJ2MAuwvtYVLP9AvTMkLUWsi9DhQ@mail.gmail.com>
 <20151224150552.GF8644@n2100.arm.linux.org.uk>
 <CAOZdJXXdMHG7c9yDTo+oh7uNPCmH_Mc08s5YCoL3j--7uj5Mow@mail.gmail.com>
 <20151224154027.GH8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151224154027.GH8644@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Hurley <peter@hurleysoftware.com>, Andre Przywara <andre.przywara@arm.com>, Timur Tabi <timur@codeaurora.org>, Andrew Jackson <Andrew.Jackson@arm.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huang Shijie <shijie.huang@arm.com>, Jiri Slaby <jslaby@suse.com>, Jun Nie <jun.nie@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Dec 24, 2015 at 9:40 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>>         while (readl(port->membase + REG_FR) & UART01x_FR_TXFF)
>>
>> is broken because REG_FR is equal to 1.
>
> Patch 4, which changes to the REG_* stuff, does not (explicitly) touch
> this because it _will_ break stuff.

I'm just telling you what's in Greg's tty-next repository:

https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git/log/drivers/tty/serial/amba-pl011.c?h=tty-next

https://git.kernel.org/cgit/linux/kernel/git/gregkh/tty.git/tree/drivers/tty/serial/amba-pl011.c?h=tty-next#n2302


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
