From: Mason <slash.tmp@free.fr>
Subject: Re: Supporting early console on a SERIAL_8250_RT288X platform
Date: Fri, 7 Apr 2017 14:57:39 +0200
Message-ID: <f59323cb-f0f4-1936-9fab-8d3cf1799818@free.fr>
References: <0ac351b9-46bd-3a35-fab3-73177cabb747@free.fr>
 <d797386a-009e-f21d-dec4-a7520b4f6a72@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <d797386a-009e-f21d-dec4-a7520b4f6a72@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>, linux-serial <linux-serial@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>
Cc: Rob Herring <robh@kernel.org>, Mans Rullgard <mans@mansr.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Jean Delvare <jdelvare@suse.de>, Jiri Slaby <jslaby@suse.com>, Andreas Farber <afaerber@suse.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Thanks for answering so quickly! :-)

On 07/04/2017 14:18, Robin Murphy wrote:

> On 07/04/17 12:53, Mason wrote:
>
>> Did I implement something wrong?
>> Why am I not seeing the output of the panic() call, like I do
>> with earlyprintk?
>> Since tty0 is enabled, why isn't it picking up where palmchip0
>> left off?
> 
> As far as I'm aware, tty0 is a purely virtual console: look further down
> still and you'll probably see a second switch over from tty0 to ttyS0,
> which will be when the buffered output *actually* starts coming out
> again. That's certainly what happens for me, albeit with
> "pl11"->"tty0"->"ttyAMA0", (and complete with not realising ttyAMA0 is
> still the same port and reprinting the entire log buffer from the top).

Right you are!

Also, I had not noticed the "print the entire log buffer from the top"
issue you mention.

[    0.000000] Booting Linux on physical CPU 0x0
...
[    0.000000] earlycon: palmchip0 at MMIO 0x00010700 (options '115200n8')
[    0.000000] bootconsole [palmchip0] enabled
...
[    0.014147] Console: colour dummy device 80x30
[    0.018616] console [tty0] enabled
[    0.022039] bootconsole [palmchip0] disabled
[    0.000000] Booting Linux on physical CPU 0x0
...
[    0.000000] earlycon: palmchip0 at MMIO 0x00010700 (options '115200n8')
[    0.000000] bootconsole [palmchip0] enabled
[    0.014147] Console: colour dummy device 80x30
[    0.018616] console [tty0] enabled
[    0.022039] bootconsole [palmchip0] disabled
...
[    0.460630] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.462278] 10700.serial: ttyS0 at MMIO 0x10700 (irq = 20, base_baud = 460800) is a Palmchip BK-3103
[    1.084227] console [ttyS0] enabled

> I believe this is something to do with how the DT stdout-path property
> is implemented, because with an explicit "console=ttyAMA0" (or ttyS0 in
> your case) on the command line instead of relying on stdout-path, the
> boot console does switch directly to the real UART without the
> intermediate tty0 blind spot.

Indeed, an explicit console=ttyS0,115200 does avoid the "dupe the entire log"
issue. There is still some "stuttering" involved:

[    0.000000] earlycon: palmchip0 at MMIO 0x00010700 (options '115200n8')
[    0.000000] bootconsole [palmchip0] enabled
...
[    0.745811] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.753681] console [ttyS0] disabled
[    0.757426] 10700.serial: ttyS0 at MMIO 0x10700 (irq = 20, base_baud = 460800) is a Palmchip BK-3103
[    0.766672] console [ttyS0] enabled
[    0.766672] console [ttyS0] enabled
[    0.773726] bootconsole [palmchip0] disabled
[    0.773726] bootconsole [palmchip0] disabled


More importantly, it also solves the "hang before panic message" issue:

...
[    0.575937] io scheduler noop registered
[    0.579888] io scheduler deadline registered
[    0.584245] io scheduler cfq registered (default)
[    0.589650] Kernel panic - not syncing: THIS IS A TEST


Hopefully, supporting earlycon on this platform can be included
in time for v4.12 :-)

Greg, Peter, what do you think? ;-)

Regards.
