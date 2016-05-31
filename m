From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFT PATCH 1/2] serial: Fix console setup section mismatch
Date: Tue, 31 May 2016 16:34:47 +0200
Message-ID: <574DA107.8050002@samsung.com>
References: <1464704372-17668-1-git-send-email-k.kozlowski@samsung.com>
 <20160531142142.GX19428@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-reply-to: <20160531142142.GX19428@n2100.arm.linux.org.uk>
Sender: sparclinux-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Tobias Klauser <tklauser@distanz.ch>, Nicolas Ferre <nicolas.ferre@atmel.com>, Sonic Zhang <sonic.zhang@analog.com>, "Maciej W. Rozycki" <macro@linux-mips.org>, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Barry Song <baohua@kernel.org>, "David S. Miller" <davem@davemloft.net>, Tony Prisk <linux@prisktech.co.nz>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, nios2-dev@lists.rocketboards.org, adi-buildroot-devel@lists.sourceforge.net, linux-arm
List-Id: linux-serial@vger.kernel.org

On 05/31/2016 04:21 PM, Russell King - ARM Linux wrote:
> On Tue, May 31, 2016 at 04:19:31PM +0200, Krzysztof Kozlowski wrote:
>> Remove __init annotation from all of console->setup implementations
>> because:
>> 1. The pointer to it is stored in a struct console which is not
>>    marked with __initdata.
>> 2. It is referenced by register_console() from kernel which is not
>>    marked with __init.
> 
> However, many of these drivers, the console can only be used when the
> driver is built-in, and register_console() is only called early in
> initialisation.

Indeed so maybe the word "fix" in commit subject is not proper because
there might be no error at all. My point is that current solution is a
little bit non-obvious and an error might happen. If we were sure that
register_console() is called only from other __init functions, then it
should be made also __init.

Best regards,
Krzysztof

