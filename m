From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH 05/12] tty: amba-pl011: add register lookup table
Date: Thu, 24 Dec 2015 09:03:12 -0600
Message-ID: <CAOZdJXWmBYrjgC2GcY2NSeuJ2MAuwvtYVLP9AvTMkLUWsi9DhQ@mail.gmail.com>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
 <E1ZyNlS-0003jg-46@rmk-PC.arm.linux.org.uk>
 <20151224065437.GA18445@robwan01-pc.asiapac.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151224065437.GA18445@robwan01-pc.asiapac.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Huang Shijie <shijie.huang@arm.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Jun Nie <jun.nie@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Dec 24, 2015 at 12:54 AM, Huang Shijie <shijie.huang@arm.com> wrote:
> My kernel cmdline:
>   console=ttyAMA0,115200 earlycon=pl011,0x7ff80000 root=/dev/sda1 rootwait verbose debug sky2.mac_address=0x00,0x02,0xF7,0x00,0x63,0x3C dtb=r1a57.dtb

earlycon is broken with Russell's patches.  My patch fixes it, but
only for standard pl011 devices.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
