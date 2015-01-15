From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v5] ARC: Dynamically determine BASE_BAUD from DeviceTree
Date: Thu, 15 Jan 2015 09:49:12 +0530
Message-ID: <54B73FC0.4060506@synopsys.com>
References: <CAL_JsqLzzLajoQAT3nYd5zi4=+zchXfVVPnYNriAZZi4tpa6yA@mail.gmail.com> <1420889152-29361-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420889152-29361-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, robh@kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

Hi Greg,

On Saturday 10 January 2015 04:56 PM, Vineet Gupta wrote:
> 8250 earlycon is broken on multi-platform ARC because the UART clk
> value (BASE_BAUD) is fixed at build time.
> 
> Instead, determine the appropriate UART clk at runtime; parse the
> devicetree early for platforms requiring alternate UART clk values
> (currently only the TB10X platform).
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Rob Herring <robh@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> ---
>  arch/arc/include/asm/serial.h | 23 +++++------------------
>  arch/arc/kernel/devtree.c     | 24 ++++++++++++++++++++++++

This being all in arch code, do you want me to take this in via ARC tree ?

Thx,
-Vineet
