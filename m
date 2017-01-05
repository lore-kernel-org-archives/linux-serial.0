From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 2/4] serial: 8250: Add new port type for TI
 DA8xx/OMAPL13x/AM17xx/AM18xx/C66x
Date: Thu, 5 Jan 2017 13:51:50 +0530
Message-ID: <7b175d65-7193-32e4-999b-e3cdd0005c3a@ti.com>
References: <1483561814-21953-1-git-send-email-david@lechnology.com>
 <1483561814-21953-3-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1483561814-21953-3-git-send-email-david@lechnology.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Lechner <david@lechnology.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Alexandre Bailon <abailon@baylibre.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Franklin S Cooper Jr <fcooper@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thursday 05 January 2017 02:00 AM, David Lechner wrote:
> This adds a new UART port type for TI DA8xx/OMAPL13x/AM17xx/AM18xx/C66x.

The Keystone2 processors do include the C66x DSP. But the SoCs being
targeted with this patch are the ARM + DSP variants. Using 66AK2x is
more appropriate.

http://www.ti.com/lsds/ti/processors/dsp/c6000_dsp-arm/66ak2x/overview.page

Also, DA8xx includes DA830 which is pin-compatible with AM17x. So you
can shorten the list of supported processors to DA8xx/66AK2x.

> These SoCs have standard 8250 registers plus some extra non-standard
> registers.
> 
> The UART will not function unless the non-standard Power and Emulation
> Management Register (PWREMU_MGMT) is configured correctly. This is
> currently handled in arch/arm/mach-davinci/serial.c for non-device-tree
> boards. Making this part of the UART driver will allow UART to work on
> device-tree boards as well and the mach code can eventually be removed.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Looks good to me, apart from the minor change above.

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
