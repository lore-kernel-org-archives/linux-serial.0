From: Philip Elcan <pelcan@codeaurora.org>
Subject: Re: [PATCH 10/10] drivers: PL011: add support for the ARM SBSA generic
 UART
Date: Tue, 17 Feb 2015 10:55:35 -0500
Message-ID: <54E36477.3050406@codeaurora.org>
References: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
 <1421428986-11300-11-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1421428986-11300-11-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: Mark Rutland <mark.rutland@arm.com>, rob.herring@linaro.org, arnd@arndb.de, linux-serial@vger.kernel.org, Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 01/16/2015 12:23 PM, Andre Przywara wrote:
> The ARM Server Base System Architecture[1] document describes a
> generic UART which is a subset of the PL011 UART.
> It lacks DMA support, baud rate control and modem status line
> control, among other things.
> The idea is to move the UART initialization and setup into the
> firmware (which does this job today already) and let the kernel just
> use the UART for sending and receiving characters.
> We use the recent refactoring the build a new struct uart_ops
> variable which points to some new functions avoiding access to the
> missing registers. We reuse as much existing PL011 code as possible.
> 
> In contrast to the PL011 the SBSA UART does not define any AMBA or
> PrimeCell relations, so we go a pretty generic probe function
> which only uses platform device functions.
> A DT binding is provided, but other systems can easily attach to it,
> too (hint, hint!).
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---

<snip>

Andre,

I'm a little late to address this patchset, but the SBSA defines all
the Generic UART registers 32-bit wide. However, the amba-pl011 driver
uses 16-bit accessors. How will you be handling that? Can the ARM PL011
hardware handle 32-bit access?

Philip

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
