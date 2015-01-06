From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [Patch v4] ARC: Dynamically determine BASE_BAUD from DeviceTree
Date: Tue, 06 Jan 2015 09:02:01 -0500
Message-ID: <54ABEAD9.9090200@hurleysoftware.com>
References: <54ABD526.9020907@hurleysoftware.com> <1420552747-27544-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420552747-27544-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

On 01/06/2015 08:59 AM, Vineet Gupta wrote:
> 8250 earlycon is broken on multi-platform ARC because the UART clk
> value (BASE_BAUD) is fixed at build time.
> 
> Instead, determine the appropriate UART clk at runtime; parse the
> devicetree early for platforms requiring alternate UART clk values
> (currently only the TB10X platform).

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
