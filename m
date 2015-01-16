From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 00/10] drivers: PL011: add ARM SBSA Generic UART support
Date: Fri, 16 Jan 2015 17:53:52 +0000
Message-ID: <54B95030.1010909@arm.com>
References: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
 <7542669.MXdXNkVnKh@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7542669.MXdXNkVnKh@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "rob.herring@linaro.org" <rob.herring@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, Dave P Martin <Dave.Martin@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Arnd,

On 16/01/15 17:31, Arnd Bergmann wrote:
> On Friday 16 January 2015 17:22:56 Andre Przywara wrote:
>> The ARM Server Base System Architecture[1] document describes a
>> generic UART which is a subset of the PL011 UART.
>> It lacks DMA support, baud rate control and modem status line
>> control, among other things.
>> The idea is to move the UART initialization and setup into the
>> firmware (which does this job today already) and let the kernel just
>> use the UART for sending and receiving characters.
> 
> Given that all other approaches that have been tried have failed, this
> seems like the best way forward. I don't know enough about the driver
> to do a detailed review, but all patches looked good to me as far as
> I could tell.

Thanks for looking at them!

> One question: How does the name space and minor number allocation work
> if you have both sbsa-uart and real pl011 in the same system? Do
> they share the ttyAMA name space without collisions?

Yes, that works. Both parts use the same pl011_probe_dt_alias() routine
to do the numbering.
For testing I specified the second and fourth port as SBSA in the DT,
leaving the first and third as PL011. This is what you get then:
...
Serial: AMBA PL011 UART driver
uart-pl011 1c090000.uart: ttyAMA0 at MMIO 0x1c090000 (irq = 15,
base_baud = 0) is a PL011 rev2
...
uart-pl011 1c0b0000.uart: ttyAMA2 at MMIO 0x1c0b0000 (irq = 17,
base_baud = 0) is a PL011 rev2
....
sbsa-uart 1c0a0000.uart: ttyAMA1 at MMIO 0x1c0a0000 (irq = 16, base_baud
= 0) is a SBSA
sbsa-uart 1c0c0000.uart: ttyAMA3 at MMIO 0x1c0c0000 (irq = 18, base_baud
= 0) is a SBSA

Cheers,
Andre.
