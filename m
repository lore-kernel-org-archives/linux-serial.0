From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/10] drivers: PL011: add ARM SBSA Generic UART support
Date: Fri, 16 Jan 2015 18:31:46 +0100
Message-ID: <7542669.MXdXNkVnKh@wuerfel>
References: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: rob.herring@linaro.org, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, jslaby@suse.cz, Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Friday 16 January 2015 17:22:56 Andre Przywara wrote:
> The ARM Server Base System Architecture[1] document describes a
> generic UART which is a subset of the PL011 UART.
> It lacks DMA support, baud rate control and modem status line
> control, among other things.
> The idea is to move the UART initialization and setup into the
> firmware (which does this job today already) and let the kernel just
> use the UART for sending and receiving characters.

Given that all other approaches that have been tried have failed, this
seems like the best way forward. I don't know enough about the driver
to do a detailed review, but all patches looked good to me as far as
I could tell.

One question: How does the name space and minor number allocation work
if you have both sbsa-uart and real pl011 in the same system? Do
they share the ttyAMA name space without collisions?

	Arnd
