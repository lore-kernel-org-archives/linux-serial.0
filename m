From: Robert Richter <robert.richter@caviumnetworks.com>
Subject: Re: [PATCH v4 00/11] drivers: PL011: add ARM SBSA Generic UART support
Date: Tue, 12 May 2015 18:42:49 +0200
Message-ID: <20150512164249.GA20609@rric.localhost>
References: <1431440095-5146-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1431440095-5146-1-git-send-email-andre.przywara@arm.com>
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, arnd@arndb.de, Jakub Kicinski <moorray3@wp.pl>, Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, rmk+kernel@arm.linux.org.uk, Jiri Slaby <jslaby@suse.cz>, dave.martin@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 12.05.15 15:14:44, Andre Przywara wrote:
> This is the fourth revision of the SBSA UART support series, now
> based on the current tty-next branch.
> Compared to v3 I addressed some comments Jakub had on v3 (thanks for
> the review!). Also since some basic ACPI support for ARM64 is now
> upstream, I include the necessary ACPI binding as a new patch 11
> on top.
> ----

> Andre Przywara (10):
>   drivers: PL011: avoid potential unregister_driver call
>   drivers: PL011: refactor pl011_startup()
>   drivers: PL011: refactor pl011_shutdown()
>   drivers: PL011: refactor pl011_set_termios()
>   drivers: PL011: refactor pl011_probe()
>   drivers: PL011: replace UART_MIS reading with _RIS & _IMSC
>   drivers: PL011: move cts_event workaround into separate function
>   drivers: PL011: allow avoiding UART enabling/disabling
>   drivers: PL011: allow to supply fixed option string
>   drivers: PL011: add support for the ARM SBSA generic UART
> 
> Graeme Gregory (1):
>   drivers: PL011: add ACPI probing for SBSA UART

Tested-by: Robert Richter <rrichter@cavium.com>

... with devicetree and ACPI.

-Robert
