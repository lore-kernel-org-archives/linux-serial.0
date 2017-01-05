From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH v2 4/4] ARM: dts: keystone: Add "ti, da830-uart" compatible
 string
Date: Thu, 5 Jan 2017 09:10:35 -0800
Message-ID: <317f1f81-74da-68ae-200f-42a969774ae8@oracle.com>
References: <1483561814-21953-1-git-send-email-david@lechnology.com>
 <1483561814-21953-5-git-send-email-david@lechnology.com>
 <93c4aed0-6faa-2c27-7931-454fc1f48e79@oracle.com>
 <824238e0-b710-7146-b67b-b2135c2a8bd2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <824238e0-b710-7146-b67b-b2135c2a8bd2@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Alexandre Bailon <abailon@baylibre.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Franklin S Cooper Jr <fcooper@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 1/5/2017 1:04 AM, Sekhar Nori wrote:
> Hi Santosh,
>
> On Thursday 05 January 2017 03:30 AM, Santosh Shilimkar wrote:
>> On 1/4/2017 12:30 PM, David Lechner wrote:
>>> The TI Keystone SoCs have extra UART registers beyond the standard 8250
>>> registers, so we need a new compatible string to indicate this. Also, at
>>> least one of these registers uses the full 32 bits, so we need to specify
>>> reg-io-width in addition to reg-shift.
>>>
>>> "ns16550a" is left in the compatible specification since it does work as
>>> long as the bootloader configures the SoC UART power management
>>> registers.
>>>
>> NAK!!
>> We can't break the booting boards with existing boot loaders.
>
> Sorry, but it not clear to me how this breaks booting with older
> bootloaders? If older DTB is ROM'ed, it will continue to work because of
> match with ns16550a.
>
> I just verified boot on K2E with these patches applied and using 2016.05
> based U-Boot from a TI release.
>
> http://pastebin.ubuntu.com/23744719/
>
Thanks for test. As long as it doesn't break the boot, am fine
with it.

>> I suggest you to first get the driver updated to take care of
>> the UART PM register and then enable the support for it.
>
> Isn't that what patch 2/4 is doing?
>
I see that now. Thanks for clarifying.

Serial patch needs to go via Greg's tree. I will pick up the
DTS bits.

Regards,
Santosh
