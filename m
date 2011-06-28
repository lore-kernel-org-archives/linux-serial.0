From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 10/12] SERIAL: SC26xx: Fix link error.
Date: Tue, 28 Jun 2011 09:25:40 +0100
Message-ID: <20110628092540.61c94bf9@bob.linux.org.uk>
References: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
        <f0b3d9a91be8dba5c45c14efebaa9c7800694f15.1309182743.git.ralf@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <f0b3d9a91be8dba5c45c14efebaa9c7800694f15.1309182743.git.ralf@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-serial@vger.kernel.org

On Mon, 27 Jun 2011 14:26:56 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> Kconfig allows enabling console support for the SC26xx driver even
> when it's configured as a module resulting in a:
> 
> ERROR: "uart_console_device" [drivers/tty/serial/sc26xx.ko] undefined!
> 
> modpost error since the driver was merged in
> eea63e0e8a60d00485b47fb6e75d9aa2566b989b [SC26XX: New serial driver
> for SC2681 uarts] in 2.6.25.  Fixed by only allowing console support
> to be enabled if the driver is builtin.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Acked-by: Alan Cox <alan@linux.intel.com>
